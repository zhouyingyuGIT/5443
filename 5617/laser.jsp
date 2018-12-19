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


%>

<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html;">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta name="description" content="game for iPhone">
<meta name="keywords" content="iPhone,Androig,iPad,game,html5 game,shooting,shooting game,action game,3d,Flash,Flash for iPhone,html5,iPod touch,iPad">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="viewport" id="viewport" content="width = device-width, initial-scale = 1, minimum-scale = 1, maximum-scale = 1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta equiv="Expires" content="0">
<style type="text/css">

</style>

<script  src="jquery.js"></script>
<script language="javascript" type="text/javascript" src="static/play68.js"></script>
<script type="text/javascript" src="static/gm12.min.js"></script>


<meta name="viewport" content="width = device-width, initial-scale = 1, minimum-scale = 1, maximum-scale = 1"></head>

<body onload="ist()" onorientationchange="rtalt()">

<div id="tir" style="color: #ff0000;position: fixed;top: 0px;width: 500px;height: 100px"></div>

<script src="http://cpro.baidustatic.com/cpro/ui/cm.js" type="text/javascript"></script>

<div id="chf2" style="position:relative;width:320px;margin:0 auto;"><canvas id="gcvs" width="320" height="416"></canvas></div>
 

<link type="text/css" rel="stylesheet" href="static/sidebar.css">

<div style="display:none">
<script type="text/javascript" src="static/play68bar.js"></script>
<script src="http://s11.cnzz.com/stat.php?id=5578006&web_id=5578006" language="JavaScript"></script>

</div></body>

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
		
		score=scr;
		<!-- var totalCount=parseInt(testDuration*score); -->
		<!-- score=totalCount; -->
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