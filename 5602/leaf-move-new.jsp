<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="com.lattice.entity.*"%>
<%@ page language="java" import="com.lattice.dao.*,java.util.*"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>leaf movement</title>


<link rel="stylesheet" href="/lattice/css/oneui/oneui.css" type="text/css" media="screen" />
<link rel="stylesheet" href="/lattice/css/jquery/redmond/jquery-ui-1.9.1.custom.min.css" />


<style type="text/css">
          
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


%>


<body >
	
	<div  id='game_area_div_id' >
		<span id='score_span_id' style='    font-size: 1.7em; color: #212121;font-weight: 600;'>得分：0 </span> 
		<img id='arraw_img_id' style="width:40px;height:40px;" src="v3.ico">
		
		<div id='center_pan_div_id' style="display:block;width:550px;height:400px; border: 1px #C0FF3E; border-radius: 3px 3px 3px 3px;background:#000;" id="main_processing_div"  >
		</div>
	</div>
	<!-- 
		<a href='javascript:;' onclick='return clear_all();'>aaaaa</a>
		background:#C0FF3E;
		
	 -->
	
</body>

<SCRIPT type="text/javascript" src="/lattice/js/jquery-1.8.2.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/lattice/js/jquery-ui-1.9.1.custom.min.js"></SCRIPT>
<script type="text/javascript" src="jquery.fly.js"></script>
<script type='text/javascript' src='mousetrap-1.4.6.min.js'></script>
<script type='text/javascript' src='jQueryRotate.2.2.js'></script>
<SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
<script src="/lattice/js/oneui/opes_post_result_util.js"></script>

<script type="text/javascript" src="/lattice/js/oneui/common_utils.js"></script>
<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="/lattice/js/flot/excanvas.min.js"></script><![endif]-->
   

