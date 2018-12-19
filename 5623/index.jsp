<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta charset="utf-8" />
<title>HTML5 snake - Canvas Snake Game</title>
<!--[if IE]>
<!--<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>-->
<![endif]-->
<link rel="stylesheet" href="page.css" type="text/css">
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

<h1>snake</h1>
<!--<p><a href="http://en.wikipedia.org/wiki/HTML5">HTML5</a> variation of the classic <a href="http://en.wikipedia.org/wiki/Snake_(video_game)">snake game</a>.</p>-->
<div id="tir" style="color: #ff0000;position: fixed;top: 0px;width: 500px;height: 100px"></div>
<div>
  <canvas id="the-game" width="320" height="240"></canvas>
  <div style="text-align: center">enter/空格键开始游戏</div>
</div>
<script>
    var canvas = document.getElementById("the-game");
    var context = canvas.getContext("2d");
    var game, snake, food;
    var scoreA=0;
    var maxtime=180;
    var finalscore=0;
    var session=0;
    game = {
        score: 0,
        fps: 8,
        over: true,
        message: null,

        start: function() {
            game.over = false;
            game.message = null;
            game.score = 0;
            game.fps = 8;
            snake.init();
            food.set();
        },

        stop: function() {

            if (session==0){
	        			finalscore=scoreA;
	        			session++;
	        			type4set="1";  
	        			stimidset=session+"";
	        		}else {
	        			finalscore=finalscore+";"+scoreA;
	        			session++;
	        			type4set=type4set+";1";
	        			stimidset=stimidset+";"+session;
	        		}
					
			
        
            game.message = 'GAME OVER - PRESS SPACEBAR';
        },

        drawBox: function(x, y, size, color) {
            context.fillStyle = color;
            context.beginPath();
            context.moveTo(x - (size / 2), y - (size / 2));
            context.lineTo(x + (size / 2), y - (size / 2));
            context.lineTo(x + (size / 2), y + (size / 2));
            context.lineTo(x - (size / 2), y + (size / 2));
            context.closePath();
            context.fill();
        },

        drawScore: function() {
            context.fillStyle = '#999';
            context.font = (canvas.height) + 'px Impact, sans-serif';
            context.textAlign = 'center';
            context.fillText(game.score, canvas.width / 2, canvas.height * 0.9);
        },

        drawMessage: function() {
            if (game.message !== null) {
                context.fillStyle = '#00F';
                context.strokeStyle = '#FFF';
                context.font = (canvas.height / 10) + 'px Impact';
                context.textAlign = 'center';
                context.fillText(game.message, canvas.width / 2, canvas.height / 2);
                context.strokeText(game.message, canvas.width / 2, canvas.height / 2);
            }
        },

        resetCanvas: function() {
            context.clearRect(0, 0, canvas.width, canvas.height);
        }

    };

    snake = {

        size: canvas.width / 40,
        x: null,
        y: null,
        color: '#0F0',
        direction: 'left',
        sections: [],

        init: function() {
            snake.sections = [];
            snake.direction = 'left';
            snake.x = canvas.width / 2 + snake.size / 2;
            snake.y = canvas.height / 2 + snake.size / 2;
            for (var i = snake.x + (5 * snake.size); i >= snake.x; i -= snake.size) {
                snake.sections.push(i + ',' + snake.y);
            }
        },

        move: function() {
            switch (snake.direction) {
                case 'up':
                    snake.y -= snake.size;
                    break;
                case 'down':
                    snake.y += snake.size;
                    break;
                case 'left':
                    snake.x -= snake.size;
                    break;
                case 'right':
                    snake.x += snake.size;
                    break;
            }
            snake.checkCollision();
            snake.checkGrowth();
            snake.sections.push(snake.x + ',' + snake.y);
        },

        draw: function() {
            for (var i = 0; i < snake.sections.length; i++) {
                snake.drawSection(snake.sections[i].split(','));
            }
        },

        drawSection: function(section) {
            game.drawBox(parseInt(section[0]), parseInt(section[1]), snake.size, snake.color);
        },

        checkCollision: function() {
            if (snake.isCollision(snake.x, snake.y) === true) {
                game.stop();
  //              console.log(scoreA)
            }
        },

        isCollision: function(x, y) {
            if (x < snake.size / 2 ||
                x > canvas.width ||
                y < snake.size / 2 ||
                y > canvas.height ||
                snake.sections.indexOf(x + ',' + y) >= 0) {
                return true;
            }
        },

        checkGrowth: function() {
            if (snake.x == food.x && snake.y == food.y) {
                game.score++;
                scoreA++;
                if (game.score % 5 == 0 && game.fps < 60) {
                    game.fps++;
                }
                food.set();
            } else {
                snake.sections.shift();
            }
        }

    };

    food = {

        size: null,
        x: null,
        y: null,
        color: '#0FF',

        set: function() {
            food.size = snake.size;
            food.x = (Math.ceil(Math.random() * 10) * snake.size * 4) - snake.size / 2;
            food.y = (Math.ceil(Math.random() * 10) * snake.size * 3) - snake.size / 2;
        },

        draw: function() {
            game.drawBox(food.x, food.y, food.size, food.color);
        }

    };

    var inverseDirection = {
        'up': 'down',
        'left': 'right',
        'right': 'left',
        'down': 'up'
    };

    var keys = {
        up: [38, 75, 87],
        down: [40, 74, 83],
        left: [37, 65, 72],
        right: [39, 68, 76],
        start_game: [13, 32]
    };

    function getKey(value){
        for (var key in keys){
            if (keys[key] instanceof Array && keys[key].indexOf(value) >= 0){
                return key;
            }
        }
        return null;
    }

    addEventListener("keydown", function (e) {
        var lastKey = getKey(e.keyCode);
        if (['up', 'down', 'left', 'right'].indexOf(lastKey) >= 0
            && lastKey != inverseDirection[snake.direction]) {
            snake.direction = lastKey;
        } else if (['start_game'].indexOf(lastKey) >= 0 && game.over) {
            game.start();
        }
    }, false);

    var requestAnimationFrame = window.requestAnimationFrame ||
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame;

    function loop() {
        if (game.over == false) {
            game.resetCanvas();
            game.drawScore();
            snake.move();
            food.draw();
            snake.draw();
            game.drawMessage();
        }
        setTimeout(function() {
            requestAnimationFrame(loop);
        }, 1000 / game.fps);
    }
    timer = setInterval(function () {
        CountDown();
    }, 1000);
    function CountDown() {
        if (maxtime >= 0) {
            minutes = Math.floor(maxtime / 60);
            seconds = Math.floor(maxtime % 60);
            msg = "距离结束还有" + minutes + "分" + seconds + "秒";
            document.getElementById("tir").innerHTML=msg;
            --maxtime;
        } else{

            clearInterval(timer);
			
			if (game.over==false){
	        		if (session==0){
	        			finalscore=scoreA;
	        			session++;
	        			type4set="1";  
	        			stimidset=session+"";
	        		}else {
	        			finalscore=finalscore+";"+scoreA;
	        			session++;
	        			type4set=type4set+";1";
	        			stimidset=stimidset+";"+session;
	        		}	        	 
            };
            
            post_result(finalscore);
        }
    }
    function post_result(finalscore) {
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
        opes_result_data.stimidset = "0";
        opes_result_data.correctanswerset = "0";
        opes_result_data.time = "0";
        opes_result_data.level = "0";
        opes_result_data.timeset = "0";
        opes_result_data.radioset = "0";
        opes_result_data.buttonset = "0";
        opes_result_data.commentset = "0";
        opes_result_data.numset = finalscore.toString();
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
    requestAnimationFrame(loop);
</script>
</body>
</html>