<%--
  Created by IntelliJ IDEA.
  User: lishengzhu
  email:530735771@qq.com
  Date: 2017/5/13
  Time: 19:03
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.Calendar" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 聊天窗口</title>

    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico"> <link href="/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/css/plugins/jsTree/style.min.css" rel="stylesheet">
    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">

    <div class="row">
        <div class="col-sm-12">

            <div class="ibox chat-view">

                <div class="ibox-title" id="title" style="height:58px">
                    <img class="img-circle" style="height:40px;width: 40px "  alt=""/>
                    <span style="font-size: medium"></span>
                </div>


                <div class="ibox-content">

                    <div class="row">
                        <div class="col-md-9 ">
                            <div class="chat-discussion" id="discussion">

                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="chat-users">

                                <div class="users-list">
                                    <c:if test="${myfriends!=null && fn:length(myfriends)!=0}">
                                        <c:forEach items="${myfriends}" var="friend">
                                            <div class="chat-user" id="${friend.uid}">
                                                <span class="pull-right label label-primary"></span>
                                                <c:if test="${friend.uid!=-1}">
                                                    <a href="/showUser/${friend.uid}"><img class="chat-avatar" src="/img/${friend.headimg}" title="查看->${friend.uemail}"></a>
                                                </c:if>
                                                <c:if test="${friend.uid==-1}">
                                                    <a><img class="chat-avatar" src="/img/${friend.headimg}" title="系统"></a>
                                                </c:if>
                                                <div class="chat-user-name">
                                                    <a onclick="chatToOne(${friend.uid},this)">${friend.unickname}</a>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-9">
                            <div style="height: 5px">
                                <hr class="hr-line-solid"/>
                            </div>
                            <div class="chat-message-form">
                                <div class="form-group">
                                    <textarea class="form-control message-input" name="message"  id="sendmessage" placeholder="输入消息内容，按alt+回车键发送"></textarea>
                                    <button type="button" class="btn btn-primary btn-group "  style="float: right;margin-top: 5px;margin-right: 5px" id="sendbtn">发送</button>
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
<script src="/js/jquery.min.js?v=2.1.4"></script>
<script src="/js/bootstrap.min.js?v=3.3.6"></script>

