<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8" />
    <title>班级列表</title>
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
    <script src="js/list.js"></script>
    <link rel="stylesheet" href="css/list.css" />
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <script type="text/javascript">
      $(function () {
        let deleteClass = function () {
          var selectRow = $("#dataList").datagrid("getSelected");
          if (selectRow == null) {
            $.messager.alert("消息提醒", "请选择数据进行删除!", "warning");
          } else {
            var clazzid = selectRow.id;
            $.messager.confirm(
              "消息提醒",
              "将删除与班级相关的所有数据(包括学生)，确认继续？",
              function (r) {
                if (r) {
                  $.ajax({
                    type: "post",
                    url: "ClazzServlet?method=DeleteClazz",
                    data: { clazzid: clazzid },
                    success: function (msg) {
                      if (msg == "success") {
                        $.messager.alert("消息提醒", "删除成功!", "info");
                        //刷新表格
                        $("#dataList").datagrid("reload");
                      } else {
                        $.messager.alert("消息提醒", "删除失败!", "warning");
                        return;
                      }
                    },
                  });
                }
              }
            );
          }
        };
        let addClass = function () {
          $("#addDialog").dialog("open");
        };
        let initDataGridOptions = {
          title: "班级列表",
          iconCls: "icon-more", //图标
          border: true,
          collapsible: false, //是否可折叠的
          fit: true, //自动大小
          method: "post",
          url: "ClazzServlet?method=ClazzDetailList&t=" + new Date().getTime(),
          idField: "id",
          singleSelect: true,
          pagination: true, //分页控件
          rownumbers: true, //行号
          sortName: "id",
          sortOrder: "DESC",
          remoteSort: false,
          columns: [
            [
              { field: "chk", checkbox: true, width: 50 },
              { field: "id", title: "ID", width: 50, sortable: true },
              { field: "name", title: "班级名称", width: 200 },
              {
                field: "grade",
                title: "所属年级",
                width: 100,
                formatter: function (value, row, index) {
                  if (row.grade) {
                    return row.grade.name;
                  } else {
                    return value;
                  }
                },
              },
            ],
          ],
          toolbar: "#toolbar",
        };

        let selectGradeOptions = {
          width: "150",
          height: "25",
          valueField: "id",
          textField: "name",
          multiple: false, //可多选
          editable: false, //不可编辑
          method: "post",
          url: "GradeServlet?method=GradeList&t=" + new Date().getTime(),
          onChange: function (newValue, oldValue) {
            $("#dataList").datagrid("options").queryParams = {
              gradeid: newValue,
            };
            $("#dataList").datagrid("reload");
          },
        };
        var setGradeOfClassOptions = {
          valueField: "id",
          textField: "name",
          multiple: false, //可多选
          editable: false, //不可编辑
          method: "post",
          url: "GradeServlet?method=GradeList&t=" + new Date().getTime(),
          onLoadSuccess: function () {
            //默认选择第一条数据
            var data = $(this).combobox("getData");
            $(this).combobox("setValue", data[0].id);
          },
        };
        var addClassOptions = {
          title: "添加班级",
          width: 500,
          height: 400,
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
              iconCls: "icon-add",
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
                  var gradeid = $("#add_gradeList").combobox("getValue");
                  $.ajax({
                    type: "post",
                    url: "ClazzServlet?method=AddClazz",
                    data: $("#addForm").serialize(),
                    success: function (msg) {
                      if (msg == "success") {
                        $.messager.alert("消息提醒", "添加成功!", "info");
                        //关闭窗口
                        $("#addDialog").dialog("close");
                        //清空原表格数据
                        $("#add_name").textbox("setValue", "");

                        //重新刷新页面数据
                        $("#gradeList").combobox("setValue", gradeid);
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
              iconCls: "icon-reload",
              handler: function () {
                $("#add_name").textbox("setValue", "");
                //重新加载年级
                $("#add_gradeList").combobox("reload");
              },
            },
          ],
        };

        $("#dataList").datagrid(initDataGridOptions);
        $("#dataList").datagrid("getPager").pagination(paginationOptions);
        $("#gradeList").combobox(selectGradeOptions);
        $("#add_gradeList").combobox(setGradeOfClassOptions);
        $("#addDialog").dialog(addClassOptions);
        $("#delete").click(deleteClass);
        $("#add").click(addClass);

        paginationHoverTip();
      });
    </script>
  </head>
  <body>
    <!-- 数据列表 -->
    <table id="dataList" cellspacing="0" cellpadding="0"></table>

    <!-- 工具栏 -->
    <div id="toolbar">
      <div style="float: left">
        <a
          id="add"
          href="javascript:;"
          class="easyui-linkbutton"
          data-options="iconCls:'icon-add',plain:true"
        >
          添加
        </a>
      </div>
      <div style="float: left" class="datagrid-btn-separator"></div>
      <div style="float: left; margin-right: 10px">
        <a
          id="delete"
          href="javascript:;"
          class="easyui-linkbutton"
          data-options="iconCls:'icon-some-delete',plain:true"
        >
          删除
        </a>
      </div>

      <div style="margin: 0 10px 0 10px">
        年级：<input id="gradeList" class="easyui-textbox" name="grade" />
      </div>
    </div>

    <!-- 添加窗口 -->
    <div id="addDialog" style="padding: 10px">
      <form id="addForm" method="post">
        <table cellpadding="8">
          <tr>
            <td>所属年级:</td>
            <td>
              <select
                id="add_gradeList"
                style="width: 200px; height: 30px"
                name="gradeid"
              ></select>
            </td>
          </tr>
          <tr>
            <td>班级名称:</td>
            <td>
              <input
                id="add_name"
                style="width: 200px; height: 30px"
                class="easyui-textbox"
                type="text"
                name="name"
                validType="repeat_clazz['#add_gradeList']"
                data-options="required:true, missingMessage:'不能为空'"
              />
            </td>
          </tr>
        </table>
      </form>
    </div>
  </body>
</html>
