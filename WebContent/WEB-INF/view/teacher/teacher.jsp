<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>教师端|学生信息管理系统</title>
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

    <script type="text/javascript">
      var _menus = {
        menus: [
          {
            menuid: "1",
            icon: "",
            menuname: "教学管理",
            menus: [
              {
                menuid: "11",
                menuname: "成绩登记",
                icon: "icon-pencil-add",
                url: "TeacherServlet?method=toExamTeacherView",
              },
            ],
          },
          {
            menuid: "2",
            icon: "",
            menuname: "教师信息",
            menus: [
              {
                menuid: "21",
                menuname: "教师通讯录",
                icon: "icon-note",
                url: "TeacherServlet?method=toTeacherNoteListView",
              },
            ],
          },
          {
            menuid: "3",
            icon: "",
            menuname: "系统管理",
            menus: [
              {
                menuid: "31",
                menuname: "个人信息",
                icon: "icon-password",
                url: "TeacherServlet?method=toTeacherPersonalView",
              },
            ],
          },
        ],
      };
    </script>
  </head>
  <body class="easyui-layout" style="overflow-y: hidden" scroll="no">
    <div class="northRegion" region="north" split="false"></div>

    <div region="south" split="false" class="southRegion">
      <div class="footer">Copyright &copy;</div>
    </div>
    <div
      region="west"
      hide="true"
      split="false"
      title="导航菜单"
      class="westRegion"
    >
      <div id="nav" class="easyui-accordion" fit="true" border="false"></div>
    </div>
    <div id="mainPanle" region="center">
      <div id="tabs" class="easyui-tabs" fit="true" border="false">
        <jsp:include page="/WEB-INF/view/teacher/welcome.jsp" />
      </div>
    </div>

    <iframe width="0" height="0" src="refresh.jsp"></iframe>
    <script src="js/user.js"></script>
    <script>
      insertTopNav("${user.name}");
    </script>
  </body>
</html>
