package com.itbank.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Scanner;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import com.itbank.model.ForPurchaseDTO;
import com.itbank.model.Nonuser_orderDTO;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import oracle.jdbc.logging.annotations.StringBlinder;

@Service
public class MailService {

	@Value("classpath:account.txt")
	private Resource account;
	
	public int sendMail(String dst, String text) throws IOException{
		
		Scanner sc = new Scanner(account.getFile());
		String accountInfo = null;
		
		while(sc.hasNextLine()) {
			accountInfo = sc.nextLine();
		}
		sc.close();
		
		String host = "smtp.gmail.com";
		int port = 465;
		final String serverId = accountInfo.split("/")[0];
		final String serverPw = accountInfo.split("/")[1];
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		Session mailSession = Session.getDefaultInstance(props, new Authenticator() {
			String un = serverId;
			String pw = serverPw;
			
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pw);
			}
		});
		//mailSession.setDebug(true);
		
		Message mimeMessage = new MimeMessage(mailSession);
		
//		String body = "";
//		body += "<div style=\"padding: 10px; border: 3px solid #dadada; font-size: 20px; \">";
//		body += "	<h3>인증번호</h3>";
//		body += "	<p>인증번호는 <b>[%s]</b>입니다";
//		body += "</div>";
		
		StringBuilder stringBody = new StringBuilder();
		stringBody.append("<div style=\"padding: 10px; border: 3px solid #dadada; font-size: 20px; \">\n");
		stringBody.append("<h3>인증번호</h3>\n");
		stringBody.append("<p>인증번호는 <b>[%s]</b>입니다\n");
		stringBody.append("</div>\n");
		String body = stringBody.toString();
		
		
		try {
			mimeMessage.setFrom(new InternetAddress("dodoro914@gmail.com"));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(dst));
			mimeMessage.setSubject("[CK2J] 인증번호입니다");
//			mimeMessage.setText(text);									// 단순 텍스트로 메일을 보낼 경우
			body = String.format(body, text);
			mimeMessage.setContent(body, "text/html; charset=utf-8");	// 태그 및 스타일 적용
			Transport.send(mimeMessage);
			return 1;
		}catch(AddressException e) {
			System.out.println("잘못된 주소입니다");
			return -1;
		}catch(MessagingException e) {
			e.printStackTrace();
			System.out.println("메세지 전송에 문제가 발생했습니다");
			return -2;
		}
		
		
	}

	public int sendMailForUserPurchase(String dst, ArrayList<ForPurchaseDTO> clone) throws IOException {
		Scanner sc = new Scanner(account.getFile());
		String accountInfo = null;
		
		while(sc.hasNextLine()) {
			accountInfo = sc.nextLine();
		}
		sc.close();
		
		String host = "smtp.gmail.com";
		int port = 465;
		final String serverId = accountInfo.split("/")[0];
		final String serverPw = accountInfo.split("/")[1];
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		Session mailSession = Session.getDefaultInstance(props, new Authenticator() {
			String un = serverId;
			String pw = serverPw;
			
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pw);
			}
		});
		//mailSession.setDebug(true);
		
		Message mimeMessage = new MimeMessage(mailSession);
		
//		String body = "";
//		body += "<div style=\"padding: 10px; border: 3px solid #dadada; font-size: 20px; \">";
//		body += "	<h3>인증번호</h3>";
//		body += "	<p>인증번호는 <b>[%s]</b>입니다";
//		body += "</div>";
		
		StringBuilder stringBody = new StringBuilder();
		
		int totalCost = 0;
		for(int i = 0; i < clone.size(); i++) {
			totalCost += clone.get(i).getItemPrice();
		}
		DecimalFormat formatter = new DecimalFormat("#,###");
        String formattedNumber = formatter.format(totalCost);
        stringBody.append("<div>\r\n" + 
        		"	        <h2 style=\"color: hotpink;\">CK2J 결제내역을</h2>\r\n" + 
        		"	        <h2>확인해주세요.</h2>\r\n" + 
        		"        </div>\r\n" + 
        		"\r\n" + 
        		"        <div style=\"width: 800px;\">\r\n" + 
        		"	        <div style=\"border-bottom: 1px solid black;\"><h3>결제 정보</h3></div>\r\n" + 
        		"	        <div style=\"display: flex; margin: 10px;\">\r\n" + 
        		"	            <div style=\"margin-right: 30px;\">결제금액</div>\r\n" + 
        		"	            <div>￦ " + formattedNumber +"</div>\r\n" + 
        		"	        </div>\r\n" + 
        		"	        <div style=\"display: flex; margin: 10px;\">\r\n" + 
        		"	            <div style=\"margin-right: 30px;\">결제수단</div>\r\n" + 
        		"	            <div>무통장입금</div>\r\n" + 
        		"	        </div>\r\n" + 
        		"	        <div style=\"display: flex; margin: 10px; border-bottom: 1px solid black; padding-bottom: 10px;\">\r\n" + 
        		"	            <div style=\"margin-right: 30px;\">입금계좌</div>\r\n" + 
        		"	            <div>[평양은행]112-119-123456</div>\r\n" + 
        		"	        </div>\r\n" + 
        		"	        <h3>감사합니다.</h3>\r\n" + 
        		"        </div>");
		String body = stringBody.toString();
		
		try {
			mimeMessage.setFrom(new InternetAddress("dodoro914@gmail.com"));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(dst));
			mimeMessage.setSubject("[CK2J] 결제내역서 안내");
