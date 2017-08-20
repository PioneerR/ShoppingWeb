<%@ page language="java" import="java.util.*" pageEncoding="utf8" contentType="text/html;charset=utf8" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf8">
  	<title>艺术创想管理平台</title> 
    <link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css"> 
  	<style type="text/css">
  		iframe
  		{
			border-radius:15px;
		}
		html,body
		{
		    margin: 0;
		    padding: 0;
		    border: 0;
		    overflow: hidden;
		    height: 100%;
		}
  	</style>
    <script type="text/javascript">
    	state=0;
    	menuState=0;
    	mainState=0;    
    </script>
  </head>
  <body>
	  <iframe style="float:left;box-shadow:0 0 25px #B9B9B9;margin-left:20px;margin-top:30px;padding-left:20px;height:77%; " 
	          frameborder=0  width=15% src="menu1.html" scrolling="no" id="menu" name="mleft" >
	  </iframe>	 
	  <div class="heipc100 widpc80 flor">
	      <iframe style="border-radius:5px;margin-left:7px;" frameborder=0 height=5% width=15% 
	      src="title.html" scrolling="auto" name="mtitle"></iframe>
	      
	      <iframe style="border:solid blue 0px;margin:2% 0;" frameborder=0 height=45% width=100% 
	      src="" scrolling="yes" name="main"></iframe>
	      
	      <iframe style="border:solid blue 0px;" frameborder=0 height=40% width=100% 
	      src="" scrolling="yes" name="detail"></iframe>
	  </div>
  </body>
</html>

