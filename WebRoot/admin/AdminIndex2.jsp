<%@ page language="java" import="java.util.*" pageEncoding="utf8" contentType="text/html;charset=utf8" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf8">
    <link rel="shortcut icon" href="/Gouwu/images/icon/yscx.ico" type="image/x-icon"/>
  	<title>艺术创想校园管理中心</title> 
    <link rel="stylesheet" type="text/css" href="/Gouwu/css/base.css"> 
  	<style type="text/css">
  		iframe
  		{
			border-radius:10px;
		}
		.header{
			background:url("/Gouwu/images/background/chengguo.png") no-repeat;height:500px;
		}
		.header1{
			background:url("/Gouwu/images/background/chengguo.png") no-repeat;height:500px;
			background-position:0% 120%; 
		}
		.ishide{
		 	display:none;  
		 	color:#B5B4B4;
		}
		/* 在navs被hover的时候list2的hidden属性被覆盖，就会显现出下拉菜单  */
		.isshow:hover >.ishide{
		 	display:block;
		 	
		}
		/* 导航刚开始的样子   */
		.isshow{
			line-height:50px;/* 让navs在hover的时候 不会使下拉菜单消失 */
			
		}		
		.isshow:hover{
			background-color:#009de6;		
		}
		/* item被呼出的效果   */
		.is{
			box-shadow:1px 1px 2px #B5B4B4,1px 1px 2px #B5B4B4;
		}
		/* item被hover后的效果  */
		.is:hover{
			background:#03a9f4;
			color:#fff;
		}
  	</style>
    <script type="text/javascript">
    	state=0;
    	menuState=0;
    	mainState=0;    
    </script>
  </head>
  <body>
  	    <div class="widpc100 backgb" style="position:fixed;top:0;height:50px;
			 box-shadow:5px 5px 8px #B5B4B4,-5px 5px 8px #B5B4B4;" id="nav">
		  <nav style="" class="overfh">
			<div class="flol" style="margin-right:15%;margin-left:7%;">
				<a href="AdminIndex2.jsp" style="color:white;" class="fontw700">				
					<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:30px;">艺术创想
				</a>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="UserList1.jsp" class="" target="main" style="color:#fff;">用户管理</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="UserList1.jsp" target="main" class="" onclick="window.location.href='#a'" >
						<div class="is colgy backgw" style="line-height:34px">用户列表</div>						
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="CategoryList1.jsp" class="" target="main" style="color:#fff;">课程类别</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="CategoryList1.jsp" target="main" class="" >
						<div class="is colgy backgw"style="line-height:34px">类别列表</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="ProductList1.jsp" class="" target="main" style="color:#fff;">课程管理</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="ProductList1.jsp" target="main" class="" >
						<div class="is colgy backgw"style="line-height:34px">课程列表</div>
					</a>
					<a href="ProductSearch1.jsp" target="main" class="" >
						<div class="is colgy backgw"style="line-height:34px">课程搜索</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="OrderList1.jsp" class="" target="main" style="color:#fff;">报名管理</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="OrderList1.jsp" target="main" class="" >
						<div class="is colgy backgw"style="line-height:34px">报名列表</div>
					</a>		
				</div>
			</div>
			
			<div class="isshow flol textc" style="margin-top:0px;width:100px;padding-bottom:1px;">
				<a href="/Gouwu/servlet/SalesCountServlet" class="" target="main" style="color:#fff;">数据统计</a>
				<div class="ishide " style="line-height:35px;  ">						
					<a href="/Gouwu/servlet/SalesCountServlet" target="main" class="" >
						<div class="is colgy backgw"style="line-height:34px">分类统计</div>
					</a>		
				</div>
			</div>
			
	
			<div class="itemshow flol" style="margin-top:0px;margin-left:10%;" >
				<a href="" style="color:white;">
					<img src="/Gouwu/images/icon/user.png" class="wida" 
						 style="height:20px;margin-right:5px;">
					管理员
				</a>
				<div class="itemhide" style="width:150px;padding-bottom:5px;">
					<a href="Orderstatus1.jsp">
						<div class="item borrt5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
							待处理订单
						</div>
					</a>
					<a href="Index1.jsp?action=exit">
						<div class="item borrb5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
							退出
						</div>
					</a>					
				</div>
			</div>
		
		  </nav>
	  </div>	
  
	  <div class="heia widpc100 " style="padding:8% 5% 5% 5%;">
	   	<div class="boxs10 widpc90 borr10">
	   	    <div class="flol" style="">
				<a href="/Gouwu/Index1.jsp" style="" class="fontw700 colb">				
					<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:100px;">艺术创想
				</a>
			</div>	
	   	  <div class="header borr10">
	      </div>
	      <iframe frameborder=0 id="a"  style="padding:5% 5% 5% 5%;height:500px;width:90%;" 
	      		  src="OrderList1.jsp" class="boxs10" scrolling="yes" name="main"></iframe>
	      
	      <iframe style="" frameborder=0 height=500px width=100% class="boxs10" 
	      		  src="" scrolling="yes" name="detail"></iframe>
	      <div class="header1 borr10">
	      </div>		  
	  	</div>
	  </div>
  </body>
</html>

