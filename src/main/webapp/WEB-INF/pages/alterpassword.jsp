<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/11/28
  Time: 17:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
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
<div class="wrapper wrapper-content" >
    <div class="row animated fadeInRight">
        <div class="col-sm-12 col-md-8 col-lg-offset-2">

            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>修改密码</h5>
                </div>
                <div class="ibox-content profile-content">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-12 col-md-2 control-label">原 密 码：</label>

                            <div class="col-sm-12 col-md-4">
                                <input type="text" id="password1" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-12 col-md-2 control-label">新 密 码：</label>

                            <div class="col-sm-12 col-md-4">
                                <input type="password" id="password2" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-md-2 control-label">验 证 码：</label>

                            <div class="col-sm-8 col-md-2">
                                <input id="yzm" type="text" readonly  class="form-control"/>
                            </div>
                            <div class="col-sm-2 col-md-2"> <button class="btn btn-danger" onclick="getyzm(this);">获取验证码</button></div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-8 col-md-3 col-md-offset-2">
                                <button type="button" class="btn btn-primary btn-block" onclick="alterpsd();">提交</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<!-- 全局js -->
<script src="/js/jquery.min.js?v=2.1.4"></script>
<script src="/js/bootstrap.min.js?v=3.3.6"></script>
<script src="/js/plugins/layer/layer.min.js"></script>

<!-- 自定义js -->
<script src="/js/content.js?v=1.0.0"></script>
<script type="text/javascript">
    function getyzm(obj) {
        $('#yzm').removeAttr('readonly');
        $(obj).attr({'disabled':'disabled'});
        $.ajax({
            type:'get',
            url:'/sendyzm',
        });
    }

    function alterpsd() {
        var password1=$('#password1').val().trim();
        var password2=$('#password2').val().trim();
        var yzm=$('#yzm').val();
        var rpassword = /^[\w]{6,12}$/;
        if(!rpassword.test(password1)){
            layer.tips("格式错误",$('#password1'));
            return false;
        }else if(!rpassword.test(password2)){
            layer.tips("格式错误",$('#password2'));
            return false;
        }
        $.ajax({
            url:'/alterpassword',
            type:"post",
            data:{beginp:password1,endp:password2,yzm:yzm},
            success:function(data){
                if(data=='errpassword'){
                    layer.tips("密码输入不正确",$('#password1'));
                }else if(data=='erryzm'){
                    layer.tips("验证码错误",$('#yzm'));
                }else if(data=='success'){
                    layer.msg("修改成功，下次登录请使用新密码");
                }
            }
        });
    }

</script>
</html>