<script type="text/javascript">
	var $allflys=[];
	var alltimeout=[];
	var allSnapshotList=[];
	var totalTimeLimitInSeconds=160;
	var startTime=getTimestamp();
	
	var userResultSummary={
			totalScore:0,
			totalResponseCount:0,
			totalCorrectCount:0,
			averageResponseTime:0
	};

	jQuery(document).ready(function () 
	{
		show_instructions();
		//start_game();
		
	});
	function show_instructions()
	{
		$('#game_area_div_id').hide();
		
		var instruction="<div id='instruction_div_id' style='width:600px;height:200px;font-size: 1.6em; color: #212121;font-weight: 500;border: 0px solid red;'>游戏前的游戏指导：屏幕上会出现绿色或黄色的树叶，统一向“上下左右”中的某一个方向流动，树叶的指向也分为四种：上、下、左或右。当出现绿色树叶时，关注树叶的指向，按键盘上相应的方向按键进行反应；当出现黄色树叶时，关注树叶的流向，黄色树叶往哪个方向流动便按哪个键。<br/>准备好了么？准备好的话就点击下方的“开始”按钮吧！</div>";
		instruction+="<button id='start_game_button_id'  style='font-size:23px;' onclick='start_game();' >确定</button>";
		
		$('body').append(instruction);
		$( "#instruction_div_id" ).position({
			  my: "center center",
			  at: "center center",
			  of: $(document),
			  collision: "none"
			});
		$( "#start_game_button_id" ).position({
			  my: "center bottom",
			  at: "center bottom",
			  of: $(document),
			  collision: "none"
			});
		
	}
	function start_game()
	{
		$('#game_area_div_id').show();
		$('#instruction_div_id').remove();
		$('#start_game_button_id').remove();
		
		startTime=getTimestamp();
		initialize_keyboard_events();
		position_center_div();
		
		var snap=getNextSnapshot();
		showNextSnapshot(snap);
		//$('body').append('<br/>'+JSON.stringify(snap));
	}
	function initialize_keyboard_events()
	{
		var userDefinedKeys=['up','down','left','right'];
		Mousetrap.bind(userDefinedKeys, function(e) {jsplumb_util_js_UpKeyEvent(String.fromCharCode(e.keyCode||e.which));});
		
		//Mousetrap.bind('up', jsplumb_util_js_UpKeyEvent);
		//Mousetrap.bind('down', jsplumb_util_js_DownKeyEvent);
		//Mousetrap.bind('left', jsplumb_util_js_LeftKeyEvent);
		//Mousetrap.bind('right', jsplumb_util_js_RightKeyEvent);
	}
	function getTimestamp()
	{
		var now = new Date();
		return now.getTime(); // in ms
	}
	function jsplumb_util_js_UpKeyEvent(userTypedKey)
	{
		var intUserTypedKey=0;
		//alert(userTypedKey);
		//userTypedKey=userTypedKey.toLowerCase();
		if(userTypedKey=='&')//up
		{
			intUserTypedKey=1;
		}else if(userTypedKey=='(')//down
		{
			intUserTypedKey=2;
		}else if(userTypedKey=='%')//left
		{
			intUserTypedKey=3;
		}else if(userTypedKey=='\'')//right
		{
			intUserTypedKey=4;
		}
		//alert(userTypedKey+'__'+intUserTypedKey);
		
		clear_all();
		
		var currentSnap=allSnapshotList[allSnapshotList.length-1];
		currentSnap.userResult=intUserTypedKey;
		
		if(currentSnap.correctResult==intUserTypedKey)//correct
		{
			//calculate score for current snapshot
			currentSnap.userScore=currentSnap.currentLevel*50;
			
			currentSnap.continuousCorrectCount++;
			if(currentSnap.continuousCorrectCount==4)
			{
				currentSnap.currentLevel++;
				currentSnap.continuousCorrectCount=0;
			}
			
		}else //wrong
		{
			//calculate score for current snapshot
			currentSnap.userScore=0;
			if(currentSnap.continuousCorrectCount>=1)//至少作对一题
			{
				currentSnap.continuousCorrectCount=0;
				
			}else if(currentSnap.continuousCorrectCount==0)//当前等级没作对一题
			{
				currentSnap.continuousCorrectCount=0;
				currentSnap.currentLevel--;
				if(currentSnap.currentLevel<=0)
				{
					currentSnap.currentLevel=1;
				}
			}
			
		}
		
		var snap=getNextSnapshot();
		showNextSnapshot(snap);
		
		calculate_final_summary();
		$('#score_span_id').html('等级：'+currentSnap.currentLevel+'正确：'+currentSnap.continuousCorrectCount+'得分：'+currentSnap.userScore+'总分：'+userResultSummary.totalScore);
		
		//$('body').append('<br/>'+JSON.stringify(snap));
	}
	
	
	
	
	//1 2 3 4 = up down left right
	//1 2 = yellow green
	function getNextSnapshot()
	{
		var snap={};
		snap.moveDirection=rnd(1, 4);
		snap.leafDirection=rnd(1, 4);
		snap.leafType=rnd(1, 2);
		snap.correctResult=0;
		snap.userResult=0;//user does not type any key
		snap.userScore=0;
		
		if(snap.leafType==2)//green
		{
			snap.correctResult=snap.leafDirection;
			//alert('green: correctResult='+snap.correctResult+'_leafDirection='+snap.leafDirection);
		}else if(snap.leafType==1)//yellow
		{
			snap.correctResult=snap.moveDirection;
			//alert('yellow: correctResult='+snap.correctResult+'_moveDirection='+snap.moveDirection);
		}
		
		if(allSnapshotList.length==0)
		{
			snap.currentLevel=1;
			snap.continuousCorrectCount=0;
		}else
		{
			var preSnap=allSnapshotList[allSnapshotList.length-1];
			snap.currentLevel=preSnap.currentLevel;
			snap.continuousCorrectCount=preSnap.continuousCorrectCount;
		}
		allSnapshotList.push(snap);
		
		//$('body').append('<br/>'+JSON.stringify(snap));
		return snap;
	}
	function showNextSnapshot(snap)
	{
		
		var docwidth=$(window).width();
		var docheight=$(window).height();
		var deltaleft=(docwidth-550)/2;
		var deltabottom=(docheight-400)/2;
		
		//alert(docwidth+'_'+docheight+'_'+deltaleft+'_'+deltabottom+'')
		
		var rangle=0;
		var speed=0.2;
		var vertex_Rtop=500;
		var src="";
		var start={
			 left: 0, 
		      top: 0 
		};
		var end={
			 left: 0, 
		      top: 0 
		};
		if(snap.leafType==1)
		{
			src="a2.png";
		}else if(snap.leafType==2)
		{
			src="a1.png";
		}
		if(snap.leafDirection==1)//up
		{
			rangle=0;
		}else if(snap.leafDirection==2)//
		{
			rangle=180;
		}else if(snap.leafDirection==3)//left
		{
			rangle=270;
		}else if(snap.leafDirection==4)//right
		{
			rangle=90;
		}
		
		//move leaf as time goes on
		for(var timeCount=0;timeCount<500;timeCount++)
		{
			//each row with 9 leaf
			for(var i=1;i<9;i++)
			{
				//go up
				if(snap.moveDirection==1)
				{
						start={
							 left: deltaleft+i*50, 
						      top: 350+deltabottom
						};
						end={
							 left: deltaleft+i*50, 
						      top: deltabottom 
						};
						vertex_Rtop=550+deltabottom;
				}else if(snap.moveDirection==2)//go down
				{
					start={
							 left: deltaleft+i*50, 
						      top: deltabottom
						};
						end={
							 left: deltaleft+i*50, 
						      top: 350+deltabottom 
						};
						vertex_Rtop=deltabottom;
				}else if(snap.moveDirection==3)//go left
				{
					start={
							 left: 500+deltaleft, 
						      top: 400+deltabottom-i*50
						};
						end={
							 left: deltaleft, 
						      top: 400+deltabottom-i*50
						};
						vertex_Rtop=550+deltabottom;
				}else if(snap.moveDirection==4)//go right
				{
					start={
							 left: deltaleft, 
						      top: 400+deltabottom-i*50
						};
						end={
							 left: 500+deltaleft, 
						      top: 400+deltabottom-i*50
						};
						vertex_Rtop=550+deltabottom;
				}
				
				
				var passobj={};
				passobj.src=src;
				passobj.start=start;
				passobj.end=end;
				passobj.rangle=rangle;
				passobj.speed=speed;
				passobj.vertex_Rtop=vertex_Rtop;
				
				var timeout_id=window.setTimeout(move_common_util_with_json , 1000*timeCount, passobj);
				alltimeout.push(timeout_id);
				
				
			}
		}
		
		
	}
	function move_common_util_with_json(passobj)
	{
		var endTime=getTimestamp();
		if((endTime-startTime)/1000>totalTimeLimitInSeconds)
		{
			clear_all();
			calculate_final_summary();
			$('#score_span_id').html('总分数：'+userResultSummary.totalScore+' 平均响应时间：'+userResultSummary.averageResponseTime);
			//$('body').append('<br/><br/><br/><br/>'+JSON.stringify(allSnapshotList));
			
			post_result() ;
			
		}else
		{
			move_common_util(passobj.src,passobj.start,passobj.end,passobj.rangle,passobj.speed,passobj.vertex_Rtop);
		}
	}
	function calculate_final_summary()
	{
		userResultSummary.totalResponseCount=allSnapshotList.length;
		userResultSummary.totalScore=0;
		for(var i=0;i<allSnapshotList.length;i++)
		{
			var snap=allSnapshotList[i];
			userResultSummary.totalScore+=snap.userScore;
			
			if(snap.userScore>0)
			{
				userResultSummary.totalCorrectCount++;
			}
			
		}
		
		userResultSummary.totalScore+=250*allSnapshotList[allSnapshotList.length-1].currentLevel;
		
		userResultSummary.averageResponseTime=parseInt(userResultSummary.totalScore/userResultSummary.totalResponseCount);
		
		//alert($('#score_span_id').html())
	}
	function clear_all()
	{
		//alert($allflys.length);
		for(var i=0;i<$allflys.length;i++)
		{
			$allflys[i].remove();
		}
		
		for(var i=0;i<alltimeout.length;i++)
		{
			clearTimeout(alltimeout[i]);
		}
	}
	
	function position_center_div()
	{
		var docwidth=$(document).width();
		var docheight=$(document).height();
		var deltaleft=(docwidth-550)/2;
		var deltabottom=(docheight-400)/2;
		
		
		$( "#center_pan_div_id" ).position({
			  my: "center center",
			  at: "center center",
			  of: $(document),
			  collision: "none"
			});
		
		$( "#score_span_id" ).position({
			  my: "center top",
			  at: "center-100 top-50",//at: "center top"+" + "+(deltabottom+100),
			  of: $('#center_pan_div_id'),
			  collision: "none"
			});
		
		$( "#arraw_img_id" ).position({
			  my: "center top",
			  at: "center+100 top-50",//at: "center top"+" + "+(deltabottom+100),
			  of: $('#center_pan_div_id'),
			  collision: "none"
			});
		
		
		
	}
	function start_10()
	{
		var docwidth=$(document).width();
		var docheight=$(document).height();
		var deltaleft=(docwidth-550)/2;
		
		var speed=0.2;
		for(var i=1;i<7;i++)
		{
			var src="a2.ico";
			var top=150;
			var left=0;
			left+=deltaleft;
			//left=rnd(1,50);
			move(src,top+i*40,left,speed)
		}
		
		for(var i=1;i<7;i++)
		{
			var src="a2.ico";
			var top=150;
			var left=50;
			left+=deltaleft;
			//left=rnd(1,50);
			move(src,top+i*40,left,speed*1.1)
		}
		
		for(var i=1;i<7;i++)
		{
			var src="a2.ico";
			var top=150;
			var left=100;
			left+=deltaleft;
			//left=rnd(1,50);
			move(src,top+i*40,left,speed*1.2)
		}
		
		
	}
	function start_bottom_to_up()
	{
		var docwidth=$(document).width();
		var docheight=$(document).height();
		var deltaleft=(docwidth-550)/2;
		var deltabottom=(docheight-400)/2;
		
		
		for(var i=1;i<=5;i++)
		{
			var src="a3.ico";
			var top=350+deltabottom;
			var left=deltaleft+50;
			move_bottom_to_up(src,top,left+i*30)
		}
	}
	function move(src,top,left,speed)
	{
		var docwidth=$(document).width();
		var docheight=$(document).height();
		var deltaleft=(docwidth-550)/2;
		
		var flyer = $('<img style="width:38px;height:67px;" class="flyer-img" src="'+src+'">'); //抛物体对象
		flyer.fly({
			start: {
				 left: left,  //开始位置（必填）#fly元素会被设置成position: fixed
			      top: top  //开始位置（必填）
			},
			end: {
				 left: 500+deltaleft, //结束位置（必填）
			      top: top  //结束位置（必填）
			},
			speed: speed, //越大越快，默认1.2//0.2
		    vertex_Rtop: top, //运动轨迹最高点top值，默认20
			onEnd: function() {
				//$("#aaaaaaatip").show().animate({width: '200px'},300).fadeOut(500);////成功加入购物车动画效果
				//this.destory(); //销毁抛物体
				flyer.remove(); //销毁抛物体
			}
		});
		$allflys.push(flyer);
		
		
		/*
		$('#fly').fly({
		    start:{
		      left: 11,  //开始位置（必填）#fly元素会被设置成position: fixed
		      top: 600,  //开始位置（必填）
		    },
		    end:{
		      left: 500, //结束位置（必填）
		      top: 130,  //结束位置（必填）
		      width: 100, //结束时高度
		      height: 100, //结束时高度
		    },
		    autoPlay: false, //是否直接运动,默认true
		    speed: 1.1, //越大越快，默认1.2
		    //vertex_Rtop：100, //运动轨迹最高点top值，默认20
		    onEnd: function(){} //结束回调
		  });
		  $('#fly').play(); //autoPlay: false后，手动调用运动
		  $('#fly').destroy(); //移除dom
		  */
		  
	}
	function move_bottom_to_up(src,top,left)
	{
		var docwidth=$(document).width();
		var docheight=$(document).height();
		var deltaleft=(docwidth-550)/2;
		var deltabottom=(docheight-400)/2;
		
		
		var flyer = $('<img style="width:30px;height:30px;" class="flyer-img" src="'+src+'">'); //抛物体对象
		flyer.fly({
			start: {
				 left: left,  //开始位置（必填）#fly元素会被设置成position: fixed
			      top: top  //开始位置（必填）
			},
			end: {
				 left: left, //结束位置（必填）
			      top: deltabottom  //结束位置（必填）
			},
			speed: 0.2, //越大越快，默认1.2
		    vertex_Rtop: top, //运动轨迹最高点top值，默认20
			onEnd: function() {
				//$("#aaaaaaatip").show().animate({width: '200px'},300).fadeOut(500);////成功加入购物车动画效果
				//this.destory(); //销毁抛物体
				flyer.remove(); //销毁抛物体
			}
		});
		$allflys.push(flyer);
		  
	}
	
	function move_common_util(src,start,end,rangle,speed,vertex_Rtop)
	{
		var docwidth=$(document).width();
		var docheight=$(document).height();
		var deltaleft=(docwidth-550)/2;
		var deltabottom=(docheight-400)/2;
		//alert(start.left+'='+start.top+'='+end.left+'='+end.top+'')
		
		//77px 134px
		var flyer = $('<img class="rotate_class" style="width:31px;height:55px;position:aboslute;" class="flyer-img" src="'+src+'">'); //抛物体对象
		flyer.fly({
			start: start,
			end:end,
			speed: speed, //越大越快，默认1.2
		    vertex_Rtop: vertex_Rtop, //运动轨迹最高点top值，默认20
			onEnd: function() {
				//$("#aaaaaaatip").show().animate({width: '200px'},300).fadeOut(500);////成功加入购物车动画效果
				//this.destory(); //销毁抛物体
				flyer.remove(); //销毁抛物体
			}
		});
		$allflys.push(flyer);
		
		$('.rotate_class').rotate(rangle);
		  
	}
	//[n,m]
	function rnd(n, m)
	{
        var random = Math.floor(Math.random()*(m-n+1)+n);
        return random;
    }
	
	function post_result() 
	{
        var opes_result_data = {};

        /*
        var userResultSummary={
			totalScore:0,
			totalResponseCount:0,
			totalCorrectCount:0,
			averageResponseTime:0
		};*/
		
		
	
        opes_result_data.taskid ='<%= taskid %>';
        //alert(opes_result_data.taskid);
        opes_result_data.sumitcoids =<%= sumitcoids %>;
       // alert(opes_result_data.sumitcoids)
        //opes_result_data.targetpagename = "<%=targetpagename%>";
       // opes_result_data.codematerial =<%= codematerial %>;
        opes_result_data.uid =<%= uid %>;
       // opes_result_data.lan = "<%=lan%>";
        opes_result_data.projectid =<%= projectid %>;

        opes_result_data.duration = totalTimeLimitInSeconds;
        opes_result_data.timeaverage = userResultSummary.averageResponseTime;

        //以下判断总题数
        opes_result_data.type4set = userResultSummary.totalResponseCount+'';
        opes_result_data.stimidset = userResultSummary.totalResponseCount+'';
        opes_result_data.correctanswerset = userResultSummary.totalResponseCount+'';
        //opes_result_data.time = timer;
        //opes_result_data.level = sd.blankNum;

        opes_result_data.timeset = userResultSummary.totalResponseCount+'';
        opes_result_data.radioset = userResultSummary.totalScore+'';
        opes_result_data.buttonset = userResultSummary.totalCorrectCount+'';
        opes_result_data.commentset = JSON.stringify(allSnapshotList);
        opes_result_data.numset = userResultSummary.totalResponseCount+'';
        console.log(opes_result_data);
       opes_post_result_util_js_opes_post_result(opes_result_data);
        return;


    }


	
</script>

</html>