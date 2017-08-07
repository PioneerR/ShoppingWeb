<%@ page language="java" import="java.util.*" pageEncoding="utf8" %>
<%@ page contentType="text/html;charset=utf8" import="user.*" %>

<%
	request.setCharacterEncoding("utf8");//若该句不写，数据库的数据会是乱码
	String action=request.getParameter("action");//判定是否有提交事件
	
	if(action!=null && action.equals("register"))
	{
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String phone=request.getParameter("phone");
		String address=request.getParameter("address");
		
		User u=new User();
		u.setUsername(username);
		u.setPassword(password);
		u.setPhone(phone);
		u.setAddress(address);
		u.setDate(new Date());
		u.save();
		
		out.println("恭喜您注册成功！");
		return;//常常用于提交回本页面并将数据转交到后台进行存储的操作
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>用户注册</title>
    <style type="text/css">
    	/*@import url("/Gouwu/css/div.css");*/  
    	/*background-color*/
		.backg{background-color: #000;}
		.backgw{background-color: #fff;}
		.backgg{background-color: #B5B4B4;}
		.backgb{background-color: #03a9f4;}
		.backgr{background-color: #F44336;}
		/*color*/
		.col{color: #000;}
		.colw{color: #fff;}
		.colg{color: #B5B4B4;}
		.colr{color: #F44336;}
		.coly{color: #efbb24;}
		.colg{color: #00aa90;}
		.colb{color:  #03a9f4;}
		
		/*font-size:px*/
		.fonts14{font-size: 14px;}
		.fonts16{font-size: 16px;}
		.fonts18{font-size: 18px;}
		.fonts20{font-size: 20px;}
		.fonts24{font-size: 24px;}
		/*font-family*/
		.fonta{font-family:Arial;}
		.fontt{font-family:Tahoma;}
		.fontv{font-family:Verdana;}
		.fonts{font-family:Simsun;}
		.fontl{font-family:'Lucida Console';}
		.fontw{font-family:'Microsoft Yahei';}
		
		/* text-align */
		.textc{text-align:center;}
		.textr{text-align:right;}
		.textl{text-align:left;}
		.textj{text-align:justify;}
		/*text-decoration*/
		.textdn{text-decoration: none;}
		.textdu{text-decoration: underline;}
		
		/*letter-spacing*/
		.letters1{letter-spacing: 0.5em;}
		.letters2{letter-spacing: 1em;}
		.letters3{letter-spacing: 1.5em;}
		.letters4{letter-spacing: 2em;}
		
		/* position */
		.posr{position:relative;}
		.posa{position:absolute;}
		
		/*box-shadow*/
		.boxsb{box-shadow:0px 0px 20px 0px #03a9f4;}
		.boxsg{box-shadow:0px 0px 20px 0px #B5B4B4;}
		
		/* float */
		.flol{float:left;}
		.flor{float:right;}
		
		/*z-index*/
		.zin-1{z-index:-1;}
		.zin1{z-index:1;}
		
		/*border-solid*/
		.bors{border: solid #000 1px;}
		.borsw{border: solid #fff 1px;}
		.borsg{border: solid #B5B4B4 1px;}
		.borsr{border: solid #F44336 1px;}
		.borsy{border: solid #efbb24 1px;}
		.borsb{border: solid #03a9f4 1px;}
		.borsg{border: solid #00aa90 1px;}
		
		/*border-solid -bottom*/
		.borsb{border:none; border-bottom:solid #000 1px}
		.borsbw{border:none; border-bottom:solid #fff 1px}
		.borsbg{border:none; border-bottom:solid #B5B4B4 1px}
		.borsbr{border:none; border-bottom:solid #F44336 1px}
		.borsby{border:none; border-bottom:solid #efbb24 1px}
		.borsbb{border:solid #03a9f4 1px}
		.borsbg{border:none; border-bottom:solid #00aa90 1px}
		
		
		/*border-radius*/
		.borr5{border-radius:5px}
		.borr10{border-radius:10px}
		.borr15{border-radius:15px}
		.borr20{border-radius:20px}
		.borr25{border-radius:25px}
		/*border-radius-top*/
		.borrt5{border-radius:5px 5px 0px 0px}
		.borrt10{border-radius:10px 10px 0px 0px}
		.borrt15{border-radius:15px 15px 0px 0px}
		.borrt20{border-radius:20px 20px 0px 0px}
		.borrt25{border-radius:25px 25px 0px 0px}
		/*border-radius-bottom*/
		.borrb5{border-radius:0px 0px 5px 5px}
		.borrb10{border-radius:0px 0px 10px 10px}
		.borrb15{border-radius:0px 0px 15px 15px}
		.borrb20{border-radius:0px 0px 20px 20px}
		.borrb25{border-radius:0px 0px 25px 25px}
		
		/*margin:%*/
		.marpc0{margin: 0%;}
		.marpc1{margin: 1%;}
		.marpc2{margin: 2%;}
		.marpc5{margin: 5%;}
		.marpc15{margin: 15%;}
		.marpc20{margin: 20%;}
		.marpc25{margin: 25%;}
		/*margin-top&bottom:%*/
		.martbpc1{margin: 1% 0;}
		.martbpc2{margin: 2% 0;}
		.martbpc5{margin: 5% 0;}
		.martbpc15{margin: 15% 0;}
		.martbpc20{margin: 20% 0;}
		.martbpc25{margin: 25% 0;}
		/*margin-left&right:%*/
		.marlrpc0{margin:0 0%;}
		.marlrpc1{margin:0 1%;}
		.marlrpc2{margin:0 2%;}
		.marlrpc5{margin:0 5%;}
		.marlrpc15{margin:0 15%;}
		.marlrpc20{margin:0 20%;}
		.marlrpc25{margin:0 25%;}
		
		/*margin:px*/
		.mar0{margin: 0px;}
		.mar1{margin: 1px;}
		.mar2{margin: 2px;}
		.mar5{margin: 5px;}
		.mar10{margin: 10px;}
		.mar15{margin: 15px;}
		.mar20{margin: 20px;}
		.mar25{margin: 25px;}
		/*margin-top&bottom:px*/
		.martb1{margin: 1px 0;}
		.martb2{margin: 2px 0;}
		.martb5{margin: 5px 0;}
		.martb10{margin: 10px 0;}
		.martb15{margin: 15px 0;}
		.martb20{margin: 20px 0;}
		.martb25{margin: 25px 0;}
		/*margin-left&right:px*/
		.marlr1{margin:0 1px;}
		.marlr2{margin:0 2px;}
		.marlr5{margin:0 5px;}
		.marlr10{margin:0 10px;}
		.marlr15{margin:0 15px;}
		.marlr20{margin:0 20px;}
		.marlr25{margin:0 25px;}
		
		/*padding:px*/
		.pad0{padding: 0px;}
		.pad1{padding: 1px;}
		.pad2{padding: 2px;}
		.pad5{padding: 5px;}
		.pad10{padding: 10px;}
		.pad15{padding: 15px;}
		.pad20{padding: 20px;}
		.pad25{padding: 25px;}
		.pad30{padding: 30px;}
		/*padding-top&bottom:px*/
		.padtb1{padding: 1px 0;}
		.padtb2{padding: 2px 0;}
		.padtb5{padding: 5px 0;}
		.padtb10{padding: 10px 0;}
		.padtb15{padding: 15px 0;}
		.padtb20{padding: 20px 0;}
		.padtb25{padding: 25px 0;}
		.padtb30{padding: 30px 0;}
		/*padding-left&right:px*/
		.padlr1{padding:0 1px;}
		.padlr2{padding:0 2px;}
		.padlr5{padding:0 5px;}
		.padlr10{padding:0 10px;}
		.padlr15{padding:0 15px;}
		.padlr20{padding:0 20px;}
		.padlr25{padding:0 25px;}
		.padlr30{padding:0 30px;}
		
		/*padding:%*/
		.padpc0{padding: 0%;}
		.padpc1{padding: 1%;}
		.padpc2{padding: 2%;}
		.padpc5{padding: 5%;}
		.padpc10{padding: 10%;}
		.padpc15{padding: 15%;}
		/*padding-top&bottom:%*/
		.padtbpc1{padding: 1% 0%;}
		.padtbpc2{padding: 2% 0%;}
		.padtbpc5{padding: 5% 0%;}
		.padtbpc10{padding: 10% 0%;}
		.padtbpc15{padding: 15% 0%;}
		/*padding-left&right:%*/
		.padlrpc1{padding:0% 1%;}
		.padlrpc2{padding:0% 2%;}
		.padlrpc5{padding:0% 5%;}
		.padlrpc10{padding:0% 10%;}
		.padlrpc15{padding:0% 15%;}
		
		/*auto*/
		.wida{width: auto;}
		.heia{height: auto;}
		.marlra{margin-left: auto; margin-right: auto;}
		
		/*width:px*/
		.wid100{width: 100px;}
		.wid200{width: 200px;}
		.wid300{width: 300px;}
		.wid400{width: 400px;}
		.wid500{width: 500px;}
		.wid600{width: 600px;}
		.wid700{width: 700px;}
		.wid800{width: 800px;}
		.wid900{width: 900px;}
		/*width:%*/
		.widpc10{width: 10%;}
		.widpc20{width: 20%;}
		.widpc25{width: 25%;}
		.widpc30{width: 30%;}
		.widpc33{width: 33.3%;}
		.widpc40{width: 40%;}
		.widpc50{width: 50%;}
		.widpc60{width: 60%;}
		.widpc66{width: 66.6%;}
		.widpc70{width: 70%;}
		.widpc75{width: 75%;}
		.widpc80{width: 80%;}
		.widpc90{width: 90%;}
		.widpc100{width: 100%;}
		
		/*height:px*/
		.hei100{height: 100px;}
		.hei200{height: 200px;}
		.hei300{height: 300px;}
		.hei400{height: 400px;}
		.hei500{height: 500px;}
		.hei600{height: 600px;}
		.hei700{height: 700px;}
		/*height:%*/
		.heipc50{height: 50%;}
		.heipc60{height: 60%;}
		.heipc70{height: 70%;}
		.heipc80{height: 80%;}
		.heipc90{height: 90%;}
		.heipc100{height: 100%;}
		
		input{
		  color: #B5B4B4;
		  font-size: 16px;
		  width: 70%;
		  border: none;
		  border-bottom: solid #B5B4B4 1px;
		  margin: 6% 0 3% 0;
		}
		
		.header-filter{
		  background-color:rgba(0,0,0,0.3);
		  width: 100%;
		  height: 100%;
		  position: absolute;
		  top:0;
		  left:0;
		}
		.header{
		  background:url("https://ws1.sinaimg.cn/large/006tKfTcly1fg2bd499yqj31jk18g7gr.jpg")no-repeat;
		  background-position: 70% 40%;
		  position: absolute;
		  top:0;
		  left:0;
		  width: 100%;
		  height: 100%;
		}
    </style>
  </head>
  <body>

    <div class="header">
      <div class="header-filter">
          <form method="post" action="Register1.jsp" style="padding-bottom:0"
          	class="widpc25 heia borr10 padtb30 boxsg backgw marlra marpc15 colb textc fonts16 letters1">
  			<input type="hidden" name="action" value="register" />
          	  邮箱注册<br>
          	<input type="text" name="username" placeholder="用户名"/><br>
          	<input type="text" name="phone" placeholder="手机号码"/><br>
          	<input type="password" name="password" placeholder="登录密码" /><br>
          	<input type="password" name="password2" placeholder="确认密码" /><br>
          	
          	<input type="submit" value="注册"  name="regsubmit" style="border-bottom:none;margin-top:30;"
          		   class="backgb colw borr25 padtb10 wid100 fonts16"/>
          </form>
      </div>
    </div>

  </body>
</html>
