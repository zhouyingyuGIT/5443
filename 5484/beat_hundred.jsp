<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>打百子</title>
    <style>
        .box{
            width: 800px;
            margin: 20px auto;
            height: 400px;
            border: 1px solid #5e5e5e;
            border-radius: 5px;
            position: relative;
        }
        .typeBox{
            width: 100%;
            text-align: center;
            margin-top: 100px;
            padding: 16px 0px;
            height: 100px;
        }
        .typeBox span{
            padding: 12px 26px;
            border: 1px solid #000;
            border-radius: 10px;
            margin: 0px 16px;
            cursor: pointer;
        }
        .btn {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: 400;
            line-height: 1.42857143;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            -ms-touch-action: manipulation;
            touch-action: manipulation;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #fff;
            background-color: #337ab7;
            border-color: #2e6da4;
        }
        .buttonBox{
            position: absolute;
            bottom: 0px;
            height: 120px;
            width: 100%;
            line-height: 120px;
            text-align: center;
        }
        .step{
            position: relative;
            width: 100%;
            height: 100%;
        }
        .tabBox{
            height: 280px;
            width: 100%;
            position: absolute;
            padding-top: 16px;
            /*background-color: #00b0f0;*/
        }
        .tabBox .tab{
            height: 160px;
            width: 100%;
            position: absolute;
            /*background-color: #00b0f0;*/
        }
        .tabBox .tab span{
            display: inline-block;
            padding: 12px 26px;
            border: 1px solid #000;
            border-radius: 10px;
            margin: 16px 16px;
            cursor: pointer;
        }
        .tabBox .tab .topic{
            padding: 16px;
            margin: 16px;
            font-size: 24px;
            font-weight: 700;
            text-align: center;
        }
        .tabBox .inputBox{
            position: absolute;
            top: 160px;
            width: 100%;
            padding-top: 16px;
            margin-top: 30px;
            font-size: 24px;
            font-weight: 700;
            text-align: center;
        }
        .tabBox .inputBox input{
            -webkit-appearance: none;
            background-color: #fff;
            background-image: none;
            border-radius: 4px;
            border: 1px solid #dcdfe6;
            box-sizing: border-box;
            color: #606266;
            display: inline-block;
            font-size: 18px;
            height: 36px;
            line-height: 36px;
            outline: none;
            padding: 0 15px;
            transition: border-color .2s cubic-bezier(.645,.045,.355,1);
        }
        .step3{
            position: absolute;
            width: 100%;
            height: 100%;
        }
        .step3 .title{
            margin-top: 16px;

        }
        .step3 .title span{
            display: inline-block;
            padding: 12px 26px;
            border: 1px solid #000;
            border-radius: 10px;
            margin: 16px 16px;
            cursor: pointer;

        }
        #step1{
            display: block;
        }
        #step2{
            display: none;
        }
        #step3{
            display: none;
        }
        #tab1{
            display: none;
        }
        #tab2{
            display: none;
        }
        #tab3{
            display: none;
        }
        #tab4{
            display: none;
        }
        #tab5{
            display: none;
        }
    </style>
    <SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
    <script src="/lattice/js/oneui/opes_post_result_util.js"></script>
</head>
<%
Users u=(Users)request.getSession().getAttribute("cu");
int uid=u.getUserid();
int taskid=Integer.parseInt(request.getParameter("taskid"));
String lan=request.getParameter("lan");
String targetpagename=request.getParameter("targetpagename");

int projectid=0;
if (!(request.getParameter("projectid")==null)) {
projectid=Integer.parseInt(request.getParameter("projectid"));
}

int codematerial=0;
if (!(request.getParameter("codematerial")==null)) {
codematerial=Integer.parseInt(request.getParameter("codematerial"));
}

int sumitcoids=u.getCoid();


Vector
<OPES_Task> ots=OPES_TaskDAO.getOPES_aTask(Integer.parseInt(request.getParameter("taskid")),lan);
    if (ots.size()==0)
    {
    response.sendRedirect("/lattice/"+targetpagename);
    return;
    }
    ots.get(0).setProjectid(Integer.parseInt(request.getParameter("projectid")));
    request.getSession().setAttribute("ot",ots.get(0));

    %>
