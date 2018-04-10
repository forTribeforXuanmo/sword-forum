<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2017/3/15
  Time: 18:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<html>
<head>
    <title>用户管理</title>
    <link rel="shortcut icon" href="/img/favicon.ico">
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/font-awesome.css" rel="stylesheet">
    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="/css/plugins/bootstrap-table/bootstrap-table.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script src="/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>

    <!-- Latest compiled and minified Locales -->
    <script src="/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="/js/plugins/layer/layer.min.js"></script>
    <!-- layer  -->
    <script src="/js/plugins/layer/layer.min.js"></script>
</head>
    <style type="text/css">
        td{
            font-family: Arial;
            font-size: 14px;
            font-weight: normal;
        }
    </style>
<body >
<div class="wrapper">
    <h2 class="text-center font-bold">用户管理</h2>
    <div id="toolbar">
        <button id="add" class="btn btn-primary" >
            <i class="glyphicon glyphicon-plus"></i>增加用户
        </button>
    </div>
    <input type="hidden" id="hiddenuser" />
    <table id="table"
           data-toolbar="#toolbar"
           data-search="true"
           data-query-params="queryParams"
           data-show-refresh="true"
           data-detail-view="true"
           data-detail-formatter="detailFormatter"
           data-minimum-count-columns="2"
           data-show-pagination-switch="true"
           data-pagination="true"
           data-id-field="uid"
           data-page-list="[10, 50, 100, ALL]"
           data-show-footer="false"
           data-side-pagination="client"
           data-query-params-type="undefined" <%--注意如果用自定义的非limit格式去需要写上去--%>
           data-url="/manlistusers"
           data-response-handler="responseHandler">
    </table>
</div>
<script type="text/javascript">
    var $table=$('#table'),
        $add=$('#add'),
        selections=[]
    function initTable() {
        $table.bootstrapTable({
            height: getHeight(),
            columns: [{
                field: 'state',
                checkbox: true,
                align: 'center',
                valign: 'middle'
            },{
                title: 'id',
                field: 'uid',
                align: 'center',
                valign: 'middle',
            },{
                title: '头像',
                field: 'headimg',
                align: 'center',
                valign: 'middle',
                formatter: headimgFormatter
            }, {
                title: '账号',
                field: 'uemail',
                align: 'center',
                valign: 'middle',

            }, {
                title: '昵称',
                field: 'unickname',
                align: 'center',
                valign: 'middle'
            },{
                title:'密码',
                field:'upassword'
            } ,{
                title: '性别',
                field: 'usex',
                align: 'center',
                valign: 'middle',
                formatter: sexFormatter
            }, {
                title:'生日',
                field:'ubirthday',
                align:'center',
                valign:'middle',
                formatter:dateFormatter
            },{
                title:'个性签名',
                field:'ustatement',
                align:'center',
                valign:'middle'
            },{
                title:'注册时间',
                field:'uregtime',
                align:'center',
                valign:'middle',
                formatter:dateFormatter
            },{
                title:'被封天数',
                field:'ustate',
                align:'center',
                valign:'middle'
            },{
                title: '等级',
                field: 'ulevel',
                align: 'center',
                valign: 'middle',
            }, {
                title:'积分',
                field:'upoint',
                align:'center',
                valign:'middle'
            },{
                title: '操作',
                field: 'operate',
                align: 'center',
                events: operateEvents,
                formatter: operateFormatter
            }]
        });
        setTimeout(function () {
            $table.bootstrapTable('resetView');
        }, 200);


        $(window).resize(function () {
            $table.bootstrapTable('resetView',{
                height:getHeight()
            });
        });
    }

    function getIdSelections() {
        return $.map($table.bootstrapTable('getSelections'),function (row) {
            return row.uid;
        });
    }

    function responseHandler(res) {
        $.each(res,function (i,row) {
            row.state=$.inArray(row.uid,selections)!=-1
        });
        return res;
    }
    function queryParams(params) {
        var temp={
            pagenumber:params.pageNumber,
            pagesize: params.pageSize,
            search:params.searchText
        };
        return temp;
    }
    function detailFormatter(index,row) {
        var html=[];
        $.each(row,function (key,value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
        });
        return html.join('');
    }
    function headimgFormatter(value,row,index) {
        return '<img  class="img-circle" style="width: 32px;height: 32px;" src="/img/'+value+'"/>';
    }
    function sexFormatter(value) {
        return value==0?'男':'女';
    }
    function operateFormatter(value,row,index) {
        return [
            '<a class="edit" href="javascript:void(0)" title="edit">',
            '<i class="glyphicon glyphicon-edit">修改</i>',
            '</a>  '
        ].join('');
    }

    function dateFormatter(value) {
       var date=new Date(value);
        y = date.getFullYear(),
        m = date.getMonth() + 1,
        d = date.getDate();
        return y + "-" + (m < 10 ? "0" + m : m) + "-" + (d < 10 ? "0" + d : d);
    }



    function sizeSet() {
        var size=['240px','420px'];
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone",
            "SymbianOS", "Windows Phone",
            "iPad", "iPod"];
        var flag =1;   //1为pc 2为安卓 3为ipad
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                if(Agents[v]=='iPad'||Agents[v]=='iPod'){
                    flag=3;
                }else {
                    flag=2;
                }
                alert(Agents[v]);
                break;
            }
        }

        if(flag==1){
            size=['900px','500px'];
        }else if(flag==2){
            size=['240px','420px'];
        }else {
            size=['420px','600px'];
        }
        return size;
    }

    window.operateEvents={
        'click .edit': function (e, value, row, index) {
            var size=sizeSet();
           layer.open({
                type:2,
                title:'修改用户信息',
                shade: 0.8,
                area: size,
                content: '/mtoedituser?uid='+row.uid,
                success: function(layero, index) {
                   layer.iframeAuto(index);
               }
            });
           ;
        },
    }
    function getHeight() {
        return $(window).height()-$('h1').outerHeight(true);
    }
    initTable();
    $add.on('click',function () {
        var size=sizeSet();
        layer.open({
            type:2,
            shade:0.8,
            title:'增加用户',
            area:size,
            content:'/mtoadduser',
            success: function(layero, index) {
                layer.iframeAuto(index);
            }
        })

    })
</script>


</body>
</html>
