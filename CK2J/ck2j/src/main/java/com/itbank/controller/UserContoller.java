package com.itbank.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.component.HashComponent;
import com.itbank.model.DeliverAddressDTO;
import com.itbank.model.UserDTO;
import com.itbank.model.UserOrderDTO;
import com.itbank.model.UserOrder_returnDTO;
import com.itbank.service.MailService;
import com.itbank.service.UserService;

@Controller
@RequestMapping("/user")
public class UserContoller{
	
	@Autowired private UserService userService;
	
	@Autowired
	private MailService mailService;
	private HashMap<String, String> authNumberMap = new HashMap<String, String>();
	
	@Value("classpath:agreement/agreement1.txt")
	private Resource agreement1;
	
	@Value("classpath:agreement/agreement2.txt")
	private Resource agreement2;
	
	@Value("classpath:agreement/agreement3.txt")
	private Resource agreement3;
	
	
	@GetMapping("/login")
	public void login(){}
	
	@PostMapping("/login")
	//로그인후 세션에 user 라는 이름으로 600초간 등록. 
	public ModelAndView login(UserDTO dto, String url, HttpSession session) {
		
		HashComponent hashcomponent = new HashComponent();
		String pwd = hashcomponent.getHash(dto.getUser_pwd());
		dto.setUser_pwd(pwd);
				
		UserDTO user = userService.login(dto);
		
		if(user == null) {
			System.out.println(user);
			ModelAndView  mav = new ModelAndView("/errorpage");
			String msg = "일치하는 아이디와 비밀번호가 존재하지 않습니다.";
			mav.addObject("url","/user/login");
			mav.addObject("msg",msg);

			return mav;
		}

		String RedirectUrl = "redirect:" + (url == null ? "/" : url);
		ModelAndView mav =  new ModelAndView(RedirectUrl);
			session.setAttribute("user", user);
		return mav;
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}


	
	@GetMapping("join")
	public ModelAndView join() throws IOException {
		ModelAndView mav = new ModelAndView();
		String[] agreement = {"agreement1","agreement2","agreement3"};
		
		File[] f = {agreement1.getFile(),agreement2.getFile(),agreement3.getFile()};
		
		for(int i=0; i < f.length; i ++) {
			System.out.println(f[i].getName() + " : " + f[i].length());
			Scanner sc = new Scanner(f[i]);
		 	agreement[i] = "";
			while(sc.hasNextLine()) {
				agreement[i] += sc.nextLine();
				agreement[i] += "\n";
				mav.addObject("agreement"+(i+1),agreement[i]);
			}
//			System.out.println(agreement[i].substring(0, 20));
			sc.close();
		}
				
		return mav;
	}
	
	@PostMapping("/join")
	public ModelAndView join(UserDTO dto, HttpSession session) {
		ModelAndView mav = new ModelAndView("/user/joinComplete");
		HashComponent hashcomponent = new HashComponent();
		String pwd = hashcomponent.getHash(dto.getUser_pwd());
		dto.setUser_pwd(pwd);
		
		int row = userService.join(dto);
		System.out.println(row == 1? "추가성공":"추가 실패");
		mav.addObject("dto",dto);
		return mav;
	}
	
	@GetMapping("/mypage")							
	public String board(HttpSession session) {		
		if(session.getAttribute("user") == null) {	
			return "redirect:/user/login";				
		}
		return "/user/mypage";	//
	}
	@GetMapping("/deliverAddress/{user_id}")
	public ModelAndView address(HttpSession session) {
		ModelAndView mav = new ModelAndView("/user/deliverAddress");
		String userId = ((UserDTO)session.getAttribute("user")).getUser_id();
		DeliverAddressDTO address = userService.getAddress(userId);
		mav.addObject("address",address);
		return mav;		
	}
	@GetMapping("/addressRegist")
	public void addressRegist() {}
	
	@PostMapping("/addressRegist")
	public String addressRegist(DeliverAddressDTO dto,HttpSession session) {
		dto.setUser_id(((UserDTO)session.getAttribute("user")).getUser_id());
		int row  = userService.addressRegist(dto);
		System.out.println(row==1 ? "배송지추가완료":"배송지추가실패");
		return "redirect:/user/mypage";
	}
	
