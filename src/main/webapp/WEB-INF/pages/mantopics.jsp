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
    <title>帖子管理</title>
    <link rel="shortcut icon" href="/img/favicon.ico"> <link href="/css/bootstrap.min.css" rel="stylesheet">
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

    <style type="text/css">
        td{
            font-family: Arial;
            font-size: 14px;
            font-weight: normal;
        }
    </style>
</head>
<body>
<div class="wrapper ">
    <h1 class="font-bold text-center">帖子管理</h1>
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
           data-minimum-count-columns="2"
           data-show-pagination-switch="true"
           data-pagination="true"
           data-id-field="tid"
           data-page-list="[3, 10, 50, 100, ALL]"
           data-show-footer="false"
           data-side-pagination="client"
           data-query-params-type="undefined", <%--注意如果用自定义的非limit格式去需要写上去--%>
           data-url="/manlisttopics?sid=${sid}"
           data-response-handler="responseHandler">
    </table>
</div>
<script type="text/javascript">
    var $table=$('#table'),
        $remove=$('#remove'),
        selections=[];
    function initTable(){
        $table.bootstrapTable({
            height: getHeight(),
            columns: [{
                field: 'state',
                checkbox: true,
                align: 'center',
                valign: 'middle'
            },{
                title: '帖子id',
                field: 'tid',
                align: 'center',
                valign: 'middle',
            },{
                title:'标题',
                field:'ttopic',
                align:'center',
                valign:'middle'
            },{
                title:'板块id',
                field:'tsid',
                align:'center',
                valign:'middle'
            },{
              title:'板块名称',
                field:'sname',
                align:'center',
                valign:'middle'
            },
                {
                title:'发布时间',
                field:'ttime',
                align:'center',
                valign:'middle',
                formatter:dateFormatter
            }, {
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
            },
                {
                title:'浏览量',
                field:'tclickcount',
                align:'center',
                valign:'middle'
            },{
                title:'回复量',
                field:'treplaycount',
                align:'center',
                valign:'middle'
            },{
                title:'点赞数',
                field:'tzan',
                align:'center',
                valign:'middle'
            },{
                title:'置顶',
                field:'tstaus',
                align:'center',
                valign:'middle',
                formatter: stausFormatter
            },{
                title:'上次访问时间',
                field:'tlastclickcount',
                align:'center',
                valign:'middle',
                formatter:dateFormatter
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

        $remove.click(function () {
            var ids=getIdSelections();
            $.ajax({
                url:'/mdeletetopicbatch',
                type:'post',
                data:{tids:ids},
                success:function (data) {
                    if(data=='ok'){
                        $table.bootstrapTable('remove',{
                            field:'tid',
                            values:ids
                        });
                        $remove.prop('disabled',true);
                        layer.msg("删除成功");
                    }else{
                        layer.msg("删除失败");
                    }
                }
            })

        });
        $(window).resize(function () {
            $table.bootstrapTable('resetView',{
                height:getHeight()
            });
        });
    }

    function getIdSelections() {
        return $.map($table.bootstrapTable('getSelections'),function (row) {
            return row.tid;
        });
    }
    function responseHandler(res) {
        $.each(res,function (i,row) {
            row.state=$.inArray(row.tid,selections)!=-1
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
    function headimgFormatter(value,row,index) {
        return '<img  class="img-circle" style="width: 32px;height: 32px;" src="/img/'+value+'"/>';
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
    function stausFormatter(value,row,inde) {
        return value==0?'否':'<font class="text-danger">是</font>'
    }
    function operateFormatter(value,row,index) {
        var istop='<a class="totop" href="javascript:void(0)" title="置顶"><i class="glyphicon glyphicon-arrow-up"></i></a>';
        if(row.tstaus==1) {
            istop='<a class="todown" href="javascript:void(0)" title="取消置顶"><i class="glyphicon glyphicon-arrow-down"></i></a>';
        }
        return [
            '<a class="look" href="javascript:void(0)" title="查看">',
            '<i class="glyphicon glyphicon-eye-open"></i>',
            '</a> ',
            '<a class="remove" href="javascript:void(0)" title="删除">',
            '<i class="glyphicon glyphicon-remove"></i>',
            '</a> ',
            istop
        ].join('');
    }
    window.operateEvents={
        'click .look': function (e, value, row, index) {
            location.href="/showTopicDetail/"+row.tid;
        },
        'click .remove': function (e, value, row, index) {
            $.ajax({
                type:'post',
                url:"/mdeletetopic",
                data:{tid:row.tid},
                success:function (data) {
                    if(data=='success'){
                        layer.msg("删除成功");
                        $table.bootstrapTable('remove', {
                            field: 'tid',
                            values: [row.tid]
                        });
                        $table.bootstrapTable('refresh');
                    }else {
                        layer.msg("删除失败");
                    }

                }
            })
        },
        'click .totop':function (e,value,row) {
            $.ajax({
                url:'/mtotop',
                type:'get',
                data:{tid:row.tid,sid:row.tsid},
                success:function (data) {
                    if(data=='success'){
                        layer.msg("置顶成功,目前一个版块只能有一个被置顶。");
                        $table.bootstrapTable('refresh');

                    }else {
                        layer.msg("置顶失败");
                    }
                }
            })
        },
        'click .todown':function (e,value,row) {
            $.ajax({
                url:'/mcancletotop',
                type:'get',
                data:{tid:row.tid},
                success:function (data) {
                    if(data=='success'){
                        $table.bootstrapTable('refresh');
                    }else {
                        layer.msg("置顶失败");
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
