<%@ page import="user.User"%>
<%@ page import="category.CategoryService"%>
<%@ page import="category.Category"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");
    List<Category> categories=CategoryService.getInstance().getCategoriesGradeTwo();
	User u=(User)session.getAttribute("user");
	
	String action=request.getParameter("action");
	if(action !=null && action.equals("exit"))
	{
		session.removeAttribute("user");
		response.sendRedirect("Index1.jsp");
	}
	
	//不论是第一次进入该页面，还是第二次返回该页面，都刷新页面，不保留表单信息
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
		<title>艺术创想</title>
	    <link type="text/css" rel="stylesheet" href="/Gouwu/css/base.css" /> 
	    <style type="text/css">
			.header{
			background:url("/Gouwu/images/background/timg.jpg") no-repeat;
			background-position: 50% 40%;
			position: absolute;
			top:0;
			left:0;
			z-index: -1;
			}
			.title{
			text-shadow:10px 10px 20px #373638;
			font-size: 55px;
			font-weight: 600;
			}
			.header-filter{
			background-color:rgba(0,0,0,0.3);
			position: absolute;
			top:0;
			left:0;
			}
			.title-text{
			font-size: 21px;
			text-align: center;
			text-shadow:10px 10px 20px #373638;
			}
			.button-1{
			 border:#F44336 solid;
			 border-radius:50px;
			 width: 100px;
			 text-align: right;
			 background: #F44336;
			 padding:10px;
			 padding-right: 20px;
			 margin: auto;
			 margin-bottom: 20px;			
			 transition:all 0.6s;
			}
			div.button-1:hover{
			 border:#F44336 solid;
			 border-radius:50px;
			 width: 100px;
			 text-align: right;
			 background: #F44336;
			 padding:10px;
			 padding-right: 20px;
			 margin: auto;
			 box-shadow:0px 0px 20px 0px #F44336;
			}
			.button-2{
			 width: 0px;
			 height: 0px;
			 padding:0px;
			 margin-left:15px;
			 float: left;
			 border-top: 10px solid transparent;
			 border-bottom: 10px solid transparent;
			 border-left: 20px solid #fff;
			}
			.section-top{
			margin: 40% 50px 0px ;
			box-shadow:10px 25px 15px #B5B4B4,
					  -10px 25px 15px #B5B4B4;
			z-index:1;
			}
			.section-mid{
			margin: 0px 50px 0px;
			padding: 10% 0%;
			box-shadow:10px 25px 15px #B5B4B4,
						-10px 25px 15px #B5B4B4;
			}
			.section-bottom{
			background:url("https://ws3.sinaimg.cn/large/006tKfTcly1fg2cterovzj31kw0fge7n.jpg")no-repeat;
			background-size: cover;
			margin: 0px 50px 100px;
			box-shadow:10px 25px 15px #B5B4B4,
						-10px 25px 15px #B5B4B4;
			}
			.section-photo{
			background: url("https://ws1.sinaimg.cn/large/006tKfTcly1fg2e1y440tj304g04g0nx.jpg")repeat;
			}
	    </style>
	    <script type="text/javascript">
	    	window.onscroll=function()
	    	{
	    		var t=document.documentElement.scrollTop || document.body.scrollTop;
	    		var nav=document.getElementById("nav");
	    		if(t<=500)
	    		{
	    			nav.style.backgroundColor='rgba(50,170,220,-0.1)';
	    			nav.style.boxShadow='none';
	    		}
	    		else
	    		{
	    			nav.style.backgroundColor='rgba(50,170,220,1)';//如果用双引号就会无效
	    			nav.style.boxShadow='5px 5px 8px #B5B4B4,-5px 5px 8px #B5B4B4';
	    		} 
	    	}
	    </script>
	</head>
	<body>
		<div class="widpc100" style="position:fixed;top:0;height:70px;" id="nav">
			<nav style="" class="overfh">
				<div class="flol" style="margin-right:20px;margin-left:7%;">
					<a href="Index1.jsp" style="color:white;" class="fontw700">				
						<img src="/Gouwu/images/icon/yscx.png" class="wida" style="height:50px;">艺术创想
					</a>
				</div>
				
				<div class="itemshow flol wid100 textc" style="margin-top:17px; ">
					<a href="ShowProducts1.jsp" class="" style="color:#fff;">课程</a>
					<div class="itemhide" style="margin-left:18%;width:150px;padding-bottom:5px;">
					<%
						Category cg=categories.get(0);				
					%>		
						<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>">
							<div class="item backgw borrt5 textc fonts16 colgy" style="line-height:37px;">
								<%= cg.getName() %>
							</div>
						</a>						
					<%						
						for(int i=1;i<categories.size()-1;i++)
						{							
							cg=categories.get(i);							
					%>	
						<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>">
							<div class="item backgw textc fonts16 colgy" style="line-height:37px;">
								<%= cg.getName() %>
							</div>
						</a>
					<%
						}
							cg=categories.get(categories.size()-1);							
					%>
						<a href="ShowProducts1.jsp?categoryId=<%= cg.getId() %>" >
							<div class="item backgw borrb5 textc fonts16 colgy" style="line-height:37px;">
								<%= cg.getName() %>
							</div>
						</a>	
					</div>
				</div>
				
				<div class="itemshow flol wid100 textc" style="margin-top:17px;margin-left:45%; ">
					<a href="Buy1.jsp" class="" style="color:#fff;">
						<img src="/Gouwu/images/background/cart2.png" class="wida" style="height:22px;">
					</a>
					<div class="itemhide" style="width:150px;padding-bottom:5px; ">
						<a href="Buy1.jsp">
							<div class="item backgw textc fonts16 colgy borr5" style="line-height:37px;margin-right:15%;">
								查看购物车
							</div>
						</a>
					</div>
				</div>
				
		<%
			if(u==null)
			{
		%>	
				<div class="flol marlr15" style="margin-top:25px;" >
					<a href="Register1.jsp" style="color:white;">
						<img src="/Gouwu/images/icon/signup.png" class="wida" style="height:20px;margin-right:5px;">注册
					</a>
				</div>
				<div class="flol marlr15" style="margin-top:25px;" >
					<a href="UserLogin1.jsp?url=index" style="color:white;">
						<img src="/Gouwu/images/icon/signin.png" class="wida" style="height:20px;">登录
					</a>
				</div>
		<%
			}
			else
			{
		%>
				<div class="itemshow flol marlr15" style="margin-top:17px;" >
					<a href="" style="color:white;">
						<img src="/Gouwu/images/icon/user.png" class="wida" 
							 style="height:20px;margin-right:5px;">
						<%= u.getUsername() %>
					</a>
					<div class="itemhide" style="width:150px;padding-bottom:5px;">
						<a href="Orderstatus1.jsp">
							<div class="item borrt5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
								我的订单
							</div>
						</a>
						<a href="Index1.jsp?action=exit">
							<div class="item borrb5 textc backgw colgy fonts16" style="line-height:37px;margin-right:10%;">
								退出
							</div>
						</a>					
					</div>
				</div>
		<%
			}
		%>	
			</nav>
		</div>
		
		<div class="widpc100 heipc100 header">
	      <div class="widpc100 heipc100 header-filter">
	          <div class="heia wida textc" style="padding-top:15%">
	            <h1 class="title coly" >与孩子有关的一切，都充满意义 </h1>
	            <p class="title-text coly">艺术创想，带孩子到属于他的绘画王国，与大师结盟，开启充满想象的艺术之旅</p>
	          </div>
	          
	          <div class="wid100" style="margin-left:46%;">
		          <a href="ShowProducts1.jsp">
			          <div class="button-1">
			            <div class="button-2"></div>
			          	<div class="title-text colw" style="font-size:14px;">开始上课</div>
			          </div>
		          </a>
	          </div>
	      </div>
	    </div>

	    <div class="section-top section-photo borrt20 fonts30 padtbpc10">
	      <div class="heia widpc100">
	        <div class="heia wida textc colb">
	          <h3 style="margin:0px;">不仅要「得到」，还要「做到」</h3>
		        <p style="font-size:20px;" >
		          <br>以认知科学原理为基础，我们打造了科学高效的认知学习法
		          <br>帮助人们快速提升学习效率，完成认知升级
		          <br>同时，我们以认知学习法重塑了职业技能教育
		          <br>不仅要「得到」，还要让你快速从零到「做到」
		        </p>
	        </div>
	      </div>
	    </div>

	    <div class="section-mid heipc100 wida backgw" style="overflow:hidden;">
	        <div class="heia widpc30 flol colb" style="margin-left:9%;margin-right:1%;">
	          <h3 style="margin:20px;" class="fonts30" >手把手极简教程</h3>
		        <p  style="font-size:20px;">
		          <br>以「做到」为原则的教程体系，第一件事就是输出完整作品。
		          <br>
		          <br>传统的教程一开始就教你基础理论和原理，但通常来说，这样的学习很容易让你从入门到放弃，这不符合认知原理。
		          <br>
		          <br>我们的教学根据认知原理重塑，详细到无需思考仅需照做，第一件事就是让你学习做出完成作品。
		        </p>
	        </div>
			<div class="flol widpc50">
				<img src="https://ws1.sinaimg.cn/large/006tNbRwgy1fg02h3qy53j31b30z1wi9.jpg" style="width:100%;"/>
	        </div>
	    </div>


      <div  class="heia wida section-mid backgw" style="overflow:hidden;">
		<div style="margin-left:5%;margin-right:10%;width:45%" class="heia flol">
			<img src="https://ws2.sinaimg.cn/large/006tNbRwgy1fg02glp0h3j310b0m5jvk.jpg" class="widpc100" />
        </div>
        <div class="heia widpc30 flol colb" > <!--块级宽度会影响排版-->
          <h3 style="margin:25px;" class="fonts30">学习游戏化</h3>
	        <p style="font-size:20px;">
	          <br>为什么学习不可以像游戏一样，让人沉迷上瘾呢？
	          <br>
	          <br>课程内容，将被设计成不同的策略、竞技、对抗游戏，让大家通过游戏速成新技能。
	        </p>
        </div>
      </div>

	    <div class="section-mid heipc100 wida backgw" style="overflow:hidden;">
	  		<div class="heia widpc30 flol colb" style="margin-left:9%;margin-right:7%;">
	          <h3 style="margin-top:50px;" class="fonts30">全面辅导</h3>
		        <p style="font-size:20px;">
		          <br>一切的学习均是社交。
		          <br>
		          <br>认知科学认为，越是社会化的学习，你能获取信息量越多，理解得越深。
		          <br>
		          <br>我们不定期邀请牛人分享，通过线下聚会、及线上社群进行社会化学习，学习的过程与同学交流切磋。
		          <br>
		          <br>同时，老师以及助教会全程答疑。
		        </p>
	        </div>
			<div class="flol" style="width:45%">
				<img src="https://ws1.sinaimg.cn/large/006tNbRwgy1fg02gidqsbj314010bn0k.jpg" style="width:100%;"/>
	        </div>
	      </div>


	    <div class="section-mid section-photo" style="overflow:hidden;">
	        <div class="heia wida colb fonts30 textc">
		       <h5 style="margin:0 0 100px 0" class="fonts30">牛 人 推 荐</h5>
		
		       <div class="heipc70 wida padtbpc1 padlrpc2" >
		
		        <div class=" heipc100 widpc20 flol padtb10 marlrpc2" style="margin-left:3%">
		          <div class="heia wida colb fonts30 textc">
		            <img src="http://odau7u92l.bkt.clouddn.com/%E6%9D%8E%E7%AC%91%E6%9D%A5.jpg" class="widpc70 heia"
								 style="border-radius:80%;box-shadow:0px 0px 5px 5px #B5B4B4"/>
		            <p style="font-size:18px">李笑来</p>
		            <p style="font-size:16px;">中国比特币首富</p>
		            </div>
		            <div class="heia wida fonts30 colb textl">
		            <p style="font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;老朋友了解，‘认知’是我多年研究的主题。不搞清楚‘大脑’如何运作，
									再努力也是无用。刘传这小伙儿相当Sharp，不仅自己摸透了‘大脑’，还总结出了体系化的课程。</p>
		          </div>
		        </div>
		
		        <div class="heipc100 widpc20 flol padtb10 marlrpc2">
		          <div class="heia wida colb fonts30 textc">
		            <img src="http://odau7u92l.bkt.clouddn.com/%E6%9D%8E%E5%8F%AB%E5%85%BD.jpg" class="widpc70 heia"
		                 style="border-radius:80%;box-shadow:0px 0px 5px 5px #B5B4B4"/>
		            <p style="font-size:18px ">李靖</p>
		            <p style="font-size:16px;">百度副总裁</p>
		          </div>
		          <div class="heia wida fonts30 colb textl">
		            <p style="font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;谁也不能否认，在这个每天都在变化的时代里，学习的质量和速度已然成为了决定人价值的重要因素。
		              	可大部分人这么多年一直在学习，却从没学习过如何学习。推荐千古刘传的《认知学习法》，你应该重新学习下，如何学习！</p>
		          </div>
		        </div>
		
		        <div class="heipc100 widpc20 flol padtb10 marlrpc2">
		          <div class="heia wida colb fonts30 textc">
		            <img src="http://odau7u92l.bkt.clouddn.com/xdite.jpg" class="widpc70 heia"
		                 style="border-radius:80%;box-shadow:0px 0px 5px 5px #B5B4B4"/>
		            <p style="font-size:18px ">Xdite</p>
		            <p style="font-size:16px;">全栈营创始人</p>
		          </div>
		          <div class="heia wida fonts30 colb textl">
		            <p style="font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;千古刘传的认知学习法，是我接触认知心理学的第一道契机。
		              	他的课深入浅出，让我从此一头钻进认知心理学的领域，此后我将认知心理学应用在教学上，设计出了全栈营学习生态体系。</p>
		          </div>
		        </div>
		
		        <div class="heipc100 widpc20 flol padtb10 marlrpc2">
		          <div class="heia wida colb fonts30 textc">
		            <img src="http://odau7u92l.bkt.clouddn.com/%E6%88%90%E7%94%B2.jpg" class="widpc70 heia"
		                 style="border-radius:80%;box-shadow:0px 0px 5px 5px #B5B4B4"/>
		            <p style="font-size:18px ">成甲</p>
		            <p style="font-size:16px;">《好好学习》作者</p>
		          </div>
		          <div class="heia wida fonts30 colb textl">
		            <p style="font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;掌握学习的认知原理是具备科学学习能力的关键。
		            	刘传一直致力于研究认知科学，推荐你学习《认知学习法》，掌握高效学习背后的原理！</p>
		          </div>
		        </div>
		
		       </div>
	        </div>
	    </div>
	    <div class="section-bottom borrb20 padtbpc5 fonts30 colb textc">
	      <h3>现在开始认知升级</h3>
	    </div>
	    
	    <div class="widpc100 backgbs" style="height:100px;padding-top:30px;background-color:#eafbf6;">
	    	<div class="widpc100 heia">
		    	<div class="flol backgr" style="margin-right:20px;margin-left:45%;border-radius:60%;height:40px;width:40px;">
			    	<a href="" target="_blank" style="position:relative;left:22%;top:22%;">				
						<img src="/Gouwu/images/icon/weibo.png" class="wida" style="height:20px;border-radius:50%">
					</a>
				</div>
				<div class="flol" style="margin-right:20px;border-radius:60%;height:40px;width:40px;background-color:#4867AA;">
					<a href="" target="_blank" style="position:relative;left:20%;top:20%;">				
						<img src="/Gouwu/images/icon/facebook.png" class="wida" style="height:25px;border-radius:50%">
					</a>
				</div>
				<div class="flol backg" style="margin-right:20px;border-radius:60%;height:40px;width:40px;">
					<a href="https://github.com/PioneerR" style="position:relative;left:20%;top:20%;">				
						<img src="/Gouwu/images/icon/github.png" class="wida" style="height:25px;border-radius:50%">
					</a>
				</div>
			</div>
			<div class="flol heia martbpc1 fonts14" style="margin-left:38%;">
				Copyright © 2017 艺术创想  Designed by 
				<a href="https://github.com/PioneerR" target="_blank" style="color:#03a9f4;">PioneerR</a>
			</div>
	    </div>
	</body>
</html>



