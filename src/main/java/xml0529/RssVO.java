package xml0529;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public class RssVO {
	private String title, category, pubDate;//부가적인 정보
	
	private List<itemVO> itemList;
}//class
