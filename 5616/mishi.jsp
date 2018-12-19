
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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=480,user-scalable=no,uc-user-scalable=no,target-densitydpi=high-dpi"/>
<script>


session=0;
type4set="";
stimidset="";
timeset="";
trialno=1;
numset="";



testStartTime_eachtrial=0;
	
	
function play68_init() {
	updateShare(0);
}

function goHome() {
	window.location.href = HOME_PATH;
}

function play68_submitScore(score) {
	
	if (session==0){
		numset=score;	
		type4set='1';
		stimidset=trialno+'';
		var now = new Date();
		nowTime=now.getTime();
		timeset=(nowTime-testStartTime_eachtrial)+"";
	}else {
		numset=numset+";"+score;	
		type4set=type4set+";"+'1';
		stimidset=stimidset+";"+trialno;
		var now = new Date();
		nowTime=now.getTime();
		timeset=timeset+";"+(nowTime-testStartTime_eachtrial);
	}
	session=session+1;
	trialno=trialno+1;
		
	var now = new Date();
	testStartTime_eachtrial=now.getTime();
	
	//alert(timeset);
	//post_result(finalscore);
	//updateShareScore(score);
	//setTimeout( function() { show_share(); }, 500 );
}

function updateShare(bestScore) {
	//imgUrl ="http://g.lanrenmb.com/icon/mishi.png";
	//lineLink ="http://g.lanrenmb.com/games/mishi/index.html";
	//descContent = "你觉得你反应很快吗？试试就知道！";
	//updateShareScore(bestScore);
	appid = '';
}

function updateShareScore(bestScore) {
	if(bestScore > 0) {
		shareTitle = "考反应游戏《密室逃脱》我过了" + bestScore + "关，实在是太变态了！";
	}
	else{
		shareTitle = "变态考反应游戏《密室逃脱》能通关你就能闪子弹了！";
	}
}
</script>
<script type="text/javascript" src="jsgamemin.js"></script>
<script type="text/javascript" src="spaceman.min.js"></script>
<SCRIPT type="text/javascript" src="/lattice/js/jquery-1.8.2.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/lattice/js/jquery-ui-1.9.1.custom.min.js"></SCRIPT>
<SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
<script src="/lattice/js/oneui/opes_post_result_util.js"></script>
<script type="text/javascript" src="/lattice/js/oneui/common_utils.js"></script>


<title>密室逃脱</title>
<style>
	body{margin:0px; background-color:#434243; color:#6A6A6A;}
	.bandiv{float:left; width:100%; background-color:#DBD1BB;}
	.bandiv div{padding:10px; text-align:left;}
	body{
	oncontextmenu: return false;
	onselectstart: return false;
}

#play68box{
	width: 190px;
	font-size: 12px;
	line-height: 15px;
	right: -172px;
	top: 35%; 
	position: fixed;
	z-index: 100;
}

#tab{
	float: left;
	list-style: none outside none;
	padding: 0;
	position: relative;
	z-index: 99;
	margin-top: 10px;
	margin-right: 0;
	margin-bottom: 0;
	margin-left: 0;
}

#tab li span{
    display: block;
    padding: 0 5px;
    position: relative;
}

#links{
	width: 100px;
	padding: 1px;
	float: left;
	background-color: #f6bb42;
	border-radius: 8px;
}

.show, .hide{
            transition: margin-right .4s ease-in;
    -webkit-transition: margin-right .4s ease-in;
}

.hide{
    margin-right:0px;
}

.show{
    margin-right:95px;
}

#arrow, .bt{
    cursor: pointer;
}

.bt{
	width: 95px;
	height: 41px;
	margin: 2px;
	text-align:center;
    font: bold 15px Arial, Helvetica, "Microsoft Yahei", "微软雅黑", STXihei, "华文细黑", sans-serif;
	background-color: #da4453;
	border-radius: 6px;
}

.bt a{
    line-height: 40px;
    color: #fff;
    display: block;
	text-decoration:none;
}

.bt:hover{
    transition: background .3s linear         -o-transition: background .3s linear;
       -moz-transition: background .3s linear;
    -webkit-transition: background .3s linear;
	background-color: #37bc9b;
}

