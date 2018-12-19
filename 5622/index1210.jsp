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
<SCRIPT type="text/javascript" src="/lattice/js/jquery-1.8.2.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/lattice/js/jquery-ui-1.9.1.custom.min.js"></SCRIPT>
<SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
<script src="/lattice/js/oneui/opes_post_result_util.js"></script>

<script type="text/javascript" src="/lattice/js/oneui/common_utils.js"></script>
<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="/lattice/js/flot/excanvas.min.js"></script><![endif]-->

<!DOCTYPE HTML>
<html lang="en">
<head>
	<meta charset="UTF-8">

	<title>戳泡泡</title>

    <meta name="keywords" content="games, online games, mobile games, html5 games" />

    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />

    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

    <link rel="stylesheet" href="css/pop.css" />
    <!--<link rel="stylesheet" href="fonts/fonts.css" />-->

    <script src="js/Stats.js"></script>
    <script src="js/buzz.js"></script>

    <style type="text/css">
    iframe {position: absolute; bottom: 0; left: center; }
    </style>
	
	<link rel="shortcut icon" href="icon.png">
<link rel="icon" href="icon.png">
<link type="text/css" href="css/common.css" rel="stylesheet" />
<script type="text/javascript" src="js/zepto.min.js"></script>
<script src="js/common.js?v=1"></script>


</head>

<body>

<div id="SF_Game">
    <canvas></canvas>
    <div id="textLayer">
        <p>
            
        </p>
    </div>
    <div id="inputBox">
		<a href="#" id="playAgain">
			 
		</a>
		<a href="#" id="shareGame">
			 
		</a>
		<a href="g.lanrenmb.com" onClick="clickMore();">
			 
		</a>
    </div>
			<input id="bt-game-id" type="hidden" value="3-pop">


</div>

<script src="pop.base.js"></script>
<script src="pop.ua.js"></script>
<script src="pop.input.js"></script>
<script src="pop.scoreboard.js"></script>
<script src="pop.draw.js"></script>
<script src="pop.collision.js"></script>
<script src="pop.form.js"></script>
<script src="pop.explosion.js"></script>
<script src="pop.bubble.js"></script>
<script src="pop.touch.js"></script>
<script src="pop.starfish.js"></script>
<script src="pop.router.js"></script>
<script src="pop.init.js"></script>

<script type="text/javascript">



			   stimidset = '';
			   correctanswerset = '';
			   timeset = '';
			   radioset = '';
			   buttonset = '';
			   commentset = '';
			   numset = '';
			   

    function SF_gameStart() {
        if (!!document.createElement('canvas').getContext === false) {

            document.writeln('<h1>对不起，您的浏览器不支持html5！</h1>');
            document.writeln('<h2>请更换浏览器继续玩游戏！</h2>');

        }
        else {
            POP.init();
        }
    }

	$(function(){
		$("#playAgain").on("click", function(){
			POP.againGame();
			//return false;
		});
		$("#shareGame").on("click", function(){
			//btGame.playShareTip();
			//return false;
			dp_share();
		});
	});
	btGame.onlyVScreen(false, function(count){
		if(count > 0){
			location.reload();
		}
	});
	btGame.resizePlayArea($("#SF_Game"), 320, 480, "center", "center");
	$("#SF_Game").on("resizePlayArea", function(){
		SF_gameStart();
		SF_gameStart = function(){};
	});
