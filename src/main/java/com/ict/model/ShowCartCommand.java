package com.ict.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ict.db.DAO;
import com.ict.db.MVO;
import com.ict.db.VO;

public class ShowCartCommand implements Command{
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 해당 제품을 구입한 id를 구하자 (session에 mvo가 담아 있다.)
		MVO mvo = (MVO)request.getSession().getAttribute("mvo");
		String id = mvo.getId(); 
		
		// 해당 아이디가 가진 카트안에 모든 제품가져오기
		List<VO> cartList = DAO.getCartList(id);
		
		request.setAttribute("cartList", cartList);
		return "view/viewcart.jsp";
	}
}
