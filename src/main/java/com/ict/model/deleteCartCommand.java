package com.ict.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ict.db.CVO;
import com.ict.db.DAO;

public class deleteCartCommand implements Command{
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
			/*
			 * CVO cvo = new CVO(); cvo.setId(request.getParameter("id"));
			 * cvo.setP_num(request.getParameter("p_num"));
			 * 
			 * int result = DAO.getCartDelete(cvo);
			 */
			String[] arr = request.getParameterValues("ar");

			CVO cvo = new CVO();
			/*
			 * for(int i = 0; i < arr.length; i++) { cvo.setC_idx(Integer.parseInt(arr[i]));
			 * int result = DAO.getCartDelete(cvo); }
			 */
			return "MyController?cmd=showCart";
	
	}
}
