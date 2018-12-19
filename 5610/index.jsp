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
<html lang="en-us">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Unity WebGL Player | ff</title>
    <link rel="shortcut icon" href="TemplateData/favicon.ico">
    <link rel="stylesheet" href="TemplateData/style.css">
    <script src="TemplateData/UnityProgress.js"></script>  
    <script src="Build/UnityLoader.js"></script>
	
	</script>
	<script type="text/javascript" src="jsgamemin.js"></script>
	<script type="text/javascript" src="spaceman.min.js"></script>
	<SCRIPT type="text/javascript" src="/lattice/js/jquery-1.8.2.min.js"></SCRIPT>
	<SCRIPT type="text/javascript" src="/lattice/js/jquery-ui-1.9.1.custom.min.js"></SCRIPT>
	<SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
	<script src="/lattice/js/oneui/opes_post_result_util.js"></script>
	<script type="text/javascript" src="/lattice/js/oneui/common_utils.js"></script>
	
    <script>
      var gameInstance = UnityLoader.instantiate("gameContainer", "Build/w.json", {onProgress: UnityProgress});


    </script>

    <Script type = "text/javascript" language = "javascript">

      function alterRes( a, b, c, d, e,f)
      {
        // alert(a+b+c+d+e+f);
		stimidset =a;
		type4set =b;
		buttonset = c;
		correctanswerset =d;
		timeset = e;
        numset = f;
		post_result();
      }
	  userlevel=<%=highestLevel%>;
	  maxlevel=userlevel+1;
	  maxlevel=""+maxlevel;
	
      function initParam()
      {
        // 设置最高等级
        gameInstance.SendMessage("game", "SetMaxLevel", maxlevel);
		// 设置最低等级
        gameInstance.SendMessage("game", "SetMinLevel", "1");
        // 设置火车速度
        gameInstance.SendMessage("game", "SetTrainSpeed", "0.6");
        // 设置升级正确率
        gameInstance.SendMessage("game", "SetRatioLevelup", "0.85");
        // 设置火车生成间隔时间
        gameInstance.SendMessage("game", "SetGenTrainTime", "3");
        // 设置每轮火车数量
        gameInstance.SendMessage("game", "SetTrainCountPerRound", "20");
      }
    </Script>
  </head>
  <body>
    <div class="webgl-content">
      <div id="gameContainer" style="width: 960px; height: 600px"></div>
      <div class="footer">
        <div class="webgl-logo"></div>
        <!--div class="fullscreen" onclick="gameInstance.SetFullscreen(1)"></div-->
        <div class="title">火车扳道工</div>
      </div>
    </div>
  </body>
  <script type="text/javascript">

		stimidset ="";
		type4set ="";
		buttonset = "";
		correctanswerset ="";
		timeset = "";
        numset = "";
		
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
			var testDuration=parseInt((endTime-testStartTime)/1000);
		
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
		        opes_result_data.correctanswerset = correctanswerset;
		        //opes_result_data.time = timer;
		        //opes_result_data.level = sd.blankNum;

		        opes_result_data.timeset = timeset;
		        opes_result_data.radioset = "";
		        opes_result_data.buttonset = buttonset;
		        opes_result_data.commentset = "";
		        opes_result_data.numset = numset;
		        console.log(opes_result_data);
		       opes_post_result_util_js_opes_post_result(opes_result_data);
		        return;


	    }
	</script>		
</html>
</html>