<body>
<div class="box">
    <div id="step1" class="step">
        <h1 style="text-align: center;margin: 0px;padding: 20px 0px">打百子</h1>

        <div class="typeBox">
            <span id="type1">阶段一</span>
            <span id="type2">阶段二</span>
            <span id="type3">阶段三</span>
            <span id="type4">阶段四</span>
            <span id="type5">阶段五</span>
        </div>

        <div class="buttonBox">
            <button id="stepBtn1" class="btn">结束训练</button>
        </div>
    </div>

    <div id="step2" class="step">
        <div class="tabBox">
            <div id="tab1" class="tab">
                <div class="title">
                    <span>打百子/阶段一</span>
                </div>

                <div class="topic">题目：1+2+…+19+20=</div>

                <!--<div class="inputBox">
                    <input id="input1" placeholder="请输入结果" type="text">
                </div>-->
            </div>
            <div id="tab2" class="tab">
                <div class="title">
                    <span>打百子/阶段二</span>
                </div>

                <div class="topic">题目：1+2+…+20-1-2-…-20=</div>

                <!--<div class="inputBox">
                    <input id="input2" placeholder="请输入结果" type="text">
                </div>-->
            </div>
            <div id="tab3" class="tab">
                <div class="title">
                    <span>打百子/阶段三</span>
                </div>

                <div class="topic">题目：1+2+…+40-1-2…-40=</div>

                <!--<div class="inputBox">
                    <input id="input3" placeholder="请输入结果" type="text">
                </div>-->
            </div>
            <div id="tab4" class="tab">
                <div class="title">
                    <span>打百子/阶段四</span>
                </div>

                <div class="topic">题目：1+2+…+70-1-2…-70=</div>

                <!--<div class="inputBox">
                    <input id="input4" placeholder="请输入结果" type="text">
                </div>-->
            </div>
            <div id="tab5" class="tab">
                <div class="title">
                    <span>打百子/阶段五</span>
                </div>

                <div class="topic">题目：1+2+…+100-1-2…-100=</div>

                <!--<div class="inputBox">
                    <input id="input5" placeholder="请输入结果" type="text">
                </div>-->
            </div>
            <div class="inputBox">
                <input onkeyup="this.value=this.value.replace(/\D/g,'')" id="result" placeholder="请输入结果" type="text">
            </div>
        </div>

        <div class="buttonBox">
            <button id="step2Btn1" class="btn">开始拨珠</button>
            <button id="step2Btn2" class="btn">结束拨珠，输入答案</button>
            <button id="step2Btn3" class="btn">结束</button>
        </div>
    </div>
    <div id="step3" class="step">
        <div class="step3">
            <div class="title">
                <span id="title">打百子/阶段一</span>
            </div>

            <div style="width: 50%;margin: 0px auto;height: 200px;text-align: center;font-weight: 700;font-size: 24px">
                <div id="RrealTime" style="line-height: 100px">实拨时间 <span id="realTime"></span>毫秒</div>
                <div id="DdumpTime" style="line-height: 100px">虚拨时间 <span id="dumpTime"></span>毫秒</div>
            </div>

            <div class="buttonBox">
                <button id="step3Btn1" class="btn">返回</button>
            </div>
        </div>
    </div>
