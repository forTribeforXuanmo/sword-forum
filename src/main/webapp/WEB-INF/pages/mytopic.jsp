<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2017/3/11
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>我的帖子</title>
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
            <div class="col-sm-12 ">
                <div class="wrapper wrapper-content animated fadeInRight">


                    <div class="ibox">
                        <div class="ibox-content" style="background-color: #e7eaec">
                            <span class="text-muted small pull-right">耗时:<i
                                    class="fa fa-clock-o"></i> ${needtime}毫秒</span>
                            <h2>My Topic</h2>
                            <p>
                                关键字:[文章标题]&nbsp;查询
                            </p>
                            <div class="input-group">
                                <input type="text" id="condition" placeholder="查找帖子.." class="input form-control"
                                       value="${condition}">
                                <span class="input-group-btn">
                                        <button type="button" class="btn btn btn-primary" onclick="search()"> <i
                                                class="fa fa-search"></i> 搜索</button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <c:if test="${tcvos==null && fn:length(tcvos) ==0}">
                        <div class="ibox">
                            <div class="ibox-content" style="background-color: #fbffd9"><h2> SORRY,没有帖子</h2></div>
                        </div>
                    </c:if>

                    <c:if test="${tcvos!=null && fn:length(tcvos) !=0}">
                        <c:forEach items="${tcvos}" var="item" varStatus="status">
                            <div class="col-lg-12 ">
                                <!-------------------------------------------------------------------------------------------->
                                <div class="ibox">
                                    <div class="ibox-content">
                                        <a href="/showTopicDetail/${item.tid}" class="btn-link">
                                            <h2>
                                                    ${item.tTopic}

                                            </h2>
                                        </a>
                                        <a class="pull-right" onclick="deleteTopic(${item.tid});">删除</a>
                                        <div class="small m-b-xs">
                                            <a  class="pull-left">
                                                <img alt="image" class="img-circle" style="width: 38px;height: 38px;" src="/img/${item.headimg}">
                                            </a>

                                            <strong style="margin-left: 5px;margin-bottom: 0px">${item.uNickName}</strong> </span>
                                            <span class="text-muted"><i
                                                    class="fa fa-clock-o"></i> ${item.times}</span>
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
                        <div  class="col-sm-6 col-sm-offset-3" id="page"></div>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="/js/jquery.min.js"></script>
<script src="/js/plugins/layer/layer.min.js"></script>
<script src="/js/plugins/layer/laypage/laypage.js"></script>
<script type="text/javascript">
    /*翻页+查询*/
        laypage({
            cont: $('#page'),
            pages: ${pages}, //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18
            curr: function(){ //通过url获取当前页，也可以同上（pages）方式获取
                var page = location.search.match(/page=(\d+)/);
                return page ? page[1] : 1;
            }(),
            jump: function(e, first){ //触发分页后的回调
                if(!first){ //一定要加此判断，否则初始时会无限刷新
                    location.href = '/mytopic?page='+e.curr+'&&condition='+$('#condition').val().trim();
                }
            }
        });
        function search(){
            location.href='/mytopic?page=1&&condition='+$('#condition').val().trim();
        }
        /*删除*/
        function deleteTopic(obj) {
            layer.confirm('确认删除？',{btn:['是','否']},function () {
                $.ajax({
                    type:'post',
                    url:'/deleteMytopic',
                    data:{tid:obj},
                    success:function (data) {
                        if(data=='ok'){
                            location.reload();
                        }else {
                            layer.msg('删除失败');
                        }
                    }
                });
            })
        }
</script>
</html>
