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
        $("input").focus();
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


    function strole3Fun(t,arrNum) {
        timer1 = setInterval(function () {
            if(topicTime==3){
                fayin(arrNum[0],speed);
            }else if(topicTime==2){
                fayin(arrNum[1],speed);
            }else if(topicTime==1){
                fayin(arrNum[2],speed);
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
            $("input").focus();
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
            alert("训练结束")
            // post_result()
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