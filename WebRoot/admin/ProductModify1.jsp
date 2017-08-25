<%@ page import="java.util.Date"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="category.Category"%>
<%@ page import="java.util.List"%>
<%@ page import="product.*,category.CategoryService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<%
	request.setCharacterEncoding("utf8");
	int id=Integer.parseInt(request.getParameter("id"));
    Product	p=ProductMgr.getInstance().getProduct(id);

	int categoryId = -1;
	//因为这些数据都是要一次提交的，所以每个参数都必须要有，但是如果有些参数有误，需要标识，用负号进行标识
	String strCategoryId = request.getParameter("categoryId");
	if(strCategoryId != null && !strCategoryId.trim().equals("")) {
		categoryId = Integer.parseInt(strCategoryId);
	}
	
	
	String action=request.getParameter("action");
	if(action!=null && action.trim().equals("pruductmodify"))
	{	
		String name=request.getParameter("product");
		int normalPrice=Integer.parseInt(request.getParameter("normalPrice"));
		int memberPrice=Integer.parseInt(request.getParameter("memberPrice"));	
		String describe=request.getParameter("describe");
		
		p.setName(name);
		p.setNormalPrice(normalPrice);
		p.setMemberPrice(memberPrice);
		p.setDescribe(describe);
		p.setCategoryId(categoryId);
	
		ProductMgr.getInstance().modify(p);
		
		out.println("<div style='padding:10% 5% 5% 5%;box-shadow:0 0 10px #B5B4B4;border-radius:10px;width:80%;height:200px;margin-left:5%;margin-top:5%;'");
		out.println("<div style=''>");
		out.println("<h2 style='color:#03a9f4;text-align:center;padding:6%;'>"+"修改课程成功！~"+"</h2>");
		out.println("</div></div>");
		
		out.println("<a href='javascript:window.history.go(-2)' style='text-decoration:none;");
		out.println("background:#03a9f4;padding-bottom:5px;padding-top:5px;color:#fff;float:right;");
		out.println("margin:2% 5% 5% 5%;padding-left:30px;padding-right:30px;text-align:center;border-radius:5px;'>");
		out.println("返回</a>");
		return;
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
  		<title>艺术创想校园管理中心</title> 
    	<link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css">		
	</head>
	<body>
		<div style="padding:5% 5% 5% 5%;">
			<div class="boxs10 borr10">	
				<div class="backgb" style="height:50px;width:50px;padding-left:5px;padding-top:5px;">
					<img src="/Gouwu/images/background/info.png" />
				</div>
				
				<div class="pad20 overfh" style="margin-left:100px; ">	
					<div>
						<div class="colb fonts20 fontw700 textl" style="margin-left:13px;">
							课程信息修改
						</div>						
					</div>	
					
					<form action="/Gouwu/servlet/FileUpload" method="post" name="form2" class="flol" 
						  style="margin-right:60px;margin-top:30px; " encTYPE="multipart/form-data">
						<input type="hidden" name="id" value="<%= id %>" />										
						<img  style="width:120px;height:120px;margin-top:3%;margin-left:13px;"
							  src="/Gouwu/images/product/<%= id+".jpg" %>" 
							  onerror="javascript:this.src='/Gouwu/images/product/yscx.png'" />
						<input type="file" name="img" style="width:160px;border-bottom:none;display:block;margin:10px 0px 10px 13px "/>	
						<a href="javascript:window.form2.submit()" class="backgw padlr30 colgys boxs5 textc borr5" 
						   style="padding-bottom:2px;padding-top:2px;display:block;width:55px;margin-top:0px;margin-left:13px;" >
							上传
						</a>
					</form>
								
					<form method="post" action="ProductModify1.jsp" name="form1" class="flol" >
					<input type=hidden name="action" value="pruductmodify" />
					<input type=hidden name="id" value="<%= id %>"/>
					<table style="margin-top:20px;padding-left:10px;padding-right:10px;margin-bottom:3%;">						
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;">
								课程名称：
							</td>
							<td class="textl" style="width:250px;">
								<input type="text" name=product style="width:150px;" value="<%= p.getName() %>" />
							</td>			
						</tr>
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;">
								所属类别：
							</td>
							<td class="textl">
								<select name="categoryId" style="width:155px;">
								<option value="-1" selected="selected" >--------------------------</option>
								<%
									List<Category> categories=CategoryService.getInstance().getCategoriesGradeTwo();
									Iterator<Category> it=categories.iterator();
									while(it.hasNext())
									{
										Category c=it.next();
										String selected="";
										if(c.getId()==p.getCategoryId()) selected="selected";
										//selected="selected",设置默认选项
								%>
									<option value="<%= c.getId() %>" <%= selected %>>
										<%= c.getName() %>
									</option>
								<%
									}						
								%>					
								</select>
							</td>			
						</tr>
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;" >
								市场价格：
							</td>
							<td class="textl" style="width:250px;">
								<input type="text" name=normalPrice style="width:150px;" 
										value="<%= p.getNormalPrice() %>"/>
							</td>			
						</tr>
						<tr style="">
							<td class="colb fonts16 textl" style="margin-left:13px;" >
								会员价格：
							</td>
							<td class="textl" style="width:250px;">
								<input type="text" name=memberPrice style="width:150px;" 
										value="<%= p.getMemberPrice() %>"/>
							</td>			
						</tr>
						<tr>
							<td class="colb fonts16 textl" style="margin-left:13px;">
								课程描述：
							</td>							
							<td class="wid100 textl">
								<textarea cols=30px rows=5 name="describe"><%= p.getDescribe() %></textarea>								
							</td>							
						</tr>					
					</table>	
					
				</div>			
			</div>
			<a href="javascript:window.form1.submit()" class="flor marpc1 backgb padlr30 boxs5 textc borr5" 
			   style="margin-right:30px;padding-bottom:5px;padding-top:5px;color:#fff;">
				保存
			</a>
			</form>
			<a href="javascript:window.history.go(-1)" class="flor marpc1 backgw padlr30 colgy boxs5 textc borr5" 
			   style="margin-right:10px;padding-bottom:5px;padding-top:5px;" >
				返回
			</a>
		</div>
	
	</body>
</html>