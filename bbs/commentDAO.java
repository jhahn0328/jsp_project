package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class commentDAO {
	// dao : 데이터베이스 접근 객체의 약자
			private Connection conn; // connection:db에접근하게 해주는 객체
			//private PreparedStatement pstmt;
			private ResultSet rs;
			
			// mysql 처리부분
			public commentDAO() {
				// 생성자를 만들어준다.
				try {
					String dbURL = "jdbc:mariadb://127.0.0.1:3301/TEST";
					String dbID = "root";
					String dbPassword = "markany1@";
					Class.forName("org.mariadb.jdbc.Driver");
					conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
					if( conn != null ) {
		                System.out.println("DB 접속 성공");
		            }
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			//현재의 시간을 가져오는 함수
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
				return ""; //데이터베이스 오류
			}
			//bbsID 게시글 번호 가져오는 함수
				public int getNext() { 
					String SQL = "SELECT commentID FROM COMMENT ORDER BY commentID DESC";
					try {
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							return rs.getInt(1) + 1;
						}
						return 1;//첫 번째 게시물인 경우
					} catch (Exception e) {
						e.printStackTrace();
					}
					return -1; //데이터베이스 오류
				}
				//실제로 글을 작성하는 함수
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
					return -1; //데이터베이스 오류
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
					return -1; // 데이터베이스 오류
				}
				//코멘트 가져오는 함수가 필요함 
}
