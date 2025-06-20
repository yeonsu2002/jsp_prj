package xml0529;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

public class ParsingRSS {

	public RssVO parsing(String url) {
		RssVO rssVO=null;
		
		
			try {
				//1. Builder 생성
				SAXBuilder builder=new SAXBuilder();
				
				//2.XML문서 객체 얻기
				
				Document doc=builder.build(new URL("https://news-ex.jtbc.co.kr/v1/get/rss/"+url));
				Element rssNode=doc.getRootElement();
				
				Element channelNode=rssNode.getChild("channel");
				String title="", category="",pubDate="";
				title=channelNode.getChild("title").getText();
				category=channelNode.getChild("category").getText();
				pubDate=channelNode.getChild("pubDate").getText();
						
				List<Element> itemNodes=channelNode.getChildren("item");
				
				itemVO item=null;
				List<itemVO> itemList=new ArrayList<itemVO>();
				
				for(Element itemNode :itemNodes) {
					item=new itemVO(itemNode.getChild("title").getText(),
							itemNode.getChild("link").getText(),
							itemNode.getChild("description").getText(),
							itemNode.getChild("pubDate").getText());
							
							itemList.add(item);
				}
				
				rssVO=new RssVO(title, category, pubDate,itemList);
						
				
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (JDOMException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			System.out.println(rssVO);
		return rssVO;
	}//parsing
}//class
