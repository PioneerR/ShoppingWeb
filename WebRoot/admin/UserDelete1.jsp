<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
<%@ page import="java.util.*,user.*" %>

<%
	int id=Integer.parseInt(request.getParameter("id"));
	String url = request.getParameter("from");
	User.delete(id);
%>

<!DOCTYPE HTML>
<html>
	<head>
		<title>信息提示</title>
		<meta http-equiv="Content-type" content="text/html; charset=utf8">
	</head>
	<body>
		<span>恭喜您，删除成功！1秒钟后，跳转到上一个页面......</span>
		<script type="text/javascript">
			parent.main.location.reload();
			//parent.main.location.reload();//可能更好的方式是用ajax进行操作，因为用当前方法会出现重新此前动作数据	    
		</script>		
	</body>
</html>


	
 