<!-- 自定义js -->
<script src="/js/content.js?v=1.0.0"></script>
<!-- 第三方插件 -->
<script src="js/plugins/pace/pace.min.js"></script>
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script type="text/javascript">
    var websocket;
    var hisuid;
    var lastfrienddiv=null;
    $('#sendmessage').attr("readonly",true);
    $('#sendbtn').attr('disabled',true);
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:8080/chatouser");
    } else if ('MozWebSocket' in window) {
        websocket = new MozWebSocket("ws://localhost:8080/chatouser");
    } else {
        websocket = new SockJS("http://localhost:8080/sockjs/chattouser");
    }
    websocket.onopen = function (evnt) {
        alert("链接上了");
    };
    websocket.onmessage = function (evnt) {
        var data=JSON.parse(evnt.data);
        var unreadlist=data.unreadsixinlist;
        var somecount=data.someonecount;
        var message=data.message;
        alert(message);
        if(unreadlist!=null&&  unreadlist.length!=0) {
            for (var i = 0; i < unreadlist.length; i++) {
                var element = unreadlist[i];
                $('div[uid=' + element.uid + ']').children(':first').html(element.count);
            }
        }
        if(somecount!=null){
            $('div[uid=' + somecount.uid + ']').children(':first').html(somecount.count);
        }
        if(message!=null){
           var img=$('#title').children("img").attr("src");
           var nickname=$('#title').children("span").text();
            var hesend='<div class="chat-message" > <img class="hismessage-avatar img-circle" src="' +img+
                '" alt=""> ' +
                '<div class="hismessage"> <a class="message-author" >' +nickname+
                '</a> ' +
                '<span class="hismessage-date"> ' +dateFormatter(new Date())+
                ' </span> ' +
                '<span class="message-content">' +message+
                ' </span> </div> </div>';
            $('#discussion').append(hesend);
            $('#discussion').scrollTop($('#discussion')[0].scrollHeight);
        }
    }
    function chatToOne(uid,obj) {
        hisuid=uid;
        var img=$(obj).parent().parent().children('a').children("img").attr("src");
        var nickname=$(obj).text();
        $('#title').children("img").attr("src",img);
        $('#title').children('span').html(nickname);
        if(uid==-1){
            $('#sendmessage').val("");
            $('#sendmessage').attr("readonly",true);
            $('#sendbtn').attr('disabled',true);
        }else {
            $('#sendmessage').val("");
            $('#sendmessage').attr("readonly",false);
            $('#sendbtn').attr('disabled',false);
        }
        $.ajax({
            url:'/openchatlastinfo',
            type:'post',
            dataType:'json',
            data:{hisuid:uid},
            success:function (data) {
                if(data!=null){
                    $('#discussion').html("");
                    for(var i=0;i<data.length;i++){
                    var discussiondiv=$('#discussion');
                    if(data[i].sifromuid==${sessionScope.user.uid}){
                        var isend='<div class="chat-message"> ' +
                            '<img class="mymessage-avatar " src="img/${sessionScope.user.headimg}" alt=""> ' +
                            '<div class="mymessage"> ' +
                            '<a class="mymessage-author" > ${sessionScope.user.unickname}</a> ' +
                            '<span class="mymessage-date">' +dateFormatter(data[i].time)+
                            ' </span> ' +
                            '<span class="message-content">' +data[i].content+
                            ' </span> </div> </div>';
                        discussiondiv.append(isend);
                        $('#discussion').scrollTop($('#discussion')[0].scrollHeight);
                    }else {
                        var hesend='<div class="chat-message" > <img class="hismessage-avatar img-circle" src="' +img+
                            '" alt=""> ' +
                            '<div class="hismessage"> <a class="message-author" >' +nickname+
                            '</a> ' +
                            '<span class="hismessage-date"> ' +dateFormatter(data[i].time)+
                            ' </span> ' +
                            '<span class="message-content">' +data[i].content+
                            ' </span> </div> </div>';
                        discussiondiv.append(hesend);
                        $('#discussion').scrollTop($('#discussion')[0].scrollHeight);
                    }
                    }
                }
                var frienddiv=$(obj).parent().parent();
                if(lastfrienddiv==null){
                    lastfrienddiv=frienddiv;
                    frienddiv.css('backgroundColor','#EEEEEE');
                }else {
                    lastfrienddiv.css('backgroundColor','#FFFFFF');
                    frienddiv.css('backgroundColor','#EEEEEE');
                    lastfrienddiv=frienddiv;
                }
                //去掉未读数
                $(obj).parent().parent().children("span").html("");
            }
        })
    }
    function dateFormatter(value) {
        var date=new Date(value);
        y = date.getFullYear(),
            m = date.getMonth() + 1,
            d = date.getDate(),
            h=date.getHours(),
            min=date.getMinutes(),
            s=date.getSeconds();
        return y + "-" + (m < 10 ? "0" + m : m) + "-" + (d < 10 ? "0" + d : d)+" "+(h<10?"0"+h:h)+":"+(min<10?"0"+min:min)+":"
            +(s<10?"0"+s:s);
    }
    $('#sendmessage').keydown(function (e) {
        if(e.ctrlKey&&e.which==13){
            send();
        }
    })
    $('#sendbtn').on('click',function () {
        send();
    })
    function send() {
        var text=$('#sendmessage').val().trim();
        if(text==''){
            alert("不能为空");
        }else{
            var data={};
            data["sifromuid"]=${sessionScope.user.uid};
            data["sitouid"]=hisuid;
            data["content"]=text;
            websocket.send(JSON.stringify(data));
            var isend='<div class="chat-message"> ' +
                '<img class="mymessage-avatar " src="img/${sessionScope.user.headimg}" alt=""> ' +
                '<div class="mymessage"> ' +
                '<a class="mymessage-author" > ${sessionScope.user.unickname}</a> ' +
                '<span class="mymessage-date">' +dateFormatter(new Date())+
                ' </span> ' +
                '<span class="message-content">' +text+
                ' </span> </div> </div>';
            $('#discussion').append(isend);
            $('#discussion').scrollTop($('#discussion')[0].scrollHeight);
            $('#sendmessage').val("");
        }
    }
    /**获取#后面的cid并用颜色展示**/
    function getUrlAtWho() {
        var href=window.location.href;
        var a=href.split("#");
        if(a[1]!=null){
           chatToOne(a[1],$('#'+a[1]).children('.chat-user-name').children('a'));
        }
    }
    getUrlAtWho();

</script>


</body>

</html>
