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

<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width initial-scale=1.0, user-scalable=no" />

	<title>黄金矿工 - 懒人模板</title>
	<meta name="keywords" content="黄金矿工,休闲游戏" /> 
	<meta name="description" content="黄金矿工,休闲游戏" />
	<meta name='robots' content='noindex,follow' />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
</head>

<body  style="-webkit-user-select: none;background-color: #000;	">

<div id="tir" style="color: #ff0000;position: fixed;top: 0px;width: 500px;height: 100px"></div>;

	
	<script language="JavaScript">function clickIE(){if(document.all)return false;}function clickNS(e){if(document.layers||(document.getElementById&&!document.all)){
		if(e.which==2||e.which==3)return false;}}if(document.layers){document.captureEvents(Event.MOUSEDOWN);document.onmousedown=clickNS;}else{document.onmouseup=clickNS;document.oncontextmenu=clickIE;}document.oncontextmenu=new Function("return false");
		if(window.innerWidth){rW=window.innerWidth;rH=window.innerHeight;}else{rW=document.documentElement.clientWidth ? document.documentElement.clientWidth : document.body.clientWidth;rH=document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight;}
		if(window.innerWidth<600){var gW=384;var gH=60;}
		else {var gW=768;gH=120;}
	</script>
	

	<script>
		var par_level;
		var par_score;
		var par_game;var par_ad2=1;
		var par_ad3=1;
		var par_ad4=1;
		var par_adx2;
		var par_adx3;
		var par_adx4;

		if(window.innerWidth){rW=window.innerWidth;rH=window.innerHeight;}
		else{rW=document.documentElement.clientWidth ? document.documentElement.clientWidth : document.body.clientWidth;rH=document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight ;}

		var ds_urlhiscore="http://g.lanrenmb.com"; 

		function ds_SHS(){return "";}
		function ds_HS(){}

		var dsp=new Array("=0", 
			"dse.jpg", 
			"g.lanrenmb.com", 
			1,	
			0, 
			0,  
			0,  
			"", 
			"http://g.lanrenmb.com/test_hjkg/",
			1,	
			0, 
			0,
			1, 
			0, 
			"g.lanrenmb.com", 
			"http://g.lanrenmb.com/games/AngelsAndDevils/ad1.jpg", 
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
	<script src="GoldNuggets_x.js?v=14502aa"></script>

	<div style="display:none;"><script type="text/javascript" src="http://tajs.qq.com/stats?sId=36313548" charset="UTF-8"></script></div>

	
	</body>
<script type="text/javascript">

var testStartTime=0;
var maxtime=600;

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
            post_result();
        }
    }


	
	function post_result() 
	{
		var endTime=getTimestamp();
		var testDuration=parseInt((endTime-testStartTime)/1000);
		
		score=L;
		alert(score);
		//var totalCount=parseInt(testDuration*score);
		// score=totalCount;
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
	        opes_result_data.commentset = 'al';
	        opes_result_data.numset = score+'';
	        console.log(opes_result_data);
	        opes_post_result_util_js_opes_post_result(opes_result_data);
	        return;


    }


	
</script>

</html>
