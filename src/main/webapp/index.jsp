<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/11/24
  Time: 20:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

    <title> 仗剑论坛- 主页</title>

    <meta name="keywords" content="">
    <meta name="description" content="">

    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->

    <link rel="shortcut icon" href="img/favicon.ico"> <link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css?v=4.1.0" rel="stylesheet">
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<div id="wrapper">
    <!--左侧导航开始-->
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="nav-close"><i class="fa fa-times-circle"></i>
        </div>
        <div class="sidebar-collapse">
            <ul class="nav" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="" style="cursor: default">
                                <span class="clear">
                                    <span class="block m-t-xs" style="font-size:20px;">
                                        <i class="fa fa-globe"></i>
                                        <strong class="font-bold">仗剑论坛</strong>
                                    </span>
                                </span>
                        </a>
                    </div>
                    <div class="logo-element">仗剑
                    </div>
                </li>
                <li>
                    <a class="" href="/index.jsp" onclick="">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">主页</span>
                    </a>
                </li>
                <!--版块类别开始-->
                <li>
                    <a href="">
                        <i class="fa fa fa-bar-chart-o"></i>
                        <span class="nav-label">版块类别</span>
                        <span class="fa arrow"></span>
                    </a>
                    <ul class="nav nav-second-level">
                        <!--课堂问答开始-->
                        <li>
                            <a class="J_menuItem" href="/show/topicCatalog?sid=1&&page=1">课堂问答</a>

                        </li>
                        <!--课堂问答结束-->

                        <!--技术分享开始-->
                        <li>
                            <a class="J_menuItem" >技术分享<span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level">
                                <li><a href="/show/topicCatalog?sid=2&&page=1" class="J_menuItem">java<span class="label label-danger pull-right">推荐</span></a></li>
                                <li><a href="/show/topicCatalog?sid=3&&page=1" class="J_menuItem">c/c++</a></li>
                                <li><a href="/show/topicCatalog?sid=4&&page=1" class="J_menuItem">phython</a></li>
                            </ul>

                        </li>
                        <!--技术分享结束-->

                        <!--情感开始-->
                        <li>
                            <a class="J_menuItem" >情感<span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level">
                                <li><a class="J_menuItem" href="/show/topicCatalog?sid=5&&page=1">情感部落</a>
                                </li>
                                <li><a class="J_menuItem" href="/show/topicCatalog?sid=6&&page=1">真情天下</a>
                                </li>
                                <li><a href="/show/topicCatalog?sid=7&&page=1" class="J_menuItem">婆媳关系</a></li>
                            </ul>
                        </li>
                        <!--情感结束-->

                        <!--杂谈开始-->
                        <li>
                            <a class="J_menuItem" >杂谈<span class="fa arrow"></span></a>

                            <ul class="nav nav-third-level">
                                <li><a class="J_menuItem" href="/show/topicCatalog?sid=8&&page=1">仗剑杂谈</a>
                                </li>
                                <li><a class="J_menuItem" href="/show/topicCatalog?sid=9&&page=1">医疗曝光</a>
                                </li>
                                <li><a href="/show/topicCatalog?sid=10&&page=1" class="J_menuItem">大话教育</a></li>
                            </ul>
                        </li>
                        <!--杂谈结束-->

                        <!--娱乐开始-->
                        <li>
                            <a class="J_menuItem" >娱乐<span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level">
                                <li><a class="J_menuItem" href="/show/topicCatalog?sid=11&&page=1">娱乐八卦</a>
                                </li>
                                <li><a class="J_menuItem" href="/show/topicCatalog?sid=12&&page=1">体育沙龙</a>
                                </li>
                                <li><a href="/show/topicCatalog?sid=13&&page=1" class="J_menuItem">星座论坛</a></li>
                            </ul>
                        </li>
                        <!--娱乐结束-->

                        <!--生活开始-->
                        <li>
                            <a class="J_menuItem" >生活<span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level">
                                <li>
                                    <a class="J_menuItem" href="/show/topicCatalog?sid=14&&page=1">保健养生</a>
                                    <%--<ul class="nav" style="padding-left:20px">--%>
                                        <%--<li ><a class="J_menuItem" >aaaa</a></li>--%>
                                        <%--<li><a class="J_menuItem">bbbbb</a></li>--%>
                                        <%--<li><a class="J_menuItem">ccccccc</a></li>--%>
                                    <%--</ul>--%>
                                </li>
                                <li><a href="/show/topicCatalog?sid=15&&page=1" class="J_menuItem">文化漫谈</a></li>
                                <li><a href="/show/topicCatalog?sid=16&&page=1" class="J_menuItem">手机综合</a></li>
                            </ul>
                        </li>
                        <!--生活结束-->

                    </ul>
                </li>
                <!--版块类别结束-->

                <li class="line dk"></li>
                <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
                    <span class="ng-scope">分类</span>
                </li>
                <li>
                    <a ><i class="fa fa-envelope"></i> <span class="nav-label">帖子 </span><span class="label label-warning pull-right"></span></a>
                    <ul class="nav nav-second-level">
                        <li><a class="J_menuItem" href="/mytopic?page=1&&condition=">我的帖子</a>
                        </li>
                        <li><a class="J_menuItem" >我的好友</a>
                        </li>
                        <li><a class="J_menuItem" href="form_editors.html">发&nbsp;&nbsp;帖</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a ><i class="fa fa-edit"></i> <span class="nav-label">个人资料</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li><a class="J_menuItem" href="/showmyplace">我的空间</a></li>
                        <li><a class="J_menuItem" href="/intoalterinfo">修改资料</a></li>
                        <li><a class="J_menuItem" href="/intoalterpassword">密码修改</a></li>

                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    <!--左侧导航结束-->
    <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-info " href="#"><i class="fa fa-bars"></i> </a>
                    <form role="search" class="navbar-form-custom" method="post" action="search_results.html">
                        <div class="form-group">
                            <input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="top-search" id="top-search">
                        </div>
                    </form>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <!--头像-->
                    <c:if test="${sessionScope.user!=null}">
                        <li >
                            <a href="/leave"><i class="glyphicon glyphicon-log-out"></i>注销</a>
                        </li>
                        <li class="dropdown">
                        <a class="dropdown-toggle J_menuItem count-info" data-toggle="dropdown" href="/showmyplace">
                            <img alt="image" class="img-circle" style="width: 32px;height: 32px;" src="/img/${sessionScope.user.headimg}"/>
                        </a>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#" id="all">
                                <i class="fa fa-bell" id="bell"></i> <span class="label label-primary"  id="allunread"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <li>
                                    <a href="/unReadComment?page=1" class="J_menuItem">
                                        <div >
                                            <i class="fa fa-envelope fa-fw"></i> 您有<font id="unreadComment">0</font>条未读评论
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a>
                                        <div>
                                            <i class="fa fa-qq fa-fw"></i> 3条私信（待实现）
                                            <span class="pull-right text-muted small">12分钟钱</span>
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="text-center link-block" >
                                        <a class="J_menuItem" >
                                            <strong>查看所有 </strong>
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </li>
                    </c:if>
                    <c:if test="${sessionScope.user==null}">
                        <li  >
                            <a class="   btn-sm" style="color: #010101"  href="login.html" target="_top">
                                <i class="fa fa-user "></i> 登录
                            </a>
                        </li>
                    </c:if>



                </ul>
            </nav>
        </div>
        <div class="row J_mainContent" id="content-main" >
            <iframe id="J_iframe" width="100%" height="100%" src="forum_main.html?v=4.0" frameborder="0" data-id="index_v1.html" seamless></iframe>
        </div>
    </div>
    <!--右侧部分结束-->
