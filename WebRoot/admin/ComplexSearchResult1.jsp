<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="product.PruductSearchFormBean"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="product.ProductMgr" %>
<%@ page import="category.Category" %>
<%@ page import="product.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%!
	public int check(int a)
	{
		int n=0;
		if(a>10)
		{
			a=a-10;
			n++;
			check(a);//递归计算56中的整十数5
		}
		return n;
	}
%>

<%
	request.setCharacterEncoding("utf8");
	PruductSearchFormBean bean=new PruductSearchFormBean();
	
	String categoryIdStr=request.getParameter("categoryId");
	if(categoryIdStr!=null && !categoryIdStr.equals(""))
	{
		int categoryId=Integer.parseInt(categoryIdStr);
		bean.setCategoryId(categoryId);
	}
	else
	{
		int categoryId=-1;
		bean.setCategoryId(categoryId);
	}
	
	String nameStr=request.getParameter("productName");
	if(nameStr != null && !nameStr.equals(""))
	{
		String name=nameStr;
		bean.setName(name);
	}
	else
	{
		String name=null;
		bean.setName(name);
	}
	
	String lowNormalPriceStr=request.getParameter("lowNormalPrice");
	if(lowNormalPriceStr !=null && !lowNormalPriceStr.trim().equals(""))
	{
		double lowNormalPrice=Double.parseDouble(lowNormalPriceStr);
		bean.setLowNormalPrice(lowNormalPrice);
	}
	else
	{
		double lowNormalPrice=-1;
		bean.setLowNormalPrice(lowNormalPrice);
	}
	
	String highNormalPriceStr=request.getParameter("highNormalPrice");
	if(highNormalPriceStr !=null && !highNormalPriceStr.trim().equals(""))
	{
		double highNormalPrice=Double.parseDouble(highNormalPriceStr);
		bean.setHighNormalPrice(highNormalPrice);
	}
	else
	{
		double highNormalPrice=-1;
		bean.setHighNormalPrice(highNormalPrice);
	}
	
	String lowMemberPriceStr=request.getParameter("lowMemberPrice");
	if(lowMemberPriceStr !=null && !lowMemberPriceStr.trim().equals(""))
	{
		double lowMemberPrice=Double.parseDouble(lowMemberPriceStr);
		bean.setLowMemberPrice(lowMemberPrice);
	}
	else
	{
		double lowMemberPrice=-1;
		bean.setLowMemberPrice(lowMemberPrice);
	}
	
	String highMemberPriceStr=request.getParameter("highMemberPrice");
	if(highMemberPriceStr !=null && !highMemberPriceStr.trim().equals(""))
	{
		double highMemberPrice=Double.parseDouble(highMemberPriceStr);
		bean.setHighMemberPrice(highMemberPrice);
	}
	else
	{
		double highMemberPrice=-1;
		bean.setHighMemberPrice(highMemberPrice);
	}
	
	String startDateStr=request.getParameter("startDate");
	if(startDateStr !=null && !startDateStr.equals(""))
	{
		String startDate=startDateStr;
		bean.setStartDate(startDate);
	}
	else
	{
		String startDate=null;
		bean.setStartDate(startDate);
	}
	
	String endDateStr=request.getParameter("endDate");
	if(endDateStr !=null && !endDateStr.equals(""))
	{
		String endDate=endDateStr;
		bean.setEndDate(endDate);
	}
	else
	{
		String endDate=null;
		bean.setEndDate(endDate);
	}
	

	final int pageSize=5;
	int pageNo=1;
	String strPageNo=request.getParameter("pageNo");
	if(strPageNo!=null && !strPageNo.equals(""))
	{
		try
		{
			pageNo=Integer.parseInt(strPageNo);
			//虽然strPageNo不为空，但也有可能为其他数据类型
		}
		catch(NumberFormatException e)
		{
			pageNo=1;
		}
	}
	if(pageNo<=0)
	{
		pageNo=1;//虽然strPageNo是int的数据类型，但是有可能是负数
	}
%>


