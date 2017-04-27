<%--
  Created by IntelliJ IDEA.
  User: lishengzhu
  email:530735771@qq.com
  Date: 2017/4/27
  Time: 11:16
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <title> 增加用户</title>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <link href="${ctx}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx}/css/font-awesome.css" rel="stylesheet">
    <link href="${ctx}/css/animate.css" rel="stylesheet">
    <link href="${ctx}/css/style.css" rel="stylesheet">
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/bootstrap.min.js"></script>
    <!--layer插件-->
    <script src="${ctx}/js/plugins/layer/layer.min.js"></script>
    <!-- layerDate plugin javascript -->
    <script src="${ctx}/js/plugins/layer/laydate/laydate.js"></script>

</head>
<body class="gray-bg animated bounceInLeft">
<div class="wrapper wrapper-content container">
    <div class="form-horizontal">
        <div class="row">
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">账 号：</label>
                <div class="col-sm-8 ">
                    <input type="text"  class="form-control" id="uemail">
                </div>
            </div>

            <div class="form-group col-sm-6  ">
                <label class="col-sm-4  control-label">昵  称：</label>
                <div class="col-sm-8 ">
                    <input type="text"  id="unickname" class="form-control">
                </div>
            </div>

            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">密 码：</label>
                <div class="col-sm-8 ">
                    <input type="text"  id="upassword" class="form-control">
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">性 别：</label>
                <div class="col-sm-8 ">
                    <select type="text"  id="usex" class="form-control">
                        <option value=0 >男</option>
                        <option value=1 >女</option>
                    </select>
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">生 日：</label>
                <div class="col-sm-8 ">
                    <input   class="form-control layer-date" id="ubirthday" type="date"/>
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">个性签名：</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="ustatement"  />
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">被封天数:</label>
                <div class="col-sm-8">
                    <input type="tel"  class="form-control " id="ustate" />
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">积 分：</label>
                <div class="col-sm-8">
                    <input type="tel" class="form-control " id="upoint"  />
                </div>
            </div>
        </div>
    </div>

    <div class="row "style="margin-top: 30px;padding:5px 2px 5px 2px">
        <div class=" col-sm-6">
            <button class="btn btn-sm btn-default  btn-block "  onclick="cancle();" type="button">取 消</button>
        </div>
        <div class=" col-sm-6">
            <button class="btn btn-sm btn-primary btn-block " id="submit" type="button">确 定</button>
        </div>
    </div>

</div>
</body>

</html>
<script type="text/javascript">
    var start = {
        elem: '#ubirthday',
        format: 'YYYY-MM-DD',
        max: laydate.now(), //最大日期
        istime: true,
        istoday: true,
        choose: function (datas) {
        }
    };
    laydate(start);

    $('#submit').on('click',function () {
        var nickname=$('#unickname').val().trim();
        var email=$('#uemail').val().trim();
        var password=$('#upassword').val().trim();
        var sex=$('#usex').val();
        var birthday=$('#ubirthday').val();
        var statement=$('#ustatement').val();
        var state=$('#ustate').val();
        var point=$('#upoint').val();
        var rpassword = /^[\w]{6,12}$/;
        var remail = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
        if(email==''||nickname==''||password==''||sex==''||birthday==''||statement==''||state==''||point==''){
            layer.msg("错误，输入有为空的值",{icon:5});
            return false;
        }else {
            if(!rpassword.test(password)){
                layer.tips("6-12位字母、数字、下划线", $('#upassword'));
                return false;
            }else if(!remail.test(email)){
                layer.tips("邮箱格式不对",$("#uemail"));
            }else if(state<-1){
                layer.tips("不能小于最小值-1",$('#ustate'));
            }else if(point<0){
                layer.tips("积分不能为负数",$('#upoint'));
            }else {
                $.ajax({
                    url:"/madduser",
                    type:'post',
                    data:{uemail:email,unickname:nickname,
                        upassword:password,usex:sex,ubirthday:birthday,ustatement:statement,
                        ustate:state,upoint:point
                    },
                    success:function (data) {
                        if(data=='success'){
                            layer.msg("修改成功",
                                {   time:'800',
                                    end: function () {
                                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                        parent.layer.close(index);
                                    }
                                });
                        }else if(data=='busy'){
                            layer.msg("系统繁忙");
                        } else if(data=='has'){
                            layer.tips("该账号已被注册",$('#uemail'));
                        }else if(data=='sessionout'){
                            layer.msg('SESSION失效了',
                                {   time:'1000',
                                    end:function () {
                                        location.href="/login2.html";
                                    }
                                });
                        }else {
                            layer.msg("出错了");
                        }

                    }

                })
            }
        }
    });
    function cancle() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index);
    }
</script>