#deco{
	width: 90px;
	float: left;    
}

#share-wx{
	background:rgba(0,0,0,0.8);
	position:absolute;top:0px;
	left:0px;
	width:100%;
	height:100%;
	z-index:10000;
	display:none;
}

#wx-qr{
	background:rgba(0,0,0,0.8);
	position:absolute;top:0px;
	left:0px;
	width:100%;
	height:100%;
	z-index:10000;
	display:none;
}
</style>
<script>
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('showOptionMenu');
});
new Image().src = 'http://g.lanrenmb.com/';
</script>
<script type="text/javascript" src="http://tajs.qq.com/stats?sId=34915524" charset="UTF-8"></script>
</head>
<body onLoad="main()" id="0">
	
	<div id="tir" style="color: #ff0000;position: fixed;top: 0px;width: 500px;height: 100px"></div>
	
<div style="text-align:center;">
<canvas id="jsGameScreen"></canvas> 
</div>
<script type="text/javascript">
var mebtnopenurl = 'http://g.lanrenmb.com/';
function shareFriend() {
	WeixinJSBridge.invoke("sendAppMessage", {
		appid: appid,
		img_url: imgUrl,
		img_width: "200",
		img_height: "200",
		link: lineLink,
		desc: descContent,
		title: shareTitle
	},
	function(e) {
		document.location.href = mebtnopenurl;
		
	})
}
function shareTimeline() {
	WeixinJSBridge.invoke("shareTimeline", {
		img_url: imgUrl,
		img_width: "200",
		img_height: "200",
		link: lineLink,
		desc: descContent,
		title: shareTitle
	},
	function(e) {
		document.location.href = mebtnopenurl;
	})
}
function shareWeibo() {
	WeixinJSBridge.invoke("shareWeibo", {
		img_url: imgUrl,
		content: shareTitle + " " + descContent,
		url: lineLink
	},
	function(e) {
		document.location.href = mebtnopenurl;
	})
}
function isWeixin() {
	var e = navigator.userAgent.toLowerCase();
	if (e.match(/MicroMessenger/i) == "micromessenger") {
		return true
	} else {
		return false
	}
}
function toggle(e) {
	var t = document.getElementById(e);
	var n = document.getElementById("arrow");
	var r = t.getAttribute("class");
	if (r == "hide") {
		t.setAttribute("class", "show");
		delay(n, RESOURCE_IMG_PATH + "arrowright.png", 400)
	} else {
		t.setAttribute("class", "hide");
		delay(n, RESOURCE_IMG_PATH + "arrowleft.png", 400)
	}
}
function delay(e, t, n) {
	window.setTimeout(function() {
		e.setAttribute("src", t)
	},
	n)
}
function show_share() {

		document.getElementById("share-wx").style.display = "block"
	
}
function closeshare() {
	document.getElementById("share-wx").style.display = "none"
}
function closewx() {
	document.getElementById("wx-qr").style.display = "none"
}
function addShareWX() {
	var e = document.createElement("div");
	e.id = "share-wx";
	e.onclick = closeshare;
	document.body.appendChild(e);
	var t = document.createElement("p");
	t.style.cssText = "text-align:right;padding-left:10px;";
	e.appendChild(t);
	var n = document.createElement("img");
	n.src = "2.png";
	n.id = "share-wx-img";
	n.style.cssText = "max-width:280px;padding-right:25px;";
	t.appendChild(n);
}

if (getCookie("num")) {
		var nn = parseInt(getCookie("num"));
		setCookie("num", ++nn);
	} else {
		setCookie("num", 1);
	}
	function getCookie(name) 
	{ 
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)"); 
		if(arr=document.cookie.match(reg)) return unescape(arr[2]); 
		else return null; 
	} 
	function setCookie(name, value) {
		var Days = 30;
		var exp = new Date();
		exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
		document.cookie = name + "=" + escape(value) + ";expires" + exp.toGMTString();
	}
	

	
