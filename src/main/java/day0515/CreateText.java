package day0515;

import java.io.FileWriter;
import java.io.IOException;

public class CreateText {

	public static void main(String[] args) {
		String msg="AJAX 동작은 쉽지않구만 목요일목요일목요일목요일";
		try {
			FileWriter fw=new FileWriter("C:/dev/workspace/jsp_prj/src/main/webapp/day0515/ajax.txt");
			fw.write(msg);
			fw.flush();
			if(fw !=null) {fw.close();}
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