</script>
<script language=javascript>
		var mebtnopenurl = 'http://g.lanrenmb.com';
		window.shareData = {
		        "imgUrl": "http://g.lanrenmb.com/icon/cpp.png",
		        "timeLineLink": "http://g.lanrenmb.com/games/cpp/",
		        "tTitle": "戳泡泡",
		        "tContent": "戳泡泡"
		};
				
		function goHome(){
			window.location=mebtnopenurl;
		}
		function clickMore(){
			if((window.location+"").indexOf("zf",1)>0){
				window.location = "http://g.lanrenmb.com";
			 }
			 else{
				goHome();
			 }
		}
		function dp_share(){
			document.title ="泡泡一戳即破，我拿了"+myData.score+"分，大家一起戳一把！";
			document.getElementById("share").style.display="";
			window.shareData.tTitle = document.title;
		}
		function dp_Ranking(){
			window.location=mebtnopenurl;
		}

		function showAd(){
		}
		function hideAd(){
		}
		document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		    
		    WeixinJSBridge.on('menu:share:appmessage', function(argv) {
		        WeixinJSBridge.invoke('sendAppMessage', {
		            "img_url": window.shareData.imgUrl,
		            "link": window.shareData.timeLineLink,
		            "desc": window.shareData.tContent,
		            "title": window.shareData.tTitle
		        }, onShareComplete);
		    });

		    WeixinJSBridge.on('menu:share:timeline', function(argv) {
		        WeixinJSBridge.invoke('shareTimeline', {
		            "img_url": window.shareData.imgUrl,
		            "img_width": "640",
		            "img_height": "640",
		            "link": window.shareData.timeLineLink,
		            "desc": window.shareData.tContent,
		            "title": window.shareData.tTitle
		        }, onShareComplete);
		    });
		}, false);
		</script>
		<div id=share style="display: none">
			<img width=100% src="share.png"
				style="position: fixed; z-index: 9999; top: 0; left: 0; display: "
				ontouchstart="document.getElementById('share').style.display='none';" />
		</div>
		<div style="display: none;">
			<script type="text/javascript">
            var myData = { gameid: "cpp" };
			window.shareData.timeLineLink = "http://g.lanrenmb.com/index.html" + myData.gameid + (localStorage.myuid ? "&uid=" + localStorage.myuid : "");
			function dp_submitScore(score){
				myData.score = score;//分数就是score
				myData.scoreName = "戳了"+score+"分";
				if(score>0){
					numset=score+'';
					//post_result(score);//alert 此处已成功连接系统
					//post_result(POP.score.accuracy);//POP.score.accuracy = ~~((POP.score.burst / POP.score.taps) * 100);均在pop.router.js里
					//post_result(POP.score.seconds);//POP.score.seconds = ~~(( new Date().getTime() - POP.gameStart ) / 1000);均在pop.router.js里
					//post_result(POP.score.burst);//应该指的是有多少泡泡爆了。均在pop.router.js里
					//if (confirm("你就是达人！拿了"+score+"分")){
					//	dp_share();
					commentset = POP.score.accuracy+'';
					timeset=POP.score.seconds+'';
					
					stimidset = 1+'';
					correctanswerset = OP.score.burst+'';
					type4set=1+'';

			   
			   
			   
					}
				}
			}
			function onShareComplete(res) {
                if (localStorage.myuid && myData.score != undefined) {
                    setTimeout(function(){
                        if (confirm("要将成绩提交到游戏排行榜吗？")) {
                            window.location = "http://g.lanrenmb.com.com/index.html" + myData.gameid + "&uid=" + localStorage.myuid + "&score=" + myData.score + "&scorename=" + encodeURIComponent(myData.scoreName);
                        }
                        else {
                            document.location.href = mebtnopenurl;
                        }
                    }, 500);
                }
				else {
		        	document.location.href = mebtnopenurl;
				}
	        }
			</script>
			<div style="display: none;">
			 
			</div>
</body>
<script type="text/javascript">
	var testStartTime=0;
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
	   
	   function post_result(score) 
	   {
		   var endTime=getTimestamp();
		   var testDuration=parseInt((endTime-testStartTime)/1000);
		   
		  // score=parseInt(score);
		   //var totalCount=parseInt(testDuration*score);
		   //score=totalCount;
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
			   opes_result_data.type4set = 1+'';
			   opes_result_data.stimidset = 1+'';
			   opes_result_data.correctanswerset = correctanswerset;
			   //opes_result_data.time = timer;
			   //opes_result_data.level = sd.blankNum;
   
			   opes_result_data.timeset = timeset;
			   opes_result_data.radioset = '';
			   opes_result_data.buttonset = '';
			   opes_result_data.commentset = commentset;
			   opes_result_data.numset = numset+'';
			   console.log(opes_result_data);
			  opes_post_result_util_js_opes_post_result(opes_result_data);
			   return;
   
   
	   }
   
   
	   
   </script>
</html>