<%	
	List<Product>products =new ArrayList();
	int totalRecords=ProductMgr.getInstance().find(products, pageNo, pageSize, bean);
	int totalPages=(totalRecords-1)/pageSize+1;
	
	if(pageNo>totalPages)
	{
		pageNo=totalPages;//虽然strPageNo是int的数据类型，也是正数，但是有可能输入的值大于总页数
	}
	
	//点击浏览器后退按钮时，不读取该页缓存，并自动刷新本页面
	response.setHeader("Pragma","No-cache"); 		
	response.setHeader("Cache-Control","no-cache"); 
	response.setHeader("Cache-Control", "No-store");
	response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
	  	<title>艺术创想校园管理中心</title> 
	    <link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css">
	    <style type="text/css">
			hr{		
				border:none;
				border-top:1px dashed #03a9f4;
			}			
		</style>
	</head>
	<body>
		<div class="flol colgy fonts16 fontw700 martb10" style="margin-left:25px;">
			课程搜索结果
		</div>
			
		<div class="pad10 borr10" style="margin-bottom:30px; ">
			<table class="widpc100">
				<tr>	
					<td></td>			
					<td class="colgy">课程名称</td>
					<td class="colgy">课程描述</td>
					<td class="colgy">价格</td>
					<td class="colgy">会员价格</td>					
					<td class="colgy">所属类别</td>
					<td class="colgy">上架时间</td>
					<td></td>
				</tr>
				<tr><td colspan="8"><hr></td></tr>
				<%
					for(int i=0;i<products.size();i++)
					{
						Product p=products.get(i);//集合取出的方式是 get，数组取出方式是[]
						Category c=ProductMgr.getInstance().getCategory(p.getCategoryId());
						//通过产品类别的id号，取得产品类别，进而获取类别属性
				%>
				<tr>
					<td style="width:90px;">
						<a name="modify" href="ProductModify1.jsp?id=<%= p.getId() %>&action=modify">						
							<img src="/Gouwu/images/product/<%= p.getId()+".jpg" %>" class="borr10 boxs5"
							 	  style="height:80px;width:80px;" 
							 	  onerror="javascript:this.src='/Gouwu/images/product/yscx.png'"/>	
						</a> 	  				
					</td>				
					<td style="width:150px;" class="colb fontw700">
						<%= p.getName() %>
					</td>
					<td style="width:300px;" class="textl">					
						<%= p.getDescribe() %>					
					</td>
					<td style="width:60px;">
						<%= p.getNormalPrice() %>
					</td>
					<td style="width:70px;">
						<%= p.getMemberPrice() %>
					</td>					
					<td style="width:70px;">
						<% 
							if(c.getName()==null)
							{
								out.println("/");
							}
							else
							{
								out.println(c.getName());
							}
						%>
					</td>
					<td style="width:100px;" class="fonts14">
						<%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(p.getDate()) %>
					</td>
					<td style="">
					
						<a name="modify" href="ProductModify1.jsp?id=<%= p.getId() %>&action=modify" 
						   style="padding:3px 8px;color:#fff;" class="backgb borr5 boxs5">修改</a>
						   &nbsp;
						<a name="delete1" href="ProductDelete1.jsp?id=<%= p.getId() %>&parameter=1" 
						   onclick="return confirm('真的要删除吗？')" class="borr5 boxs5 backgb" 
						   style="padding:3px 8px;color:#fff;">删除</a>			
					</td>
				</tr>
				<tr><td colspan="8"><hr></td></tr>							
				<%
					}
				%>				
			</table>		
		</div>
		
		<form name="form1" method=post action="ProductList1.jsp" style="float:left" >
			<select name="pageNo" onchange="document.form1.submit()" class="textc" >
				<% 
					for(int i=1;i<=totalPages;i++)
					{
				%>
					<option value=<%=i%> <%=(pageNo==i)?"selected":""%>>第<%=i%>页</option>
				<%
					}
				%>
			</select>
		</form>
		<div style="margin-left:33%;" class="flol">
			<a href="ProductList1.jsp?pageNo=<%
							if(pageNo-1>0)
							{
								out.println(pageNo-1);
							}
							%>" class="boxs5 borr5 colgys" style="padding:3px 8px 3px 8px;">上一页</a>
				<%
					int a=1,b=totalPages;//如果不符合以下两个if,那么a=1,b==totalpages,此时
					int m=0;
					m=check(pageNo);
					if(totalPages>10 && m==0)
					{
						a=1;
						b=10;
					}
					else if(totalPages>10 && m>=1)
					{
						a=1+m*10;
						b=(m+1)*10;
						if(b>totalPages)
						{
							b=totalPages;
						}	
					}
					for(int i=a;i<=b;i++)
					{
				%>
					<a href="ProductList1.jsp?pageNo=<%= i %>" class="fonts18" 
						style="color:#03a9f4;margin-left:15px;"><%= i %></a>
				<%
					}
				%>
			<a href="ProductList1.jsp?pageNo=<%
							if(pageNo+1<=totalPages)
							{
								out.println(pageNo+1);
							}
							%>" class="boxs5 borr5 colgys pad5" 
				style="margin-left:15px;padding:3px 8px 3px 8px;">下一页</a>	
		</div>
		
		<form name="form2" method=post action="ProductList1.jsp" style="float:right" >
			<input type="text" name="pageNo" class="textc" value="<%= pageNo %>" size=6 />
			<input type="submit" name="submit" value="Go" />
		</form>

	</body>
</html>