function isMobile() {
	return navigator.userAgent.match(/android|iphone|ipod|blackberry|meego|symbianos|windowsphone|ucbrowser/i)
}
function isIOS() {
	return navigator.userAgent.match(/iphone|ipod|ios/i)
}
var HOME_PATH = HOME_PATH || "http://g.lanrenmb.com/",
RESOURCE_IMG_PATH = RESOURCE_IMG_PATH || "/game/",
HORIZONTAL = HORIZONTAL || false,
COVER_SHOW_TIME = COVER_SHOW_TIME || 2e3;
var imgUrl ="http://g.lanrenmb.com/icon.mishi.png/";
var lineLink ="http://g.lanrenmb.com/games/mishi/index.html";
var descContent = "快来跟我一起玩！";
var shareTitle = "最好玩的小游戏就在游戏排行榜！";
var appid = "";
document.addEventListener("WeixinJSBridgeReady",
function() {
	WeixinJSBridge.on("menu:share:appmessage",
	function(e) {
		shareFriend()
	});
	WeixinJSBridge.on("menu:share:timeline",
	function(e) {
		shareTimeline()
	});
	WeixinJSBridge.on("menu:share:weibo",
	function(e) {
		shareWeibo()
	});
	if (HORIZONTAL == true) {
		WeixinJSBridge.call("hideToolbar")
	}
},
false); (function() {
	function n() {
		window.scroll(0, 0);
		var e;
		if (window.orientation == 0 || window.orientation == 180) {
			e = false
		} else if (window.orientation == -90 || window.orientation == 90) {
			e = true
		}
		if (e == HORIZONTAL) {
			t.style.display = "none"
		} else {
			setTimeout(function() {
				r();
				t.style.width = window.innerWidth + "px";
				t.style.display = "block"
			},
			isIOS() ? 0 : 600)
		}
		if (HORIZONTAL == true && isWeixin() && !isIOS()) {
			WeixinJSBridge.call("hideToolbar")
		}
	}
	function r() {
		e.style.height = window.innerHeight + "px";
		e.style.width = window.innerWidth + "px";
		t.style.height = window.innerHeight + "px"
	}
	if (typeof play68_init == "function") {
		play68_init()
	}
	if (!isMobile()) return;
	var e = document.createElement("div");
	e.style.cssText = "position:absolute;z-index:1000000;left:0;top:0;background-size: 50%;width:" + window.innerWidth + "px;height:" + Math.max(window.innerHeight, window.document.documentElement.offsetHeight) + "px";
	e.className = "common_cover";
	document.body.appendChild(e);
	setTimeout(function() {
		e.parentNode.removeChild(e)
	},
	COVER_SHOW_TIME);
	document.addEventListener("touchmove",
	function(e) {
		e.preventDefault()
	},
	false);
	var t = document.createElement("div");
	t.className = "common_notice";
	t.style.cssText = "position:absolute;z-index:999999;left:0;top:0;background-size: 50%;";
	document.body.appendChild(t);
	window.addEventListener("orientationchange", n);
	window.addEventListener("load", n);
	window.addEventListener("scroll", r)
})();
addShareWX();


		var maxtime=180;
		testStartTime=0;

		jQuery(document).ready(function () 
		{
			 var now = new Date();
	         testStartTime=now.getTime();
			 testStartTime_eachtrial=testStartTime
	         
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
	            //document.getElementById("tir").innerHTML=msg;
	            --maxtime;
	        } else{

	            clearInterval(timer);
	            post_result();
	        }
	    }
	    
		function post_result() 
		{
			var endTime=getTimestamp();
			var testDuration=parseInt((endTime-testStartTime)/1000);
			
//			score=parseInt(score);
//			var totalCount=parseInt(testDuration*score);
//			score=totalCount;
			//alert('score='+score+'  totalCount='+totalCount);
			
			alert(numset);
			alert(type4set);
			alert(stimidset);
			
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
		        opes_result_data.stimidset = stimidset;
		        opes_result_data.correctanswerset = stimidset;
		        //opes_result_data.time = timer;
		        //opes_result_data.level = sd.blankNum;

		        opes_result_data.timeset = timeset;
		        opes_result_data.radioset = stimidset;
		        opes_result_data.buttonset = stimidset;
		        opes_result_data.commentset = stimidset;
		        opes_result_data.numset = numset;
		        console.log(opes_result_data);
		       opes_post_result_util_js_opes_post_result(opes_result_data);
		        return;


	    }



</script>
</body>
</html>