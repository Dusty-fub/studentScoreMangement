<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8" />
    <title>课程列表</title>
    <link
      rel="stylesheet"
      type="text/css"
      href="easyui/themes/default/easyui.css"
    />
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script src="easyui/themes/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="easyui/js/validateExtends.js"></script>
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <script src="js/list.js"></script>
    <script type="text/javascript">
      $(function () {
        let initDataGridOptions = {
          iconCls: "icon-more",
          border: true,
          collapsible: false,
          fit: true,
          method: "post",
          idField: "id",
          singleSelect: false,
          pagination: false,
          rownumbers: true,
          sortName: "id",
          sortOrder: "DESC",
          remoteSort: false,
          title: "课程列表",
          url: "CourseServlet?method=CourseList&t=" + new Date().getTime(),
          columns: [
            [
              { field: "chk", checkbox: true, width: 50 },
              { field: "id", title: "ID", width: 50, sortable: true },
              { field: "name", title: "课程名称", width: 200, sortable: true },
            ],
          ],
          toolbar: "#toolbar",
        };

        let showAddCoursePanel = function () {
          $("#addDialog").dialog("open");
        };

        function confirmDeleteCourse(result) {
          if (result) {
            let ajaxs = $("#dataList")
              .datagrid("getChecked")
              .map((course) => {
                return $.ajax({
                  type: "post",
                  url: "CourseServlet?method=DeleteCourse",
                  data: { courseid: course.id },
                });
              });

            $.when(...ajaxs).done(function (msg) {
              let batchDeleteMsg = true;
              if (msg.length) {
                for (let i = 0; i < msg.length - 1; i++) {
                  if (msg[i] !== "success") {
                    batchDeleteMsg = false;
                  }
                }
              } else {
                batchDeleteMsg = false;
              }

              if (msg == "success") {
                $.messager.alert("消息提醒", "删除成功!", "info");
                $("#dataList").datagrid("reload");
              } else if (batchDeleteMsg) {
                $.messager.alert("消息提醒", "删除成功!", "info");
                $("#dataList").datagrid("reload");
              } else {
                $.messager.alert("消息提醒", "删除失败!", "warning");
                return;
              }
            });
          }
        }

        let removeCourse = function () {
          var selectRow = $("#dataList").datagrid("getSelected");
          if (selectRow == null) {
            $.messager.alert("消息提醒", "请选择数据进行删除!", "warning");
          } else {
            $.messager.confirm(
              "消息提醒",
              "将删除与课程相关的所有数据，确认继续？",
              confirmDeleteCourse
            );
          }
        };

        let addCourseOptions = {
          title: "添加课程",
          width: 450,
          height: 250,
          iconCls: "icon-add",
          modal: true,
          collapsible: false,
          minimizable: false,
          maximizable: false,
          draggable: true,
          closed: true,
          buttons: [
            {
              text: "添加",
              plain: true,
              iconCls: "icon-book-add",
              handler: function () {
                var validate = $("#addForm").form("validate");
                if (!validate) {
                  $.messager.alert(
                    "消息提醒",
                    "请检查你输入的数据!",
                    "warning"
                  );
                  return;
                } else {
                  $.ajax({
                    type: "post",
                    url: "CourseServlet?method=AddCourse",
                    data: $("#addForm").serialize(),
                    success: function (msg) {
                      if (msg == "success") {
                        $.messager.alert("消息提醒", "添加成功!", "info");
                        //关闭窗口
                        $("#addDialog").dialog("close");
                        //清空原表格数据
                        $("#add_name").textbox("setValue", "");
                        //刷新
                        $("#dataList").datagrid("reload");
                      } else {
                        $.messager.alert("消息提醒", "添加失败!", "warning");
                        return;
                      }
                    },
                  });
                }
              },
            },
            {
              text: "重置",
              plain: true,
              iconCls: "icon-book-reset",
              handler: function () {
                $("#add_name").textbox("setValue", "");
              },
            },
          ],
        };

        $("#dataList").datagrid(initDataGridOptions);
        $("#add").click(showAddCoursePanel);
        $("#addDialog").dialog(addCourseOptions);
        $("#delete").click(removeCourse);
      });
    </script>
  </head>
  <body>
    <table id="dataList" cellspacing="0" cellpadding="0"></table>

    <div id="toolbar">
      <div style="float: left">
        <a
          id="add"
          href="javascript:;"
          class="easyui-linkbutton"
          data-options="iconCls:'icon-add',plain:true"
          >添加</a
        >
      </div>
      <div style="float: left" class="datagrid-btn-separator"></div>
      <div>
        <a
          id="delete"
          href="javascript:;"
          class="easyui-linkbutton"
          data-options="iconCls:'icon-some-delete',plain:true"
        >
          删除
        </a>
      </div>
    </div>

    <!-- 添加数据窗口 -->
    <div id="addDialog" style="padding: 10px">
      <form id="addForm" method="post">
        <table cellpadding="8">
          <tr>
            <td>课程名称:</td>
            <td>
              <input
                id="add_name"
                style="width: 200px; height: 30px"
                class="easyui-textbox"
                type="text"
                name="name"
                data-options="required:true, validType:'repeat_course', missingMessage:'不能为空'"
              />
            </td>
          </tr>
        </table>
      </form>
    </div>
  </body>
</html>
