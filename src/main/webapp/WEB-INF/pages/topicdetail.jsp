<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/11/22
  Time: 17:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 帖子</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="/img/favicon.ico">
    <link href="/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css?v=4.1.0" rel="stylesheet">
    <style type="text/css">
        .loadnav{
            color: #5fd3d4;
            font-size: 18px;
            font-family: 华文彩云;
        }
        .loadnav:hover{
            color: #00a2d4;
        }
        .topichead{
            font-size: 14px;
            color: #898986;
            font-weight: 300;
        }
    </style>
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-9 col-md-9 col-md-offset-1 " style="padding-left: 0px">
            <%--标题--%>
            <div class="ibox ">
                <div class="ibox-content text-left">
                    <div class="m-b-xxs">
                            <a href="/forum_main.html"  class="loadnav"  >home</a>&nbsp;/
                           <a href="/show/topicCatalog?sid=${sectionid} &&page=1" class="loadnav"> ${sectionname}</a>&nbsp;/
                        <span class="topichead">${topic.tTopic}</span>
                    </div>
                </div>
            </div>
            <%--标题结束--%>
            <%--帖子内容开始--%>
            <div class="social-feed-separated">
                <div class="social-avatar">
                    <a href="/showUser/${topic.tuid}">
                        <img alt="image" src="/img/${topic.headimg}">
                    </a>
                </div>
                <div class="social-feed-box">

                    <div class="social-avatar">
                        <a href="/showUser/${topic.tuid}">
                            ${topic.uNickName}
                        </a>
                        <small class="text-muted">${topic.times}</small>
                    </div>
                    <div class="social-body">
                        <p>
                            ${topic.shortContent}
                        </p>

                        <div class="btn-group">
                            <button class="btn btn-white btn-xs" onclick="addtopicclick(this);" ><i class="fa fa-thumbs-up"></i> <span>${topic.tzan}</span>赞</button>
                            <button class="btn btn-white btn-xs"><i class="fa fa-comments"></i> ${topic.replyCount}评论
                            </button>
                            <button class="btn btn-white btn-xs"><i class="fa fa-share"></i> 分享</button>
                        </div>
                    </div>
                    <!--评论-->
                    <c:if test="${comment==null || fn:length(comment)==0}">
                        <div class="social-footer">
                            <div class="media-body" style="text-align: center">
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <h3 style="color: #291f40"> 啊偶，没有评论噢</h3>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                            </div>
                        <c:if test="${sessionScope.user==null}">
                            <div class="social-comment">

                                <div class="media-body">
                                    请先<a href="/login.html">登录</a>再评论
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.user!=null}">
                            <div class="social-comment" >
                                <a  class="pull-left">
                                    <img alt="image" src="/img/${sessionScope.user.headimg}"/>
                                </a>
                                <div class="media-body">
                                    <textarea class="form-control rootcontent"  placeholder="填写评论..."></textarea>
                                    <button type="button" class="btn btn-primary "  style="float: right;margin-top: 5px" onclick="submitroot()">发表评论</button>
                                </div>
                            </div>
                        </c:if>
                        </div>

                    </c:if>
                    <c:if test="${comment!=null && fn:length(comment)!=0}">
                    <div class="social-footer">
                        <c:forEach items="${comment}" var="single">


                        <!--根评论开始-->
                        <div class="social-comment" rootcid="${single.rootcomment.cid}" >
                            <a href="/showUser/${single.rootcomment.uid}" class="pull-left" >
                                <img alt="image" src="/img/${single.rootcomment.headimg}">
                            </a>
                            <div class="media-body" id="${single.rootcomment.cid}">
                                <a href="/showUser/${single.rootcomment.uid}">
                                        ${single.rootcomment.nickname}
                                </a>
                                    ${single.rootcomment.content}
                                <br/>
                                <a  class="small"><i class="fa fa-thumbs-up"></i> ${single.rootcomment.czan}</a>
                                &nbsp;
                                <a  class="small" onclick="adddirecTextArea(this);" ><i class="fa fa-comments"></i></a>&nbsp;
                                <small class="text-muted">${single.rootcomment.timeinterval}前</small>
                            </div>
                            <!-- 根评论结束  -->
                            <!-- 根评论的直接评论开始-->
                            <c:if test="${single.root_directcomment !=null && fn:length(single.root_directcomment)!=0}">
                                <c:forEach items="${single.root_directcomment}" var="dire" >
                                    <div    class="social-comment"   >
                                        <a href="/showUser/${dire.uid}" class="pull-left">
                                            <img alt="image" src="/img/${dire.headimg}">
                                        </a>
                                        <div cid="" class="media-body" directuid="${dire.uid}" id="${dire.cid}">
                                            <a href="/showUser/${dire.uid}">
                                                ${dire.nickname}
                                            </a>
                                            ${dire.content}
                                            <br/>
                                            <a  class="small"><i class="fa fa-thumbs-up"></i> ${dire.czan}</a> &nbsp;
                                            <a  class="small" onclick="addNdirectTextArea(this);" ><i class="fa fa-comments"></i></a>&nbsp;
                                            <small class="text-muted">${dire.timeinterval}前</small>
                                        </div>

                                    </div>
                                    <c:if test="${single.root_Ndirectcomment !=null && fn:length(single.root_Ndirectcomment)!=0}">
                                        <c:forEach items="${single.root_Ndirectcomment}" var="ndire">
                                            <c:if test="${ndire.parentuid eq dire.uid}">

                                                <div class="social-comment" >
                                                    <a href="/showUser/${ndire.uid}" class="pull-left">
                                                        <img alt="image" src="/img/${ndire.headimg}">
                                                    </a>
                                                    <div class="media-body" directuid="${ndire.uid}" id="${ndire.cid}">
                                                        <a href="/showUser/${ndire.uid}">
                                                                ${ndire.nickname}
                                                        </a>
                                                        &nbsp;<font color="#8b5de4">回复</font>
                                                        <a href="/showUser/${dire.uid}">${dire.nickname}</a>

                                                        ${ndire.content}
                                                        <br/>
                                                        <a  class="small"><i class="fa fa-thumbs-up"></i> ${ndire.czan}</a>&nbsp;
                                                        <a  class="small" onclick="addNdirectTextArea(this);"><i class="fa fa-comments"></i></a>&nbsp;
                                                        <small class="text-muted">${ndire.timeinterval}前</small>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </div>
                        </c:forEach>
                        <c:if test="${sessionScope.user==null}">
                            <div class="social-comment">

                                <div class="media-body">
                                    请先<a href="/login.html">登录</a>再评论
                                </div>

                            </div>
                        </c:if>
                        <c:if test="${sessionScope.user!=null}">
                        <div class="social-comment">
                            <a  class="pull-left">
                                <img alt="image" src="/img/${sessionScope.user.headimg}"/>
                            </a>
                            <div class="media-body">
                                <textarea class="form-control rootcontent"   placeholder="填写评论..."></textarea>
                                <p><span class="emotion">表情</span><button type="button" class="btn btn-primary "  style="float: right;margin-top: 5px" onclick="submitroot()">发表评论</button></p>
                            </div>
                        </div>
                        </c:if>
                    </div>
                </div>


                </c:if>
            </div>

        </div>


    </div>
