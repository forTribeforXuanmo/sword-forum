<%--
  Created by IntelliJ IDEA.
  User: lishengzhu
  email:530735771@qq.com
  Date: 2017/5/14
  Time: 16:36
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


    <title> -添加好友记录</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link href="/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">

<div class="wrapper wrapper-content animated fadeInUp">
    <div class="row">
        <div class="col-sm-12">

            <div class="ibox">
                <div class="ibox-title">
                    <h5>添加好友消息</h5>
                </div>
                <div class="ibox-content">
                    <div class="project-list">
                        <c:if test="${alladdfriend==null || fn:length(alladdfriend)==0}"><p>您最近没有通知</p></c:if>
                        <c:if test="${alladdfriend!=null  && fn:length(alladdfriend)!=0}"><span>有消息</span>
                            <table class="table table-hover">
                                <tbody>
                                <c:forEach items="${alladdfriend}" var="single">
                                    <c:if test="${single.addfriend.flag==1}">
                                        <%--我添加他人的反馈信息--%>
                                        <tr>
                                            <td class="project-title">
                                                向<span
                                                    class="label label-primary ">${single.user.uemail}</span>昵称为${single.user.unickname}的用户申请加为好友已被
                                                    ${single.addfriend.staus}
                                            </td>
                                            <td>
                                                创建于 <fmt:formatDate value="${single.addfriend.time}" type="both"/>
                                            </td>
                                            <td class="project-people">
                                                <a href=""><img alt="image" class="img-circle"
                                                                src="img/${single.user.headimg}"></a>
                                            </td>
                                            <td class="project-actions">
                                                <a class="btn btn-white btn-sm"
                                                   onclick="finish(${single.addfriend.touid},this)"><i
                                                        class="fa fa-meh-o"></i> 知道了 </a>
                                            </td>

                                        </tr>
                                    </c:if>
                                    <c:if test="${single.addfriend.flag!=1}">
                                        <%--他人申请加我我好友--%>
                                        <tr>
                                            <td>
                                                账号&nbsp;<span
                                                    class="label label-primary font-bold">${single.user.uemail}</span>&nbsp;昵称&nbsp;<span
                                                    class="label label-danger">${single.user.unickname}</span>
                                                的用户申请加你为好友
                                            </td>
                                            <td>
                                                创建于 <fmt:formatDate value="${single.addfriend.time}" type="both"/>
                                            </td>
                                            <td class="project-people">
                                                <a href="/showUser/${single.user.uid}"><img alt="image"
                                                                                            class="img-circle"
                                                                                            src="img/${single.user.headimg}"></a>
                                            </td>
                                            <td class="project-actions">
                                                <a class="btn btn-white btn-sm" onclick="accept(${single.user.uid},this);"><i
                                                        class="fa fa-check"></i> 接受 </a>
                                                <a class="btn btn-white btn-sm" onclick="reject(${single.user.uid},this);"><i
                                                        class="fa  fa-times"></i>拒绝</a>
                                            </td>
                                        </tr>
                                    </c:if>

                                </c:forEach>
                                </tbody>
                            </table>
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


<script>
    function finish(touid,obj) {
        $.ajax({
            url: "/finishaddfriend?touid=" + touid,
            success: function (data) {
                if (data == 'success') {
                    alert("完成了一个" + touid);
                    $(obj).parent().parent().fadeOut("slow");
                }
            }
        })
    }
    function accept(hisuid,obj) {
        $.ajax({
            url: '/acceptaddfriend?fromuid=' + hisuid,
            success: function (data) {
                if (data == 'success') {
                    $(obj).removeClass("btn-white").addClass('btn-primary');
                    $(obj).text('已接受');
                    $(obj).fadeOut("slow");
                }
            }
        })
    }
    function reject(hisuid,obj) {
        $.ajax({
            url: '/rejectaddfriend?touid=' + hisuid,
            success: function (data) {
                if (data == 'success') {
                    alert("拒绝了" + hisuid);
                    $(obj).removeClass("btn-white").addClass('btn-primary');
                    $(obj).text('已拒绝');
                    $(obj).fadeOut("slow");
                }
            }
        })
    }

</script>


</body>
</html>
