<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>学生成绩管理系统 管理员后台</title>
    <link rel="shortcut icon" href="favicon.ico" />
    <link rel="bookmark" href="favicon.ico" />
    <link rel="stylesheet" type="text/css" href="easyui/css/default.css" />
    <link
      rel="stylesheet"
      type="text/css"
      href="easyui/themes/default/easyui.css"
    />
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
    <link rel="stylesheet" href="css/user.css" />
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/js/outlook.js"></script>
    <script type="text/javascript" src="js/adminMenu.js"></script>
  </head>
  <body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div id="mainPanel" region="center">
      <div id="tabs" class="easyui-tabs" fit="true" border="false">
        <jsp:include page="/WEB-INF/view/admin/welcome.jsp" />
      </div>
    </div>
    <script src="js/user.js"></script>
    <script>
      insert("${user.name}");
    </script>
  </body>
</html>