	@GetMapping("/addressModify")
	public ModelAndView addressModify(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String userId = ((UserDTO)session.getAttribute("user")).getUser_id();
		DeliverAddressDTO dto = userService.getAddress(userId);
		mav.addObject("userAddress",dto);
		
		return mav;
	}
	
	@PostMapping("/addressModify")
	public String addressModify(DeliverAddressDTO dto, HttpSession session) {
		dto.setUser_id(((UserDTO)session.getAttribute("user")).getUser_id());
		int row = userService.addressModify(dto);
		System.out.println(row == 1 ? "주소 변경 성공":"주소변경 실패");
		return "redirect:/user/mypage";
	}
	@GetMapping("/mypageModify")
	public void modify() {}
	
	@PostMapping("/mypageModify")
	public ModelAndView modify(UserDTO dto, HttpSession session) {
		ModelAndView mav = new ModelAndView("/errorpage");
		HashComponent hashcomponent = new HashComponent();
		String pwd = hashcomponent.getHash(dto.getUser_pwd());
		dto.setUser_pwd(pwd);
		int row = userService.modify(dto);
		UserDTO user = userService.getOne(dto.getUser_id());
		session.setAttribute("user", user);
		session.setMaxInactiveInterval(600);
		String msg = "정보가 정상적으로 수정 되었습니다.😊";
		mav.addObject("msg",msg);
		System.out.println(row == 1 ? "계정수정 성공":"계정 수정실패");
		return mav;
	}
	@GetMapping("/userOrder")
	public ModelAndView userOrder(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<UserOrderDTO> orderList = userService.getOrderList(((UserDTO)session.getAttribute("user")).getUser_id());
		mav.addObject("orderList",orderList);
		return mav;
	}
	
	//===========================재훈 시작=========================================
	
	// =================================================0220======================================
	@GetMapping("/find_Id")
	public void find_Id() {}
	
	@PostMapping("find_Id")
	public ModelAndView find_Id(UserDTO dto) {
		ModelAndView mav =  new ModelAndView("/user/id_result");
		UserDTO ob = userService.findId(dto);
		if(ob == null) {
			String msg = "일치하는 계정이 없습니다.";
			mav.addObject("msg", msg);
			return mav;
		}
		mav.addObject("ob",ob);
		return mav;
	}
	@GetMapping("/find_Pwd")
	public void find_Pwd() {}
	
	@PostMapping("/find_Pwd")
	public ModelAndView find_Pwd(UserDTO dto) throws IOException {
		ModelAndView mav = new ModelAndView("/user/pwd_result");
		UserDTO ob = userService.findPwd(dto);
		if(ob == null) {
			String msg = "계정을 찾을수가 업습니다.";
			mav.addObject("msg",msg);
			return mav;
		}
		Random ran = new Random();
		String authNumber = ran.nextInt(89999999) + 10000000 + "";
		System.out.println(authNumber);
		int row = mailService.sendMail(dto.getUser_email(),authNumber );
		if(row == 1) {
			authNumberMap.put(dto.getUser_email(), authNumber);
		}
		String msg2 = "해당 이메일로 인증 메일이 발송 되었습니다. 메일을 확인해주세요";
		mav.addObject("ob",ob);
		mav.addObject("msg2",msg2);
		return mav;
	}
	
	@PostMapping("/pwd_result")
	@ResponseBody
	public int pwd_result(@RequestBody HashMap<String, String> param) {

		System.out.println(param);

		String storedAuthNumber = authNumberMap.get(param.get("email"));
		String inputAuthNumber = param.get("verification");
		
		System.out.println(storedAuthNumber);
		System.out.println(inputAuthNumber);

		boolean flag = storedAuthNumber.equals(inputAuthNumber);
		System.out.println(flag);
		return flag ? 1 : 0;
	}
	
	@GetMapping("/pwd_change")
	public void pwd_change() {};
	
