<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	int id=Integer.parseInt(request.getParameter("id"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>产品封面上传</title>
	</head>
	<body>
		<form action="/Gouwu/servlet/FileUpload" method="post" encTYPE="multipart/form-data" >
		    <input type="hidden" name="id" value="<%= id %>" />
			产品图片上传：
			<input type="file" name="img" />
			<input type="submit" value="提交" />	
		</form>
	</body>
</html>










