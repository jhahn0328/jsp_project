package user;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bbs.Bbs;

public class UserDAO {
	// dao : �����ͺ��̽� ���� ��ü�� ���ڷμ�
	// ���������� db���� ȸ������ �ҷ����ų� db�� ȸ������ ������
	private Connection conn; // connection:db�������ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;
	private ResultSet rs;
	// mysql�� ������ �ִ� �κ�

	public UserDAO() { // ������ ����ɶ����� �ڵ����� db������ �̷�� �� �� �ֵ�����

	try {
		String dbURL = "jdbc:mariadb://127.0.0.1:3301/TEST"; // localhost:3306 ��Ʈ�� ��ǻ�ͼ�ġ�� mysql�ּ�
		String dbID = "root";
		String dbPassword = "markany1@";
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // ������ �������� ���
		}
	}
		
		// �α����� �õ��ϴ� �Լ�****
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			// pstmt : prepared statement ������ sql������ db�� �����ϴ� �������� �ν��Ͻ�������
			pstmt = conn.prepareStatement(SQL);
			// sql������ ���� ��ŷ����� ����ϴ°�... pstmt�� �̿��� �ϳ��� ������ �̸� �غ��ؼ�(����ǥ���)
			// ����ǥ�ش��ϴ� ������ �������̵��, �Ű������� �̿�.. 1)�����ϴ��� 2)��й�ȣ��������
			pstmt.setString(1, userID);
			// rs:result set �� �������
			rs = pstmt.executeQuery();
			// ����� �����Ѵٸ� ����
			if (rs.next()) {
				// �н����� ��ġ�Ѵٸ� ����
			if (rs.getString(1).equals(userPassword)) {
				return 1; // ��� ����
			} else
				return 0; // ��й�ȣ ����ġ
			}
			return -1; // ���̵� ���� ����
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ������ �ǹ�
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			pstmt.setInt(6, 0);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}
	
	public User getUser(String userID) {
		String SQL = "SELECT * FROM USER WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, bbsID);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String userID, String userPassword, String userName, String userEmail) {

		String SQL = "UPDATE USER SET userPassword = ?, userName = ?,userEmail = ? WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userName);
			pstmt.setString(3, userEmail);
			pstmt.setString(4, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	//���� �Լ�

	public int delete(String userID) {
		String SQL = "DELETE FROM USER WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);   
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public ArrayList<User> getList(){ 
		String SQL = "SELECT * FROM USER";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				list.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
}