	@PostMapping("/pwd_change")
	public ModelAndView pwd_change(String user_id,String user_pwd) {
		HashComponent hashcomponent = new HashComponent();
		int row = userService.changePwd(user_id, hashcomponent.getHash(user_pwd));
		ModelAndView mav = new ModelAndView("/errorpage");
//		int row = userService.changePwd(user_id,user_pwd);
		System.out.println(row == 1 ? "수정성공":"수정실패");
		
		mav.addObject("msg", "비밀번호가 변경되었습니다.");
		mav.addObject("url", "/user/login");
		return mav;
	}
	
	//===========================재훈 끝=========================================
	
	
	//===========================새봄 시작=========================================
	
	// 교환/환불 버튼을 누르면 그 한개 제품만 데이터를 넘겨 받아서 띄워줌. 2.20
			@GetMapping("/user_return/{product_opt_idx}/{product_idx}/{userOrder_detail_idx}")
			public ModelAndView nonuser_return(@PathVariable("product_opt_idx")int product_opt_idx,@PathVariable("product_idx")int product_idx ,@PathVariable("userOrder_detail_idx") int userOrder_detail_idx) {
			
				ModelAndView mav = new ModelAndView("/user/user_return");
		
				UserOrderDTO list = userService.returnGetList(userOrder_detail_idx); // 원래는  product_opt_idx 받았었음.
				
				mav.addObject("list", list);
				
				System.out.println("-----------------------1아래 product_idx-----");
				System.out.println(list.getProduct_idx());
				System.out.println("----------1아래 product_opt_idx------------------");
				System.out.println(list.getProduct_opt_idx());
				System.out.println("----------1아래 NonuserOrder_detail_idx------------------");
				System.out.println(list.getUserOrder_detail_idx());
				System.out.println("----------1제품 선택해서 불러오기 끝------------------");
				return mav;
			}
			
			// 2.20 사이즈, 컬러 교환을 하고 나면 , 그 값을 데이터에서 수정해서 띄워줌. 제품의 옵션 idx 로 값을 구문.
			@PostMapping("/exchange/{product_opt_idx}/{product_idx}/{userOrder_detail_idx}") 
			public ModelAndView exchange(@PathVariable("product_opt_idx")int product_opt_idx ,@PathVariable("product_idx")int product_idx,@PathVariable("userOrder_detail_idx") int userOrder_detail_idx, UserOrderDTO dto) {
				System.out.println("옴 안옴");
				ModelAndView mav = new ModelAndView("redirect:/user/userOrder");
				int row = userService.getUserExchange(dto);
				mav.addObject("msg", "modify:" + (row != 0 ? "교환성공" : "교환실패"));
				System.out.println("row == " + row);
				if(row != 0) {
					int idx = userService.getOrderIdx(userOrder_detail_idx);
					int row2 = userService.updateStatusForAdmin(idx);
				}
				return mav;
			}
			
			// 2.20 환불하고 나면 주문상태를 환불로 바꿔서 출력해줌 
			@PostMapping("/refund/{product_opt_idx}/{product_idx}/{userOrder_detail_idx}")
			public ModelAndView refund(UserOrder_returnDTO dto) {
				System.out.println("옴 안옴");
				ModelAndView mav = new ModelAndView("redirect:/user/userOrder");
				int row = userService.getUserRefund(dto);
				System.out.println("row == " + row);
				if(row != 0) {
					int idx = userService.getOrderIdx(dto.getUserOrder_detail_idx());
					int row2 = userService.updateStatusForAdmin(idx);
				}
				mav.addObject("msg", "modify:" + (row != 0 ? "환불성공" : "환불실패"));
				return mav;
				
			}
			
			
			// 2.21 주문건 전체 삭제 
			
			@GetMapping("/orderListDelete/{user_order_idx}")
			public String delete(@PathVariable("user_order_idx")int user_order_idx) {
				int row = userService.userOrderListDelete(user_order_idx);
				System.out.println(row != 0 ? "삭제성공":"삭제실패");
				return "redirect:/user/userOrder";
			}
			//===========================새봄 끝=========================================
			
}
