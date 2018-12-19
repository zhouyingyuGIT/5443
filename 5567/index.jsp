<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>数字纸牌</title>
    <link rel="stylesheet" href="style.css">
    <script src="jquery.js"></script>
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
    <div class="container">
        <div class="tit">数字纸牌</div>
        <div class="main_content">
            <div class="box">
                <div class="item">
                    <div class="state0">
                        <span>?</span>
                    </div>
                    <div class="state1">
                        <span></span>
                    </div>
                </div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
                <div class="item">?</div>
            </div>
            <div id="cover"></div>
            <div class="panel">
                <button class="btn">开始</button>
                <div class="msg">
                    计时：<span class="time">0</span>秒，步数：<span class="steps">0</span>
                </div>
                <div class="intro">游戏说明：连续翻两个相同的数字认为配对成功，所有的数字配对完成则游戏通过</div>
            </div>
        </div>
        <div class="tip">
            <div class="result">
                <div class="tit">恭喜！</div>
                <div class="content">
                    <span></span>
                    <button class="confirm">确定</button>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    (function(){

        var list = [],          //初始化一个由整数构成的数组
            first = 0,          //第一次单击时记录下的数字（第奇数次）
            second = 0,         //第二次单击时记录下的数字（第偶数次）
            steps = 0,          //步数，即点击的总次数
            success = 0,        //成功配对计数
            isRunning = false,  //是否开始游戏
            time = 0,           //时间
            timer = null;       //计时器
        var source;
        var numset;
        var buttonset=[];

        function init(){

            for(var i=1;i<=20;i++){
                list.push(i);
            }

            addEvent();
        }

        init();

        //从list中随机取出num个不同的数字，成对的放在一个新数组中，
        // 打乱新数组中数字排列顺序
        function getNewList(arr, num){
            var temp_array1 = [], temp_array2 = [], return_array = [];
            for(var index in arr){
                temp_array1.push(arr[index]);
            }

            for(var i=0;i<num;i++){
                if(temp_array1.length>0){
                    var arrIndex = Math.floor(Math.random()*temp_array1.length);
                    temp_array2.push(temp_array1[arrIndex]);
                    temp_array2.push(temp_array1[arrIndex]);
                    temp_array1.splice(arrIndex, 1);
                }else{
                    break;
                }
            }

            for(var j=0,len=temp_array2.length;j<len;j++){
                if(temp_array2.length>0){
                    var index = Math.floor(Math.random()*temp_array2.length);
                    return_array.push(temp_array2[index]);
                    temp_array2.splice(index, 1);
                }else{
                    break;
                }

            }

            return return_array;
        }

        function loadNewData(){
            source = getNewList(list,8);

            var html='';
            for(var item=0;item< source.length; item++){
                html += `<div class="item">
                    <div class="state0">
                        <span>?</span>
                    </div>
                    <div class="state1">
                        <span>`+source[item]+`</span>
                    </div>
                </div>`
            }
            $('.box').html(html);
        }

        //事件绑定
        function addEvent(){
            $('.btn').click(function () {
                if(!isRunning){
                    isRunning = true;
                    timer = setInterval(function () {
                        time++;
                        $('.time').html(time);
                    },1000);
                    $('#cover').hide();
                    $('.btn').addClass('disabled').html('正在游戏...');
                    loadNewData();
                }
            });

            //主体处理逻辑
            $('.box').on('click', '.item', function () {
                if(!$(this).is('.clicked')){
                    $(this).addClass('clicked');
                    steps++;

                    $('.steps').html(steps);

                    $(this);
                    if(steps%2 === 1){
                        first = $(this).find('.state1 span').html();
                        buttonset.push(first)
                    }
                    if(steps%2 === 0){
                        second = $(this).find('.state1 span').html();
                        buttonset.push(second);
                        if(first !== second){
                            setTimeout(function () {
                                $('.item:not(.succ)').removeClass('clicked');
                            },300);
                        }else{
                            $('.clicked').addClass('succ');
                            success++;
                            if(success === 8){
                                post_result();
                                clearInterval(timer);
                                timer = null;
                                $('.tip').show().find('.content>span').html(`恭喜，你共花了 ${time} 秒，${steps} 步完成任务!`);
                            }
                        }
                    }

                }
            });

            $('.confirm').click(function () {
                location.reload(true);
            })
        }

        function post_result() {
            var opes_result_data = {};
            numset=(180-time);
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
            opes_result_data.stimidset = "0";
            opes_result_data.correctanswerset = "0";

            opes_result_data.timeset = parseInt(time).toString();
            opes_result_data.radioset = "0";
            opes_result_data.buttonset = buttonset.join(";");
            opes_result_data.commentset = source.join(";");
            opes_result_data.numset = numset.toString();
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

    })();

</script>
</html>
