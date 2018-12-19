<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>计算</title>
    <link rel="stylesheet" href="practice.css">
    <style>
        #title {
            display: block;
        }

        #inputAnswer {
            line-height: 32px;
            font-size: 16px;
            width: 100%;
        }
    </style>
    <SCRIPT src="/lattice/js/Statistics/Statistics.js" type=text/javascript></SCRIPT>
    <script src="/lattice/js/oneui/opes_post_result_util.js"></script>
    <script src="jquery.js"></script>

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
        <div id="title">
            <div class="topicBox">
                <div id="topic" class="topic">
                    <h3>本次练习先做实拨立刻做虚拨</h3>

                    <h1>题目、从1起，加2加3,直至加到100</h1>

                    <!--<h4 id="ti" style="color: #555">准备好了吗？准备好了就点击开始计时</h4>-->
                </div>

                <div style="margin: 60px auto 0px;text-align: center;width: 300px">
                    <input id="inputAnswer" type="text" placeholder="请输入您实拨结果">
                </div>

            </div>


            <div class="buttonBox">
                <button class="btn" id="time1">开始实拨</button>
                <button class="btn" id="time2">实拨结束，虚拨开始</button>
                <button class="btn" id="time3">结束计时</button>
            </div>
        </div>

        <div id="result" class="result">
            <h1>实拨时间为 <span id="time1_1"></span>毫秒</h1>
            <h1 style="margin: 0px" id="antonym"></h1>
            <h1>虚拨时间为 <span id="time2_1"></span>毫秒</h1>
            <div class="buttonBox">
                <button class="btn" id="finishExercise">结束练习</button>
            </div>
        </div>
    </div>
    </body>
    <script>
        $(function () {
            var beginTime;
            var endTime;
            var time1;
            var time2;
            var time3;
            var inputAnswer;
            var timeBtn1 = true;
            var timeBtn2 = false;
            var timeBtn3 = false;


            $("#time1").on("click", function () {
                if (timeBtn1) {
                    timeBtn1 = false;
                    beginTime = new Date().getTime();
                    $("#time1").css({
                        "background-color": "#aaa",
                        "border-color": "#aaa"
                    });
                    timeBtn2 = true;
                }

            });
            $("#time2").on("click", function () {
                if (timeBtn2) {
                    timeBtn2 = false;
                    endTime = new Date().getTime();
                    $("#time2").css({
                        "background-color": "#aaa",
                        "border-color": "#aaa"
                    });
                    $("#inputAnswer").css({
                        display: "none"
                    });

                    if ($("#inputAnswer").val() == "5050") {
                        $("#antonym").text("答对了")
                    } else {
                        $("#antonym").text("答错了")
                    }
                    inputAnswer = $("#inputAnswer").val();
                    // alert(((endTime-beginTime)/1000).toFixed(0));
                    time1 = (endTime - beginTime).toFixed(0);

                    beginTime = new Date().getTime();
                    timeBtn3 = true;

                }


            });
            $("#time3").on("click", function () {
                if (timeBtn3) {
                    timeBtn3 = false;
                    endTime = new Date().getTime();
                    $("#title").css({
                        display: "none"
                    });
                    $("#result").css({
                        display: "block"
                    });
                    $("#time2").css({
                        "background-color": "#aaa",
                        "border-color": "#aaa"
                    });
                    // alert(time2);
                    time2 = (endTime - beginTime).toFixed(0);

                    $("#time1_1").text(time1);
                    $("#time2_1").text(time2);

                }
                // timeOut();
            });


            function timeOut() {
                setTimeout(function () {
                    post_result();
                }, 2000);
            };

            $("#finishExercise").on("click",function () {
                post_result();
            });

            /*$("#startBtn").on("click", function () {
                if (startBtn) {
                    $("#startBtn").css({
                        "background-color": "#aaa",
                        "border-color": "#aaa"
                    });
                    $("#ti").css({
                        opacity: 0
                    });
                    beginTime = new Date().getTime();
                    startBtn = false;
                    endBtn = true;
                }
                ;
            });

            $("#endBtn").on("click", function () {
                if (endBtn) {
                    endTime = new Date().getTime();
                    $("#title").css({
                        display: "none"
                    });
                    $("#result").css({
                        display: "block"
                    });
                    $("#answerB").text($("#inputAnswer").val());
                    beadFun(1, $("#answerA").text());
                    if ($("#answerA").text() == $("#answerB").text()) {
                        $("#antonym").text("答对了")
                    } else {
                        $("#antonym").text("答错了")
                    }
                    inputAnswer = $("#inputAnswer").val();
                    time = (endTime - beginTime).toFixed(0);
                    $("#answerTime").text(time);
                }

            });*/


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
                opes_result_data.type4set = "0";
                opes_result_data.stimidset = "";
                opes_result_data.correctanswerset = "5050";
                opes_result_data.time = "0";
                opes_result_data.level = "0";

                opes_result_data.timeset = time1;
                opes_result_data.radioset = time2;
                opes_result_data.buttonset = "0";
                opes_result_data.commentset ="从1起，加2加3,直至加到100";
                console.log(time1);
                console.log(opes_result_data);
                opes_result_data.numset = inputAnswer;
                console.log(opes_result_data);
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


            function beadFun(n, num) {
                var digit;
                digit = num.toString().length;
                /*算盘复位*/
                for (var k = 1; k < 10; k++) {
                    $("#pa_" + n + "_" + k + " .bead:nth-child(1)").css({
                        "top": "0px",
                        "background-color": "#0ad845"
                    });
                    $("#pa_" + n + "_" + k + " .bead:nth-child(2)").css({
                        "bottom": "54px",
                        "background-color": "#0ad845"
                    });
                    $("#pa_" + n + "_" + k + " .bead:nth-child(3)").css({
                        "bottom": "36px",
                        "background-color": "#0ad845"
                    });
                    $("#pa_" + n + "_" + k + " .bead:nth-child(4)").css({
                        "bottom": "18px",
                        "background-color": "#0ad845"
                    });
                    $("#pa_" + n + "_" + k + " .bead:nth-child(5)").css({
                        "bottom": "0px",
                        "background-color": "#0ad845"
                    });
                }

                /*个位*/
                if (digit > 0) {
                    var b1 = num.slice(digit - 1);
                    if (b1 >= 5) {
                        $("#pa_" + n + "_1" + " .bead:nth-child(1)").css({
                            "top": "30px",
                            "background-color": "#e10601"
                        });
                        if ((b1 - 5) > 0) {
                            $("#pa_" + n + "_1" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 1) {
                            $("#pa_" + n + "_1" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 2) {
                            $("#pa_" + n + "_1" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 3) {
                            $("#pa_" + n + "_1" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    } else {
                        if ((b1) > 0) {
                            $("#pa_" + n + "_1" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 1) {
                            $("#pa_" + n + "_1" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 2) {
                            $("#pa_" + n + "_1" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 3) {
                            $("#pa_" + n + "_1" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    }
                }

                /*十位*/

                if (digit > 1) {
                    var b1 = num.slice(digit - 2, digit - 1);
                    if (b1 >= 5) {
                        $("#pa_" + n + "_2" + " .bead:nth-child(1)").css({
                            "top": "30px",
                            "background-color": "#e10601"
                        });
                        if ((b1 - 5) > 0) {
                            $("#pa_" + n + "_2" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 1) {
                            $("#pa_" + n + "_2" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 2) {
                            $("#pa_" + n + "_2" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 3) {
                            $("#pa_" + n + "_2" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    } else {
                        if ((b1) > 0) {
                            $("#pa_" + n + "_2" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 1) {
                            $("#pa_" + n + "_2" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 2) {
                            $("#pa_" + n + "_2" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 3) {
                            $("#pa_" + n + "_2" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    }
                }

                /*百位*/
                if (digit > 2) {
                    var b1 = num.slice(digit - 3, digit - 2);
                    if (b1 >= 5) {
                        $("#pa_" + n + "_3" + " .bead:nth-child(1)").css({
                            "top": "30px",
                            "background-color": "#e10601"
                        });
                        if ((b1 - 5) > 0) {
                            $("#pa_" + n + "_3" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 1) {
                            $("#pa_" + n + "_3" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 2) {
                            $("#pa_" + n + "_3" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 3) {
                            $("#pa_" + n + "_3" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    } else {
                        if ((b1) > 0) {
                            $("#pa_" + n + "_3" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 1) {
                            $("#pa_" + n + "_3" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 2) {
                            $("#pa_" + n + "_3" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 3) {
                            $("#pa_" + n + "_3" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    }
                }

                /*千位*/
                if (digit > 3) {
                    var b1 = num.slice(digit - 4, digit - 3);
                    if (b1 >= 5) {
                        $("#pa_" + n + "_4" + " .bead:nth-child(1)").css({
                            "top": "30px",
                            "background-color": "#e10601"
                        });
                        if ((b1 - 5) > 0) {
                            $("#pa_" + n + "_4" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 1) {
                            $("#pa_" + n + "_4" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 2) {
                            $("#pa_" + n + "_4" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 3) {
                            $("#pa_" + n + "_4" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    } else {
                        if ((b1) > 0) {
                            $("#pa_" + n + "_4" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 1) {
                            $("#pa_" + n + "_4" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 2) {
                            $("#pa_" + n + "_4" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 3) {
                            $("#pa_" + n + "_4" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    }
                }

                /*万位*/
                if (digit > 4) {
                    var b1 = num.slice(digit - 5, digit - 4);
                    if (b1 >= 5) {
                        $("#pa_" + n + "_5" + " .bead:nth-child(1)").css({
                            "top": "30px",
                            "background-color": "#e10601"
                        });
                        if ((b1 - 5) > 0) {
                            $("#pa_" + n + "_5" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 1) {
                            $("#pa_" + n + "_5" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 2) {
                            $("#pa_" + n + "_5" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 3) {
                            $("#pa_" + n + "_5" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    } else {
                        if ((b1) > 0) {
                            $("#pa_" + n + "_5" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 1) {
                            $("#pa_" + n + "_5" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 2) {
                            $("#pa_" + n + "_5" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 3) {
                            $("#pa_" + n + "_5" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    }
                }
                /*十万位*/
                if (digit > 5) {
                    var b1 = num.slice(digit - 6, digit - 5);
                    if (b1 >= 5) {
                        $("#pa_" + n + "_6" + " .bead:nth-child(1)").css({
                            "top": "30px",
                            "background-color": "#e10601"
                        });
                        if ((b1 - 5) > 0) {
                            $("#pa_" + n + "_6" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 1) {
                            $("#pa_" + n + "_6" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 2) {
                            $("#pa_" + n + "_6" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 3) {
                            $("#pa_" + n + "_6" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    } else {
                        if ((b1) > 0) {
                            $("#pa_" + n + "_6" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 1) {
                            $("#pa_" + n + "_6" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 2) {
                            $("#pa_" + n + "_6" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 3) {
                            $("#pa_" + n + "_6" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    }
                }
                /*百万位*/
                if (digit > 6) {
                    var b1 = num.slice(digit - 7, digit - 6);
                    if (b1 >= 5) {
                        $("#pa_" + n + "_7" + " .bead:nth-child(1)").css({
                            "top": "30px",
                            "background-color": "#e10601"
                        });
                        if ((b1 - 5) > 0) {
                            $("#pa_" + n + "_7" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 1) {
                            $("#pa_" + n + "_7" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 2) {
                            $("#pa_" + n + "_7" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 3) {
                            $("#pa_" + n + "_7" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    } else {
                        if ((b1) > 0) {
                            $("#pa_" + n + "_7" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 1) {
                            $("#pa_" + n + "_7" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 2) {
                            $("#pa_" + n + "_7" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 3) {
                            $("#pa_" + n + "_7" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    }
                }
                /*千万位*/
                if (digit > 7) {
                    var b1 = num.slice(digit - 8, digit - 7);
                    if (b1 >= 5) {
                        $("#pa_" + n + "_8" + " .bead:nth-child(1)").css({
                            "top": "30px",
                            "background-color": "#e10601"
                        });
                        if ((b1 - 5) > 0) {
                            $("#pa_" + n + "_8" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 1) {
                            $("#pa_" + n + "_8" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 2) {
                            $("#pa_" + n + "_8" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 3) {
                            $("#pa_" + n + "_8" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    } else {
                        if ((b1) > 0) {
                            $("#pa_" + n + "_8" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 1) {
                            $("#pa_" + n + "_8" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 2) {
                            $("#pa_" + n + "_8" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 3) {
                            $("#pa_" + n + "_8" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    }
                }
                /*亿位*/
                if (digit > 8) {
                    var b1 = num.slice(digit - 9, digit - 8);
                    if (b1 >= 5) {
                        $("#pa_" + n + "_9" + " .bead:nth-child(1)").css({
                            "top": "30px",
                            "background-color": "#e10601"
                        });
                        if ((b1 - 5) > 0) {
                            $("#pa_" + n + "_9" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 1) {
                            $("#pa_" + n + "_9" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 2) {
                            $("#pa_" + n + "_9" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1 - 5) > 3) {
                            $("#pa_" + n + "_9" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    } else {
                        if ((b1) > 0) {
                            $("#pa_" + n + "_9" + " .bead:nth-child(2)").css({
                                "bottom": "88px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 1) {
                            $("#pa_" + n + "_9" + " .bead:nth-child(3)").css({
                                "bottom": "70px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 2) {
                            $("#pa_" + n + "_9" + " .bead:nth-child(4)").css({
                                "bottom": "52px",
                                "background-color": "#e10601"
                            });
                        }
                        if ((b1) > 3) {
                            $("#pa_" + n + "_9" + " .bead:nth-child(5)").css({
                                "bottom": "34px",
                                "background-color": "#e10601"
                            });
                        }
                    }
                }
            }


            /*function timeFu(s) {
            var t;
            if(s > -1){
            var hour = Math.floor(s/3600);
            var min = Math.floor(s/60) % 60;
            var sec = s % 60;
            if(hour >=0) {
            t = hour + "时";
            }
            if(min >=0){t += min + "分";}

            if(sec >=0){t += sec+ "秒";}

            }
            //console.log(hour);
            //console.log(min);
            //console.log(sec);
            return t;

            }*/

        });


    </script>

</html>