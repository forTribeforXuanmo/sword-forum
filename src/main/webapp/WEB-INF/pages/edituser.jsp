<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2017/4/24
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg animated bounceInLeft">
<div class="wrapper wrapper-content container">
    <div class="form-horizontal">
        <div class="row ">
            <div class="form-group col-sm-6 ">
                <label class="col-sm-4 control-label ">用户ID：</label>
                <div class="col-sm-8 ">
                    <input type="text" value="${selectUser.uid}" id="uid" readonly class="form-control views-number">
                </div>
            </div>
            <div class="form-group col-sm-6  col-sm-offset-6">
                <label class="col-sm-4  control-label">昵  称：</label>
                <div class="col-sm-8 ">
                    <input type="text" placeholder="密码" value="${selectUser.unickname}" id="unickname" class="form-control">
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">账 号：</label>
                <div class="col-sm-8 ">
                    <input type="text" value="${selectUser.uemail}" readonly class="form-control" id="uemail">
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">密 码：</label>
                <div class="col-sm-8 ">
                    <input type="text" value="${selectUser.upassword}" id="upassword" class="form-control">
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">性 别：</label>
                <div class="col-sm-8 ">
                    <select type="text"  id="usex" class="form-control">
                        <option value=0 <c:if test="${selectUser.usex eq 0}">selected</c:if> >男</option>
                        <option value=1 <c:if test="${selectUser.usex eq 1}">selected</c:if>>女</option>
                    </select>
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">生 日：</label>
                <div class="col-sm-8 ">
                    <input   class="form-control layer-date" id="ubirthday"
                            value='<fmt:formatDate value="${selectUser.ubirthday}" type="date"/>' />
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">注册时间：</label>
                <div class="col-sm-8 ">
                    <input type="text" readonly value='<fmt:formatDate value="${selectUser.ubirthday}" type="date"/>'  class="form-control"/>
                </div>
            </div>

            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">个性签名：</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="ustatement" value="${selectUser.ustatement}" />
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">被封天数：</label>
                <div class="col-sm-8">
                    <input type="tel"  class="form-control " id="ustate" value="${selectUser.ustate}" />
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">等 级：</label>
                <div class="col-sm-8">
                    <input type="tel"  readonly class="form-control " id="ulevel" value="${selectUser.ulevel}" />
                </div>
            </div>
            <div class="form-group col-sm-6">
                <label class="col-sm-4 control-label ">积 分：</label>
                <div class="col-sm-8">
                    <input type="tel" class="form-control " id="upoint" value="${selectUser.upoint}" />
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
<script src="/js/jquery.min.js?v=2.1.4"></script>
<script src="/js/bootstrap.min.js?v=3.3.6"></script>
<!--layer插件-->
<script src="/js/plugins/layer/layer.min.js"></script>
<!-- layerDate plugin javascript -->
<script src="/js/plugins/layer/laydate/laydate.js"></script>



<script type="text/javascript">
    //日期范围限制
    var start = {
        elem: '#ubirthday',
        format: 'YYYY-MM-DD',
        max: laydate.now(), //最大日期
        istime: true,
        istoday: false,
        start: '<fmt:formatDate value="${selectUser.ubirthday}" type="date" />',
        choose: function (datas) {

        }
    };
    laydate(start);

    $('#submit').on('click',function () {
        var nickname=$('#unickname').val().trim();
        var password=$('#upassword').val().trim();
        var sex=$('#usex').val();
        var birthday=$('#ubirthday').val();
        var statement=$('#ustatement').val();
        var state=$('#ustate').val();
        var point=$('#upoint').val();
        var rpassword = /^[\w]{6,12}$/;
        if(nickname==''||password==''||sex==''||birthday==''||statement==''||state==''||point==''){
            layer.msg("错误，输入有为空的值",{icon:5});
            return false;
        }else {
            if(!rpassword.test(password)){
                layer.tips("6-12位字母、数字、下划线", $('#upassword'));
                return false;
            }else if(state<-1){
                layer.tips("不能小于最小值-1",$('#ustate'));
            }else if(point<0){
                layer.tips("积分不能为负数",$('#upoint'));
            }else {
                $.ajax({
                    url:"/meditupdateuser",
                    type:'post',
                    data:{uid:'${selectUser.uid}',uemail:$('#uemail').val(),unickname:nickname,
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



        alert(nickname+" "+ password+" "+sex+" "+birthday+" "+statement+" "+state+" "+point);
    });
    function cancle() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index);
    }
</script>
</html>
