<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="com.lattice.entity.*"%>
<%@ page language="java" import="com.lattice.dao.*,java.util.*"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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

	Vector 	<OPES_Task> ots=OPES_TaskDAO.getOPES_aTask(Integer.parseInt(request.getParameter("taskid")),lan);
    if (ots.size()==0)
    {
    response.sendRedirect("/lattice/"+targetpagename);
    return;
    }
    ots.get(0).setProjectid(Integer.parseInt(request.getParameter("projectid")));
    request.getSession().setAttribute("ot",ots.get(0));
	
%>



<!DOCTYPE html>
<html>
	<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<meta name="viewport"
			content="width=device-width,user-scalable=no,initial-scale=1.0" />
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<title>一个都不能掉  微信HTML5在线朋友圈游戏</title>
		<link type="text/css" href="css/game_base.css" rel="stylesheet" />
		<!--<script type="text/javascript">document.write('<script type="text/javascript" src="/js/resource_loader.js?ver=' + Math.random() + '"><\/script>')</script>-->
		<script type="text/javascript" src="js/jquery-2.1.0.min.js"></script>
		<script type="text/javascript" src="js/game_base.js"></script>
       <!-- <script src="js/game_index.js"></script>-->
		<script type="text/javascript" src="js/createjs-2013.12.12.min.js"></script>
		<script type="text/javascript" src="js/createjs_game.js"></script>
		<script type="text/javascript" src="js/jquery.cookie.js"></script>
		<script type="text/javascript" src="js/main.js"></script>
		<style type="text/css">
.follow {
	z-index: 100;
	position: absolute;
	left: -500px;
	bottom: 0px;
	width: 20%;
	opacity: 0;
}

.follow img {
	width: 100%
}

.moreGames {
	z-index: 100;
	position: absolute;
	bottom: 10px;
	margin-left: auto;
	margin-right: auto;
	width: 100%;
	text-align: center;
}


.moreGames a {
	font: 11px Arial;
	text-decoration: none;
	background-color: #C0C0C0;
	color: #FFFFFF;
	padding: 2px 10px 2px 10px;
	border-radius: 8px;
	-webkit-border-radius: 8px;
}
</style>
	</head>
	<body>
	<div id="tir" style="color: #ff0000;position: fixed;top: 0px;width: 500px;height: 100px"></div>
		<canvas id="stage">
		您的浏览器不支持html5, 请换用支持html5的浏览器
		</canvas>
		<script language=javascript>
		
		    window.shareData = {
		        "imgUrl": "http://g.lanrenmb.com/games/pigbaby/img/pigbaby.jpg",
		        "timeLineLink": "http://g.lanrenmb.com/games/pigbaby/",
		        "tTitle": "一个都不能丢",
		        "tContent": "小猪宝宝都要被我玩坏了！你们能像我一样和他快乐的玩耍吗？"
		    };

		    function goHome() {
		        window.location = mebtnopenurl;
		    }
		    function dp_share() {
		       
		        myscore = $("#scorehide").val();
		        window.shareData.tTitle = "" + myscore + "分！一个都不能丢，你看过我的小猪吗?一起来快乐的玩吧！";
		        //document.title = "" + myscore + "分！一个都不能丢，你看过我的小猪吗?一起来快乐的玩吧！";
		        document.getElementById("share").style.display = "";
		        //window.shareData.tTitle = document.title;
		    }
		    function dp_Ranking() {
		        //alert("到更多");
		        window.location = mebtnopenurl;
		    }
		    function showAd() {
		    }
		    function hideAd() {
		    }

		    var mebtnopenurl = 'http://g.lanrenmb.com/';
		    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		        WeixinJSBridge.on('menu:share:appmessage', function(argv) {
		            WeixinJSBridge.invoke('sendAppMessage', {
		                "img_url": window.shareData.imgUrl,
		                "link": window.shareData.timeLineLink,
		                "desc": window.shareData.tContent,
		                "title": window.shareData.tTitle
		            }, function(res) {
		                document.location.href = mebtnopenurl;
		            })
		        });

		        WeixinJSBridge.on('menu:share:timeline', function(argv) {
		            WeixinJSBridge.invoke('shareTimeline', {
		                "img_url": window.shareData.imgUrl,
		                "img_width": "640",
		                "img_height": "640",
		                "link": window.shareData.timeLineLink,
		                "desc": window.shareData.tContent,
		                "title": window.shareData.tTitle
		            }, function(res) {
		                document.location.href = mebtnopenurl;
		            });
		        })});
	</script>
	
	
	
	
	
	
	</body>


<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="/lattice/js/flot/excanvas.min.js"></script><![endif]-->






         
	<input type="hidden" id="scorehide" />
<div id=share style="display: none">
	<img width=100% src="img/xuanyao.png"
	style="position: fixed; z-index: 9999; top: 0; left: 0; display: "
	ontouchstart="document.getElementById('share').style.display='none';">
</div>
			<script type="text/javascript">
			    var myData = {};
			    var myscore = 0;
</script>
	<div class="scoreinfo">
        	<div class="holder">
        		<div class="head">
        		<!--	<img src="img/showtop.png" />-->
        			<!--<hr>-->
        		</div>
        		<div class="record">
        			<div class="nowrecord"><span class="num"></span>分</div>
        			<div class="bestrecord">榜单最佳：<span class="num"></span>分</div>
        		</div>
        	<!--	<div class="foot">
        			<div class="btngrp"><span class="return"><img src="img/showreturn.png" /></span><span class="xuyao"><img src="img/showweixin.png" /></span></div>
        		</div>-->
        	</div>
        </div>
        <div class="weixinshare"></div>

</body>



 <div style="display:none">

</div>
<img src="http://img.tongji.linezing.com/3455448/tongji.gif">

</div>


<SCRIPT type="text/javascript" src="/lattice/js/jquery-1.8.2.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/lattice/js/jquery-ui-1.9.1.custom.min.js"></SCRIPT>
<SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
<script src="/lattice/js/oneui/opes_post_result_util.js"></script>
<script type="text/javascript" src="/lattice/js/oneui/common_utils.js"></script>

<script type="text/javascript">


finalscore=0;
session=0;
type4set="";
stimidset="";

		var maxtime=180;
		testStartTime=0;
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
		
		timer = setInterval(function () {
	        CountDown();
	    }, 1000);
	    function CountDown() {
	        if (maxtime >= 0) {
	            minutes = Math.floor(maxtime / 60);
	            seconds = Math.floor(maxtime % 60);
	            msg = "距离结束还有" + minutes + "分" + seconds + "秒";
	            document.getElementById("tir").innerHTML=msg;
	            --maxtime;
	        } else{

	            clearInterval(timer);

				 if (gameisover==0){
						if (session==0){
							finalscore=score;
							session++;
							type4set="1";  
							stimidset=session+"";
						}else {
							finalscore=finalscore+";"+score;
							session++;
							type4set=type4set+";1";
							stimidset=stimidset+";"+session;
						}	        	 
				 };
//				 alert(finalscore);
	             post_result(finalscore);
	        }
	    }
	    
		function post_result(finalscore) 
		{
			var endTime=getTimestamp();
			var testDuration=parseInt((endTime-testStartTime)/1000);
			
			score=finalscore;
			
//			score=parseInt(score);
//			var totalCount=parseInt(testDuration*score);
//			score=totalCount;
			//alert('score='+score+'  totalCount='+totalCount);
			
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
		        opes_result_data.type4set = type4set;
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