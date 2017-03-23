<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/11/27
  Time: 16:11
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


    <title> - 修改资料</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="/img/favicon.ico">
    <link href="/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row animated fadeInRight">
        <div class="col-sm-12 col-md-8 col-lg-offset-1">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>修改资料</h5>
                </div>
                <div>
                    <div class="ibox-content profile-content">

                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-3 col-md-2 control-label">头像：</label>
                                <div class="col-md-4">
                                    <div class="image-crop" id="imgitem" >
                                        <img id="myheadimg" style="cursor: hand;width: 200px;height: 200px" class="circle-border" onclick="imgitem();"
                                             src="/img/${sessionScope.user.headimg}"/>
                                    </div>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-3 col-md-2 control-label">昵称：</label>

                                <div class="col-sm-8 col-md-4">
                                    <input type="text" id="nickname" value="${sessionScope.user.unickname}" class="form-control"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 col-md-2 control-label">性别：</label>
                                <div class="col-sm-8 col-md-4">
                                    <div class="radio i-checks">
                                        <label>
                                            <input type="radio" ${sessionScope.user.usex==0?'checked':''} value="0"
                                                   name="sex"> <i></i> 男
                                        </label>
                                        <label>
                                            <input type="radio" ${sessionScope.user.usex==1?'checked':''} value="1"
                                                   name="sex"> <i></i> 女
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 col-md-2 control-label">生日：</label>
                                <div class="col-sm-8 col-md-4">
                                    <input  readonly class="form-control layer-date" id="birthday"
                                           value='<fmt:formatDate value="${sessionScope.user.ubirthday}" type="date"/>'/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 col-md-2 control-label">关于我：</label>
                                <div class="col-sm-8 col-md-6">
                                    <textarea id="statement" class="form-control" rows="2">${sessionScope.user.ustatement}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-8 col-md-4 col-md-offset-2">
                                    <button class="btn btn-sm btn-info" onclick="save();" type="button">保 存</button>
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

<!-- layerDate plugin javascript -->
<script src="/js/plugins/layer/laydate/laydate.js"></script>
<!-- Peity -->
<script src="/js/plugins/peity/jquery.peity.min.js"></script>
<!--layer插件-->
<script src="/js/plugins/layer/layer.min.js"></script>
<!-- Peity -->
<script src="/js/demo/peity-demo.js"></script>
<script type="text/javascript">
    //日期范围限制
    var start = {
        elem: '#birthday',
        format: 'YYYY-MM-DD',
        max: laydate.now(), //最大日期
        istime: true,
        istoday: false,
        start: '<fmt:formatDate value="${sessionScope.user.ubirthday}" type="date" />',
        choose: function (datas) {

        }
    };
    laydate(start);
    function imgitem() {
        layer.open({
            type: 2,
            title: '更换头像',
            shadeClose: true,
            shade: 0.8,
            area: ['1000px', '500px'],
            content: '/changeheadimg.jsp' //iframe的url
        });
    }
    function save() {
        var sex = $(':radio:checked').val();
        var nickname = $('#nickname').val().trim();
        var birthday = $('#birthday').val();
        var statement = $('#statement').val().trim();
        alert(nickname + "-" + birthday + "-" + sex + "-" + statement);
        if(nickname==null||nickname==''){
            layer.tips("不允许为空",$('#nickname'));
            return false;
        }else{
            var flag=0;
            var headimg=$('#myheadimg').attr('src');
            if(headimg!="/img/${sessionScope.user.headimg}"){
                 flag=1;
            }else {
                flag=0;
            }
            $.ajax({
                url:'/alterinfo',
                type:'POST',
                data:{nickname:nickname,sex:sex,birthday:birthday,headimg:headimg,statement:statement,flag:flag},
                success:function (data) {
                    layer.msg(data);
                }
            });
        }

    }
</script>


</body>

</html>


