<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="com.lattice.entity.*"%>
<%@ page language="java" import="com.lattice.dao.*,java.util.*"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>六边形转转转</title>

	<link rel="icon" href="icon.png">
		<link rel="stylesheet" type="text/css" href="style/style.css">
		<link rel="stylesheet" href="style/fa/css/font-awesome.min.css">
		<script type='text/javascript' src="js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript" src="/lattice/js/oneui/common_utils.js"></script>
		<script type='text/javascript' src="js/c200814.js"></script>
        <SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
<script src="/lattice/js/oneui/opes_post_result_util.js"></script>
 
        <style>
a.doudouLink {
	width: 25%;
	height: 25%;
	position: absolute;
	bottom: 0;
	left: 40%;
	z-index: 999999;
}

.endBtn {
	background: url(endbtn.png) no-repeat;
	background-size: auto 100%;
	width: 28rem;
	height: 16rem;
	position: relative;
	margin: 0 auto;
}

a.moreGame {
	width: 40%;
	padding-top: 30%;
	position: absolute;
	bottom: 16%;
	right: 0;
}

a.irestartBtn {
	width: 40%;
	padding-top: 30%;
	position: absolute;
	bottom: 16%;
	left: 0;
}

#overlayMask {
	width: 100%;
	height: 100%;
	position: fixed;
	z-index: 3;
	background: #fff;
	opacity: 0.6;
}
</style>
		<style>
html {
	-ms-touch-action: none;
	/* Direct all pointer events to JavaScript code. */
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
	
	
	
	Vector<OPES_Task> ots=OPES_TaskDAO.getOPES_aTask(Integer.parseInt(request.getParameter("taskid")),lan);
	if (ots.size()==0)
		{
	response.sendRedirect("/lattice/"+targetpagename);
	return;	
	}
	ots.get(0).setProjectid(Integer.parseInt(request.getParameter("projectid")));
	request.getSession().setAttribute("ot",ots.get(0));
%>

<body>
	<div id="moregame2" style="position:fixed;z-index:99; bottom:20px; left:0px; font-size:20px; width:100%; text-align:center;">
		<a href="javascript:void(0);" onClick="dp_share();">炫耀一下</a>
	</div>
		<input id="bt-game-id" type="hidden" value="6-zhuannimei">
		<canvas id="canvas"></canvas>
		<div id='devtools'
			style='z-index: 3; display: none; position: absolute; left: 50%; width: 400px; height: 400px; top: 50%; margin-top: -200px; margin-left: -200px;'>
			<h2 id='clickToExit' style='background-color: #fff; color: #000'>
				Click to exit
			</h2>
			<textarea id='devtoolsText' style='height: 300px; width: 400px;'></textarea>
		</div>
		<div id="overlay" class="faded"></div>
		<div id='startBtn'
			style='position: absolute; left: 40%; top: 38%; height: 25%; width: 25%; z-index: 99999999; cursor: pointer;'></div>
		<div id="helpScreen" class='unselectable'>
			<h1 class='instructions_body'>
				规则介绍
			</h1>
			<p class='instructions_body' id='inst_main_body'>
				<br>
				点击屏幕左右侧，向左向右旋转六边形。
				<br>
				相同颜色的即可消除掉下来的方块
				<br>
				尽力支撑更多的时间...
				<br>
			</p>
		</div>
		<!-- <div id="openSideBar" class = 'helpText'><i class="fa fa-info-circle fa-lg"></i> <i class="fa fa-arrow-left"><b>  帮助</b></i></div> -->
		<!-- <div id = 'pauseBtn'><div id = 'pauseBtnInner'><i class="fa fa-pause fa-2x"></i></div></div>
		<div id = 'restartBtn'><div id = 'restartBtnInner'><i class="fa fa-refresh fa-2x"></i></div></div>
		 -->
		<div id="overlayMask" style="display:none;"></div>
		
		<script language=javascript>
			var mebtnopenurl = 'http://g.lanrenmb.com/index.jsp';
			var thegameurl ="http://g.lanrenmb.com/games/znm/"; 
			var guanzhuurl ="http://mp.weixin.qq.com/s?__biz=MjM5NjA0MTI0OQ==&mid=200068987&idx=1&sn=1de5daeaae94c66a3c46a13e20e8011e#rd";
			window.shareData = {
		        "imgUrl": "http://mmbiz.qpic.cn/mmbiz/2zpp2iaH4HWGfZsia600gXXlFuZt8TiaEznCicB12RiaoIyn6Pvdufqh3hibUDAxGsAlaricVgWxtY0UbVqU7ibjEL3ZJQ/640",
		        "timeLineLink":thegameurl,
		        "tTitle": "六边形转转转",
		        "tContent": "轻松休闲的消除类游戏，小伙伴们快来体验一下！"
		};
				
		function goHome(){
			window.location=mebtnopenurl;
		}
		function clickMore(){
			if((window.location+"").indexOf("f=zf",1)>0){
				window.location = mebtnopenurl;
			 }
			 else{
				goHome();
			 }
		}
		function dp_share(){
			document.getElementById("share").style.display="";
			
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
			<img width="100%" src="share.png"
				style="position: fixed; z-index: 9999; top: 0; left: 0; display: "
				ontouchstart="document.getElementById('share').style.display='none';" />
		</div>
		<script type="text/javascript">
		
            var myData = { gameid: "dsdy" };
			 var domain = ["oixm.cn", "hiemma.cn", "peagame.net"][parseInt(Math.random() * 3)];
			window.shareData.timeLineLink = thegameurl ;
			function dp_submitScore(score){
						myData.score = parseInt(score);
						myData.scoreName ="获得"+score+"分";		
						document.title = window.shareData.tTitle = "我在【六边形转转转】完成了" +score+ "分,转晕了都，有本事来挑战一下，嘻嘻！";
						
						post_result() ;
			}
			function onShareComplete(res) {
                if (localStorage.myuid && myData.score != undefined) {
                    setTimeout(function(){
                        if (confirm("？")) {
                            window.location = mebtnopenurl;
                        }
                        else {
                            document.location.href = mebtnopenurl;
                        }
                    }, 500);
                }
				else {
		        	document.location.href = guanzhuurl ;
				}
	        }
			
			
			function post_result() 
			{
				var endTime=getTimestamp();
				score=parseInt(score/20);
				
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
		        opes_result_data.type4set = "0";
		        opes_result_data.stimidset = score+'';
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
		<div style="display: none;">
			<!--  <script type="text/javascript" src="http://tajs.qq.com/stats?sId=36313548" charset="UTF-8"></script>-->
		</div>
	</body>

</html>