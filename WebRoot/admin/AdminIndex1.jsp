<%@ page language="java" import="java.util.*" pageEncoding="utf8" 
contentType="text/html;charset=utf8" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf8">
    <link rel="stylesheet" type="text/css" href="/Gouwu/css/mine.css"> 
    <script type="text/javascript">
    	state=0;
    	menuState=0;
    	mainState=0;    
    </script>
  	<title>管理员主页</title> 
  	<style type="text/css">
  		iframe{
			border-radius:15px;
		}
  	</style>
  </head>
  <body>
	  <iframe style="float:left;box-shadow:0 0 25px #B9B9B9;margin-left:20px;
	  			margin-top:30px;padding-left:20px;" frameborder=0 height=77% width=15% 
	  			src="menu1.html" scrolling="auto" id="menu" name="mleft" ></iframe>
	  <div class="heipc100 widpc80 flor">
	      <iframe style="border-radius:5px;margin-left:7px;" frameborder=0 height=5% width=15% 
	      src="title.html" scrolling="no" name="mtitle"></iframe>
	      
	      <iframe style="border:solid blue 0px;margin:2% 0;" frameborder=0 height=45% width=100% 
	      src="" scrolling="yes" name="main"></iframe>
	      
	      <iframe style="border:solid blue 0px;" frameborder=0 height=40% width=100% 
	      src="" scrolling="yes" name="detail"></iframe>
	  </div>
  </body>
</html>

