<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>破5进位加，退位满5减</title>
    <style>

        .box{
            width: 1000px;
            margin: 16px auto 0px;
            border: 1px solid #0ad845;
            height: 500px;
        }

        .step{
            width: 100%;
            position: relative;
            height: 500px;
        }
        .step1 h1{
            text-align: center;
            width: 100%;
            padding: 16px 0px;
        }
        .levelBox{
            padding: 16px;
            text-align: center;
        }
        .levelBox .title{
            font-size: 18px;
            font-weight: 700;
            padding: 16px 0px;
        }
        .levelBox .digitBox{
            padding: 16px 0px;
        }
        .levelBox .pensBox{
            padding: 16px 0px;
        }
        .levelBox .le{
            font-size: 16px;
            font-weight: 700;
            padding: 16px 20px;
            margin: 16px 12px;
            border: 1px solid #000;
            cursor: pointer;
        }
        #step1 .active{
            border: 1px solid #00b0f0;
        }
        #digitBox .active{
            border: 1px solid #00b0f0;
            color: #00b0f0;
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
            height: 40px;
            width: 100%;
            line-height: 40px;
            text-align: center;
        }
        .ti{
            width: 120px;
            padding: 0px 0px 0px;
            margin: 0px auto;
        }
        .ti input{
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
            width: 100%;

        }
        .ti .tl{
            width: 100%;
            padding: 8px 0px;
            font-size: 28px;
            font-weight: 700;
            text-align: right;
        }
        .boxBeam{
            height: 170px;
            width: 386px;
            border: 2px solid #000;
            border-radius: 5px;
            position: relative;
        }
        .beam{
            border: 0px;height: 100%;position: absolute;top:-8px;background-color: #000;width: 4px
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
    <div class="box">
        <div id="tir" style="color: #9f0f17;position: fixed;top: 0px;width: 500px;height: 100px"></div>
        <div id="step1" class="step step1">
            <h1 style="margin: 0px">破5进位加，退位满5减</h1>
            <!--digit-->
            <div class="levelBox">
                <div class="title">位数</div>
                <div id="digitBox" class="digitBox">
                    <span class="le digit active">1</span>
                    <span class="le digit">2</span>
                    <span class="le digit">3</span>
                    <span class="le digit">4</span>
                    <span class="le digit">5</span>
                    <span class="le digit">6</span>
                    <span class="le digit">7</span>
                </div>
            </div>
            <div class="levelBox">
                <div class="title">笔数</div>
                <div id="pensBox" class="pensBox">
                    <span class="le pens active">3</span>
                    <span class="le pens">4</span>
                    <span class="le pens">5</span>
                    <span class="le pens">6</span>
                    <span class="le pens">7</span>
                </div>
            </div>


            <div class="buttonBox">
                <button id="stepBtn1" class="btn">开始训练</button>
            </div>



        </div>
        <div id="step2" class="step step2">

            <div class="ti">
                <div id="t1" class="tl t1"></div>
                <div id="t2" class="tl t2"></div>
                <div id="t3" class="tl t3"></div>
                <div id="t4" class="tl t4"></div>
                <div id="t5" class="tl t5"></div>
                <div id="t6" class="tl t6"></div>
                <div id="t7" class="tl t7"></div>
                <hr style="margin: 16px 0px">
                <div><input id="answer" onkeyup="this.value=this.value.replace(/\D/g,'')" type="text" style="width: 100%"></div>
            </div>





            <div class="buttonBox">
                <button id="stepBtn2" class="btn">确认(ENTER)</button>
            </div>



        </div>
        <div id="step3" class="step step3">

            <div style="width: 100%;height: 100%;padding: 16px 0px 0px">
                <div style="font-weight: 700;font-size: 28px;text-align: center;line-height: 50px">
                    <div id="yesNo"></div>
                    <div>用时<span id="time"></span>毫秒</div>
                </div>
                <div id="pa_1" class="boxBeam" style="margin: 0px auto">
                    <hr style="border: 0px;height: 16px;position: absolute;top: 40px;background-color: #000;width: 100%">


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


            <div class="buttonBox">
                <!--<button id="stepBtn3" class="btn">下一题</button>-->
            </div>
        </div>
    </div>
    </body>
    <script src="jquery.js"></script>
    <!--<script src="full_five_plus_five_cuts.js"></script>-->

    <script>
        $(function () {
            var digit="1";
            var pens="3";
            var taskid;
            var answer;
            var num;
            var time;
            var beginTime;
            var endTime;
            var spacer=false;
            var enter=false;
            var correctanswerset=[];
            var numset=[];
            var timeset=[];
            var type4set=[];
            var commentset=[];
            var stimidset=[];
            var stimid=0;
            var arrT=[];
            var maxtime=180;
            var NexTime=1;
            var numArr=[5,6,7,8];
            var num1;
            var num2;
            var num3;
            var num4;
            var num5;
            var num6;
            var num7;

            taskid=getUrlParam("taskid");

            taskidFun(taskid);
            function taskidFun(taskid) {
                if(taskid == "5525" || taskid == "5556"){
                    digit="1";

                }else if(taskid == "5526" || taskid == "5557"){
                    digit="2";
                }else if(taskid == "5527" || taskid == "5558"){
                    digit="3";
                }else if(taskid == "5528" || taskid == "5559"){
                    digit="4";
                }

                for (var i=1;i<8;i++){
                    if(digit == i){
                        $("#digitBox .le:nth-child("+i+")").addClass("active");
                    }else {
                        $("#digitBox .le:nth-child("+i+")").removeClass("digit");
                        $("#digitBox .le:nth-child("+i+")").removeClass("active");
                        $("#digitBox .le:nth-child("+i+")").css({
                            "background-color": "#eee"
                        });
                    }
                }
            }

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


            $("#digitBox").on("click",".digit",function(event){
                var target = $(event.target);
                $("#digitBox .digit").removeClass("active");
                target.addClass("active");
                digit=target.text();
            });

            $("#pensBox").on("click",".pens",function(event){
                var target = $(event.target);
                $("#pensBox .pens").removeClass("active");
                target.addClass("active");
                pens=target.text();
            });
            // 随机生成第一位数
            function num1Fun(digit) {
                var num = "";
                for (var i = 0; i < digit; i++) {
                    num += (numArr[Math.floor(Math.random()*numArr.length)]).toString()
                }
                return num;
            };
            // 生成加数
            function additionFun(data) {
                var arr1 = data.split('');
                arr1.reverse();
                var numA = "";
                var dl=parseInt(digit)-1;
                for (var i = dl; i>=0; i--) {
                    if (arr1[i] == "4") {
                        var numArr4 = [6,7,8,5];
                        numA += (numArr4[Math.floor(Math.random() * numArr4.length)]).toString();
                        continue;
                    } else if (arr1[i] == "5") {
                        var numArr4 = [6,7,8,9];
                        numA += (numArr4[Math.floor(Math.random() * numArr4.length)]).toString();
                        continue;
                    } else if (arr1[i] == "6") {
                        var numArr4 = [6,7,8];
                        numA += (numArr4[Math.floor(Math.random() * numArr4.length)]).toString();
                        continue;
                    } else if (arr1[i] == "7") {
                        var numArr4 = [6,7];
                        numA += (numArr4[Math.floor(Math.random() * numArr4.length)]).toString();
                        continue;
                    } else if (arr1[i] == "8") {
                        var numArr4 = [6];
                        numA += (numArr4[Math.floor(Math.random() * numArr4.length)]).toString();
                        continue;
                    } else if (arr1[i] == "9") {
                        var numArr4 = [5];
                        numA += (numArr4[Math.floor(Math.random() * numArr4.length)]).toString();
                        continue;
                    }
                }

                return numA.split("").reverse().join("");
            }
            // 生成减数
            function subtractionFun(data) {
                var arr2=data.split('');
                arr2.reverse();
                var numB = "";
                var dl=parseInt(digit)-1;
                for (var i = dl; i >= 0; i--) {
                    if(arr2[i] == "0"){
                        var numArr1=[5];
                        numB += (numArr1[Math.floor(Math.random()*numArr1.length)]).toString();
                        continue;
                    }else if(arr2[i] == "1"){
                        var numArr2=[6];
                        numB += (numArr2[Math.floor(Math.random()*numArr2.length)]).toString();
                        continue;
                    }else if(arr2[i] == "2"){
                        var numArr3=[6,7];
                        numB += (numArr3[Math.floor(Math.random()*numArr3.length)]).toString();
                        continue;
                    }else if(arr2[i] == "3"){
                        var numArr4=[6,7,8];
                        numB += (numArr4[Math.floor(Math.random()*numArr4.length)]).toString();
                        continue;
                    }else if(arr2[i] == "4"){
                        var numArr4=[6,7,9];
                        numB += (numArr4[Math.floor(Math.random()*numArr4.length)]).toString();
                        continue;
                    }else if(arr2[i] == "5"){
                        var numArr4=[6];
                        numB += (numArr4[Math.floor(Math.random()*numArr4.length)]).toString();
                        continue;
                    }
                }
                return numB.split("").reverse().join("");
            }

            function pensFun(pens) {
                arrT=[];
                num1=num1Fun(digit);
                num2="";
                num3="";
                num4="";
                num5="";
                num6="";
                num7="";

                showHideFun(pens);
                if(pens == "3"){
                    num2=additionFun(num1);
                    numExcessive=(parseInt(num1)+parseInt(num2)).toString();
                    num3=subtractionFun(numExcessive);
                    $("#t1").text(num1);
                    $("#t2").text(num2);
                    $("#t3").text(-num3);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num3);
                    num=(parseInt(numExcessive)-parseInt(num3)).toString();

                }else if(pens == "4"){
                    num2=additionFun(num1);
                    numExcessive=(parseInt(num1)+parseInt(num2)).toString();
                    num3=subtractionFun(numExcessive);
                    numExcessive=(parseInt(numExcessive)-parseInt(num3)).toString();
                    num4=additionFun(numExcessive);
                    $("#t1").text(num1);
                    $("#t2").text(num2);
                    $("#t3").text(-num3);
                    $("#t4").text(num4);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num3);
                    arrT.push(num4);
                    num=(parseInt(numExcessive)+parseInt(num4)).toString();

                }else if(pens == "5"){
                    num2=additionFun(num1);
                    numExcessive=(parseInt(num1)+parseInt(num2)).toString();
                    num3=subtractionFun(numExcessive);
                    numExcessive=(parseInt(numExcessive)-parseInt(num3)).toString();
                    num4=additionFun(numExcessive);
                    numExcessive=(parseInt(numExcessive)+parseInt(num4)).toString();
                    num5=subtractionFun(numExcessive);
                    $("#t1").text(num1);
                    $("#t2").text(num2);
                    $("#t3").text(-num3);
                    $("#t4").text(num4);
                    $("#t5").text(-num5);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num3);
                    arrT.push(num4);
                    arrT.push(-num5);
                    num=(parseInt(numExcessive)-parseInt(num5)).toString();

                }else if(pens == "6"){

                    num2=additionFun(num1);
                    numExcessive=(parseInt(num1)+parseInt(num2)).toString();
                    num3=subtractionFun(numExcessive);
                    numExcessive=(parseInt(numExcessive)-parseInt(num3)).toString();
                    num4=additionFun(numExcessive);
                    numExcessive=(parseInt(numExcessive)+parseInt(num4)).toString();
                    num5=subtractionFun(numExcessive);
                    numExcessive=(parseInt(numExcessive)-parseInt(num5)).toString();
                    num6=additionFun(numExcessive);
                    $("#t1").text(num1);
                    $("#t2").text(num2);
                    $("#t3").text(-num3);
                    $("#t4").text(num4);
                    $("#t5").text(-num5);
                    $("#t6").text(num6);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num3);
                    arrT.push(num4);
                    arrT.push(-num5);
                    arrT.push(num6);
                    num=(parseInt(numExcessive)+parseInt(num6)).toString();

                }else if(pens == "7"){

                    num2=additionFun(num1);
                    numExcessive=(parseInt(num1)+parseInt(num2)).toString();
                    num3=subtractionFun(numExcessive);
                    numExcessive=(parseInt(numExcessive)-parseInt(num3)).toString();
                    num4=additionFun(numExcessive);
                    numExcessive=(parseInt(numExcessive)+parseInt(num4)).toString();
                    num5=subtractionFun(numExcessive);
                    numExcessive=(parseInt(numExcessive)-parseInt(num5)).toString();
                    num6=additionFun(numExcessive);
                    numExcessive=(parseInt(numExcessive)+parseInt(num6)).toString();
                    num7=subtractionFun(numExcessive);
                    $("#t1").text(num1);
                    $("#t2").text(num2);
                    $("#t3").text(-num3);
                    $("#t4").text(num4);
                    $("#t5").text(-num5);
                    $("#t6").text(num6);
                    $("#t7").text(-num7);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num3);
                    arrT.push(num4);
                    arrT.push(-num5);
                    arrT.push(num6);
                    arrT.push(-num7);
                    num=(parseInt(numExcessive)-parseInt(num7)).toString();

                }

            }

            $("#stepBtn1").on("click",function () {
                stimid++;
                pensFun(pens);
                timer = setInterval(function () {
                    CountDown();
                }, 1000);
                $("#step1").css({
                    "display": "none"
                });

                $("#step2").css({
                    "display": "block"
                });
                $("#step3").css({
                    "display": "none"
                });
                $("#answer").val("");
                $("input").focus();
                beginTime=new Date().getTime();
                enter=true;

            });

            $("#stepBtn2").on("click",function () {
                enter=false;
                spacer=true;
                answer=$.trim($("#answer").val());

                if(num == answer){
                    $("#yesNo").text("答对了")
                }else {
                    $("#yesNo").text("答错了")
                }
                beadFun(1,num);
                endTime=new Date().getTime();
                time=(endTime-beginTime).toFixed(0);
                timeset.push(time);
                correctanswerset.push(num);
                commentset.push(arrT.join(","));
                stimidset.push(stimid);
                type4set.push(pens);
                numset.push(answer);
                $("#time").text(time);
                $("#step1").css({
                    "display": "none"
                });

                $("#step2").css({
                    "display": "none"
                });
                $("#step3").css({
                    "display": "block"
                });
                NexTimer=setInterval(function () {
                    NextFun();
                }, 1000);
            });

            $("#stepBtn3").on("click",function () {
                spacer=false;
                enter=true;
                stimid++;
                pensFun(pens);
                $("#step1").css({
                    "display": "none"
                });

                $("#step2").css({
                    "display": "block"
                });
                $("#step3").css({
                    "display": "none"
                });

                $("#answer").val("");
                $("input").focus();
                beginTime=new Date().getTime();

            });

            $(document).keydown(function (event) {
                var e = event || window.event;
                var k = e.keyCode || e.which;

                console.log(k);
                if(k == 13){
                    if(enter){
                        enter=false;
                        spacer=true;
                        answer=$.trim($("#answer").val());

                        if(num == answer){
                            $("#yesNo").text("答对了")
                        }else {
                            $("#yesNo").text("答错了")
                        }
                        beadFun(1,num);
                        endTime=new Date().getTime();
                        time=(endTime-beginTime).toFixed(0);
                        timeset.push(time);
                        correctanswerset.push(num);
                        commentset.push(arrT.join(","));
                        stimidset.push(stimid);
                        type4set.push(pens);
                        numset.push(answer);
                        $("#time").text(time);
                        $("#step1").css({
                            "display": "none"
                        });

                        $("#step2").css({
                            "display": "none"
                        });
                        $("#step3").css({
                            "display": "block"
                        });
                        NexTimer=setInterval(function () {
                            NextFun();
                        }, 1000);
                    }
                }




                /*if(k == 32){
                    if(spacer){
                        spacer=false;
                        enter=true;
                        stimid++;
                        pensFun(pens);
                        $("#step1").css({
                            "display": "none"
                        });

                        $("#step2").css({
                            "display": "block"
                        });
                        $("#step3").css({
                            "display": "none"
                        });

                        $("#answer").val("");
                        $("input").focus();
                        beginTime=new Date().getTime();
                    }
                }*/
            });

            function NextFun() {
                if (NexTime > 0) {
                    --NexTime;
                    console.log(NexTime);
                } else{
                    clearInterval(NexTimer);
                    NexTime=1;
                    spacer=false;
                    enter=true;
                    stimid++;
                    pensFun(pens);
                    $("#step1").css({
                        "display": "none"
                    });

                    $("#step2").css({
                        "display": "block"
                    });
                    $("#step3").css({
                        "display": "none"
                    });

                    $("#answer").val("");
                    $("input").focus();
                    beginTime=new Date().getTime();
                }
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
                opes_result_data.commentset = commentset.join(";");
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

            function showHideFun(data) {
                if(data == "3"){
                    $("#t1").css({
                        "display": "block"
                    });
                    $("#t2").css({
                        "display": "block"
                    });
                    $("#t3").css({
                        "display": "block"
                    });
                    $("#t4").css({
                        "display": "none"
                    });
                    $("#t5").css({
                        "display": "none"
                    });
                    $("#t6").css({
                        "display": "none"
                    });
                    $("#t7").css({
                        "display": "none"
                    });
                }else if(data == "4"){

                    $("#t1").css({
                        "display": "block"
                    });
                    $("#t2").css({
                        "display": "block"
                    });
                    $("#t3").css({
                        "display": "block"
                    });
                    $("#t4").css({
                        "display": "block"
                    });
                    $("#t5").css({
                        "display": "none"
                    });
                    $("#t6").css({
                        "display": "none"
                    });
                    $("#t7").css({
                        "display": "none"
                    });
                }else if(data == "5"){

                    $("#t1").css({
                        "display": "block"
                    });
                    $("#t2").css({
                        "display": "block"
                    });
                    $("#t3").css({
                        "display": "block"
                    });
                    $("#t4").css({
                        "display": "block"
                    });
                    $("#t5").css({
                        "display": "block"
                    });
                    $("#t6").css({
                        "display": "none"
                    });
                    $("#t7").css({
                        "display": "none"
                    });
                }else if(data == "6"){

                    $("#t1").css({
                        "display": "block"
                    });
                    $("#t2").css({
                        "display": "block"
                    });
                    $("#t3").css({
                        "display": "block"
                    });
                    $("#t4").css({
                        "display": "block"
                    });
                    $("#t5").css({
                        "display": "block"
                    });
                    $("#t6").css({
                        "display": "block"
                    });
                    $("#t7").css({
                        "display": "none"
                    });
                }else if(data == "7"){

                    $("#t1").css({
                        "display": "block"
                    });
                    $("#t2").css({
                        "display": "block"
                    });
                    $("#t3").css({
                        "display": "block"
                    });
                    $("#t4").css({
                        "display": "block"
                    });
                    $("#t5").css({
                        "display": "block"
                    });
                    $("#t6").css({
                        "display": "block"
                    });
                    $("#t7").css({
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