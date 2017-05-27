<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 论坛</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="/img/favicon.ico">
    <link href="/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="row">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="wrapper wrapper-content animated fadeInRight">

                    <div class="ibox-content m-b-sm border-bottom">
                        <div class="p-xs">
                            <div class="pull-left m-r-md">
                                <i class="fa fa-globe text-navy mid-icon"></i>
                            </div>
                            <h2>欢迎来到仗剑论坛</h2>
                            <span>你可以自由选择你感兴趣的话题。</span>
                        </div>
                    </div>

                    <div class="ibox-content forum-container">

                        <div class="forum-title">
                            <div class="pull-right forum-desc">
                                <samll>在线人数:<span style="color: #91806b" id="online">${onlineCount}</span></samll>
                                &nbsp;
                                <samll id="topic_total">总帖子数：<span style="color: #91806b" >${sumoftopic}</span></samll>
                            </div>
                            <h3>主版</h3>
                        </div>

                        <c:forEach items="${sectionlist}" var="single">

                            <div class="forum-item active">
                                <div class="row">
                                    <div class="col-sm-9">
                                        <div class="forum-icon">
                                            <i class="fa fa-shield"></i>
                                        </div>
                                        <a href="/show/topicCatalog?sid=${single.sid}&&page=1" class="forum-item-title">${single.sname}</a>
                                        <div class="forum-sub-title" >${single.sshortsm}</div>
                                    </div>
                                    <div class="col-sm-1 forum-info">
                                        <span class="views-number" >
                                            ${single.sclickcount}
                                        </span>
                                        <div>
                                            <small>浏览</small>
                                        </div>
                                    </div>
                                    <div class="col-sm-1 forum-info">
                                        <span class="views-number" id="${single.sid}_reply_num">
                                            0
                                        </span>
                                        <div>
                                            <small>回帖</small>
                                        </div>
                                    </div>
                                    <div class="col-sm-1 forum-info">
                                        <span class="views-number" >
                                            ${single.stopiccount}
                                        </span>
                                        <div>
                                            <small>帖子</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>


                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 全局js -->
<script src="/js/jquery.min.js?v=2.1.4"></script>
<script src="/js/bootstrap.min.js?v=3.3.6"></script>


<!-- Peity -->
<script src="/js/plugins/peity/jquery.peity.min.js"></script>

<!-- 自定义js -->
<script src="/js/content.js?v=1.0.0"></script>
<script type="text/javascript">
    $(function () {
        $.ajax({
            type: "POST",
            url: "/show/catalog",
            cache: false,
            dataType: "json",
            success: function (data) {

                $("span[id$='reply_num']").each(function (index, element) {
                    $(element).html(data.b[index]);
                });

                console.log("欢迎来到仗剑论坛^-^");
            },
            err: function (XMLHttpRequest, textStatus, errThrown) {
                alert("ajax请求失败");
            }


        })
    })
</script>


</body>

</html>