</div>


<!-- 全局js -->
<script src="/js/jquery.min.js?v=2.1.4"></script>
<script src="/js/bootstrap.min.js?v=3.3.6"></script>
<script src="/js/plugins/layer/layer.min.js"></script>
<script type="text/javascript" src="/js/plugins/qqface/jquery.qqFace.js"></script>
<!-- 自定义js -->
<script src="/js/content.js?v=1.0.0"></script>
<script type="text/javascript">
    $.ajaxSetup({
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        complete:function (XMLHttpRequest,textStatus) {
            var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus");
            if(sessionstatus=="timeout"){
                layer.msg("请先登录");
                setTimeout(function () {
                    location.replace("/login.html");
                },500);

            }
        }
    })


    /*点赞事件*/
   function addtopicclick(obj){
    var topicclick=$(obj).children("span").text();
     var newclick= parseInt(topicclick)+1;
       $(obj).children("span").html(newclick);
       $(obj).removeAttr('onclick');
       $(obj).css({'background':'#eaeff0'});
       $.ajax({
           url:"/addtopicclick",    //需要先登录
           data:{tid:'${topic.tid}'},
       });

   }
   /*根评论提交事件*/
   function submitroot() {
        var content=$('.rootcontent').val().trim();  //使用了类选择器
        if(content==null||content==''){
            layer.tips("不能为空",$('.rootcontent'));
            return false;
        }else {
            $.ajax({
                url:'/addComment',
                type:'post',
                data:{content:content,tid:${topic.tid}},
                success:function (data) {
                    if(data=='success'){
                        location.reload();
                    }else {
                        layer.msg("发表评论失败");
                        location.reload();
                    }
                },
                err:function () {
                    layer.msg("发送失败,请稍后再发");
                }
            });
        }
   }
   /*根评论的非直接评论*/
   function addNdirectTextArea(obj) {
       if($('#ndirect').length>0){
           $('#ndirect').remove();
       }
       if($('#direct').length>0){
           $('#direct').remove();
       }
       var parentName=$(obj).parent().children().first('a').text().trim();
       var html = '<div class="social-comment" id="ndirect"> <a  class="pull-left"> <img alt="image" src="/img/${sessionScope.user.headimg}"/> </a> <div class="media-body"> <textarea class="form-control Ndirectcontent"  placeholder="@'+parentName+'"></textarea> <button type="button" class="btn btn-primary "  style="float: right;margin-top: 1px" onclick="submitNdirect(this)">发表评论</button> ' +
               '<button type="button" class="btn btn-primary " onclick="cancle(this)" style="float: right;margin-top: 1px;margin-right:2px">取消</button></div> </div>';
       $(obj).parent().after(html);
   }
   function submitNdirect(obj) {
       var parentuid=$(obj).parent().parent().prev().attr('directuid');
       var rootcid=$(obj).parent().parent().parent().parent().attr('rootcid');
       var content=$(".Ndirectcontent").val().trim();
       if(content==null ||content==''){
           layer.tips("不允许为空",$('.Ndirectcontent'));
           return false;
       }
       $.ajax({
           url:'/addComment',
           type:'post',
           data:{content:content,tid:${topic.tid},rootcid:rootcid,parentuid:parentuid},
           success:function(data){
               if(data=='success'){
                   location.reload();
               }else {
                   layer.msg("发表评论失败");
                   location.reload();
               }
           }
       });

   }
   /*根评论的直接评论*/
    function adddirecTextArea(obj) {
        if($('#ndirect').length>0){
            $('#ndirect').remove();
        }
        if($('#direct').length>0){
            $('#direct').remove();
        }
        var rootid=$(obj).parent().parent().attr('rootcid');
        var rootname=$(obj).parent().children().first('a').text().trim();

        var html = '<div class="social-comment" id="direct"> <a  class="pull-left"> <img alt="image" src="/img/${sessionScope.user.headimg}"/> </a> <div class="media-body"> <textarea class="form-control directcontent"  placeholder="@'+rootname+'"></textarea> <button type="button" class="btn btn-primary "  style="float: right;margin-top: 1px" onclick="submitdirect(this,'+rootid+')">发表评论</button>' +
                '<button type="button" class="btn btn-primary " onclick="cancle(this)" style="float: right;margin-top: 1px;margin-right:2px">取消</button> </div> </div>';
        $(obj).parent().after(html);
    }
    function submitdirect(obj,rootcid){

        var content=$('.directcontent').val().trim();
        if(content==null ||content==''){
            layer.tips("不允许为空",$('.directcontent'));
            return false;
        }
        $.ajax({
            url:'/addComment',
            type:'post',
            data:{content:content,tid:${topic.tid},rootcid:rootcid},
            success:function(data){
                if(data=='success'){
                    location.reload();
                }else {
                    layer.msg("发表评论失败");
                    location.reload();
                }
            }
        });
    }
    /*取消*/
    function cancle(obj) {
        $(obj).parent().parent().remove();
    }
    /**获取#后面的cid并用颜色展示**/
    function lookTheComment() {
        var href=window.location.href;
        var a=href.split("#");
        if(a[1]!=null){
           $('#'+a[1]).css({background:'#E0E0E0'});
        }
    }
    lookTheComment();
</script>


</body>

</html>