</div>
</body>
<script src="jquery.js"></script>
<script>
    $(function () {
        var tab;
        /*实拨时间*/
        var real_time;
        /*虚拨时间*/
        var dump_time;
        var start_time;
        var end_time;
        /*控制按键点击是否有效*/
        var if_btn1=true;
        var if_btn2=false;
        var if_btn3=false;
        /*用户输入结果*/
        var result_val;
        var taskid;
        var type4set=[];
        var timeset=[];
        var correctanswerset=[];
        var numset=[];
		var stimidset=[];
        var num;
        var corr;
        var commentset=[];
        var ifxs=true;
        var NexTime=3;
		trialno=1;
		
        taskid=getUrlParam("taskid");

        function xsFun(ifxs) {
            if(ifxs){
                $("#RrealTime").css({
                    display: "block"
                });
                $("#DdumpTime").css({
                    display: "none"
                });
            }else {
                $("#DdumpTime").css({
                    display: "block"
                });
                $("#RrealTime").css({
                    display: "none"
                });
            }
        }


        function getUrlParam(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        };
        function taskidFun(taskid) {
            if(taskid == "5484"){
                ifxs=true;
                xsFun(ifxs);
                timeset.push(real_time);

            }else if(taskid == "5539"){
                ifxs=false;
                xsFun(ifxs);
                timeset.push(dump_time);
            }
        }

        $("#type1").on("click",function () {
            tab=1;
            num=210;
            corr="1+2+…+20";
            showHideFun(tab);
            $("#title").text("打百子/阶段一");
        });
        $("#type2").on("click",function () {
            tab=2;
            num=0;
            corr="1+2+…+20-1-2-…-20";
            showHideFun(tab);
            $("#title").text("打百子/阶段二");
        });
        $("#type3").on("click",function () {
            tab=3;
            num=0;
            corr="1+2+…+40-1-2…-40";
            showHideFun(tab);
            $("#title").text("打百子/阶段三");
        });
        $("#type4").on("click",function () {
            tab=4;
            num=0;
            corr="1+2+…+70-1-2…-70";
            showHideFun(tab);
            $("#title").text("打百子/阶段四");
        });
        $("#type5").on("click",function () {
            tab=5;
            num=0;
            corr="1+2+…+100-1-2…-100";
            showHideFun(tab);
            $("#title").text("打百子/阶段五");
        });


        $("#stepBtn1").on("click",function () {
            post_result()
        });

        $("#step2Btn1").on("click",function () {
            if(if_btn1){
                if_btn1=false;
                start_time=new Date().getTime();
                $("#step2Btn1").css({
                    "background-color": "#aaa",
                    "border-color": "#aaa"
                });
                if_btn2=true;
            }
        });

        $("#step2Btn2").on("click",function () {
            if(if_btn2){
                if_btn2=false;
                end_time=new Date().getTime();
                real_time=(end_time-start_time).toFixed(0);
                $("#step2Btn2").css({
                    "background-color": "#aaa",
                    "border-color": "#aaa"
                });
                start_time=new Date().getTime();
                if_btn3=true;
            }
        });

        $("#step2Btn3").on("click",function () {
        	
        	result_val=$.trim($("#result").val());
        	
            if(if_btn3){
                if_btn3=false;
                end_time=new Date().getTime();
                dump_time=(end_time-start_time).toFixed(0);
                $("#step2Btn3").css({
                    "background-color": "#aaa",
                    "border-color": "#aaa"
                });
                $("#step1").css({
                    display: "none"
                });
                $("#step2").css({
                    display: "none"
                });
                $("#step3").css({
                    display: "block"
                });
                $("#realTime").text(real_time);
                $("#dumpTime").text(dump_time);
                taskidFun(taskid);
                type4set.push(tab);
                correctanswerset.push(num);
                commentset.push(corr);
                numset.push(result_val);
				stimidset.push(trialno);
				trialno++;
            }
        });

        $("#step3Btn1").on("click",function () {
            if_btn1=true;
            if_btn2=false;
            if_btn3=false;
            $("#step2Btn1").css({
                "background-color": "#337ab7",
                "border-color": "#2e6da4"
            });
            $("#step2Btn2").css({
                "background-color": "#337ab7",
                "border-color": "#2e6da4"
            });
            $("#step2Btn3").css({
                "background-color": "#337ab7",
                "border-color": "#2e6da4"
            });


            $("#step1").css({
                display: "block"
            });
            $("#step2").css({
                display: "none"
            });
            $("#step3").css({
                display: "none"
            });
        });


        function resultFun(tab) {
        	
        	
            result_val=$.trim($("#result").val());
            if(tab == 1){
                if(result_val == "210"){
                    console.log("答对了")
                }else {
                    console.log("答错了")
                }
            }else {
                if(result_val == "0"){
                    console.log("答对了")
                }else {
                    console.log("答错了")
                }
            }
        }

        function showHideFun(tab){
            $("#result").val("");
            for(var i=1; i<6;i++){
                if(tab == i){
                    $("#tab"+i).css({
                        display: "block"
                    })
                }else {
                    $("#tab"+i).css({
                        display: "none"
                    })
                }

            };
            $("#step1").css({
                display: "none"
            });
            $("#step2").css({
                display: "block"
            });
            $("#step3").css({
                display: "none"
            });
        }

        function NextFun() {
            if (NexTime > 0) {
                --NexTime;
                console.log(NexTime);
            } else{
                clearInterval(NexTimer);
                NexTime=3;
                if_btn1=true;
                if_btn2=false;
                if_btn3=false;
                $("#step2Btn1").css({
                    "background-color": "#337ab7",
                    "border-color": "#2e6da4"
                });
                $("#step2Btn2").css({
                    "background-color": "#337ab7",
                    "border-color": "#2e6da4"
                });
                $("#step2Btn3").css({
                    "background-color": "#337ab7",
                    "border-color": "#2e6da4"
                });


                $("#step1").css({
                    display: "block"
                });
                $("#step2").css({
                    display: "none"
                });
                $("#step3").css({
                    display: "none"
                });

            }
        }

        function post_result() {
            // var numset=parseInt((100-Math.sqrt(timer/sd.blankNum))*sd.blankNum);
            var opes_result_data = {};

            opes_result_data.taskid =<%= taskid %>;
            opes_result_data.sumitcoids =<%= sumitcoids %>;
            opes_result_data.targetpagename = "<%=targetpagename%>";
            opes_result_data.codematerial =<%= codematerial %>;
            opes_result_data.uid =<%= uid %>;
            opes_result_data.lan = "<%=lan%>";
            opes_result_data.projectid =<%= projectid %>;

            opes_result_data.duration = 0;
            opes_result_data.timeaverage = Math.round(0);

            //以下判断总题数
            opes_result_data.type4set = type4set.join(";");
            
            //alert(numset.join(";"));
            
            opes_result_data.stimidset = stimidset.join(";");
            opes_result_data.correctanswerset = correctanswerset.join(";");
            opes_result_data.time = "0";
            opes_result_data.level = "0";

            opes_result_data.timeset = timeset.join(";");
            opes_result_data.radioset = "0";
            opes_result_data.buttonset = numset.join(";");
            opes_result_data.commentset =commentset.join(";");
            opes_result_data.numset = numset.join(";");
            opes_post_result_util_js_opes_post_result(opes_result_data);
            
			return;


        }


        function result_format(result) {
            var msg = "";
            var obj = result;
            for (var name in obj) {
                msg += obj[name] + "{" + name + "};";
            }


            ;
            msg = (msg.slice(msg.length - 1) == ';') ? msg.slice(0, -1) : msg;
            return msg;
        }




    });



</script>
<!--<script src="beat_hundred.js"></script>-->
</html>