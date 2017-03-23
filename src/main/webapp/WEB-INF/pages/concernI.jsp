<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2017/3/15
  Time: 18:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的粉丝</title>
    <link rel="shortcut icon" href="/img/favicon.ico"> <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/font-awesome.css" rel="stylesheet">
    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.css">
    <script src="/js/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>

    <!-- Latest compiled and minified Locales -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="/js/plugins/layer/layer.min.js"></script>
</head>
<body>
<div class="container">
    <h1>我的粉丝</h1>
    <div id="toolbar">
        <button id="remove" class="btn btn-danger" disabled>
            <i class="glyphicon glyphicon-remove"></i>删除
        </button>
    </div>
    <table id="table"
           data-toolbar="#toolbar"
           data-search="true"
           data-query-params="queryParams"
           data-show-refresh="true"
           data-show-toggle="true"
           data-show-columns="true"
           dat-show-export="true"
           data-detail-view="true"
           data-detail-formatter="detailFormatter"
           data-minimum-count-columns="2"
           data-show-pagination-switch="true"
           data-pagination="true"
           data-id-field="conid"
           data-page-list="[3, 10, 50, 100, ALL]"
           data-show-footer="false"
           data-side-pagination="server"
           data-query-params-type="undefined", <%--注意如果用自定义的非limit格式去需要写上去--%>
           data-url="/concernI"
           data-response-handler="responseHandler">
    </table>
</div>
<script type="text/javascript">
    var $table=$('#table'),
        $remove=$('#remove'),
        selections=[];
    function initTable() {
        $table.bootstrapTable({
            height: getHeight(),
            columns: [{
                field: 'state',
                checkbox: true,
                align: 'center',
                valign: 'middle'
            },{
                title: '关注id',
                field: 'conid',
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
            }, {
                title: '性别',
                field: 'usex',
                align: 'center',
                valign: 'middle',
                formatter: sexFormatter
            }, {
                title:'个性签名',
                field:'ustatement',
                align:'center',
                valign:'middle'
            },{
                title: '等级',
                field: 'ulevel',
                align: 'center',
                valign: 'middle',
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
        $table.on('check.bs.table uncheck.bs.table ' +
            'check-all.bs.table uncheck-all.bs.table', function () {
            $remove.prop('disabled', !$table.bootstrapTable('getSelections').length);
            //保存选择的
            selections = getIdSelections();
        });
//        $table.onCheck('all.bs.table',function (e,name,args) {
//            console.log(name,args);
//        });
        $remove.click(function () {
            var ids=getIdSelections();
            $table.bootstrapTable('remove',{
                field:'conid',
                values:ids
            });
            $remove.prop('disabled',true);
        });
        $(window).resize(function () {
            $table.bootstrapTable('resetView',{
                height:getHeight()
            });
        });
    }

    function getIdSelections() {
        return $.map($table.bootstrapTable('getSelections'),function (row) {
            return row.conid;
        });
    }
    function responseHandler(res) {
        $.each(res.rows,function (i,row) {
            row.state=$.inArray(row.conid,selections)!=-1
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
            '<a class="look" href="javascript:void(0)" title="Look">',
            '<i class="glyphicon glyphicon-eye-open"></i>',
            '</a>  ',
            '<a class="remove" href="javascript:void(0)" title="Remove">',
            '<i class="glyphicon glyphicon-remove"></i>',
            '</a>'
        ].join('');
    }
    window.operateEvents={
        'click .look': function (e, value, row, index) {
            location.href="/showUser/"+row.uid;
        },
        'click .remove': function (e, value, row, index) {
            $.ajax({
                type:'post',
                url:"/deleteIConcern",
                data:{conid:row.conid},
                success:function (data) {
                    if(data=='ok'){
                        layer.msg("删除成功")
                        $table.bootstrapTable('remove', {
                            field: 'conid',
                            values: [row.conid]
                        });
                    }

                }
            })
        }
    }
    function getHeight() {
        return $(window).height()-$('h1').outerHeight(true);
    }
    initTable();

</script>


</body>
</html>

