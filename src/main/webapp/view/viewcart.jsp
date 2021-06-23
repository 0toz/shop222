<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 보기</title>
<style type="text/css">
table {
	margin: 10px auto;
	width: 800px;
	border-collapse: collapse;
	border-color: navy;
	font-size: 10pt;
}

table, th, td {
	border: 1px solid black;
	padding: 2px;
}

input{
	width: 50px; 
}
</style>
<script type="text/javascript">
	var all = 0;
/* request.getParameterValues("cbox") */
	function edit_cart(f) {
		f.action="/MyController?cmd=editCart";
		f.submit();
	}
	function delete_cart(f) {
		f.action="/MyController?cmd=deleteCart";
		f.submit();
	}
	function allcheck() {
		
		cbox = document.getElementsByName("cbox");
		abox = document.getElementsByName("allcheck");
		for (var i = 0; i < cbox.length; i++) {
			if(abox[0].checked== true){
				cbox[i].checked = true;
			}
			if(abox[0].checked== false){
				cbox[i].checked = false;
			}
			all = cbox.length;
		}
	}
	
	window.onload = function(){

		cbox = document.getElementsByName("cbox");
		abox = document.getElementsByName("allcheck");
		if(cbox.length<all){
			abox.checked = false;
		}
	}
	
	function allcheckdelete(){
		var arr = [];
		cbox = document.getElementsByName("cbox");
		abox = document.getElementsByName("allcheck");
		for (var i = 0; i < cbox.length; i++) {
			if(cbox[i].checked == true) {
				arr.push(cbox[i].value);
			}
		}
		location.href="/MyController?cmd=deleteCart&ar="+arr;		
	}
</script>
</head>
<body>
	<%-- 현재 페이지에서 다른 페이지 가져오기  --%>
	<%@ include file="top.jsp" %>
	<hr>
	
	<button name="deletebox" onclick="allcheckdelete()">체크삭제</button>
	<table>
		<caption><h2> :: 장바구니 내용 :: </h2></caption>
		
	
		<thead>
			
			<tr bgcolor="#dedede">
				<th style="width: 10%">전체체크<input type="checkbox"  name= "allcheck" onclick=allcheck()></th>
				<th style="width: 10%">제품번호</th>
				<th style="width: 20%">제품명</th>
				<th style="width: 15%">단가</th>
				<th style="width: 30%">수량</th>
				<th style="width: 15%">금액</th>
			</tr>
			
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty cartList }">
					<tr>
						<td colspan="6"><h2>장바구니가 비었습니다</h2></td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="k" items="${cartList }">
					<tr>
						<td><input type="checkbox" name= "cbox" value="${k.c_idx}"> </td>
						<td>${k.p_num }</td>
						<td>${k.p_name }</td>
						<td>시중가 : <fmt:formatNumber value="${k.p_price }" pattern="#,###" /> 원 <br>
							<font style="color: tomato">(세일가 : <fmt:formatNumber value="${k.p_saleprice}" pattern="#,###" /> 원)</font>
						</td>
						<td>
							<form method="post">
				<%--변경 --%>	<input type="number" name="amount" value="${k.amount}" >
								<input type="hidden" name="id" value="${k.id}">
								<input type="hidden" name="p_num" value="${k.p_num}">
								<input type="button" value="수정" onclick="edit_cart(this.form)">
							</form>
						</td>
                <%--변경 --%><td><fmt:formatNumber value="${k.p_saleprice * k.amount }" pattern="#,###" /> 원</td>
						
				<%--추가 --%><c:set var="total" value="${total = total + (k.p_saleprice * k.amount) }"/>
					</tr>	
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
		<tfoot>
			<tr style="text-align: right;">
				<td colspan="6" style="padding-right: 50px;">
					<h2> 총 결재액 : <fmt:formatNumber value="${total}" pattern="#,###" /> 원</h2>
				</td>
			</tr>
		</tfoot>
	</table>
</body>
</html>