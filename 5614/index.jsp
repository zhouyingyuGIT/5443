<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="com.lattice.entity.*" %>
<%@ page language="java" import="com.lattice.dao.*,java.util.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=640,target-densitydpi=device-dpi,user-scalable=no">
	<title>TEN DROP</title>
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
<div id="tir" style="color: #ff0000;position: fixed;top: 0px;width: 500px;height: 100px"></div>
	<div class="wrap">
		<h1 class="title">
			<span id="leftDrop">TEN</span>
			DROP
		</h1>
		<p id="info">
			You can use ten drop.
		</p>
		<p id="level">Level 1</p>
		<p id="best"><strong>BEST:</strong> Level <span id="bestLevel">1</span></p>
		<canvas id="canvas"></canvas>
		<p id="restartBtn">RESTART</p>
	</div>

	<script>
        /**
         * @author BUPT-HJM
         * @name  TEN-DROP 1.0.0
         * @description 一个基于canvas的十滴水小游戏
         * @updateTime 2016/09/20
         */
//多维数据
        var starDrop=10;
        var maxtime=180;
        var numset=[];
        var type4set=[];

        //canvas
        var canvas = document.getElementById("canvas");
        var ctx = canvas.getContext('2d');
        canvas.width = 600;
        canvas.height = 600;
        var w = canvas.width;
        var h = canvas.height;


        //剩下的水滴
        var leftDropNum = 10;
        var leftDropSpan = document.getElementById("leftDrop");
        var leftDropArr = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
        for (var i = 11; i < 100; i++) {
            leftDropArr.push(i);
        }

        //获取页面各种元素
        var infoP = document.getElementById("info");
        var restartBtn = document.getElementById("restartBtn");
        var levelP = document.getElementById("level");
        var bestLevel = document.getElementById("bestLevel");
        var best = document.getElementById("best");

        //必要的游戏全局变量
        var game = null;


        /**
         * 水滴对象
         */
        var Drop = function() {
            this.x = w / 2;
            this.y = h / 2;
            this.generation = 1;
            this.direction = null;
            //this.color = "#1BD369";
            this.colorArr = ["#43A6FF", "#1BD369", "#FF7575"];
        };
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
                post_result();
            }
        }

        Drop.prototype = {
            //集中的处理方法
            process: function() {
                this.chooseDraw();
            },
            //根据水滴的代来选择画的方法
            chooseDraw: function() {
                var colorIndex = (game.level - 1) % 3;
                this.color = this.colorArr[colorIndex];
                //console.log(colorIndex);
                switch (this.generation) {
                    case 1:
                        this.draw_1();
                        break;
                    case 2:
                        this.draw_2();
                        break;
                    case 3:
                        this.draw_3();
                        break;
                    case 4:
                        this.draw_4();
                        break;
                    case 5:
                        this.draw_5();
                        break;
                    default:
                        break;
                }
            },
            draw_1: function() {
                EvenCompEllipse(ctx, this.x, this.y, 15, 20, this.color);
            },
            draw_2: function() {
                EvenCompEllipse(ctx, this.x, this.y, 30, 30, this.color);
            },
            draw_3: function() {
                EvenCompEllipse(ctx, this.x, this.y, 45, 35, this.color);
            },
            draw_4: function() {
                EvenCompEllipse(ctx, this.x, this.y, 50, 50, this.color);

            },
            draw_5: function() {
                var centerX = this.x;
                var centerY = this.y;

                if (this.direction == null) {
                    this.generation = 6;
                    EvenCompEllipse(ctx, this.x - 20, this.y, 10, 10, this.color);
                    EvenCompEllipse(ctx, this.x + 20, this.y, 10, 10, this.color);
                    EvenCompEllipse(ctx, this.x, this.y - 20, 10, 10, this.color);
                    EvenCompEllipse(ctx, this.x, this.y + 20, 10, 10, this.color);
                } else {
                    EvenCompEllipse(ctx, this.x, this.y, 10, 10, this.color);
                    EvenCompEllipse(ctx, this.x, this.y, 10, 10, this.color);
                    EvenCompEllipse(ctx, this.x, this.y, 10, 10, this.color);
                    EvenCompEllipse(ctx, this.x, this.y, 10, 10, this.color);
                    return;
                }

                //左
                var drop_left = new Drop();
                drop_left.x = centerX - 20;
                drop_left.y = centerY;
                drop_left.generation = 5;
                drop_left.direction = "left";
                game.dropCollection.add_broken(drop_left);

                //右
                var drop_right = new Drop();
                drop_right.x = centerX + 20;
                drop_right.y = centerY;
                drop_right.generation = 5;
                drop_right.direction = "right";
                game.dropCollection.add_broken(drop_right);

                //上
                var drop_up = new Drop();
                drop_up.x = centerX;
                drop_up.y = centerY + 20;
                drop_up.generation = 5;
                drop_up.direction = "up";
                game.dropCollection.add_broken(drop_up);

                //下
                var drop_down = new Drop();
                drop_down.x = centerX;
                drop_down.y = centerY - 20;
                drop_down.generation = 5;
                drop_down.direction = "down";
                game.dropCollection.add_broken(drop_down);
            }
        }


        /**
         * 绘制椭圆
         */
        function EvenCompEllipse(context, x, y, a, b, fillStyle) {
            context.save();
            context.fillStyle = fillStyle;
            //选择a、b中的较大者作为arc方法的半径参数
            var r = (a > b) ? a : b;
            var ratioX = a / r; //横轴缩放比率
            var ratioY = b / r; //纵轴缩放比率
            context.scale(ratioX, ratioY); //进行缩放（均匀压缩）
            context.beginPath();
            //从椭圆的左端点开始逆时针绘制
            context.moveTo((x + a) / ratioX, y / ratioY);
            context.arc(x / ratioX, y / ratioY, r, 0, 2 * Math.PI);
            context.closePath();
            context.fill();
            context.restore();
        };


        /**
         * 水滴上的盘子对象
         */
        var Board = function() {
            this.w = canvas.width;
            this.h = canvas.height;
            this.hor = 6; //水平方向格子数
            this.ver = 6; //竖直方向格子数
            this.boardArr = [];
        }

        Board.prototype = {
            //初始化
            init: function() {
                for (var i = 0; i < this.hor; i++) {
                    for (var j = 0; j < this.ver; j++) {
                        var x = i * this.w / this.hor + this.w / this.hor / 2;
                        var y = j * this.h / this.ver + this.h / this.ver / 2;
                        var pos = {
                            x: x,
                            y: y
                        }
                        this.boardArr.push(pos);
                    }
                }
                //this.draw();
            },
            //绘制（后面未使用）
            draw: function() {
                for (var i = 0; i <= this.hor; i++) {
                    ctx.save();
                    ctx.beginPath();
                    ctx.moveTo(i * this.w / this.hor, 0);
                    ctx.lineTo(i * this.w / this.hor, this.h);
                    ctx.closePath();
                    ctx.stroke();
                    ctx.restore();
                }
                for (var i = 0; i <= this.ver; i++) {
                    ctx.save();
                    ctx.beginPath();
                    ctx.moveTo(0, i * this.h / this.ver);
                    ctx.lineTo(this.w, i * this.h / this.ver);
                    ctx.closePath();
                    ctx.stroke();
                    ctx.restore();
                }
            }
        }

        /**
         * 水滴数组对象
         */
        var DropCollection = function() {
            this.dropArr = [];
            this.brokenArr = [];
        }
        DropCollection.prototype = {
            //集中的处理方法
            process: function() {
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                for (var i = 0; i < this.dropArr.length; i++) {
                    if (this.dropArr[i].generation == 6) {
                        continue;
                    }
                    this.dropArr[i].process();
                }
                for (var i = 0; i < this.brokenArr.length; i++) {
                    if (this.brokenArr[i].generation == 6) {
                        continue;
                    }
                    this.brokenArr[i].process();
                }
            },
            //水滴数组add
            add: function(drop) {
                this.dropArr.push(drop);
            },
            //水滴数组remove
            remove: function(drop) {
                for (var i = 0; i < this.dropArr.length; i++) {
                    if (this.dropArr[i] == drop) {
                        this.dropArr.splice(i, 1);
                    }
                }
            },
            //散开水滴数组add
            add_broken: function(drop) {
                this.brokenArr.push(drop);
            },
            //散开水滴数组remove
            remove_broken: function(drop) {
                for (var i = 0; i < this.brokenArr.length; i++) {
                    if (this.brokenArr[i] == drop) {
                        this.brokenArr.splice(i, 1);
                    }
                }
            },
            //散开的水滴飞行逻辑处理函数
            fly: function(drop) {
                for (var i = 0; i < this.brokenArr.length; i++) {
                    if (this.brokenArr[i].generation == 6) {
                        continue;
                    }
                    if (this.isInto(this.brokenArr[i].x, this.brokenArr[i].y) || this.brokenArr[i].x < -5 || this.brokenArr[i].x > canvas.width + 5 || this.brokenArr[i].y > canvas.height + 5 || this.brokenArr[i].y < -5) {
                        this.brokenArr[i].generation = 6;
                        continue;
                    }
                    switch (this.brokenArr[i].direction) {
                        case "left":
                            this.brokenArr[i].x--;
                            break;
                        case "right":
                            this.brokenArr[i].x++;
                            break;
                        case "up":
                            this.brokenArr[i].y++;
                            break;
                        case "down":
                            this.brokenArr[i].y--;
                            break;
                        default:
                            break;
                    }
                }
            },
            //判断散开的水滴是否击中
            isInto: function(x, y) {
                var board = game.board;
                var dropArr = game.dropCollection.dropArr;
                var i = Math.floor(x / (board.w / board.hor));
                var j = Math.floor(y / (board.h / board.ver));
                for (var k = 0; k < dropArr.length; k++) {
                    if ((dropArr[k].x == (i * board.w / board.hor + board.w / board.hor / 2)) && (dropArr[k].y == (j * board.h / board.ver + board.h / board.ver / 2)) && (dropArr[k].generation <= 4)) {
                        dropArr[k].generation++;
                        if (dropArr[k].generation > 6) {
                            dropArr[k].generation = 6;
                        }
                        return true;
                    }
                }
                return false;
            }
        }

        /**
         * 游戏对象
         */
        var Game = function() {
            this.board = null;
            this.dropCollection = null;
            this.gameStart = false;
            this.level = 1;
            this.pause = false;
        }
        Game.prototype = {
            //游戏初始化
            init: function() {
                var board = new Board();
                board.init();
                this.board = board;
                var dropCollection = new DropCollection();
                for (var i = 0; i < board.boardArr.length; i++) {
                    var drop = new Drop();
                    drop.generation = getNumberInRange(1, 4);
                    drop.x = board.boardArr[i].x;
                    drop.y = board.boardArr[i].y;
                    dropCollection.add(drop);
                }
                leftDropSpan.innerHTML = leftDropArr[10];
                this.timeChange();
                this.dropCollection = dropCollection;
                this.clickSelect();
                this.setBest();

            },
            //点击选中水滴增加代
            clickSelect: function() {
                var that = this;
                var board = this.board;
                canvas.onclick = function(e) {
                    e.preventDefault();
                    if (this.pause) {
                        return;
                    }
                    if (leftDropNum == 0 || that.isGameOver()) {
                        alert("Game over!");
                        post_result();
                        return;
                    }
                    that.gameStart = true;
                    var i = Math.floor(e.offsetX / (board.w / board.hor));
                    var j = Math.floor(e.offsetY / (board.h / board.ver));
                    var dropArr = that.dropCollection.dropArr;
                    for (var k = 0; k < dropArr.length; k++) {
                        if ((dropArr[k].x == (i * board.w / board.hor + board.w / board.hor / 2)) && (dropArr[k].y == (j * board.h / board.ver + board.h / board.ver / 2))) {
                            if (dropArr[k].generation >= 5) {
                                continue;
                            }
                            dropArr[k].generation++;
                            leftDropNum--;
                            leftDropSpan.innerHTML = leftDropArr[leftDropNum];
                            that.dropCollection.process();
                        }
                    }

                }
            },
            //时间渲染
            timeChange: function() {
                var that = this;
                if (this.gameStart && this.isGameOver() && !this.pause) {
                    info.innerHTML = "You win! Try your best to go to next level!";
                    this.pause = true;
                    setTimeout(function() {
                        that.nextLevel();
                        that.pause = false;
                    }, 1000);
                }
                if (leftDropNum == 0 && !this.isGameOver()) {
                    info.innerHTML = "You lose!";
                }
                var that = this;
                setTimeout(function() {
                    that.dropCollection.fly();
                    that.dropCollection.process();
                    that.timeChange();
                }, 5);
            },
            //判断是否游戏结束
            isGameOver: function() {
                var count = 0;
                var dropArr = this.dropCollection.dropArr;
                for (var k = 0; k < dropArr.length; k++) {
                    if (dropArr[k].generation == 6) {
                        count++;
                    }
                }
                if (count == dropArr.length) {
                    return true;
                } else {
                    return false;
                }
            },
            //进入下一关
            nextLevel: function() {
                this.level++;
                levelP.innerHTML = "Level " + this.level;
                this.setBest(this.level);
                numset.push(starDrop-leftDropNum);
                type4set.push(1);


                ctx.clearRect(0, 0, canvas.width, canvas.height);
                this.gameStart = false;
                this.dropCollection = null;
                var board = this.board;
                var dropCollection = new DropCollection();
                var count = 0;
                for (var i = 0; i < board.boardArr.length; i++) {
                    var drop = new Drop();
                    var change = Math.random();
                    drop.generation = getNumberInRange(1, 4);
                    count += drop.generation;

                    drop.x = board.boardArr[i].x;
                    drop.y = board.boardArr[i].y;
                    dropCollection.add(drop);
                }
                var giveDrop;
                if (leftDropNum + 7 <= 20) {
                    giveDrop = 7;
                } else {
                    giveDrop = 20 - leftDropNum;
                }
                leftDropNum += giveDrop;
                starDrop=leftDropNum;
                leftDropSpan.innerHTML = leftDropArr[leftDropNum];
                info.innerHTML = "Try your best! Give you another " + giveDrop + " drop!";
                this.dropCollection = dropCollection;
            },
            setBest: function(level) {
                if (window.localStorage) {
                    try {
                        localStorage.setItem('bla', 'bla');
                    } catch (e) {
                        best.innerHTML = "";
                        return;
                    }
                }

                if (!localStorage.getItem("bestL")) {
                    localStorage.setItem('bestL', '1');
                }
                if (level) {
                    localStorage.setItem("bestL", level);
                }
                bestLevel.innerHTML = localStorage.getItem("bestL");

            }

        }

        /**
         * 重新开始游戏
         */
        restartBtn.onclick = function() {
            location.reload();
        }


        /**
         * 返回返回内函数（辅助函数）
         */
        function getNumberInRange(min, max) {
            var range = max - min;
            var r = Math.random();
            return Math.round(r * range + min)
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
            opes_result_data.stimidset = "0";
            opes_result_data.correctanswerset = "0";
            opes_result_data.time = "0";
            opes_result_data.level = "0";
            opes_result_data.timeset = "0";
            opes_result_data.radioset = "0";
            opes_result_data.buttonset = "0";
            opes_result_data.commentset = "0";
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

        //创建游戏实例，并且初始化
        game = new Game();
        game.init();
	</script>
</body>
</html>