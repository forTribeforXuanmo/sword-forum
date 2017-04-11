<%@ page import="com.sword.model.Manage" %><%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2017/4/11
  Time: 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>后台管理</title>
</head>
<body>
后台管理
${sessionScope.admin}
名字:${sessionScope.admin.mname}
密码:${sessionScope.admin.mpassword}
mrole:${sessionScope.admin.mrole}
email:${sessionScope.admin.memail}
</body>
</html>
