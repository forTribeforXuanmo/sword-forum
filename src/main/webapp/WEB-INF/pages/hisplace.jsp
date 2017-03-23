<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2017/3/18
  Time: 13:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 他人资料</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="/img/favicon.ico"> <link href="/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row animated fadeInRight">
        <div class="col-sm-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>${his.uemail}的资料</h5>
                </div>
                <div>
                    <div class="ibox-content no-padding border-left-right">
                        <img alt="image" style="height: 300px;width: 300px" class="img-responsive circle-border" src="/img/${his.headimg}">
                    </div>
                    <div class="ibox-content profile-content">
                        <h4>账号：${his.uemail}</h4>
                        <h4>昵称：${his.unickname}</h4>
                        <h4>性别：
                            <c:if test="${his.usex==1}">
                                女
                            </c:if>
                            <c:if test="${his.usex==0}">
                                男
                            </c:if>
                        </h4>
                        <h4>生日：<fmt:formatDate value="${his.ubirthday}" type="date" />  </h4>
                        <h4>等级：${his.ulevel}</h4>
                        <h4>积分：${his.upoint}</h4>
                        <h4>状态：
                            <c:if test="${his.ustate==0}">
                                正常
                            </c:if>
                            <c:if test="${his.ustate!=0}">
                                暂封${his.ustate}天
                            </c:if>
                        </h4>
                        <h4>注册时间：<fmt:formatDate value="${his.uregtime}" type="date" dateStyle="full"/>  </h4>
                        <h4>
                            关于我
                        </h4>
                        <p>
                            ${his.ustatement}
                        </p>
                        <div class="row m-t-lg">

                                <div class="col-sm-4" >
                                    <span class="bar">5,3,9,6,5,9,7,3,5,2</span>
                                    <h5><strong>${histopicnum}</strong> 帖子</h5>
                                </div>

                             <div class="col-sm-4">
                                <span class="line">5,3,9,6,5,9,7,3,5,2</span>
                                <h5><strong>${hisconcernnum}</strong> 关注</h5>
                            </div>

                                <div class="col-sm-4">
                                    <span class="bar">5,3,2,-1,-3,-2,2,3,5,2</span>
                                    <h5><strong>${beconcernnum}</strong> 粉丝</h5>
                                </div>
                        </div>
                        <div class="user-button">
                            <div class="row">
                                <div class="col-sm-6">
                                    <button type="button" class="btn btn-primary btn-sm btn-block"><i class="fa fa-envelope"></i> 发送消息</button>
                                </div>
                                <input type="hidden" value="${his.uid}" id="hisuid"/>
                                <div class="col-sm-6">
                                    <c:if test="${flag==0}">
                                    <button type="button" id="addConBtn" class="btn btn-default btn-sm btn-block"><i class="fa fa-coffee"></i> +关注</button>
                                    </c:if>
                                    <c:if test="${flag==1}">
                                        <button type="button" id="cancelConBtn" class="btn btn-default btn-sm btn-block"><i class="fa fa-coffee"></i> 取消关注</button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-8">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>他发布的帖子</h5>

                </div>
                <div class="ibox-content">
                    <div>
                        <div class="feed-activity-list">
                            <c:if test="${tcvos==null && fn:length(tcvos) ==0}">
                                暂无最新动态
                            </c:if>
                            <c:if test="${tcvos!=null && fn:length(tcvos) !=0}">
                                <c:forEach items="${tcvos}" var="item" varStatus="status">
                                    <div class="feed-element">
                                        <a href="javascript:void(0) " class="pull-left">
                                            <img alt="${item.uNickName}" class="img-circle" src="/img/${item.headimg}">
                                        </a>
                                        <div class="media-body ">
                                            <small class="pull-right">${item.times}前</small>
                                            <strong>${item.uNickName}</strong> 发布
                                            <a href="/showTopicDetail/${item.tid}" class="btn-link">
                                                    ${item.tTopic}
                                            </a>
                                            <br>
                                            <div class="well">
                                                    ${item.shortContent}
                                            </div>
                                            <div class="pull-right">
                                                <i class="fa fa-thumbs-up"></i> ${item.tzan}赞&nbsp;
                                                <i class="fa fa-pencil" ></i>${item.replyCount} 评论
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>

                        <%--
                                                <button class="btn btn-primary btn-block m"><i class="fa fa-arrow-down"></i> 显示更多</button>
                        --%>

                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

<!-- 全局js -->
<script src="/js/jquery.min.js?v=2.1.4"></script>
<script src="/js/bootstrap.min.js?v=3.3.6"></script>
<!-- 自定义js -->
<script src="/js/content.js?v=1.0.0"></script>
<!-- Peity -->
<script src="/js/plugins/peity/jquery.peity.min.js"></script>
<!-- Peity -->
<script src="/js/demo/peity-demo.js"></script>
<script type="text/javascript">

    /*这里做了两组id对应两组事件方法，但仅仅修改id是不行的因为修改后根据id选择器获取的元素并没有改变，所以它对应的事件方法并没有改变，因此需要在每个绑定事件种写判断，
    既然要达到根据Id选择不同的方法，那就直接判断id*/
        function addCon() {
            $.ajax({
                type:'post',
                data:{hisuid:$('#hisuid').val()},
                url:"/addConcern",
                success:function (data) {
                    if(data=='ok'){
                        $('#addConBtn').html('<i class="fa fa-coffee"></i> 取消关注');
                        $('#addConBtn').attr("id","cancelConBtn");

                    }
                }
            });
        };
        function cancelCon() {
            $.ajax({
                type:'post',
                data:{hisuid:$('#hisuid').val()},
                url:"/cancelConcern",
                success:function (data) {
                    if(data=='ok'){
                        $('#cancelConBtn').html('<i class="fa fa-coffee"></i> +关注');
                        $('#cancelConBtn').attr("id","addConBtn");

                    }
                }
            });
        }
        $('#addConBtn').on("click",function() {
            if($(this).attr("id")=="addConBtn"){
                addCon();
            }else {
                cancelCon();
            }
        });
        $("#cancelConBtn").on("click",function() {
            if($(this).attr("id")=="addConBtn"){
                addCon();
            }else {
                cancelCon();
            }
        });

</script>



</body>

</html>
