<%@page import="org.jdom2.output.Format"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="org.jdom2.output.XMLOutputter"%>
<%@page import="org.jdom2.Element"%>
<%@page import="org.jdom2.Document"%>
<%@ page language="java" contentType="application/xml; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
    info=""%>
<%

//1.XML문서객체 생성
		Document doc=new Document();
		

		//2.최상위 부모노드 생성
		Element rootNode=new Element("root");
		
		//3.자식노드생성
		Element msgNode=new Element("msg");
		//자식노드에 값 설정
		msgNode.setText("안녕하세요?");
		
		rootNode.addContent(msgNode);
		
		doc.addContent(rootNode);
		
		XMLOutputter xOut=new XMLOutputter(Format.getPrettyFormat());
		
		try {
			//out 내장객체를 할당하면 web browser로 출력한다. 
			xOut.output(doc, out);			
		} catch (IOException e) {
			e.printStackTrace();
		}//end catch
		
		

%>