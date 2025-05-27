package kr.co.sist.member;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

import kr.co.sist.cipher.DataDecryption;
import kr.co.sist.cipher.DataEncryption;

public class MemberService {
	
	public boolean searchId(String id) {
		boolean flag=false;
		MemberDAO mDAO=MemberDAO.getInstance();
		
		try {
			flag=mDAO.selectId(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
		
		
		return flag;
		
	}//searchId
	
	public boolean addMemeber(MemberDTO mDTO) {
		boolean flag=false;
		//mDTO객체의 값 중 email과 domain을 합쳐서 useEmail할당
		mDTO.setUseEmail(mDTO.getEmail()+"@"+mDTO.getDomain());
		//정보의 중요도에 따라
		try {
			//일방향 해시: 비밀번호
			mDTO.setPass(DataEncryption.messageDigest("SHA-256", mDTO.getPass()));
			//암호화: 이름, 이메일, 전화번호
			String key="abcdef0123456789";
			DataEncryption de=new DataEncryption(key);
			mDTO.setName(de.encrypt(mDTO.getName()));
			mDTO.setUseEmail(de.encrypt(mDTO.getUseEmail()));
			mDTO.setTel(de.encrypt(mDTO.getTel()));
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		//암호화 결정
		catch (Exception e) {
			e.printStackTrace();
		}
		
		MemberDAO mDAO=MemberDAO.getInstance();
		try {
			mDAO.insertMember(mDTO);
			flag=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return flag;
	}//addMember
	
	public List<MemberDTO> searchAllMember(String role){
		
		List<MemberDTO> list=null;
		
		MemberDAO mDAO=MemberDAO.getInstance();
		
		try {
			list=mDAO.selectAllMember();
			
			
			//관리자B(이름, 이메일만 확인가능)
			if("b".equals(role)||"c".equals(role)) {
				//복호화 : 암호화된 데이터를(Cipher Text) 일반문자 (Plain text)로 변환
				//대칭키: 암호화에 사용된 키와 동일한 키를 복호화에 사용
				String key="abcdef0123456789";
				DataDecryption dd=new DataDecryption(key);
				for(MemberDTO mDTO:list) {
					try {
						mDTO.setName(dd.decrypt(mDTO.getName()));
					} catch (Exception e) {
						e.printStackTrace();
					}
					
					try {
						mDTO.setUseEmail(dd.decrypt(mDTO.getUseEmail()));
					}catch(Exception e) {
						e.printStackTrace();
					}//end catch
					
					if("c".equals(role)) {
						try {
							mDTO.setTel(dd.decrypt(mDTO.getTel()));
						} catch (Exception e) {
							e.printStackTrace();
						}//end catch
					}//end if
				}
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		return list;
		
	}//searchAllMember
	
	
	public MemberDTO searchOneMember(String id) {
		MemberDTO mDTO=null;
		
		
		MemberDAO mDAO=MemberDAO.getInstance();
		
		try {
			mDTO=mDAO.selectOneMember(id);
			String key="abcdef0123456789";
			DataDecryption dd=new DataDecryption(key);
			
			try {
				mDTO.setName(dd.decrypt(mDTO.getName()));
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				mDTO.setTel(dd.decrypt(mDTO.getTel()));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
		
		return mDTO;
	}//searchOneMember
}//class
