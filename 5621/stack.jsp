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

int sumitcoids=0;
System.out.println("sumitcoids00:"+sumitcoids);

Vector 	<OPES_Task> ots=OPES_TaskDAO.getOPES_aTask(Integer.parseInt(request.getParameter("taskid")),lan);
    if (ots.size()==0)
    {
    response.sendRedirect("/lattice/"+targetpagename);
    return;
    }
    ots.get(0).setProjectid(Integer.parseInt(request.getParameter("projectid")));
    request.getSession().setAttribute("ot",ots.get(0));
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width = 320,initial-scale=1,user-scalable=no" />
<link rel="apple-touch-icon-precomposed" href="icon.png"/>
<meta name="apple-mobile-web-app-capable" content="yes" />
<link rel="apple-touch-icon-precomposed" href="icon.png"/>
<link rel="apple-touch-startup-image" href="i/loader.png">
<meta name="description" content="堆木头游戏，简单好玩的小游戏，尽可能的精确对齐木头，堆木头达到最高，当你感觉木头和下面的对齐时，按下按钮放木头" />
<title>堆木头 反应速度测试小游戏--懒人模板</title>
<style type="text/css">
 body { font-family: helvetica, arial; background-color: #000000; color: #a3b3c3; border:0; padding:0; font-size:90%; overflow: hidden;
width: 320px;
margin: auto;}

 h1 {margin:.4em;}
 h3 { font-size:120%; margin:12px; padding-left:0;margin-bottom:.5em; color: #ffffff;}
 p {margin:0; margin:12px; margin-top:.5em; margin-bottom:.5em; font-size:84%;}
 a { color: #ffffff; }

 td{text-align:center; font-size: 70%;}
 
 .ibox {width:320px; height:315px; overflow:hidden; background-color: #000000; margin:auto;}
 .iboxcontent {width:320px; height:315px; float:left; overflow:hidden;}
 .ibc1 {background-color: #3b4859; background-image:url(./i/bg1.png);}
 .ibc2 {background-color: #404d5e; background-image:url(./i/bg2.png);}
 
 #alertbox {display:none;position:absolute; z-index:200;}
 #alertbox_flekk {position:absolute; width:320px; height: 356px; background-color:#000000; opacity: .8;}
 #alertbox_content {position:absolute; width:320px; height:286px; margin-top:70px; text-align:center; color:#ffffff;}
 #alertbox_content .fontostext {color:#a3b3c3;}
 #alertbox a {margin:10px; width:114px; height:54px; }
 img {border:0;}
 
 #imenu {width:320px;height:41px; margin:auto; text-align:center; background-image:url(./i/menu.png); background-position:0 0px;}
 #imenu a:hover {opacity:.5;}
 #button_game {background-image:url(./i/menu.png); display:block; float:left; width:72px; height:41px; background-position:0 0;}
 #button_highscore {background-image:url(./i/menu.png); display:block; float:left; width:110px; height:41px;background-position: -72px -41px;}
 #button_about {background-image:url(./i/menu.png); display:block; float:left; width:100px; height:41px; background-position: -182px -41px;}

 #score,#combo,#level {color:#ffffff;} 

 #button_xwuz {position:absolute; display:block; width:48px; height:57px; margin: 5px 0 0 267px; background-image:url(./i/xwuz.png);z-index:1; cursor:pointer;}

 #yourbest { text-align:center; font-weight:bold; color:#ffffff;font-size: 300%; margin: .5em auto .5em auto; background-image:url(./i/flekk.png); width:296px; height:65px; padding-top:15px;}
 .fontostext {color: #ffffff;}

 #preload {width:320px;position:absolute; visibility:hidden; overflow:hidden;}
</style>



</head>
<body>
<div id="tir" style="color: #ff0000;position: fixed;top: 0px;width: 500px;height: 100px"></div>;

<form id="result" name="result" method="post" action="/lattice/OPESHandler?type=formal">
<input type=hidden value="<%=taskid%>" name="taskid" id="taskid"/>
<input type=hidden value="<%=sumitcoids %>" name="sumitcoids" id="sumitcoids"/>
<input type=hidden value="<%=request.getParameter("targetpagename") %>" name="targetpagename" id="targetpagename"/>
<input type=hidden value="action" name="action" id="action"/>

</form>


<div style="width:320px; height: 500px;">
<!--<div style="width:100%; height:50px;text-align:center;overflow:hidden;margin:0 auto;margin-bottom: 10px;">
  <a href="http://xjwdm.com/">
<img src="ad.jpg" style="width:100%;height:50px;"></a>
</div>-->
<div style="position: absolute;margin-top: 400px; width: 320px; heigth: 48px; background: #ffffff"></div>



<div id="alertbox"><div id="alertbox_flekk"></div><div id="alertbox_content"></div></div>
 <a id="button_xwuz" onclick="return menuswitch(document.getElementById('button_about'));" ontouchstart="return menuswitch(document.getElementById('button_about'));"></a>

<div id="imenu">
 <a id="button_game" href="#game" class="active" onclick="return menuswitch(this);" ontouchstart="return menuswitch(this);"><span style="display:none">重新开始</span></a>
 <a id="button_highscore" href="#highscore" onclick="return menuswitch(this);" ontouchstart="return menuswitch(this);"><span style="display:none">游戏排行榜</span></a>
 <a id="button_about" href="http://g.lanrenmb.com/"  ontouchstart="return menuswitch(this);"><span style="display:none">更多游戏</span></a>
</div>

<div class="ibox" id="container"><div style="width:10000px;" id="container_scroller">
 <div id="ibox_game" class="iboxcontent ibc1" style="position: relative;">
  <div style="width: 237px; height:15px; overflow:hidden;margin-left: 13px;padding-top:10px; font-size:90%; position:absolute; z-index:20;">
  <div style="float:left"><div style="float:left" id="score_title">得分:&nbsp;</div><div id="score" style="float:left;  width:2em;">0</div></div>
  <div style="float:right"><div style="float:left">连击:&nbsp;</div><div id="combo" style="float:left; width:1.5em;">0</div></div>
  <div style="text-align:center">等级: <span id="level">1</span></div>
  </div>
  <div style="width:320px;height:316px; overflow:hidden; position: relative;" id="st_outerarea">
  </div>
 </div>
 <div id="ibox_highscore" class="iboxcontent ibc2">
  <h3>您目前的最高分是...</h3>
  <div id="yourbest"></div>
  <p>一般人努力点可以达到<span class="fontostext">2500</span> 分, 高手可以达到<span class="fontostext">3500</span> 分. 你可以分享给好友挑战下</p>
  <p>你已经玩了 <span id="gamesplayed" class="fontostext">0</span> 次 <span class="fontostext">堆木头</span>.</p>
  <p>点击右上角分享分数到朋友圈</p>
  


 </div>
</div></div>
<SCRIPT type="text/javascript" src="jquery-2.1.4.js">
 



</SCRIPT><script type="text/javascript" src="/lattice/js/oneui/common_utils.js"></script>
<SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
<script src="/lattice/js/oneui/opes_post_result_util.js"></script>

<script type="text/javascript" src="standard.js"  charset="utf-8"></script>
<script type="text/javascript" src="stack.js"  charset="utf-8"></script>


<script type="text/javascript">
<!--
firstinit();
ialert('<h1>堆木头</h1><p style="margin: 0 20px 0 20px; text-align:left;"><img src="i/icon.png" alt="堆木头!" style="width:64px; height:64px;float:left; margin-right:5px;"/> 当木头移动到木头堆正上方时，按下按钮放木头，尽可能的对齐木头.</p>'+
'<div style="width:110px; margin:30px auto -30px auto;"></div>','restartgame()');
//-->

finalscore=0;
session=0;
type4set="";
stimidset="";


function play68_init() {
	updateShare(0);
}

function updateShare(bestScore) {
	imgUrl = './icon.png';
	lineLink = './index.html';
	descContent = "创意跳高游戏，快来一起跳！";
	updateShareScore(bestScore);
	appid = '';
}

function updateShareScore(bestScore) {
	if(bestScore > 0) {
		shareTitle = "我跳我跳我跳跳跳到" + bestScore + "米，你跳你跳你跳跳跳看！";
	}
	else{
		shareTitle = "我跳我跳我跳跳跳，你跳你跳你跳跳跳！";
	}
}

play68_init();


var testStartTime=0;

var maxtime=180;  

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
		
		timer = setInterval(function () {CountDown();}, 1000);
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
	        			finalscore=stscore/100;
	        			session++;
	        			type4set="1";  
	        			stimidset=session+"";
	        		}else {
	        			finalscore=finalscore+";"+stscore/100;
	        			session++;
	        			type4set=type4set+";1";
	        			stimidset=stimidset+";"+session;
	        		}	        	 
	         };
	         
	         
	         post_result();
	     }
	 } 

	
		function add_result(id, value)
		{
		   var elem = document.createElement("input");
		   elem.setAttribute("type", "text");
		   elem.setAttribute("id", id);
		   elem.setAttribute("name", id);
		   elem.setAttribute("value", value);
		   
		   document.getElementById("result").appendChild(elem);
		}
		
	function post_result() 
	{
		var endTime=getTimestamp();
		var testDuration=parseInt((endTime-testStartTime)/1000);
		alert(finalscore);
		score=stscore;
		//finalscore=finalscore/100;
		
		/////////////////////////////////////////////////////////////////////////////
		var corrects=new Array();
		var users=new Array();
		

		add_result("correct_result","");
		add_result("correctanswerset","");
		add_result("user_result",""+finalscore);
		add_result("buttonset", "");
		add_result("duration",testDuration);
		add_result("timeaverage",testDuration);
		add_result("user_time", "");	
		add_result("timeset", "");
		add_result("stimidset",stimidset);
		add_result("type4set", type4set);
		
		///////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////
		//var type4set="1";
		var timeset="0";
		var buttonset="0";
		var correctanswerset="";
		var numset=finalscore; 
		var radioset="";
		var commentset="";
		var radiolist1set="";
		var radiolist2set="";
		var radiolist3set="";
		var radiolist4set="";
		var radiolist5set="";
		var radiolist6set="";
		var radiolist7set="";
		var radiolist8set="";
		var radiolist9set="";
		var radiolist10set="";
		
		var countOfCorrectNumber_ByType=getCorrectCountSortByType(numset,correctanswerset,type4set);
		var countOfCorrectButton_ByType=getCorrectCountSortByType(buttonset,correctanswerset,type4set);
		var countOfCorrectRadio_ByType=getCorrectCountSortByType(radioset,correctanswerset,type4set);
		var countOfCorrectButton_ByType_Corrected=getCorrectCountSortByType_Corrected(buttonset,correctanswerset,type4set);
		var percentageCorrectNumber_ByType=getPercentageCorreceSortByType(numset,correctanswerset,type4set);
		var percentageCorrectButton_ByType=getPercentageCorreceSortByType(buttonset,correctanswerset,type4set);
		var percentageCorrectRadio_ByType=getPercentageCorreceSortByType(radioset,correctanswerset,type4set);
		var meanNumber_ByType=getMeanSortByType(numset,type4set);
		var sumNumber_ByType=getSumSortByType(numset,type4set);
		var meanRT_ByType=getMeanSortByType(timeset,type4set);
		var meanDeviationNumber_ByType=getMeanDeviationSortByType(numset,correctanswerset,type4set);
		var sumWeightedRadio_ByType=getWeightedScoreSortByType(radioset,type4set,radiolist1set,radiolist2set,radiolist3set,radiolist4set,radiolist5set,radiolist6set,radiolist7set,radiolist8set,radiolist9set,radiolist10set);
		var type4_Unique=getType(type4set);
		add_result("countOfCorrectNumber_ByType", countOfCorrectNumber_ByType);
		add_result("countOfCorrectButton_ByType", countOfCorrectButton_ByType);
		add_result("countOfCorrectRadio_ByType", countOfCorrectRadio_ByType);
		add_result("countOfCorrectButton_ByType_Corrected", countOfCorrectButton_ByType_Corrected);
		add_result("percentageCorrectNumber_ByType", percentageCorrectNumber_ByType);
		add_result("percentageCorrectButton_ByType", percentageCorrectButton_ByType);
		add_result("percentageCorrectRadio_ByType", percentageCorrectRadio_ByType);
		add_result("meanNumber_ByType", meanNumber_ByType);
		add_result("sumNumber_ByType", sumNumber_ByType);
		add_result("meanRT_ByType", meanRT_ByType);
		add_result("meanDeviationNumber_ByType", meanDeviationNumber_ByType);
		add_result("sumWeightedRadio_ByType", sumWeightedRadio_ByType);
		add_result("type4_Unique", type4_Unique);

		
		////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////
		//add_result("radioset", radioset);
		add_result("numset", numset);
		//add_result("commentset", commentset);	
		document.getElementById("result").submit();	
 	}	
	


</script>

</div>

</body>





	
</script>

</html>
