package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class commentDAO {
	// dao : �����ͺ��̽� ���� ��ü�� ����
			private Connection conn; // connection:db�������ϰ� ���ִ� ��ü
			//private PreparedStatement pstmt;
			private ResultSet rs;
			
			// mysql ó���κ�
			public commentDAO() {
				// �����ڸ� ������ش�.
				try {
					String dbURL = "jdbc:mariadb://127.0.0.1:3301/TEST";
					String dbID = "root";
					String dbPassword = "markany1@";
					Class.forName("org.mariadb.jdbc.Driver");
					conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
					if( conn != null ) {
		                System.out.println("DB ���� ����");
		            }
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			//������ �ð��� �������� �Լ�
			public String getDate() { 
				String SQL = "SELECT NOW()";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						return rs.getString(1);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return ""; //�����ͺ��̽� ����
			}
			//bbsID �Խñ� ��ȣ �������� �Լ�
				public int getNext() { 
					String SQL = "SELECT commentID FROM COMMENT ORDER BY commentID DESC";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							return rs.getInt(1) + 1;
						}
						return 1;//ù ��° �Խù��� ���
					} catch (Exception e) {
						e.printStackTrace();
					}
					return -1; //�����ͺ��̽� ����
				}
				//������ ���� �ۼ��ϴ� �Լ�
				public int write(int bbsID, String userID, String comment_Content) { 
					String SQL = "INSERT INTO COMMENT VALUES(?, ?, ?, ?, ?)";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						pstmt.setInt(1, getNext());
						pstmt.setInt(2, bbsID);
						pstmt.setString(3, comment_Content);
						pstmt.setString(4, userID);
						pstmt.setString(5, getDate());
		
						return pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					}
					return -1; //�����ͺ��̽� ����
				}
				
				public ArrayList<comment> getList(int bbsID){
					String SQL = "SELECT * FROM COMMENT WHERE bbsID= ? ";
					ArrayList<comment> list =new ArrayList<comment>();
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						pstmt.setInt(1, bbsID);
						rs = pstmt.executeQuery();
						while(rs.next()) {
							comment comment=new comment();
							comment.setCommentID(rs.getInt(1));
							comment.setBbsID(rs.getInt(2));
							comment.setComment_content(rs.getString(3));
							comment.setUserID(rs.getString(4));
							comment.setCommentDate(rs.getString(5));
							list.add(comment);
						}
					}catch (Exception e) {
						e.printStackTrace();
					}
					return list;
				}
				
				public int delete(int commentID) {
					String SQL = "DELETE FROM COMMENT WHERE commentID = ?";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);   
						pstmt.setInt(1, commentID);
						return pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					}
					return -1; // �����ͺ��̽� ����
				}
				//�ڸ�Ʈ �������� �Լ��� �ʿ��� 
}
