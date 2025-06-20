package xml0527;


import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.jdom2.Attribute;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

public class CreateXML {
	
	public void createXML() {
		//1.XML문서객체 생성
		Document doc=new Document();
		

		//2.최상위 부모노드 생성
		Element rootNode=new Element("root");
		
		//3.자식노드생성
		Element msgNode=new Element("msg");
		//자식노드에 값 설정
		msgNode.setText("안녕하세요?");
		
		
		Element nameNode=new Element("name");
		nameNode.setText("유연수");
		
		
		//자식노드에 속성을 설정
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		//속성객체 생성
		Attribute attr=new Attribute("today", sdf.format(new Date()));
		//자식노드에 배치
		msgNode.setAttribute(attr);
		
		
		rootNode.addContent(msgNode);
		rootNode.addContent(nameNode);
		
		doc.addContent(rootNode);
		
		XMLOutputter xOut=new XMLOutputter(Format.getPrettyFormat());
		
		try {
			//콘솔출력
			xOut.output(doc, System.out);
			//파일로 출력
			xOut.output(doc, new FileOutputStream("C:/dev/workspace/jsp_prj/src/main/webapp/xml0527/create.xml"));
			
		} catch (IOException e) {
			e.printStackTrace();
		}//end catch
		
		
		
	}
	
	public static void main(String[] args) {
		new CreateXML().createXML();
	}

}
