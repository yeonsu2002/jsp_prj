package kr.co.sist.place;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.board.RangeDTO;
import kr.co.sist.dao.DbConnection;


public class PlaceDAO {
	
	private static PlaceDAO pDAO;
	
	private PlaceDAO() {
		
	} //PlaceDAO
	
	public static PlaceDAO getInstance() {
		if( pDAO == null ) {
			pDAO = new PlaceDAO();
		} //end if
		return pDAO;
	} //getInstance
	
	public void insertRestaurant(RestDTO rDTO) throws SQLException {
		DbConnection dbCon = DbConnection.getInstance();
		
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbConn();
			
			// 4. 쿼리문 생성객체 얻기.
			StringBuilder insertQuery = new StringBuilder();
			insertQuery
			.append("	insert	into	restaurant	")
			.append("	(rest_num, price, lat, lng, restaurant, menu, info, ip, id)	")
			.append("	values(seq_rest.nextval,?,?,?,?,?,?,?,?)	")
			;
			
			pstmt = con.prepareStatement(insertQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setInt(1, rDTO.getPrice());
			pstmt.setDouble(2, rDTO.getLat());
			pstmt.setDouble(3, rDTO.getLng());
			pstmt.setString(4, rDTO.getRestaurant());
			pstmt.setString(5, rDTO.getMenu());
			pstmt.setString(6, rDTO.getInfo());
			pstmt.setString(7, rDTO.getIp());
			pstmt.setString(8, rDTO.getId());
			
			// 6. 쿼리문 수행 후 결과 얻기.
			pstmt.executeQuery();
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(null, pstmt, con);
		} //end try finally
		
	} //insertRestaurant
	
	/**
	 * 시작번호와 끝번호 사이의 레코드를 얻는 메소드
	 * @param rDTO
	 * @return list 전체 게시물 리스트
	 * @throws SQLException 예외처리
	 */
	public List<RestDTO> selectAllRestaurant(RangeDTO rDTO) throws SQLException {
		List<RestDTO> list = new ArrayList<RestDTO>();
		
		DbConnection dbCon = DbConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbConn();
			
			// 4. 쿼리문 생성객체 얻기.
			StringBuilder selectAllQuery = new StringBuilder();
			selectAllQuery
			.append("	select rest_num, restaurant, menu, input_date, id	")
			.append("	from	(select rest_num, restaurant, menu, input_date, id,	")
			.append("	row_number() over(order by input_date desc) rnum	")
			.append("	from restaurant	")
			;
			
			// 검색 키워드
			if( rDTO.getKeyword() != null && "".equals(rDTO.getKeyword())) {
				selectAllQuery
				.append("where instr(")
				.append(rDTO.getFieldName())
				.append(",?) != 0 ")
				;
			} //end if
			selectAllQuery
			.append("	)where rnum between ? and ?	")
			;
			
			pstmt = con.prepareStatement(selectAllQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setInt(1, rDTO.getStartNum());
			pstmt.setInt(2, rDTO.getEndNum());
			
			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
			RestDTO restDTO=null;
			
			while( rs.next() ) {
				restDTO = new RestDTO();
				restDTO.setRest_num(rs.getInt("rest_num"));
				restDTO.setRestaurant(rs.getString("restaurant"));
				restDTO.setMenu(rs.getString("menu"));
				restDTO.setInput_date(rs.getDate("input_date"));
				restDTO.setId(rs.getString("id"));
				
				list.add(restDTO);
			} //end while
			
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(rs, pstmt, con);
		} //end try finally
		
		return list;
	} //selectAllRestaurant
	
	/**
	 * 한 개의 게시물 조회
	 * @param num 입력받은 게시물 번호
	 * @return bDTO 조회한 게시물
	 * @throws SQLException 예외처리
	 */
	public RestDTO selectOneRestaurant(int restNum) throws SQLException {
		RestDTO rDTO = null;
		
		DbConnection dbCon = DbConnection.getInstance();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
			// 1. JNDI 사용객체 생성.
			// 2. DBCP에서 연결객체 얻기(DataSource).
			// 3. Connection 얻기.
			con = dbCon.getDbConn();
			
			// 4. 쿼리문 생성객체 얻기.
			StringBuilder selectOneQuery = new StringBuilder();
			selectOneQuery
			.append("	select restaurant, menu, price, info, id, input_date, ip, lat, lng	")
			.append("	from	restaurant	")
			.append("	where	rest_num=?	")
			;
			
			pstmt = con.prepareStatement(selectOneQuery.toString());
			
			// 5. bind 변수에 값 할당
			pstmt.setInt(1, restNum);
			
			// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();
			
			if( rs.next() ) {
				rDTO = new RestDTO();
				rDTO.setRestaurant(rs.getString("restaurant"));
				rDTO.setMenu(rs.getString("menu"));
				rDTO.setPrice(rs.getInt("price"));
				rDTO.setInfo(rs.getString("info"));
				rDTO.setId(rs.getString("id"));
				rDTO.setInput_date(rs.getDate("input_date"));
				rDTO.setIp(rs.getString("ip"));
				rDTO.setLat(rs.getDouble("lat"));
				rDTO.setLng(rs.getDouble("lng"));
				
			} //end if
		} finally {
			// 7. 연결 끊기.
			dbCon.dbClose(rs, pstmt, con);
		} //end try finally
		
		return rDTO;
	} //selectOneRestaurant
	
	/**
	 * 게시물 전체 개수
	 * @return cnt 게시물 전체 개수
	 * @throws SQLException 예외처리
	 */
	public int selectTotalCount(RangeDTO rDTO) throws SQLException {
		int cnt=0;
		
		DbConnection dbCon = DbConnection.getInstance();
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection con = null;
		
		try {
		// 1. JNDI 사용객체 생성.
		// 2. DBCP에서 연결객체 얻기(DataSource).
		// 3. Connection 얻기.
			con = dbCon.getDbConn();
		
		// 4. 쿼리문 생성객체 얻기.
			StringBuilder countQuery = new StringBuilder();
			countQuery
			.append("	select	count(rest_num) cnt	")
			.append("	from	restaurant	")
			;
			
			// 검색 키워드
			if( rDTO.getKeyword() != null && "".equals(rDTO.getKeyword())) {
				countQuery
				.append("where instr(")
				.append(rDTO.getFieldName())
				.append(",?) != 0 ")
				;
			} //end if
			
			pstmt = con.prepareStatement(countQuery.toString());
			
		// 5. bind 변수에 값 할당
		// 6. 쿼리문 수행 후 결과 얻기.
			rs=pstmt.executeQuery();

			if(rs.next()) {
				cnt = rs.getInt("cnt");
			} //end if
			
		} finally {
		// 7. 연결 끊기.
			dbCon.dbClose(rs, pstmt, con);
		} //end try finally
		
		return cnt;
	} //selectTotalCount

} //class
