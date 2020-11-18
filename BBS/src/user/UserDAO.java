package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn; // �����ͺ��̽��� �����ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;  // sql ���� db�� �����ϰ� ���ִ� ��ü
	private ResultSet rs; // ��� ������ ������ �ִ� ��ü
	
	public UserDAO() { // mysql�� ������ ���ִ� �κ�
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC"; // localhost�� ���� ��ǻ���� �ּҸ� �ǹ� 3306 ��Ʈ�� bbs�� �����Ҽ� �ֵ��� ����
			String dbID = "root"; // root���� �� ���̵�
			String dbPassword = "root"; // root���� �� ��й�ȣ
			Class.forName("com.mysql.cj.jdbc.Driver"); // mysql ����̹��� ã���� �ֵ��� ����̹��� �־��� , mysql ����̹��� ã���� �ִ� �Ű�ü ���� �ϳ��� ���̺귯��
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // getconnection  dburl �� dbid, dbpassowrd�� �̿��ؼ� �����Ҽ� �ֵ����Ѵ�. , ������ �Ǹ� conn ��ü�ȿ� ������ ���� ��
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) { // �α��� �õ��� �ϴ� �Լ�
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); // prepareStatement ��� ������ sql������ �����ͺ��̽��� �����ϴ� ������ �ν��Ͻ��� ��������
			pstmt.setString(1, userID); // sql ������ ���� ��ŷ ����� ����ϱ� ���� �������� prepareStatement �ϳ��� ������ �̸� �غ��س��ٰ� �� ����ǥ�� �ش��ϴ� ������ userID�� �־��ִ°� / 1��° ����ǥ�� �ι�° �μ����� �־��ش�.
			rs = pstmt.executeQuery(); // resultset�� ����� ������ �ִ� �ϳ��� ��ü�� ������ ����� ��´�
			if(rs.next()) {  // ����� �����Ѵٸ� �����
				if(rs.getString(1).equals(userPassword)) { // ���̵� �ִ°�� ������ �õ��� userPassword�� ���� �ϴٸ� �α��� �����̶�� ���ϰ� 1��ȯ��
					return 1; // �α��� ����
				}
				else 
					return 0; // ��й�ȣ ����ġ
			}
			return -1; // ���̵� ����
		} catch(Exception e) { // ����ó�� ���ܰ� ����� �����Ͽ� ������
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ������ ��Ÿ��
	}
	
	public int join(User user) { // ȸ�������� ��� �߰� / �Ѹ��� ����ڸ� �Է¹����� �ֵ��� �ϰ�, �̸� ����� ���� UserŬ������ �̿��ؼ� ����� ���� �ִ� �ϳ��� �ν��Ͻ��� ��
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)"; // � ����� �Ұ��� sql ���� SQL������ ����� , �Է¹��� ���� ��ŭ ? ���� ����
		try {
			pstmt = conn.prepareStatement(SQL); // ������ ���̽��� ������ ������ ��ü conn.prearestatement�� ���� ����� SQL ���� �ִ� ������� ����
			pstmt.setString(1, user.getUserID()); // ���� sql�� ����ǥ�� �ش� �������� ����
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); // �ش� �������͸�Ʈ�� ������ �� ����� ������ �ֵ��� ��
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // ������ ���̽� ����
	}
	
	
}
