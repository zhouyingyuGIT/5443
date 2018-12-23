<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>听珠译数</title>
    <style>
        body, h1, h2, h3, h4, h5, h6, hr, p, blockquote, dl, dt, dd, ul, ol, li, pre, form, fieldset, legend, button, input, textarea, th, td { margin:0; padding:0; }
        body, button, input, select, textarea { font:12px/1.5tahoma, arial, \5b8b\4f53; }
        h1, h2, h3, h4, h5, h6{ font-size:100%; }
        address, cite, dfn, em, var { font-style:normal; }
        code, kbd, pre, samp { font-family:couriernew, courier, monospace; }
        small{ font-size:12px; }
        ul, ol { list-style:none; }
        a { text-decoration:none; }
        a:hover { text-decoration:underline; }
        sup { vertical-align:text-top; }
        sub{ vertical-align:text-bottom; }
        legend { color:#000; }
        fieldset, img { border:0; }
        button, input, select, textarea { font-size:100%; }
        table { border-collapse:collapse; border-spacing:0; }
        .lfBox{
            width: 800px;
            height: 400px;
            margin: 16px auto;
            padding: 16px;
            border: 1px solid #00b0f0;
        }
        .lfBox .step{
            width: 100%;
            height: 100%;
            position: relative;
        }
        .ta{
            text-align: center;
            font-size: 26px;
            font-weight: 900;
            padding: 16px 0px;
        }
        .digitBox{
            text-align: center;
            padding: 16px 0px;
        }
        .le{
            display: inline-block;
            height: 50px;
            width: 50px;
            text-align: center;
            line-height: 50px;
            font-size: 24px;
            font-weight: 900;
            margin: 0px 16px;
            border: 1px solid #aeaeae;
            cursor: pointer;
        }
        .tc{
            position: absolute;
            bottom: 0px;
            height: 120px;
            width: 100%;
            line-height: 120px;
            text-align: center;
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
        input{
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
            width: 320px;

        }
        .tb{
            margin-top: 28px;
        }
        .tb2{
            position: absolute;
            top: 0px;
            width: 100%;
            height: 300px;
            line-height: 300px;
            text-align: center;
        }
        .st{
            width: 500px;
            margin: 0px auto;
        }
        .tl{
            font-size: 24px;
            font-weight: 700;
            text-align: center;
            padding: 8px 0px;
        }
        .boxBeam{
            height: 170px;
            width: 386px;
            border: 2px solid #000;
            border-radius: 5px;
            position: relative;
        }
        .beam{
            border: 0px;height: 100%;position: absolute;top:0px;background-color: #000;width: 4px
        }
        .beadBox{
            width: 30px;height: 100%;position: absolute;top: 0px;
        }
        .bead{
            width: 28px;
            height: 16px;
            border: 1px solid #000;
            border-radius: 100px;
            position: absolute;
            background-color: #0ad845;
        }
        #digitBox .active{
            border-color: #00b0f0;
            color: #fff;
            background-color: #00b0f0;
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
<div class="lfBox">
    <div id="tir" style="color: #9f0f17;position: fixed;top: 0px;width: 500px;height: 100px"></div>
    <div class="step" id="step1">
        <div class="ta">听珠译数</div>
        <div class="tb">
            <div class="ta">请选择位数</div>
            <div id="digitBox" class="digitBox">
                <span class="le digit active">1</span>
                <span class="le digit">2</span>
                <span class="le digit">3</span>
                <span class="le digit">4</span>
                <span class="le digit">5</span>
                <span class="le digit">6</span>
                <span class="le digit">7</span>
                <span class="le digit">8</span>
            </div>
        </div>
        <div class="tc">
            <button class="btn" id="step1Btn">开始</button>
        </div>
    </div>
    <div class="step" id="step2">
        <div id="fayin"></div>
        <div class="tb2">
            <input id="num1" onkeyup="this.value=this.value.replace(/\D/g,'')" type="text" placeholder="请输入数字">
        </div>
        <div class="tc">
            <button class="btn" id="step2Btn">确认</button>
        </div>
    </div>
    <div class="step" id="step3">
        <div class="st">
            <div class="tl" id="t1">答对了</div>
            <div class="tl">您的答案：<span id="t2"></span></div>
            <div class="tl">
                <div style="margin-bottom: 16px">本题答案</div>
                <div id="pa_1" class="boxBeam" style="margin: 0px auto">
                    <hr style="border: 0px;height: 16px;position: absolute;top: 48px;background-color: #000;width: 100%">


                    <div style="position: absolute;height: 16px;color: #fff;top: 47px;font-size: 10px;line-height: 16px;width: 100%;z-index: 999999;">
                        <div style="position: absolute;right: 20px">个</div>
                        <div style="position: absolute;right: 62px">十</div>
                        <div style="position: absolute;right: 104px">百</div>
                        <div style="position: absolute;right: 146px">千</div>
                        <div style="position: absolute;right: 188px">万</div>
                        <div style="position: absolute;right: 225px">十万</div>
                        <div style="position: absolute;right: 267px">百万</div>
                        <div style="position: absolute;right: 309px">千万</div>
                        <div style="position: absolute;right: 356px">亿</div>
                    </div>

                    <hr class="beam ge" style="right: 24px">
                    <hr class="beam shi" style="right: 66px;">
                    <hr class="beam bai" style="right: 108px;">
                    <hr class="beam qian" style="right: 150px;">
                    <hr class="beam wan" style="right: 192px;">
                    <hr class="beam shiwan" style="right: 234px;">
                    <hr class="beam baiwan" style="right: 276px;">
                    <hr class="beam qianwan" style="right: 318px;">
                    <hr class="beam yi" style="right: 360px;">


                    <div id="pa_1_1" class="beadBox" style="right: 10px;">
                        <div class="bead" style="top: 0px;"></div>

                        <div class="bead" style="bottom: 54px;"></div>
                        <div class="bead" style="bottom: 36px;"></div>
                        <div class="bead" style="bottom: 18px;"></div>
                        <div class="bead" style="bottom: 0px;"></div>
                    </div>

                    <div id="pa_1_2" class="beadBox" style="right: 52px ;">
                        <div class="bead" style="top: 0px;"></div>

                        <div class="bead" style="bottom: 54px;"></div>
                        <div class="bead" style="bottom: 36px;"></div>
                        <div class="bead" style="bottom: 18px;"></div>
                        <div class="bead" style="bottom: 0px;"></div>
                    </div>

                    <div id="pa_1_3" class="beadBox" style="right: 94px ;">
                        <div class="bead" style="top: 0px;"></div>

                        <div class="bead" style="bottom: 54px;"></div>
                        <div class="bead" style="bottom: 36px;"></div>
                        <div class="bead" style="bottom: 18px;"></div>
                        <div class="bead" style="bottom: 0px;"></div>
                    </div>

                    <div id="pa_1_4" class="beadBox" style="right: 136px ;">
                        <div class="bead" style="top: 0px;"></div>

                        <div class="bead" style="bottom: 54px;"></div>
                        <div class="bead" style="bottom: 36px;"></div>
                        <div class="bead" style="bottom: 18px;"></div>
                        <div class="bead" style="bottom: 0px;"></div>
                    </div>

                    <div id="pa_1_5" class="beadBox" style="right: 178px;">
                        <div class="bead" style="top: 0px;"></div>

                        <div class="bead" style="bottom: 54px;"></div>
                        <div class="bead" style="bottom: 36px;"></div>
                        <div class="bead" style="bottom: 18px;"></div>
                        <div class="bead" style="bottom: 0px;"></div>
                    </div>

                    <div id="pa_1_6" class="beadBox" style="right: 220px;">
                        <div class="bead" style="top: 0px;"></div>

                        <div class="bead" style="bottom: 54px;"></div>
                        <div class="bead" style="bottom: 36px;"></div>
                        <div class="bead" style="bottom: 18px;"></div>
                        <div class="bead" style="bottom: 0px;"></div>
                    </div>

                    <div id="pa_1_7" class="beadBox" style="right: 262px;">
                        <div class="bead" style="top: 0px;"></div>

                        <div class="bead" style="bottom: 54px;"></div>
                        <div class="bead" style="bottom: 36px;"></div>
                        <div class="bead" style="bottom: 18px;"></div>
                        <div class="bead" style="bottom: 0px;"></div>
                    </div>

                    <div id="pa_1_8" class="beadBox" style="right: 304px;">
                        <div class="bead" style="top: 0px;"></div>

                        <div class="bead" style="bottom: 54px;"></div>
                        <div class="bead" style="bottom: 36px;"></div>
                        <div class="bead" style="bottom: 18px;"></div>
                        <div class="bead" style="bottom: 0px;"></div>
                    </div>

                    <div id="pa_1_9" class="beadBox" style="right: 346px;">
                        <div class="bead" style="top: 0px;"></div>

                        <div class="bead" style="bottom: 54px;"></div>
                        <div class="bead" style="bottom: 36px;"></div>
                        <div class="bead" style="bottom: 18px;"></div>
                        <div class="bead" style="bottom: 0px;"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tc">
            <%--<button class="btn" id="step3Btn">下一题</button>--%>
        </div>
    </div>
</div>
</body>
<script src="jquery.js"></script>
<!--<script src="look_for_beads.js"></script>-->
<script>
    $(function () {
        var topicNum=0;
        var daan;
        var speed=5;
        var digit="1";
        var NexTime=1;
        var num;
        var gw=[1,2,3,4,5,6,7,8,9];
        var dw=[1,2,3,0,4,5,6,7,8,9];
        var beginTime;
        var endTime;
        var time;
        var maxtime =60;
        var enter=false;
        var spacer=false;
        var correctanswerset=[];
        var numset=[];
        var timeset=[];
        var type4set=[];
        var stimidset=[];
        /*var str=splicingFun("7777777");
        fayin(str,speed)*/
        $("#digitBox").on("click",".digit",function(event){
            var target = $(event.target);
            $("#digitBox .digit").removeClass("active");
            target.addClass("active");
            digit=target.text();
        });


        $("#step1Btn").on("click",function () {
            timer = setInterval(function () {
                CountDown();
            }, 1000);
            topicNum++;
            for(var i=0;i<digit;i++){
                if(i==0){
                    num=(gw[Math.floor(Math.random()*gw.length)]).toString()
                }else {
                    num += (dw[Math.floor(Math.random()*dw.length)]).toString()
                }
            }
            var str=splicingFun(num);
            fayin(str,speed);
            stepFun(2);
            beginTime=new Date().getTime();
            $("#num1").focus();
            enter=true;
        });
        $("#step2Btn").on("click",function () {
            step2BtnFun()
        });

        function step2BtnFun(){
            enter=false;
            spacer=true;
            daan=$.trim($("#num1").val());
            $("#t2").text(daan);
            beadFun(1,num);

            if(daan == num){
                $("#t1").text("答对了")
            }else {
                $("#t1").text("答错了")
            }
            endTime=new Date().getTime();
            time=(endTime-beginTime).toFixed(0);
            correctanswerset.push(num);
            numset.push(daan);
            type4set.push(digit);
            stimidset.push(topicNum);
            timeset.push(time);
            stepFun(3);
            NexTimer=setInterval(function () {
                NextFun();
            }, 1000);
        }
        function step3BtnFun(){
            spacer=false;
            enter=true;
            $("#num1").val("");
            topicNum++;
            for(var i=0;i<digit;i++){
                if(i==0){
                    num=(gw[Math.floor(Math.random()*gw.length)]).toString()
                }else {
                    num += (dw[Math.floor(Math.random()*dw.length)]).toString()
                }
            }
            var str=splicingFun(num);
            fayin(str,speed);
            stepFun(2);
            beginTime=new Date().getTime();
            stepFun(2);
            $("#num1").focus();
        }

        $("#step3Btn").on("click",function () {
            step3BtnFun()

        });
        function NextFun(){
            if (NexTime > 0) {
                --NexTime;
            } else{
                clearInterval(NexTimer);
                NexTime=1;
                step3BtnFun()

            }
        }

        $(document).keydown(function (event) {
            var e = event || window.event;
            var k = e.keyCode || e.which;
            if(k == 13){
                if(enter){
                    step2BtnFun()
                }
            }




            if(k == 32){
                if(spacer){
                    step3BtnFun()
                }
            }
        });


        function CountDown() {
            if (maxtime >= 0) {
                minutes = Math.floor(maxtime / 60);
                seconds = Math.floor(maxtime % 60);
                msg = "距离结束还有" + minutes + "分" + seconds + "秒";
                $("#tir").text(msg);
                --maxtime;
            } else{
                clearInterval(timer);
                post_result()
            }
        }




        function getUrlParam(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }

        function post_result() {
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
            opes_result_data.stimidset = stimidset.join(";");
            opes_result_data.correctanswerset = correctanswerset.join(";");
            opes_result_data.time = "0";
            opes_result_data.level = "0";

            opes_result_data.timeset = timeset.join(";");
            opes_result_data.radioset = "0";
            opes_result_data.buttonset = numset.join(";");
            opes_result_data.commentset = correctanswerset.join(";");
            opes_result_data.numset = numset.join(";");
            opes_post_result_util_js_opes_post_result(opes_result_data);
            return;


        }


        function result_format(result) {
            var msg = "";
            var obj = result;
            for (var name in obj) {
                msg += obj[name] + "{" + name + "};";
            };
            msg = (msg.slice(msg.length - 1) == ';') ? msg.slice(0, -1) : msg;
            return msg;
        };



        function fayin(str,speed){
            var str_code=encodeURI(str);
            var str_fayin='';
            $("#fayin").html('');
            var str_fayin="<audio id='music' autoplay='autoplay'><source src='http://tts.baidu.com/text2audio?lan=zh&ie=UTF-8&spd="+speed+"&text="+str_code+"' type='audio/mpeg'></audio>";
            $("#fayin").html(str_fayin);

        }




        /*拼接播放语音*/
        function splicingFun(num) {
            var splicing;
            var voice="";
            splicing=num.toString().length;
            for (var i=0;i<splicing;i++){
                var n;
                n=num.slice(i,i+1);
                if(n == 0){
                    continue;
                }

                switch(splicing-i){
                    case 1:
                        voice +="个位上";
                        break;
                    case 2:
                        voice +="十位上";
                        break;
                    case 3:
                        voice +="百位上";
                        break;
                    case 4:
                        voice +="千位上";
                        break;
                    case 5:
                        voice +="万位上";
                        break;
                    case 6:
                        voice +="十万位上";
                        break;
                    case 7:
                        voice +="百万位上";
                        break;
                    case 8:
                        voice +="千万位上";
                        break;
                    case 9:
                        voice +="亿位上";
                        break;
                    default:
                        break;
                }

                if(n<5){
                    voice += n+"个下珠;";
                    continue;
                }else if(n == 5){
                    voice += "1个上珠;";
                    continue;
                }else if(n>5){
                    voice += "1个上珠"+","+(n-5)+"个下珠;";
                    continue;
                }
            }
            console.log(voice);
            return voice;

        }


        function stepFun(n) {
            if(n == 1){
                $("#step1").css({
                    "display": "block"
                });
                $("#step2").css({
                    "display": "none"
                });
                $("#step3").css({
                    "display": "none"
                });
            }else if(n == 2){
                $("#step1").css({
                    "display": "none"
                });
                $("#step2").css({
                    "display": "block"
                });
                $("#step3").css({
                    "display": "none"
                });
            }else if(n == 3){
                $("#step1").css({
                    "display": "none"
                });
                $("#step2").css({
                    "display": "none"
                });
                $("#step3").css({
                    "display": "block"
                });
            }

        }


        function beadFun(n,num) {
            var digit;
            digit=num.toString().length;
            /*算盘复位*/
            for(var k=1;k<10;k++){
                $("#pa_"+n+"_"+k+" .bead:nth-child(1)").css({
                    "top":"0px",
                    "background-color": "#0ad845"
                });
                $("#pa_"+n+"_"+k+" .bead:nth-child(2)").css({
                    "bottom":"54px",
                    "background-color": "#0ad845"
                });
                $("#pa_"+n+"_"+k+" .bead:nth-child(3)").css({
                    "bottom":"36px",
                    "background-color": "#0ad845"
                });
                $("#pa_"+n+"_"+k+" .bead:nth-child(4)").css({
                    "bottom":"18px",
                    "background-color": "#0ad845"
                });
                $("#pa_"+n+"_"+k+" .bead:nth-child(5)").css({
                    "bottom":"0px",
                    "background-color": "#0ad845"
                });
            }

            /*个位*/
            if(digit>0){
                var b1=num.slice(digit-1);
                if(b1>=5){
                    $("#pa_"+n+"_1"+" .bead:nth-child(1)").css({
                        "top":"30px",
                        "background-color": "#e10601"
                    });
                    if((b1-5)>0){
                        $("#pa_"+n+"_1"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>1){
                        $("#pa_"+n+"_1"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>2){
                        $("#pa_"+n+"_1"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>3){
                        $("#pa_"+n+"_1"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }else {
                    if((b1)>0){
                        $("#pa_"+n+"_1"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>1){
                        $("#pa_"+n+"_1"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>2){
                        $("#pa_"+n+"_1"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>3){
                        $("#pa_"+n+"_1"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }
            }

            /*十位*/

            if(digit>1){
                var b1 = num.slice(digit-2,digit-1);
                if(b1>=5){
                    $("#pa_"+n+"_2"+" .bead:nth-child(1)").css({
                        "top":"30px",
                        "background-color": "#e10601"
                    });
                    if((b1-5)>0){
                        $("#pa_"+n+"_2"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>1){
                        $("#pa_"+n+"_2"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>2){
                        $("#pa_"+n+"_2"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>3){
                        $("#pa_"+n+"_2"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }else {
                    if((b1)>0){
                        $("#pa_"+n+"_2"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>1){
                        $("#pa_"+n+"_2"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>2){
                        $("#pa_"+n+"_2"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>3){
                        $("#pa_"+n+"_2"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }
            }

            /*百位*/
            if(digit>2){
                var b1=num.slice(digit-3,digit-2);
                if(b1>=5){
                    $("#pa_"+n+"_3"+" .bead:nth-child(1)").css({
                        "top":"30px",
                        "background-color": "#e10601"
                    });
                    if((b1-5)>0){
                        $("#pa_"+n+"_3"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>1){
                        $("#pa_"+n+"_3"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>2){
                        $("#pa_"+n+"_3"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>3){
                        $("#pa_"+n+"_3"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }else {
                    if((b1)>0){
                        $("#pa_"+n+"_3"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>1){
                        $("#pa_"+n+"_3"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>2){
                        $("#pa_"+n+"_3"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>3){
                        $("#pa_"+n+"_3"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }
            }

            /*千位*/
            if(digit>3){
                var b1=num.slice(digit-4,digit-3);
                if(b1>=5){
                    $("#pa_"+n+"_4"+" .bead:nth-child(1)").css({
                        "top":"30px",
                        "background-color": "#e10601"
                    });
                    if((b1-5)>0){
                        $("#pa_"+n+"_4"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>1){
                        $("#pa_"+n+"_4"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>2){
                        $("#pa_"+n+"_4"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>3){
                        $("#pa_"+n+"_4"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }else {
                    if((b1)>0){
                        $("#pa_"+n+"_4"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>1){
                        $("#pa_"+n+"_4"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>2){
                        $("#pa_"+n+"_4"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>3){
                        $("#pa_"+n+"_4"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }
            }

            /*万位*/
            if(digit>4){
                var b1=num.slice(digit-5,digit-4);
                if(b1>=5){
                    $("#pa_"+n+"_5"+" .bead:nth-child(1)").css({
                        "top":"30px",
                        "background-color": "#e10601"
                    });
                    if((b1-5)>0){
                        $("#pa_"+n+"_5"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>1){
                        $("#pa_"+n+"_5"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>2){
                        $("#pa_"+n+"_5"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>3){
                        $("#pa_"+n+"_5"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }else {
                    if((b1)>0){
                        $("#pa_"+n+"_5"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>1){
                        $("#pa_"+n+"_5"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>2){
                        $("#pa_"+n+"_5"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>3){
                        $("#pa_"+n+"_5"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }
            }
            /*十万位*/
            if(digit>5){
                var b1=num.slice(digit-6,digit-5);
                if(b1>=5){
                    $("#pa_"+n+"_6"+" .bead:nth-child(1)").css({
                        "top":"30px",
                        "background-color": "#e10601"
                    });
                    if((b1-5)>0){
                        $("#pa_"+n+"_6"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>1){
                        $("#pa_"+n+"_6"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>2){
                        $("#pa_"+n+"_6"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>3){
                        $("#pa_"+n+"_6"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }else {
                    if((b1)>0){
                        $("#pa_"+n+"_6"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>1){
                        $("#pa_"+n+"_6"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>2){
                        $("#pa_"+n+"_6"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>3){
                        $("#pa_"+n+"_6"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }
            }
            /*百万位*/
            if(digit>6){
                var b1=num.slice(digit-7,digit-6);
                if(b1>=5){
                    $("#pa_"+n+"_7"+" .bead:nth-child(1)").css({
                        "top":"30px",
                        "background-color": "#e10601"
                    });
                    if((b1-5)>0){
                        $("#pa_"+n+"_7"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>1){
                        $("#pa_"+n+"_7"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>2){
                        $("#pa_"+n+"_7"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>3){
                        $("#pa_"+n+"_7"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }else {
                    if((b1)>0){
                        $("#pa_"+n+"_7"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>1){
                        $("#pa_"+n+"_7"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>2){
                        $("#pa_"+n+"_7"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>3){
                        $("#pa_"+n+"_7"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }
            }
            /*千万位*/
            if(digit>7){
                var b1=num.slice(digit-8,digit-7);
                if(b1>=5){
                    $("#pa_"+n+"_8"+" .bead:nth-child(1)").css({
                        "top":"30px",
                        "background-color": "#e10601"
                    });
                    if((b1-5)>0){
                        $("#pa_"+n+"_8"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>1){
                        $("#pa_"+n+"_8"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>2){
                        $("#pa_"+n+"_8"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>3){
                        $("#pa_"+n+"_8"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }else {
                    if((b1)>0){
                        $("#pa_"+n+"_8"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>1){
                        $("#pa_"+n+"_8"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>2){
                        $("#pa_"+n+"_8"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>3){
                        $("#pa_"+n+"_8"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }
            }
            /*亿位*/
            if(digit>8){
                var b1=num.slice(digit-9,digit-8);
                if(b1>=5){
                    $("#pa_"+n+"_9"+" .bead:nth-child(1)").css({
                        "top":"30px",
                        "background-color": "#e10601"
                    });
                    if((b1-5)>0){
                        $("#pa_"+n+"_9"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>1){
                        $("#pa_"+n+"_9"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>2){
                        $("#pa_"+n+"_9"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1-5)>3){
                        $("#pa_"+n+"_9"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }else {
                    if((b1)>0){
                        $("#pa_"+n+"_9"+" .bead:nth-child(2)").css({
                            "bottom":"88px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>1){
                        $("#pa_"+n+"_9"+" .bead:nth-child(3)").css({
                            "bottom":"70px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>2){
                        $("#pa_"+n+"_9"+" .bead:nth-child(4)").css({
                            "bottom":"52px",
                            "background-color": "#e10601"
                        });
                    }
                    if((b1)>3){
                        $("#pa_"+n+"_9"+" .bead:nth-child(5)").css({
                            "bottom":"34px",
                            "background-color": "#e10601"
                        });
                    }
                }
            }
        }





    });
</script>
</html>