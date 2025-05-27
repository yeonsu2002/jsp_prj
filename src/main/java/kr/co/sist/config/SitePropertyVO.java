package kr.co.sist.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import lombok.Getter;

@Getter
public class SitePropertyVO {
	private static SitePropertyVO spVO;
	private String site_name,site_varsion,site_info,protocol,server_name,server_port,servlet_path,logo_img,upload_path,input_date;

	
	private SitePropertyVO() {
		try {
			setConfig();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static SitePropertyVO getInstance() {
		if(spVO==null) {
			spVO=new SitePropertyVO();
		}
		return spVO;
	}//getInstance
	
	private void setConfig() throws SQLException{
		try {
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}//end catch
		
		String url="jdbc:oracle:thin:@localhost:1521:orcl";
		String id="scott";
		String pass="tiger";
		
		Connection con=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		try {
		con=DriverManager.getConnection(url,id,pass);
		stmt=con.createStatement();
		String configSql="select site_name,site_varsion,site_info,protocol,server_name,server_port,servlet_path,logo_img,upload_path from site_property";
		rs=stmt.executeQuery(configSql);
		
		if(rs.next()) {
			site_name=rs.getString("site_name");
			site_varsion=rs.getString("site_varsion");
			site_info=rs.getString("site_info");
			protocol=rs.getString("protocol");
			server_name=rs.getString("server_name");
			server_port=rs.getString("server_port");
			servlet_path=rs.getString("servlet_path");
			logo_img=rs.getString("logo_img");
			upload_path=rs.getString("upload_path");
		}
		
		}finally {
			if(rs !=null) {rs.close();}
			if(stmt !=null) {stmt.close();}
			if(con !=null) {con.close();}
		}

		
	}//setConfig
}
