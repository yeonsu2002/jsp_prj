package xml0528;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.JspWriter;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

import day0515.Dept;
import day0515.DeptService;

public class CreateDeptXML {
	public void createDeptFile() {
		
		try {
			FileOutputStream fos=new FileOutputStream("C:/dev/workspace/jsp_prj/src/main/webapp/xml0528/db_dept.xml");
			createXML(fos,null);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void webBrowserOutput(JspWriter out) {
		try {
			createXML(null, out);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}//webBrowerOutput
	
	private void createXML(FileOutputStream fos, JspWriter out ) throws IOException {
		DeptService ds=new DeptService();
		List<Dept> deptList=ds.searchAllDept();
		
		//문서객체를 생성
		Document doc=new Document();//<?xml version="1.0" encoding="UTF-8"?>
		//최상위 근 노드 생성
		Element rootNode=new Element("depts");//<depts/>
		
		//조회결과로 노드를 생성
		//정보를 가진 노드 생성:부가적인 정보를 생성{result:true, pubDate:생성, data
		Element resultNode=new Element("result");//<result/>
		resultNode.setText(String.valueOf(!deptList.isEmpty()));
		Element pubDateNode=new Element("pubDate");
		pubDateNode.setText(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
		
		rootNode.addContent(resultNode);
		rootNode.addContent(pubDateNode);
		//<depts>
		
		//조회결과로 노드를 생성하여 배치
		Element deptNode=null;//하나의 레코드를 저장하기 위한 노드
		Element deptnoNode=null;//컬럼값을 저장하기 위한 노드
		Element dnameNode=null;
		Element locNode=null;
		
		for(Dept dept:deptList) {
			deptNode=new Element("dept");		
			deptnoNode=new Element("deptno");		
			dnameNode=new Element("dname");		
			locNode=new Element("loc");		
		
			
			deptnoNode.setText(String.valueOf(dept.getDeptno()));
			dnameNode.setText(dept.getDname());
			locNode.setText(dept.getLoc());
			
			//컬럼값을 가진 코드를 부모노드(dept)에 배치
			deptNode.addContent(deptnoNode);
			deptNode.addContent(dnameNode);
			deptNode.addContent(locNode);
			
			//dept 노드를 depts 노드에 배치
			rootNode.addContent(deptNode);
		}
		
		doc.addContent(rootNode);
		
		XMLOutputter xOut=new XMLOutputter(Format.getPrettyFormat());
		
		if(out==null) {
			xOut.output(doc, fos);
		}else {
			xOut.output(doc,out);
		}
		
	}//createXML
}
