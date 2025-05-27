package kr.co.sist.place;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import kr.co.sist.board.RangeDTO;
import kr.co.sist.dao.DbConnection;


public class PlaceService {
	
	/**
	 * 맛집을 추가
	 * @param mDTO 식당명,메뉴,가격,정보,위도,경도,ip,id
	 * @return flag 성공시 true, 실패시 false 반환
	 */
	public boolean addRestaurant(RestDTO rDTO) {
		boolean flag = false;
		
		PlaceDAO pDAO = PlaceDAO.getInstance();
		
		try {
			pDAO.insertRestaurant(rDTO);
			flag = true;
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return flag;
	} //addRestaurant
	
	/**
	 * 시작번호와 끝 번호 사이의 게시물 조회
	 * @param rDTO
	 * @return list 조회한 게시물 리스트
	 */
	public List<RestDTO> searchAllRestaurant(RangeDTO rDTO){
		List<RestDTO> list = null;
		
		PlaceDAO pDAO = PlaceDAO.getInstance();
		try {
			list = pDAO.selectAllRestaurant(rDTO);
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return list;
	} //searchAllRestaurant
	
	/**
	 * 총 레코드의 수
	 * @param rDTO
	 * @return cnt 레코드의 수
	 */
	public int totalCount( RangeDTO rDTO ) {
		int cnt = 0;
		
		PlaceDAO pDAO = PlaceDAO.getInstance();
		
		try {
			cnt = pDAO.selectTotalCount(rDTO);
		} catch (SQLException se) {
			se.printStackTrace();
		} //end try catch
		
		return cnt;
	} //totalCount
	
	
	
	/**
	 * 한 화면에 출력할 게시물의 수
	 * @return pageScale 출력할 게시물의 수
	 */
	public int pageScale() {
		int pageScale=10;
		
		return pageScale;
	} //pageScale
	
	/**
	 * 총 페이지 수
	 * @param totalCount 총 게시물의 수
	 * @param pageScale 한 화면에 출력할 게시물의 수
	 * @return totalPage 총 페이지 수
	 */
	public int totalPage(int totalCount, int pageScale) {
		int totalPage= 0;
		
		totalPage = (int)(Math.ceil((double)totalCount/pageScale));
		
		return totalPage;
	} //totalPage
	
	/**
	 * pagination 을 클릭했을 때 번호를 사용하여 해당 페이지 게시물 시작 번호
	 * 예) 1=1, 2=11, 3=21, 4=31, 5=41
	 * @param pageScale 한 화면에 출력할 게시물의 수
	 * @param rDTO
	 * @return startNum 해당 페이지 게시물 시작 번호
	 */
	public int startNum(int pageScale, RangeDTO rDTO) {
		int startNum = 1;
		
		startNum = rDTO.getCurrentPage()*pageScale-pageScale+1;
		rDTO.setStartNum(startNum);
		
		return startNum;
	} //startNum
	
	/**pagination 을 클릭했을 때 번호를 사용하여 해당 페이지 게시물 끝 번호
	 * @param pageScale 한 화면에 출력할 게시물의 수
	 * @param rDTO
	 * @return endNum 해당 페이지 게시물 끝 번호
	 */
	public int endNum(int pageScale, RangeDTO rDTO) {
		int endNum = 0;
		
		endNum = rDTO.getStartNum()+pageScale-1;
		rDTO.setEndNum(endNum);
		
		return endNum;
	} //endNum
	public RestDTO selectOneRestaurant(int rest_num) throws SQLException {
		RestDTO restDTO = null;

		DbConnection db = DbConnection.getInstance();
		ResultSet rs = null; 
		PreparedStatement pstmt = null;
		Connection con = null;
 
		try {
			// 1.JNDI 사용 객체 생성
			// 2. dBCP에서 연결객체 얻기 (DataSource)
			// 3. connection 얻기
			con = db.getDbConn();
			// 4. 쿼리문 생성객체 얻기
			StringBuilder selectOneRest = new StringBuilder();
			selectOneRest
			.append("	select restaurant,menu,price,info,id,input_date,ip,lat,lng		")
			.append("	from restaurant					")
			.append("	where rest_num=?					");

			pstmt = con.prepareStatement(selectOneRest.toString());
			// 5. 바인드변수에 값 할당
			pstmt.setInt(1, rest_num);
			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				restDTO = new RestDTO();
				restDTO.setRestaurant(rs.getString("restaurant"));
				restDTO.setMenu(rs.getString("menu"));
				restDTO.setPrice(rs.getInt("price"));
				restDTO.setInfo(rs.getString("info"));
				restDTO.setId(rs.getString("id"));
				restDTO.setInput_date(rs.getDate("input_date"));
				restDTO.setIp(rs.getString("ip"));
				restDTO.setLat(rs.getDouble("lat"));
				restDTO.setLng(rs.getDouble("lng"));

				// bDTO.setContent(rs.getString ("content")); 
			}
		} finally {
			db.dbClose(rs, pstmt, con);
		}
		return restDTO;

	}// selectOne

} //class
