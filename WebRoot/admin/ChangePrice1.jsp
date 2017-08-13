<%@ page import="product.Product"%>
<%@ page import="product.ProductMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	int id=Integer.parseInt(request.getParameter("id"));
	Product p=ProductMgr.getInstance().getProduct(id);
	
	String normal=request.getParameter("normalprice");
	if(normal !=null)
	{
		double normalPrice=Double.parseDouble(normal);
		p.setNormalPrice(normalPrice);
		ProductMgr.getInstance().update(p);
	}
	
	String member=request.getParameter("memberprice");
	//System.out.println(member);
	if(member !=null)
	{
		double memberPrice=Double.parseDouble(member);	
		p.setMemberPrice(memberPrice);
		ProductMgr.getInstance().update(p);
	}
	

	response.setContentType("text/html;charset=utf8");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
