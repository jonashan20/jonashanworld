package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn; // 데이터베이스에 접근하게 해주는 객체
	private PreparedStatement pstmt;  // sql 문을 db에 연결하게 해주는 객체
	private ResultSet rs; // 어떠한 정보를 담을수 있는 객체
	
	public UserDAO() { // mysql에 접속을 해주는 부분
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC"; // localhost는 본인 컴퓨터의 주소를 의미 3306 포트의 bbs에 접속할수 있도록 해줌
			String dbID = "root"; // root계정 의 아이디
			String dbPassword = "root"; // root계정 의 비밀번호
			Class.forName("com.mysql.cj.jdbc.Driver"); // mysql 드라이버를 찾을수 있도록 드라이버를 넣어줌 , mysql 드라이버를 찾을수 있는 매개체 역할 하나의 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // getconnection  dburl 의 dbid, dbpassowrd를 이용해서 접속할수 있도록한다. , 접속이 되면 conn 객체안에 정보가 담기게 됨
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) { // 로그인 시도를 하는 함수
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); // prepareStatement 어떠한 정해진 sql문장을 데이터베이스에 삽입하는 형식의 인스턴스를 가져오고
			pstmt.setString(1, userID); // sql 인젝션 같은 해킹 기법을 방어하기 위한 수단으로 prepareStatement 하나의 문장을 미리 준비해놨다가 그 물음표에 해당하는 내용을 userID를 넣어주는것 / 1번째 물음표에 두번째 인수값을 넣어준다.
			rs = pstmt.executeQuery(); // resultset에 결과를 담을수 있는 하나의 객체에 실행한 결과를 담는다
			if(rs.next()) {  // 결과가 존재한다면 실행됨
				if(rs.getString(1).equals(userPassword)) { // 아이디가 있는경우 접속을 시도한 userPassword와 동일 하다면 로그인 성공이라는 리턴값 1반환됨
					return 1; // 로그인 성공
				}
				else 
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch(Exception e) { // 예외처리 예외가 날경우 추적하여 보여줌
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류를 나타냄
	}
	
	public int join(User user) { // 회원가입의 기능 추가 / 한명의 사용자를 입력받을수 있도록 하고, 미리 만들어 놓은 User클래스를 이용해서 만들어 질수 있는 하나의 인스턴스가 됨
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)"; // 어떤 기능을 할건지 sql 문을 SQL변수에 담아줌 , 입력받을 정보 만큼 ? 수를 넣음
		try {
			pstmt = conn.prepareStatement(SQL); // 데이터 베이스에 접근이 가능한 객체 conn.prearestatement에 위에 명시한 SQL 문을 넣는 방법으로 진행
			pstmt.setString(1, user.getUserID()); // 각각 sql문 물음표에 해당 변수들을 넣음
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); // 해당 스테이터먼트를 실행한 그 결과를 넣을수 있도록 함
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터 베이스 오류
	}
	
	
}
