<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>听心算</title>
    <style>
        /** {margin: 0; padding: 0; list-style: none;}*/
        .box{
            width: 1000px;
            margin: 16px auto 0px;
            border: 1px solid #0ad845;
            height: 450px;
        }

        .step{
            width: 100%;
            position: relative;
            height: 450px;
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
            bottom:0px;
            height: 100px;
            width: 100%;
            line-height: 100px;
            text-align: center;
        }
        .ti{
            width: 300px;
            padding: 200px 0px 0px;
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
        ul{
            list-style:none;
            margin: 0; padding: 0;
        }
        #wrap {width:900px; margin: 0px auto; overflow: hidden;height: 348px; padding: 0;}
        #tit {height: 48px;width: 900px;margin: 0; padding: 0;}
        #tit span {float: left; height: 48px; line-height: 48px; width: 90px; font-size: 20px; text-align: center; color: #000;background: #00b0f0;cursor: pointer;margin: 0; padding: 0;}
        #con li{display: none; height: 300px; width: 900px; background: #fff;font-size: 20px;text-align: center;margin: 0; padding: 0;}
        #tit span.select {background: #000; color: #fff;margin: 0; padding: 0;}
        #con li.show {display: block;margin: 0; padding: 0;}

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
    <div id="step1" class="step">
        <div style="line-height: 100px;font-size: 28px;text-align: center;font-weight: 700;">听心算</div>
        <div id="wrap">
            <div id="tit">
                <span class="select">类型一</span>
                <span>类型二</span>
                <span>类型三</span>
                <span>类型四</span>
                <span>类型五</span>
                <span>类型六</span>
                <span>类型七</span>
                <span>类型八</span>
                <span>类型九</span>
                <span>类型十</span>
            </div>
            <ul id="con">
                <li class="show">
                    <div style="line-height: 100px">一个两位数，两个一位数混合加减</div>
                    <div style="margin-top: 130px"><button data-index="1" class="btn stepBtn1">开始</button></div>
                </li>
                <li>
                    <div style="line-height: 100px">两个两位数，一个一位数混合加减</div>
                    <div style="margin-top: 130px"><button data-index="2" class="btn stepBtn1">开始</button></div>
                </li>
                <li>
                    <div style="line-height: 100px">三个两位数，一个一位数混合加减</div>
                    <div style="margin-top: 130px"><button data-index="3" class="btn stepBtn1">开始</button></div>
                </li>
                <li>
                    <div style="line-height: 100px">三个两位数，两个一位数混合加减</div>
                    <div style="margin-top: 130px"><button data-index="4" class="btn stepBtn1">开始</button></div>
                </li>
                <li>
                    <div style="line-height: 100px">四个两位数，一个一位数混合加减</div>
                    <div style="margin-top: 130px"><button data-index="5" class="btn stepBtn1">开始</button></div>
                </li>
                <li>
                    <div style="line-height: 100px">一个三位数，二个二位数混合加减</div>
                    <div style="margin-top: 130px"><button data-index="6" class="btn stepBtn1">开始</button></div>
                </li>
                <li>
                    <div style="line-height: 100px">两个三位数，一个二位数混合加减</div>
                    <div style="margin-top: 130px"><button data-index="7" class="btn stepBtn1">开始</button></div>
                </li>
                <li>
                    <div style="line-height: 100px">两个三位数，二个二位数混合加减</div>
                    <div style="margin-top: 130px"><button data-index="8" class="btn stepBtn1">开始</button></div>
                </li>
                <li>
                    <div style="line-height: 100px">一个三位数，两个两位数，二个一位数混合加减</div>
                    <div style="margin-top: 130px"><button data-index="9" class="btn stepBtn1">开始</button></div>
                </li>
                <li>
                    <div style="line-height: 100px">一个三位数，两个两位数，三个一位数混合加减</div>
                    <div style="margin-top: 130px"><button data-index="10" class="btn stepBtn1">开始</button></div>
                </li>
            </ul>
        </div>
    </div>
    <div id="step2" class="step">
        <div id="fayin"></div>
        <div class="ti">
            <input disabled="disabled" onkeyup="this.value=this.value.replace(/\D/g,'')" id="answer" type="text">
        </div>
        <div class="buttonBox">
            <button id="stepBtn2" disabled="disabled" class="btn">确认</button>
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
<script>
    $(function () {
        var topicTypes="1";
        var speed=5;
        var numArr=[1,2,3,4,5,6,7,8,9];
        var numBrr=[0,1,2,3,4,5,6,7,8,9];
        var NexTime=1;
        var correctanswerset=[];
        var numset=[];
        var timeset=[];
        var type4set=[];
        var commentset=[];
        var stimidset=[];
        var arrT=[];
        var time;
        var timer=null;
        var timer1=null;
        var stimid=0;
        var answer;
        var answer1;
        var enter=false;
        var maxtime=180;
        var beginTime;
        var endTime;
        var num1,num2,num3,num4,num5,num6;




        $('#tit span').click(function() {
            var i = $(this).index();//下标第一种写法
            //var i = $('tit').index(this);//下标第二种写法
            $(this).addClass('select').siblings().removeClass('select');
            $('#con li').eq(i).show().siblings().hide();
        });


        $("#con").on("click",".stepBtn1",function(event){

            topicTypes = $(this).attr("data-index");
            stimid++;
            topicFun(topicTypes);
            $("#answer").attr("disabled","disabled");
            $("#stepBtn2").attr("disabled","disabled");
            $("#step1").css({
                "display": "none"
            });
            $("#step2").css({
                "display": "block"
            });
            $("#step3").css({
                "display": "none"
            });
            timer = setInterval(function () {
                CountDown();
            }, 1000);
            beginTime=new Date().getTime();
            $("#answer").val("");
            enter=true;
        });
        function randomsort(a, b) {
            return Math.random()>.5 ? -1 : 1;
            //用Math.random()函数生成0~1之间的随机数与0.5比较，返回-1或1
        }

// 生成数
        function numFun(digit) {
            var numB='';
            for(var i=0;i<digit;i++){
                if(i==0){
                    numB += (numArr[Math.floor(Math.random()*numArr.length)]).toString();
                }else {
                    numB += (numBrr[Math.floor(Math.random()*numBrr.length)]).toString();
                }

            }
            return numB
        }

        function topicFun(topicTypes) {
            arrT=[];
            var arrNum=[];
            var t=2000;
            num1='';num2='';num3='';num4='';num5='';num6='';
            if(topicTypes == 1){
                t=1500;
                num1=numFun(2);num2=numFun(1);num3=numFun(1);
                arrNum=[num1,num2,num3];
                arrNum.sort(randomsort);
                topicTime=3;
                if(arrNum.indexOf(num3) == 2){
                    arrNum[2]="减"+num3;
                    strole3Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num3);
                    answer1=(parseInt(num1)+parseInt(num2)-parseInt(num3)).toString()
                    return;
                }else {
                    strole3Fun(t,arrNum);
                    arrT.push(arrNum[0]);
                    arrT.push(arrNum[1]);
                    arrT.push(arrNum[2]);
                    answer1=(parseInt(arrNum[0])+parseInt(arrNum[1])+parseInt(arrNum[2])).toString()
                    return;
                }
            }else if(topicTypes == 2){
                t=1500;
                num1=numFun(2);num2=numFun(2);num3=numFun(1);
                arrNum=[num1,num2,num3];
                arrNum.sort(randomsort);
                topicTime=3;
                if(arrNum.indexOf(num3) > 0){
                    var seat = arrNum.indexOf(num3);
                    arrNum[(seat)]="减"+num3;
                    strole3Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num3);
                    answer1=(parseInt(num1)+parseInt(num2)-parseInt(num3)).toString()
                    return;
                }else {
                    strole3Fun(t,arrNum);
                    arrT.push(arrNum[0]);
                    arrT.push(arrNum[1]);
                    arrT.push(arrNum[2]);
                    answer1=(parseInt(arrNum[0])+parseInt(arrNum[1])+parseInt(arrNum[2])).toString()
                    return;
                }
            }else if(topicTypes == 3){
                t=1500;
                num1=numFun(2);num2=numFun(2);num3=numFun(2);num4=numFun(1);
                arrNum=[num1,num2,num3,num4];
                arrNum.sort(randomsort);
                topicTime=4;
                if(arrNum.indexOf(num2) == 0){
                    var seat = arrNum.indexOf(num4);
                    arrNum[(seat)]="减"+num4;
                    strole4Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num4);
                    arrT.push(num3);
                    answer1=(parseInt(num1)+parseInt(num2)+parseInt(num3)-parseInt(num4)).toString()
                    return;
                }else {
                    strole4Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(num4);
                    arrT.push(num3);
                    answer1=(parseInt(num1)+parseInt(num2)+parseInt(num3)+parseInt(num4)).toString()
                    return;
                }
            }else if(topicTypes == 4){
                t=1500;
                num1=numFun(2);num2=numFun(2);num3=numFun(2);num4=numFun(1);num5=numFun(1);
                arrNum=[num1,num2,num3,num4,num5];
                arrNum.sort(randomsort);
                topicTime=5;
                if(arrNum.indexOf(num5)== 2 || arrNum.indexOf(num5)==4){
                    var seat = arrNum.indexOf(num5);
                    arrNum[(seat)]="减"+num5;
                    strole5Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num5);
                    arrT.push(num3);
                    arrT.push(num4);
                    answer1=(parseInt(num1)+parseInt(num2)+parseInt(num3)+parseInt(num4)-parseInt(num5)).toString()
                    return;
                }else {
                    strole5Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(num5);
                    arrT.push(num3);
                    arrT.push(num4);
                    answer1=(parseInt(num1)+parseInt(num2)+parseInt(num3)+parseInt(num4)+parseInt(num5)).toString()
                    return;
                }
            }else if(topicTypes == 5){
                t=1500;
                num1=numFun(2);num2=numFun(2);num3=numFun(2);num4=numFun(2);num5=numFun(1);
                arrNum=[num1,num2,num3,num4,num5];
                arrNum.sort(randomsort);
                topicTime=5;
                if(arrNum.indexOf(num5)== 1 || arrNum.indexOf(num5)==3){
                    var seat = arrNum.indexOf(num5);
                    arrNum[(seat)]="减"+num5;
                    strole5Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num5);
                    arrT.push(num3);
                    arrT.push(num4);
                    answer1=(parseInt(num1)+parseInt(num2)+parseInt(num3)+parseInt(num4)-parseInt(num5)).toString()
                    return;
                }else {
                    strole5Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(num5);
                    arrT.push(num3);
                    arrT.push(num4);
                    answer1=(parseInt(num1)+parseInt(num2)+parseInt(num3)+parseInt(num4)+parseInt(num5)).toString()
                    return;
                }
            }else if(topicTypes == 6){
                t=1500;
                num1=numFun(3);num2=numFun(2);num3=numFun(2);
                arrNum=[num1,num2,num3];
                arrNum.sort(randomsort);
                topicTime=3;
                if(arrNum.indexOf(num3) == 2){
                    arrNum[2]="减"+num3;
                    strole3Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num3);
                    answer1=(parseInt(num1)+parseInt(num2)-parseInt(num3)).toString()
                    return;
                }else {
                    strole3Fun(t,arrNum);
                    arrT.push(arrNum[0]);
                    arrT.push(arrNum[1]);
                    arrT.push(arrNum[2]);
                    answer1=(parseInt(arrNum[0])+parseInt(arrNum[1])+parseInt(arrNum[2])).toString()
                    return;
                }
            }else if(topicTypes == 7){
                t=1500;
                num1=numFun(3);num2=numFun(3);num3=numFun(2);
                arrNum=[num1,num2,num3];
                arrNum.sort(randomsort);
                topicTime=3;
                if(arrNum.indexOf(num3) > 0){
                    var seat = arrNum.indexOf(num3);
                    arrNum[(seat)]="减"+num3;
                    strole3Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num3);
                    answer1=(parseInt(num1)+parseInt(num2)-parseInt(num3)).toString()
                    return;
                }else {
                    strole3Fun(t,arrNum);
                    arrT.push(arrNum[0]);
                    arrT.push(arrNum[1]);
                    arrT.push(arrNum[2]);
                    answer1=(parseInt(arrNum[0])+parseInt(arrNum[1])+parseInt(arrNum[2])).toString()
                    return;
                }
            }else if(topicTypes == 8){
                t=1500;
                num1=numFun(3);num2=numFun(3);num3=numFun(2);num4=numFun(2);
                arrNum=[num1,num2,num3,num4];
                arrNum.sort(randomsort);
                topicTime=4;
                if(arrNum.indexOf(num2) == 0){
                    var seat = arrNum.indexOf(num4);
                    arrNum[(seat)]="减"+num4;
                    strole4Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(-num4);
                    arrT.push(num3);
                    answer1=(parseInt(num1)+parseInt(num2)+parseInt(num3)-parseInt(num4)).toString()
                    return;
                }else {
                    strole4Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(num4);
                    arrT.push(num3);
                    answer1=(parseInt(num1)+parseInt(num2)+parseInt(num3)+parseInt(num4)).toString()
                    return;
                }
            }else if(topicTypes == 9){
                t=1500;
                num1=numFun(3);num2=numFun(2);num3=numFun(2);num4=numFun(1);num5=numFun(1);
                arrNum=[num1,num2,num3,num4,num5];
                arrNum.sort(randomsort);
                topicTime=5;
                if(arrNum.indexOf(num1)== 0 && arrNum.indexOf(num4)==4){
                    var seat = arrNum.indexOf(num2);
                    arrNum[(seat)]="减"+num2;
                    var seat = arrNum.indexOf(num4);
                    arrNum[(seat)]="减"+num4;
                    strole5Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(-num2);
                    arrT.push(num5);
                    arrT.push(num3);
                    arrT.push(-num4);
                    answer1=(parseInt(num1)-parseInt(num2)+parseInt(num3)-parseInt(num4)+parseInt(num5)).toString()
                    return;
                }else if(arrNum.indexOf(num3)>2){
                    var seat = arrNum.indexOf(num3);
                    arrNum[(seat)]="减"+num3;
                    strole5Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(num5);
                    arrT.push(-num3);
                    arrT.push(num4);
                    answer1=(parseInt(num1)+parseInt(num2)-parseInt(num3)+parseInt(num4)+parseInt(num5)).toString()
                    return;
                }else {
                    strole5Fun(t,arrNum);
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(num5);
                    arrT.push(num3);
                    arrT.push(num4);
                    answer1=(parseInt(num1)+parseInt(num2)+parseInt(num3)+parseInt(num4)+parseInt(num5)).toString()
                    return;
                }
            }else if(topicTypes == 10){
                t=1500;
                num1=numFun(3);num2=numFun(2);num3=numFun(2);num4=numFun(1);num5=numFun(1);num6=numFun(1);
                arrNum=[num1,num2,num3,num4,num5,num6];
                arrNum.sort(randomsort);
                topicTime=5;
                if(arrNum.indexOf(num1)== 0 && arrNum.indexOf(num4)==5){
                    var seat = arrNum.indexOf(num2);
                    arrNum[(seat)]="减"+num2;
                    var seat = arrNum.indexOf(num4);
                    arrNum[(seat)]="减"+num4;
                    strole6Fun(t,arrNum)
                    arrT.push(num1);
                    arrT.push(-num2);
                    arrT.push(num5);
                    arrT.push(num6);
                    arrT.push(num3);
                    arrT.push(-num4);
                    answer1=(parseInt(num1)-parseInt(num2)+parseInt(num3)-parseInt(num4)+parseInt(num5)+parseInt(num6)).toString();
                    return;
                }else if(arrNum.indexOf(num1)== 0){
                    var seat = arrNum.indexOf(num2);
                    arrNum[(seat)]="减"+num2;
                    strole6Fun(t,arrNum)
                    arrT.push(num1);
                    arrT.push(-num2);
                    arrT.push(num5);
                    arrT.push(num6);
                    arrT.push(num3);
                    arrT.push(+num4);
                    answer1=(parseInt(num1)-parseInt(num2)+parseInt(num3)+parseInt(num4)+parseInt(num5)+parseInt(num6)).toString();
                    return;
                }else {
                    strole6Fun(t,arrNum)
                    arrT.push(num1);
                    arrT.push(num2);
                    arrT.push(num5);
                    arrT.push(num6);
                    arrT.push(num3);
                    arrT.push(+num4);
                    answer1=(parseInt(num1)+parseInt(num2)+parseInt(num3)+parseInt(num4)+parseInt(num5)+parseInt(num6)).toString();
                    return;
                }
            }
        }
        $("#stepBtn2").on("click",function () {
            stepBtn2Fun()
        });

        $("#answer").bind('input propertychange',function(){
            var nameVal = $("#answer").val();
            console.log(nameVal);
            if(nameVal == null || nameVal == "" || nameVal == undefined){
                $("#stepBtn2").attr("disabled","disabled");
                enter=false;
            }else {
                $("#stepBtn2").removeAttr("disabled");
                enter=true;
            }

        });

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
            opes_result_data.radioset ="0";
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
        }

        function strole3Fun(t,arrNum) {
            timer1 = setInterval(function () {
                if(topicTime==3){
                    fayin(arrNum[0],speed);
                }else if(topicTime==2){
                    fayin(arrNum[1],speed);
                }else if(topicTime==1){
                    fayin(arrNum[2],speed);
                    $("#answer").removeAttr("disabled");
                    $("#answer").val("");
                    $("input").focus();
                    clearInterval(timer1);
                }else if(topicTime==0){
                    clearInterval(timer1);
                    topicTime=0;
                }
                topicTime--
            }, t);
        }
        function strole4Fun(t,arrNum) {
            timer1 = setInterval(function () {
                if(topicTime==4){
                    fayin(arrNum[0],speed);
                }else if(topicTime==3){
                    fayin(arrNum[1],speed);
                }else if(topicTime==2){
                    fayin(arrNum[2],speed);
                }else if(topicTime==1){
                    fayin(arrNum[3],speed);
                    $("#answer").removeAttr("disabled");
                    $("#answer").val("");
                    $("input").focus();
                    clearInterval(timer1);
                }else if(topicTime==0){
                    clearInterval(timer1);
                    topicTime=0;
                }
                topicTime--
            }, t);
        }
        function strole5Fun(t,arrNum) {
            timer1 = setInterval(function () {
                if(topicTime==5){
                    fayin(arrNum[0],speed);
                }else if(topicTime==4){
                    fayin(arrNum[1],speed);
                }else if(topicTime==3){
                    fayin(arrNum[2],speed);
                }else if(topicTime==2){
                    fayin(arrNum[3],speed);
                }else if(topicTime==1){
                    fayin(arrNum[4],speed);
                    $("#answer").removeAttr("disabled");
                    $("#answer").val("");
                    $("input").focus();
                    clearInterval(timer1);
                }else if(topicTime==0){
                    clearInterval(timer1);
                    topicTime=0;
                }
                topicTime--
            }, t);
        }
        function strole6Fun(t,arrNum) {
            timer1 = setInterval(function () {
                if(topicTime==6){
                    fayin(arrNum[0],speed);
                }else if(topicTime==5){
                    fayin(arrNum[1],speed);
                }else if(topicTime==4){
                    fayin(arrNum[2],speed);
                }else if(topicTime==3){
                    fayin(arrNum[3],speed);
                }else if(topicTime==2){
                    fayin(arrNum[4],speed);
                }else if(topicTime==1){
                    fayin(arrNum[5],speed);
                    $("#answer").removeAttr("disabled");
                    $("#answer").val("");
                    $("input").focus();
                    clearInterval(timer1);
                }else if(topicTime==0){
                    clearInterval(timer1);
                    topicTime=0;
                }
                topicTime--
            }, t);
        }

        $(document).keydown(function (event) {
            var e = event || window.event;
            var k = e.keyCode || e.which;
            if(k == 13){
                if(enter){
                    stepBtn2Fun()
                }
            }
        });

        function stepBtn2Fun(){
            enter=false;
            answer=$.trim($("#answer").val());
            if(answer1 == answer){
                $("#yesNo").text("答对了")
            }else {
                $("#yesNo").text("答错了")
            }
            beadFun(1,answer1);
            topicTime=0;
            clearInterval(timer1);
            endTime=new Date().getTime();
            time=(endTime-beginTime).toFixed(0);
            $("#time").text(time);
            timeset.push(time);
            correctanswerset.push(answer1);
            commentset.push(arrT.join(","));
            stimidset.push(stimid);
            type4set.push(topicTypes);
            numset.push(answer);


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

        function NextFun(){
            if (NexTime > 0) {
                --NexTime;
            } else{
                clearInterval(NexTimer);
                NexTime=1;
                enter=true;
                stimid++;
                $("#answer").attr("disabled","disabled");
                $("#stepBtn2").attr("disabled","disabled");
                topicFun(topicTypes);

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
                beginTime=new Date().getTime();

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
        /*语言*/
        function fayin(str,speed){
            var str_code=encodeURI(str);
            var str_fayin='';
            $("#fayin").html('');
            var str_fayin="<audio id='music' autoplay='autoplay'><source src='http://tts.baidu.com/text2audio?lan=zh&ie=UTF-8&spd="+speed+"&text="+str_code+"' type='audio/mpeg'></audio>";
            $("#fayin").html(str_fayin);

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