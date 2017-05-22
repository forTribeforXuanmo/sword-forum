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
            <div class="form-group col-sm-12">
                <label class="col-sm-2  control-label">名 称：</label>
                <div class="col-sm-10 ">
                    <input type="text" placeholder="名 称"  id="sname" class="form-control">
                </div>
            </div>
            <div class="form-group col-sm-12">
                <label class="col-sm-2  control-label">父级菜单：</label>
                <div class="col-sm-10 ">
                    <input type="text" placeholder="父级菜单"  id="sparentname" class="form-control">
                </div>
            </div>
            <div class="form-group col-sm-12">
                <label class="col-sm-2 control-label ">详细描述：</label>
                <div class="col-sm-10 ">
                    <textarea   class="form-control" rows="6" id="sstatement"></textarea>
                </div>
            </div>
            <div class="form-group col-sm-12">
                <label class="col-sm-2 control-label ">简要描述：</label>
                <div class="col-sm-10 ">
                    <textarea  id="sshortsm" class="form-control"></textarea>
                </div>
            </div>

            <div class="form-group col-sm-12">
                <label class="col-sm-2 control-label ">版主id：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="smasterid"  />
                </div>
            </div>

        </div>
    </div>
    <div style="height: 50px"></div>
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
    $('#submit').on('click',function () {
        var sname=$('#sname').val().trim();
        var sstatement=$('#sstatement').val().trim();
        var sshortsm=$('#sshortsm').val().trim();
        var smasterid=$('#smasterid').val().trim();
        var sparentname=$('#sparentname').val().trim();
        if(sname==''||sstatement==''||sshortsm==''||sparentname==''){
            layer.msg("错误，输入有为空的值",{icon:5});
            return false;
        }else {
            $.ajax({
                url:'/maddsection',
                type:'post',
                data:{sname:sname,sstatement:sstatement,sshortsm:sshortsm,smasterid:smasterid,sparentname:sparentname},
                success:function (data) {
                    switch (data){
                        case "hasnull":
                            layer.msg("错误,存在为空的值");
                            break;
                        case "smsternotexist":
                            layer.msg("错误，没有这个版主id");
                            break;
                        case "success":
                            layer.msg("添加成功",
                                {   time:'800',
                                    end: function () {
                                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                        parent.layer.close(index);
                                    }
                                });
                            break;
                    }
                }

            });


        }
    });
    function cancle() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index);
    }
</script>
</html>