</div>

<!-- 全局js -->
<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="js/plugins/layer/layer.min.js"></script>

<!-- 自定义js -->
<script src="js/hAdmin.js?v=4.1.0"></script>
<script type="text/javascript" src="js/index.js"></script>

<!-- 第三方插件 -->
<script src="js/plugins/pace/pace.min.js"></script>
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script>
    var websocket;
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:8080/msgCountSocket");
    } else if ('MozWebSocket' in window) {
        websocket = new MozWebSocket("ws://localhost:8080/msgCountSocket");
    } else {
        websocket = new SockJS("http://localhost:8080/sockjs/msgCountSocket");
    }
    websocket.onopen = function (evnt) {

    };
    websocket.onmessage = function (evnt) {
        $("#msgcount").html("(<font color='red'>"+evnt.data+"</font>)");
        var count=evnt.data;
        if(count!=null&&count!='0'){
            $('#unreadComment').attr("color","red");
            $('#unreadComment').html(count);
           var allcountdiv= $('#allunread');
           allcountdiv.html(count);
           var timer=null;
           var i=0;
           clearInterval(timer);
           document.getElementById("all").onclick=function () {
               clearInterval(timer);
           }
           timer=setInterval(function () {
               document.getElementById("all").style.visibility=(i++)%2?"hidden":"visible";
               i>100&&(clearInterval(timer))
           },500);
        }
    };
    websocket.onerror = function (evnt) {
    };
    websocket.onclose = function (evnt) {
    }
    function isLoginFirst() {
        var loginFirstFlag='${sessionScope.loginfirst}';
        if(loginFirstFlag=='yes'){
            layer.msg("今日首次登录积分+10 ^_^");
            $.ajax({
                url:'/firstLoginSession',
                type:'get',
            })
        }
    }
    isLoginFirst();

</script>
</body>

</html>
