<%@ page import="product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="category.*,java.util.*"  %>

<%
	request.setCharacterEncoding("utf8");
	List<Product> products=ProductMgr.getInstance().getProducts();	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
		<title>产品列表</title>
		<style type="text/css">
			td{
				text-align:center;
				border:3px solid #fff1cc;
			}
			a{
				text-decoration: none;
			}
		
		</style>
		<script type="text/javascript">
		//checkbox有两个值，勾选为真，不勾选为假
			window.onload=function()
			{
				var checkboxs=document.getElementsByName("delete");
				//getElementByName在火狐浏览器是可以用的
				//checkbox中的checked属性值有true与false，true也可以是true
				var deleteall=document.getElementById("deleteall");
				deleteall.onclick=function()
				{
					if(this.checked==true)
					{
						
						for(var i=0;i<checkboxs.length;i++)//用var进行定义
						{
							checkboxs[i].checked=true;
						}
					}
					else
					{
						for(var i=0;i<checkboxs.length;i++)//用var进行定义
						{
							checkboxs[i].checked=false;
						}
					}
				}
			}
		</script>
	</head>
	<body>
		<span>产品管理 &raquo;产品列表 </span><br>
		<div style="text-align:center">
			<span><a href="ProductAdd1.jsp" target="detail" >添加新产品</a></span>
		</div>
		<table width=100% style="border:3px solid #fff1cc;border-collapse:collapse; ">
			<tr style="background-color:#fff1cc;" >
				<th>选择</th>
				<th>产品ID</th>
				<th>产品名称</th>
				<th>产品描述</th>
				<th>市场价格</th>
				<th>会员价格</th>
				<th>上架时间</th>
				<th>所属类别</th>
				<th>处理</th>
			</tr>
			<form action="ProductDelete1.jsp?parameter=x" target="detail" method="post" >
		<%
			for(int i=0;i<products.size();i++)
			{
				Product p=products.get(i);//集合取出的方式是 get，数组取出方式是[]
				Category c=ProductMgr.getInstance().getCategory(p.getCategoryId());
				//通过产品类别的id号，取得产品类别，进而获取类别属性
		%>
			<tr>
				<td><input type="checkbox" name="delete" value="<%= p.getId()  %>" /></td>
				<td><%= p.getId() %></td>
				<td><%= p.getName() %></td>
				<td><%= p.getDescribe() %></td> 
				<td><%= p.getNormalPrice() %></td>
				<td><%= p.getMemberPrice() %></td>
				<td><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(p.getDate()) %></td>
				<td><%= c.getName()+c.getCno() %></td>
				<td>
					<a name="delete1" href="ProductDelete1.jsp?id=<%= p.getId() %>&parameter=1" target="detail" onclick="return confirm('真的要删除吗？')">删</a>
					&nbsp;&nbsp;
					<a name="modify" href="ProductModify1.jsp?id=<%= p.getId() %>&action=modify" target="detail" >改</a>
					&nbsp;&nbsp;
					<a name="upload" href="ProductUpload1.jsp?id=<%= p.getId() %>" target="detail" >上传</a>
				</td>
			</tr>	
		<%
			}
		%>	
		<tr>
			<td>		
				<input type="checkbox" id="deleteall" />
				<input type="submit" value="删除" onclick="return confirm('真的要删除吗?')" />		
			</td>
			</form>	<!-- 注意，要提交的数据，一定要放在form表单内部，比如checkbox，否则会空指针异常 -->
			<td colspan=8 >
				<form action="ProductList1.jsp" method="post" >
					<input type="text" name="search" />搜索
					<input type="submit" value="提交" />
				</form>
			</td>			
		</tr>
		</table>
	</body>
</html>





