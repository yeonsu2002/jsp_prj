package day0430;


import java.util.ArrayList;
import java.util.List;



public class Service {
	
	public String name() {
		return "강태일";
	}//name

	public List<DataDTO> subject(){
		List<DataDTO> list=new ArrayList<DataDTO>();
		
		list.add(new DataDTO(1, "Java SE"));
		list.add(new DataDTO(2, "Oracle"));
		list.add(new DataDTO(3, "Java SE"));
		list.add(new DataDTO(4, "Java SE"));
		list.add(new DataDTO(5, "Java SE"));
		return list;
	}
	
}
