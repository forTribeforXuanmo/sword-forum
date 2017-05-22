<%--
  Created by IntelliJ IDEA.
  User: lishengzhu
  email:530735771@qq.com
  Date: 2017/5/2
  Time: 17:35
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<html>
<head>
    <title>板块管理</title>
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
    td {
        font-family: Arial;
        font-size: 14px;
        font-weight: normal;
    }
</style>
<body>
<div class="wrapper">
    <h2 class="text-center font-bold">板块管理</h2>
    <div id="toolbar">
        <button id="add" class="btn btn-primary" >
            <i class="glyphicon glyphicon-plus"></i>增加板块
        </button>
    </div>
    <table id="table"
           data-search="true"
           data-query-params="queryParams"
           data-show-refresh="true"
           data-detail-view="true"
           data-minimum-count-columns="2"
           data-show-pagination-switch="true"
           data-pagination="true"
           data-id-field="sid"
           data-page-list="[5,10,ALL]"
           data-show-footer="false"
           data-side-pagination="client"
           data-query-params-type="undefined" <%--注意如果用自定义的非limit格式去需要写上去--%>
           data-url="/manlistsections"
           data-response-handler="responseHandler">
    </table>
</div>
<script type="text/javascript">
    var $table = $('#table'),
        $add = $('#add'),
        selections = [];
    function initTable() {
        $table.bootstrapTable({
            height: getHeight(),
            columns: [
                {
                    title: 'sid',
                    field: 'sid',
                    align: 'center',
                    valign: 'middle',
                }, {
                    title:'板块名字',
                    field:'sname',
                    align:'center',
                    valign:'middle'
                },{
                    title: '详细描述',
                    field: 'sstatement',
                    align: 'center',
                    valign: 'middle'
                }, {
                    title: '简要描述',
                    field: 'sshortsm',
                    align: 'center',
                    valign: 'middle'
                }, {
                    title: '版主id',
                    field: 'smasterid',
                    align: 'center',
                    valign: 'middle'
                },{
                    title:'父级菜单',
                    field:'sparentname',
                    align:'center',
                    valign:'middle'
                }, {
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
            $table.bootstrapTable('resetView', {
                height: getHeight()
            });
        });
    }

    function responseHandler(res) {
        return res;
    }

    function operateFormatter(value, row, index) {
        return [
            '<a class="edit" href="javascript:void(0)" title="edit">',
            '<i class="glyphicon glyphicon-edit">修改</i>',
            '</a>  '
        ].join('');
    }

    function sizeSet() {
        var size = ['240px', '420px'];
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone",
            "SymbianOS", "Windows Phone",
            "iPad", "iPod"];
        var flag = 1;   //1为pc 2为安卓 3为ipad
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                if (Agents[v] == 'iPad' || Agents[v] == 'iPod') {
                    flag = 3;
                } else {
                    flag = 2;
                }
                alert(Agents[v]);
                break;
            }
        }

        if (flag == 1) {
            size = ['800px', '600px'];
        } else if (flag == 2) {
            size = ['240px', '420px'];
        } else {
            size = ['420px', '600px'];
        }
        return size;
    }
    window.operateEvents = {
        'click .edit': function (e, value, row, index) {
            var size = sizeSet();
            layer.open({
                type: 2,
                title: '修改板块信息',
                shade: 0.8,
                area: size,
                content: '/mtoeditsection?sid=' + row.sid,
                success: function (layero, index) {
                    layer.iframeAuto(index);
                }
            });
            ;
        },
    }
    function getHeight() {
        return $(window).height() - $('h1').outerHeight(true);
    }
    initTable();
    $add.on('click',function () {
        var size=sizeSet();
        layer.open({
            type:2,
            shade:0.8,
            title:'增加板块',
            area:size,
            content:'/mtoaddsection',
            success: function(layero, index) {
                layer.iframeAuto(index);
            }
        })

    })
</script>


</body>
</html>
