package xml0528;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

public class DeptXMLParsing {
	
	public void parsing() {
		//1.XML을 로딩할 수 있는 객체 생성
		SAXBuilder builder=new SAXBuilder();
		//2.xml에 접근하여 문서객체로 얻는다.
		try {
			//Document doc=builder.build(new File("C:/dev/workspace/jsp_prj/src/main/webapp/xml0528/db_dept.xml"));
			Document doc=builder.build(new URL("http://localhost/jsp_prj/xml0528/db_dept.xml"));
			
			Element rootNode=doc.getRootElement();
			System.out.println(rootNode); 
			
			Element resultNode=rootNode.getChild("result");
			Boolean flag=Boolean.valueOf(resultNode.getText());
			System.out.println(flag);
			
			Element putDateNode=rootNode.getChild("pubDate");
			String pubDate=putDateNode.getText();
			System.out.println("데이터 생성일"+pubDate);
			if(flag) {//검색 결과가 있음
				//여러 자식 노드를 가진 반복되는 노드를 얻기
				List<Element> deptList=rootNode.getChildren("dept");
				
				Element deptnoNode=null;
				Element dnameNode=null;
				Element locNode=null;
				
				
				
				for(Element deptNode:deptList) {
					deptnoNode=deptNode.getChild("deptno");
					dnameNode=deptNode.getChild("dname");
					locNode=deptNode.getChild("loc");
					
					System.out.println(deptnoNode.getText()+"/"+dnameNode.getText()+"/"+locNode.getText());
				}
				
			}
			
		} catch (JDOMException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	public static void main(String[] args) {
		DeptXMLParsing dxp=new DeptXMLParsing();
		dxp.parsing();
	
	}

}
