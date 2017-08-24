<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
<%@ page import="java.util.*,user.*" %>

<%
	int id=Integer.parseInt(request.getParameter("id"));
	String url = request.getParameter("from");
	User.delete(id);
%>

	<script type="text/javascript">
		window.history.go(-1);
	</script>		
	

	
 














