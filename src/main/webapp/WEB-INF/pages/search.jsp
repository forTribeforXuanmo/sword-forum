<%--
  Created by IntelliJ IDEA.
  User: lishengzhu
  email:530735771@qq.com
  Date: 2017/5/27
  Time: 6:42
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.Calendar" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 搜索</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeIn">

    <div class="row">

        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>搜索内容</h5>
            </div>
            <div class="ibox-content">
                <div class="panel-body">
                    <div class="panel-group" id="accordion">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h5 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">用户&nbsp;&nbsp;</a><span class="text-danger">${fn:length(userlist)}条</span>
                                </h5>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse in">
                                <div class="panel-body">
                                    <c:if test="${userlist!=null && fn:length(userlist)!=0}">

                                        <div class="project-list">
                                            <table class="table table-hover">
                                                <tbody>
                                        <c:forEach items="${userlist}" var="single">
                                                <tr>
                                                    <td class="project-title">
                                                        账号&nbsp;<span class="label label-primary ">${single.uemail}</span>&nbsp;昵称&nbsp;<span class="label label-warning">${single.unickname}</span>
                                                    </td>
                                                    <td >
                                                       ${single.ustatement}
                                                    </td>
                                                    <td class="project-people">
                                                        <a href=""><img alt="image" class="img-circle"
                                                                        src="/img/${single.headimg}"></a>
                                                    </td>
                                                    <td class="project-people">
                                                        <c:if test="${single.usex==0}">
                                                            <span class="btn btn-primary btn-sm"><i class="fa fa-male fa-fw"></i></span>
                                                        </c:if>
                                                        <c:if test="${single.usex!=0}">
                                                            <span class="btn btn-warning btn-sm"><i class="fa fa-female fa-fw"></i></span>
                                                        </c:if>
                                                    </td>
                                                    <td class="project-actions">
                                                        <a class="btn btn-white btn-sm"
                                                           href="/showUser/${single.uid}"><i class="fa fa-eye "></i> 查看 </a>
                                                    </td>
                                                </tr>
                                        </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">帖子 </a><span class="text-danger">${fn:length(topiclist)}条</span>
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <c:if test="${topiclist!=null && fn:length(topiclist) !=0}">
                                        <c:forEach items="${topiclist}" var="item" varStatus="status">

                                            <div class="col-lg-12 ">
                                                <!-------------------------------------------------------------------------------------------->
                                                <div class="ibox">
                                                    <div class="ibox-content">
                                                        <a href="/showTopicDetail/${item.tid}" class="btn-link">
                                                            <h3>
                                                                    ${item.tTopic}

                                                            </h3>
                                                        </a>
                                                        <div class="small m-b-xs">
                                                            <a href="/showUser/${item.tuid}" class="pull-left">
                                                                <img alt="image" class="img-circle" style="width: 38px;height: 38px;" src="/img/${item.headimg}">
                                                            </a>

                                                            <strong style="margin-left: 5px;margin-bottom: 0px">${item.uNickName}</strong> </span>
                                                            <span class="text-muted"><i
                                                                    class="fa fa-clock-o"></i> ${item.times}前</span>
                                                        </div>
                                                        <br/>
                                                        <p>
                                                                ${item.shortContent}
                                                        </p>
                                                        <div class="row" >
                                                            <div class="col-md-6">
                                                                <h5>标签：</h5>
                                                                <button class="btn btn-primary btn-xs" type="button">xxx
                                                                </button>
                                                                <button class="btn btn-white btn-xs" type="button">xxx</button>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="small text-right">
                                                                    <h5>状态：</h5>
                                                                    <div><i class="fa fa-comments-o"> </i> ${item.replyCount} 评论
                                                                    </div>
                                                                    <i class="fa fa-eye"> </i> ${item.clickCount}浏览
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!------------------------------------------>
                                            </div>
                                        </c:forEach>

                                    </c:if>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 全局js -->
<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>


<!-- 自定义js -->
<script src="/js/content.js"></script>


</body>

</html>
