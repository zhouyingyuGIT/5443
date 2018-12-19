<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="com.lattice.entity.*"%>
<%@ page language="java" import="com.lattice.dao.*,java.util.*"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta id="viewport" name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1, maximum-scale=1, user-scalable=no">
		
		
		<script type='text/javascript' src='require.js'></script>
		<script type='text/javascript' src='play68.js'></script>
		<script type='text/javascript' src='play68bar.js'></script>
		<script type='text/javascript' src='doNotTouchWhite.js'></script>
		
		<title>看谁踩方块多</title>
		<style type="text/css">
			body {
				margin:0px;
				overflow:hidden;
				background: #000;
			}
		</style>
		
		   
</head>


<%
    

Users u=(Users)request.getSession().getAttribute("cu");
int uid=u.getUserid();
int taskid=Integer.parseInt(request.getParameter("taskid"));

int codematerial=0;

String lan=request.getParameter("lan");
String targetpagename=request.getParameter("targetpagename");


int projectid=0;
if (!(request.getParameter("projectid")==null))	{
projectid=Integer.parseInt(request.getParameter("projectid"));
}

int sumitcoids=u.getCoid();


%>

<body>
		<div style="text-align:center;">
			<canvas id="linkScreen" width="320" style="width: 320px; height: 480px; " height="480">
				很遗憾，您的浏览器不支持HTML5，请使用支持HTML5的浏览器。
			</canvas>
		</div>
		
		<!--play68 init-->
		<link type="text/css" rel="stylesheet" href="http://g.lanrenmb.com/games/heibai/sidebar.css">
		<style type="text/css">
		<!--
		#play68box {
			top: 5%;
		}
		-->

		</style>
		<img src="http://img.tongji.linezing.com/3455448/tongji.gif">
		
		<!-- 
		<script type="text/javascript" src="http://g.lanrenmb.com/games/heibai/play68bar.js"></script><div style="background-color: rgba(0, 0, 0, 0.796875); position: fixed; top: 0px; left: 0px; width: 100%; height: 901px; z-index: 10000; display: none; background-position: initial initial; background-repeat: initial initial; " id="wx-qr"><p style="text-align: center; width: 220px; color: rgb(255, 255, 255); margin: 50px auto 0px; font-weight: bold; font-style: normal; font-variant: normal; font-size: 16px; line-height: normal; font-family: Arial, Helvetica, &#39;Microsoft Yahei&#39;, 微软雅黑, STXihei, 华文细黑, sans-serif; ">分享给朋友一起玩！</p></div>
	-->

</body>

<SCRIPT type="text/javascript" src="/lattice/js/jquery-1.8.2.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/lattice/js/jquery-ui-1.9.1.custom.min.js"></SCRIPT>
<SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
<script src="/lattice/js/oneui/opes_post_result_util.js"></script>

<script type="text/javascript" src="/lattice/js/oneui/common_utils.js"></script>
<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="/lattice/js/flot/excanvas.min.js"></script><![endif]-->
   

<script type="text/javascript">

	jQuery(document).ready(function () 
	{
		   var now = new Date();
           testStartTime=now.getTime();
	});


	function getTimestamp()
	{
		var now = new Date();
		return now.getTime(); // in ms
	}
	
	function post_result() 
	{
		var endTime=getTimestamp();
		score=parseInt(score);
		//alert(score+'  '+testStartTime);
		
		 var opes_result_data = {};
	        opes_result_data.taskid ='<%= taskid %>';
	        //alert(opes_result_data.taskid);
	        opes_result_data.sumitcoids =<%= sumitcoids %>;
	       // alert(opes_result_data.sumitcoids)
	        opes_result_data.targetpagename = "<%=targetpagename%>";
	       // opes_result_data.codematerial =<%= codematerial %>;
	        opes_result_data.uid =<%= uid %>;
	       // opes_result_data.lan = "<%=lan%>";
	        opes_result_data.projectid =<%= projectid %>;

	        opes_result_data.duration = parseInt((endTime-testStartTime)/1000);
	        opes_result_data.timeaverage = 0;

	        //以下判断总题数
	        opes_result_data.type4set = 1+'';
	        opes_result_data.stimidset = 1+'';
	        opes_result_data.correctanswerset = score+'';
	        //opes_result_data.time = timer;
	        //opes_result_data.level = sd.blankNum;

	        opes_result_data.timeset = score+'';
	        opes_result_data.radioset = score+'';
	        opes_result_data.buttonset = score+'';
	        opes_result_data.commentset = JSON.stringify({score:score});
	        opes_result_data.numset = score+'';
	        console.log(opes_result_data);
	       opes_post_result_util_js_opes_post_result(opes_result_data);
	        return;


    }


	
</script>

</html>