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


    <title> - 未读评论</title>
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
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>未读评论</h5>
                </div>
                <div class="ibox-content">

                        <div class="feed-activity-list">
                            <c:if test="${unreadcomms==null || fn:length(unreadcomms) ==0}">
                                暂无未读评论
                            </c:if>
                            <c:if test="${unreadcomms!=null && fn:length(unreadcomms) !=0}">
                                <c:forEach items="${unreadcomms}" var="item" varStatus="status">
                                    <div class="feed-element">
                                        <a href="javascript:void(0) " class="pull-left">
                                            <img alt="${item.unickname}" class="img-circle" src="/img/${item.headimg}">
                                        </a>
                                        <div class="media-body ">
                                            <small class="pull-right">${item.ctime}</small>
                                            <strong>${item.unickname}</strong> 在您发布的&nbsp;
                                            <a href="/showTopicDetail/${item.ctid}#${item.cid}" class="btn-link">
                                                    ${item.ttopic}
                                            </a>&nbsp;发表了评论 :
                                            <br>
                                            <div class="well">
                                                    ${item.content}
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div  class="col-sm-6 col-sm-offset-3" id="page"></div>
                            </c:if>
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
<script src="/js/plugins/layer/layer.min.js"></script>
<script src="/js/plugins/layer/laypage/laypage.js"></script>
<script type="text/javascript">
    laypage({
        cont: $('#page'),
        pages: ${pages}, //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18
        curr: function(){ //通过url获取当前页，也可以同上（pages）方式获取
            var page = location.search.match(/page=(\d+)/);
            return page ? page[1] : 1;
        }(),
        jump: function(e, first){ //触发分页后的回调
            if(!first){ //一定要加此判断，否则初始时会无限刷新
                location.href = '/unReadComment?page='+e.curr;
            }
        }
    });
</script>
</body>

</html>
