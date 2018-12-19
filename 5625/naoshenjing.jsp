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

	int highestLevel=Testresult_AllDAO.gethighestLevel(uid, taskid);

%>
<!DOCTYPE html>
<html>
    <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<title>
		    改道脑神经
		</title>
		<!--<link rel="stylesheet" type="text/css" href="resources/ygjDefault.min.css" />-->
        <link rel="stylesheet" type="text/css" href="resources/ygjDefault
		.css" />
        <script type="text/javascript" src="./resources/jquery.min.js" ></script>
        <script src="./resources/api.js"></script>
        <!--<script type="text/javascript" src="resources/ygjDefault.min.js" ></script>-->
        <script type="text/javascript" src="resources/ygjDefault.js" ></script>
        
	</head>
	<body>

<div id="tir" style="color: #ff0000;position: fixed;top: 0px;width: 500px;height: 100px"></div>;



        <div id="loading"><img src="resources/loaderc.gif" width="64px" height="64px" /></div>
	    <div style="width:100%" id="header">
	        <img src="resources/crazy-nerd-md.png" width="100px" style="padding-top:15px;" id="headimg" />
	    </div>
	    
		<a id="menuBtn" class="menuBtn" href="javascript: showMenu();" style="display: none;">菜单</a>
		<a id="menuBtn2" class="menuBtn" href="javascript: showMenu2();levelNum=1;" style="display: none;">主菜单</a>
		<span id="gametitle" style="display: none;"></span>
		<div id="menu" style="display: block;">
		</div>
		<div id="TimeClock"><span id="TimeSpan">0.00</span> 秒</div>
		<div id="canvasdiv"></div>
		<a href="javascript:hideOverlay()"><div id="overlay" class="overlay"><img src="resources/intro.gif" width="100%" height="100%" /></div></a>
        <div id="overlay4" class="overlay" style="background: rgba(0,0,0,0.5);">
            <div id="startcount" style="padding-top: 30%;color:#FFF;font-size: 8px;">3</div>
        </div>
        <div id="share" style="display: none">
			<img width="100%" src="./resources/share.png" style="position: fixed; z-index: 9999; top: 0; left: 0;" ontouchstart="document.getElementById('share').style.display='none';">
		</div>
        <script type="text/javascript" >
            var auth = new Auth9G("ygjwdd");
            var myData = {};
            auth.identify = function () {
                if (auth.user) {
                    window.shareData.timeLineLink += ((window.shareData.timeLineLink.indexOf("?") == -1 ? "?" : "&") + "uid=" + auth.myuid);
                }
            }
            auth.ready = function () {
                baiducnzz();
            }
            auth.check();
            init();
        </script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=36313548" charset="UTF-8"></script>
	</body>
	<SCRIPT type="text/javascript" src="/lattice/js/jquery-1.8.2.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/lattice/js/jquery-ui-1.9.1.custom.min.js"></SCRIPT>
<SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
<script src="/lattice/js/oneui/opes_post_result_util.js"></script>

<script type="text/javascript" src="/lattice/js/oneui/common_utils.js"></script>
<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="/lattice/js/flot/excanvas.min.js"></script><![endif]-->
<script type="text/javascript">

	finalscore=0;
	session=0;
	type4set="";
	stimidset="";
	
	numset="";
	startTime1=0;
	timeset='';
	
	userlevel=<%=highestLevel%>;
	//alert(userlevel);

	var testStartTime=0;
	var maxtime=480;  
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
		var testDuration=parseInt((endTime-startTime1)/1000);
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

	        opes_result_data.duration = parseInt(testDuration);
	        opes_result_data.timeaverage = 0;

	        //以下判断总题数
	        //opes_result_data.type4set = levelNum+'';
			opes_result_data.type4set = type4set;
	        opes_result_data.stimidset = stimidset;
	        opes_result_data.correctanswerset = finalscore;
	        //opes_result_data.time = timer;
	        //opes_result_data.level = sd.blankNum;

	        opes_result_data.timeset = timeset;
	        opes_result_data.radioset = levelNum+'';
	        opes_result_data.buttonset = levelNum+'';
	        opes_result_data.commentset = JSON.stringify({levelNum:levelNum});
	        opes_result_data.numset = numset;
	        console.log(opes_result_data);
	       opes_post_result_util_js_opes_post_result(opes_result_data);
	        return;


    }


	
</script>
</html>
