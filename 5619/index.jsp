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

<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="user-scalable=no, width=device-width, height=device-height, initial-scale=1.0, minimum-scale=1, maximum-scale=1" />

<title>青蛙跳</title>
<meta name='robots' content='noindex,follow' />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<style type="text/css">
#cvd{
width: 77px;
height: 77px;
-webkit-box-shadow: 5px 5px 8px #818181;
-webkit-border-radius: 10px;
}
body {
	-webkit-user-select:none;
	-webkit-text-size-adjust:none;
	-moz-user-select:none;
	-moz-text-size-adjust:none;
	-ms-user-select:none;
	-ms-text-size-adjust:none;
	-o-user-select:none;
	-o-text-size-adjust:none;
	user-select:none;
	text-size-adjust:none;
	min-height:100%
}
#g1{margin-top:280px;margin-left:40px;position:absolute}
#weixin-share{background-image:url(share.png);height:100px;width:160px;position:absolute;top:0px;left:240px;z-index:699}
#weixin-text{
	font-family:"Microsoft Yahei",Arial,Helvetica,sans-serif;
	height: 600px;
	width: 420px;
	margin-top: 0px;
	margin-right: auto;
	margin-left: auto;
	background-color: #E8D9AE;
	padding-top: 23px;
	padding-left: 40px;
	z-index: 600
}#weixin-text #j{
	height: 464px;
	width: 316px;
	background-image: url(j.png);
	background-repeat: no-repeat;
	padding: 0px;
	clear: both;
	position: absolute;
	z-index: 601;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	margin-left: 30px;
}#weixin-text #j #txt{font-size:36px;font-weight:bold;color:#790000;margin-top:110px;margin-left:0px;text-align:center;}#weixin-text #j #rank{text-align:center;margin-top:0px;position:absolute;width:100%;padding-top:5px;color:#4E4524}
</style>
 </head>
<body style="-webkit-user-select: none;bgcolor=" #ffffff'="" text="#000000" vlink="#7f7f7f" alink="#7f7f7f" link="#7f7f7f"> 
	<div id="tir" style="color: #ff0000;position: fixed;top: 0px;width: 500px;height: 100px"></div>
 <script>
var ds_info="Jump from one branch to another and don't fall into the river. Touch the screen to set the jump power and release it to jump.";
function info(){alert(ds_info);}
function ds_HS(){}
function myshow(){}
function mydisable(){}


var par_level;
var par_score;
var par_game;var par_ad2=1;
var par_ad3=1;
var par_ad4=1;
var par_adx2;
var par_adx3;
var par_adx4;
var testStartTime=0;
finalscore=0;

if(0)por="<br><br><br><img border=0 src=\"portrait.jpg\">";
else por="";
 

var ds_urlhiscore="http://g.lanrenmb.com"; 

function ds_RZ(){ 

}
function ds_SHS(){return "";}

   
var dsp=new Array("=0", 
"main.png", 
"http://g.lanrenmb.com", 
1,	
0, 
0,  
1,  
"", 
"http://g.lanrenmb.com",
1,	
0, 
0,
1, 
0, 
"http://g.lanrenmb.com", 
"http://g.lanrenmb.com", 
"_self", 
"udf23hh3r62srayd4", 
0,          
250,        
16,       
1,         
"Loading ...", 
"ffffff", 
"000000", 
"00bfdf", 
0,         
1,          
0,        
"",				
1,
1);

</script> 
<script src="game.js"></script>

<SCRIPT type="text/javascript" src="/lattice/js/jquery-1.8.2.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/lattice/js/jquery-ui-1.9.1.custom.min.js"></SCRIPT>
<SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
<script src="/lattice/js/oneui/opes_post_result_util.js"></script>

<script type="text/javascript" src="/lattice/js/oneui/common_utils.js"></script>



<script src="share.js"></script>
<input id="appid" name="appid" type="hidden" value="8596144" />
<script language=javascript>
		var mebtnopenurl = 'http://g.lanrenmb.com';
		window.shareData = {
		        "imgUrl": "http://g.lanrenmb.com/icon/qwt.png",
		        "timeLineLink": "http://g.lanrenmb.com/games/qwt/",
		        "tTitle": "青蛙跳",
		        "tContent": "青蛙跳"
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
            var myData = { gameid: "qwt" };
			//window.shareData.timeLineLink = "http://g.lanrenmb.com/gamecenter.html?gameid=" + myData.gameid + (localStorage.myuid ? "&uid=" + localStorage.myuid : "");
			function dp_submitScore(score){
				myData.score = score;
				myData.scoreName = score+"米";
				finalscore=score;
				if(score>0){
					if (confirm("真厉害，竟然跳了"+score+"米")){
						
						
						post_result();
						
						dp_share();
					}
				}
				//post_result();
			}
			
			</script>
			<div style="display: none;">
			 
			</div>
</body>
<script type="text/javascript">

	jQuery(document).ready(function () 
		{
			 var now = new Date();
			 testStartTime=now.getTime();
			 
		});
	
	
		var maxtime=300;
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
            post_result();
        }
    }
		function post_result() 
		{
			var endTime=getTimestamp();
			var testDuration=parseInt((endTime-testStartTime)/1000);
			
			//score=parseInt(score);
			//var totalCount=parseInt(testDuration*score);
			//score=totalCount;
			//alert('score='+finalscore+'  totalCount='+totalCount);
			
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
				opes_result_data.correctanswerset = finalscore+'';
				//opes_result_data.time = timer;
				//opes_result_data.level = sd.blankNum;
	
				opes_result_data.timeset = finalscore+'';
				opes_result_data.radioset = finalscore+'';
				opes_result_data.buttonset = finalscore+'';
				opes_result_data.commentset = JSON.stringify({finalscore:finalscore});
				opes_result_data.numset = finalscore+'';
				console.log(opes_result_data);
			   opes_post_result_util_js_opes_post_result(opes_result_data);
				return;
	
	
		}
	
	
		
	</script>
</html>