//			mimeMessage.setText(text);									// 단순 텍스트로 메일을 보낼 경우
			mimeMessage.setContent(body, "text/html; charset=utf-8");	// 태그 및 스타일 적용
			Transport.send(mimeMessage);
			return 1;
		}catch(AddressException e) {
			System.out.println("잘못된 주소입니다");
			return -1;
		}catch(MessagingException e) {
			e.printStackTrace();
			System.out.println("메세지 전송에 문제가 발생했습니다");
			return -2;
		}
		
	}

	public int sendMailForNonuserPurchase(String dst, ArrayList<ForPurchaseDTO> clone, Nonuser_orderDTO dto, int orderIdx) throws IOException {
		Scanner sc = new Scanner(account.getFile());
		String accountInfo = null;
		
		while(sc.hasNextLine()) {
			accountInfo = sc.nextLine();
		}
		sc.close();
		
		String host = "smtp.gmail.com";
		int port = 465;
		final String serverId = accountInfo.split("/")[0];
		final String serverPw = accountInfo.split("/")[1];
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		Session mailSession = Session.getDefaultInstance(props, new Authenticator() {
			String un = serverId;
			String pw = serverPw;
			
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pw);
			}
		});
		//mailSession.setDebug(true);
		
		Message mimeMessage = new MimeMessage(mailSession);
		
//		String body = "";
//		body += "<div style=\"padding: 10px; border: 3px solid #dadada; font-size: 20px; \">";
//		body += "	<h3>인증번호</h3>";
//		body += "	<p>인증번호는 <b>[%s]</b>입니다";
//		body += "</div>";
		
		StringBuilder stringBody = new StringBuilder();
		
		int totalCost = 0;
		for(int i = 0; i < clone.size(); i++) {
			totalCost += clone.get(i).getItemPrice();
		}
		DecimalFormat formatter = new DecimalFormat("#,###");
        String formattedNumber = formatter.format(totalCost);
        stringBody.append("<div style=\"width: 800px;\">\r\n" + 
        		"        <h2 style=\"color: hotpink;\">CK2J 결제내역을</h2>\r\n" + 
        		"        <h2>확인해주세요.</h2>\r\n" + 
        		"    </div>\r\n" + 
        		"\r\n" + 
        		"    <div style=\"width: 800px;\">\r\n" + 
        		"        <div style=\"border-bottom: 1px solid black;\"><h3>결제 정보</h3></div>\r\n" + 
        		"        <div style=\"display: flex; margin: 10px;\">\r\n" + 
        		"            <div style=\"margin-right: 30px; width: 15%;\">주문번호</div>\r\n" + 
        		"            <div>" + orderIdx + "</div>\r\n" + 
        		"        </div>\r\n" + 
        		"        <div style=\"display: flex; margin: 10px;\">\r\n" + 
        		"            <div style=\"margin-right: 30px; width: 15%;\">주문 비밀번호</div>\r\n" + 
        		"            <div>" + dto.getNonuser_pwd() + "</div>\r\n" + 
        		"        </div>\r\n" + 
        		"        <div style=\"display: flex; margin: 10px;\">\r\n" + 
        		"            <div style=\"margin-right: 30px; width: 15%;\">결제금액</div>\r\n" + 
        		"	            <div>￦ " + formattedNumber +"</div>\r\n" + 
        		"        </div>\r\n" + 
        		"        <div style=\"display: flex; margin: 10px;\">\r\n" + 
        		"            <div style=\"margin-right: 30px; width: 15%;\">결제수단</div>\r\n" + 
        		"            <div>무통장입금</div>\r\n" + 
        		"        </div>\r\n" + 
        		"        <div style=\"display: flex; margin: 10px; border-bottom: 1px solid black; padding-bottom: 10px;\">\r\n" + 
        		"            <div style=\"margin-right: 30px; width: 15%;\">입금계좌</div>\r\n" + 
        		"            <div>[평양은행]112-119-123456</div>\r\n" + 
        		"        </div>\r\n" + 
        		"        <h3>감사합니다.</h3>\r\n" + 
        		"    </div>");
		String body = stringBody.toString();
		
		try {
			mimeMessage.setFrom(new InternetAddress("dodoro914@gmail.com"));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(dst));
			mimeMessage.setSubject("[CK2J] 결제내역서 안내");
//			mimeMessage.setText(text);									// 단순 텍스트로 메일을 보낼 경우
			mimeMessage.setContent(body, "text/html; charset=utf-8");	// 태그 및 스타일 적용
			Transport.send(mimeMessage);
			return 1;
		}catch(AddressException e) {
			System.out.println("잘못된 주소입니다");
			return -1;
		}catch(MessagingException e) {
			e.printStackTrace();
			System.out.println("메세지 전송에 문제가 발생했습니다");
			return -2;
		}
	}

}