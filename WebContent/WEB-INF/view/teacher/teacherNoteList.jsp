<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8" />
    <title>教师通讯录</title>
    <link
      rel="stylesheet"
      type="text/css"
      href="easyui/themes/default/easyui.css"
    />
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" href="css/list.css" />
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/js/validateExtends.js"></script>
    <script src="easyui/themes/locale/easyui-lang-zh_CN.js"></script>
    <script src="js/list.js"></script>
    <script type="text/javascript">
      $(function () {
        function teacherPanelBeforeOpen() {
          var selectRow = $("#dataList").datagrid("getSelected");
          //设置值
          $("#edit_number").textbox("setValue", selectRow.number);
          $("#edit_name").textbox("setValue", selectRow.name);
          $("#edit_sex").textbox("setValue", selectRow.sex);
          $("#edit_phone").textbox("setValue", selectRow.phone);
          $("#edit_qq").textbox("setValue", selectRow.qq);
          $("#edit_photo").attr(
            "src",
            "PhotoServlet?method=GetPhoto&type=3&number=" + selectRow.number
          );

          var courseList = selectRow.courseList;

          for (var i = 0; i < courseList.length; i++) {
            var gradeId = courseList[i].grade.id;
            var gradeName = courseList[i].grade.name;
            var clazzId = courseList[i].clazz.id;
            var clazzName = courseList[i].clazz.name;
            var courseId = courseList[i].course.id;
            var courseName = courseList[i].course.name;
            //添加到表格显示
            var tr = $("<tr class='chooseTr'><td>课程:</td></tr>");

            var gradeTd = $("<td></td>");
            var gradeInput = $(
              "<input style='width: 200px; height: 30px;' data-options='readonly: true' class='easyui-textbox' name='gradeid' />"
            )
              .val(gradeName)
              .attr("gradeId", gradeId);
            $(gradeInput).appendTo(gradeTd);
            $(gradeTd).appendTo(tr);

            var clazzTd = $("<td></td>");
            var clazzInput = $(
              "<input style='width: 200px; height: 30px;' data-options='readonly: true' class='easyui-textbox' name='clazzid' />"
            )
              .val(clazzName)
              .attr("clazzId", clazzId);
            $(clazzInput).appendTo(clazzTd);
            $(clazzTd).appendTo(tr);

            var courseTd = $("<td></td>");
            var courseInput = $(
              "<input style='width: 200px; height: 30px;' data-options='readonly: true' class='easyui-textbox' name='courseid' />"
            )
              .val(courseName)
              .attr("courseId", courseId);
            $(courseInput).appendTo(courseTd);
            $(courseTd).appendTo(tr);

            $(tr).appendTo(table);

            //解析
            $.parser.parse($(table).find(".chooseTr :last"));
          }
        }
        function teacherPanelClose() {
          $("#edit_name").textbox("setValue", "");
          $("#edit_phone").textbox("setValue", "");
          $("#edit_qq").textbox("setValue", "");
          $(table).find(".chooseTr").remove();
        }

        var table;

        let initDataGridOptions = {
          title: "教师列表",
          url: "TeacherServlet?method=TeacherList&t=" + new Date().getTime(),
          pagination: true,
          singleSelect: true, //是否单选
          columns: [
            [
              { field: "chk", checkbox: true, width: 50 },
              { field: "id", title: "ID", width: 50, sortable: true },
              { field: "number", title: "工号", width: 150, sortable: true },
              { field: "name", title: "姓名", width: 150 },
              { field: "sex", title: "性别", width: 100 },
              { field: "phone", title: "电话", width: 150 },
              { field: "qq", title: "QQ", width: 150 },
              {
                field: "courseList",
                title: "课程",
                width: 500,
                formatter: function (value, row, index) {
                  if (row.courseList) {
                    var courseList = row.courseList;
                    var course = "";
                    for (var i = 0; i < courseList.length; i++) {
                      var gradeName = courseList[i].grade.name;
                      var clazzName = courseList[i].clazz.name;
                      var courseName = courseList[i].course.name;
                      course +=
                        "[" +
                        gradeName +
                        " " +
                        clazzName +
                        " " +
                        courseName +
                        "] &nbsp;&nbsp;&nbsp;";
                    }
                    return course;
                  } else {
                    return value;
                  }
                },
              },
            ],
          ],
          toolbar: [
            {
              text: "查看",
              iconCls: "icon-zoom-in",
              handler: function () {
                table = $("#editTable");
                var selectRow = $("#dataList").datagrid("getSelected");
                if (selectRow == null) {
                  $.messager.alert("消息提醒", "请选择一个老师", "warning");
                } else {
                  $("#editDialog").dialog("open");
                }
              },
            },
          ],
        };

        let viewTeacherInfoOptions = {
          title: "教师信息",
          width: 850,
          height: 550,
          iconCls: "icon-man",
          modal: true,
          collapsible: false,
          minimizable: false,
          maximizable: false,
          draggable: true,
          closed: true,
          onBeforeOpen: teacherPanelBeforeOpen,
          onClose: teacherPanelClose,
        };

        $("#dataList").datagrid(mixinDataGridOptions(initDataGridOptions));

        $("#dataList").datagrid("getPager").pagination(paginationOptions);

        $("#editDialog").dialog(viewTeacherInfoOptions);

        paginationHoverTip();
      });
    </script>
  </head>
  <body>
    <!-- 数据列表 -->
    <table id="dataList" cellspacing="0" cellpadding="0"></table>

    <!-- 查看窗口 -->
    <div id="editDialog" style="padding: 10px">
      <div class="viewTeacherPhoto">
        <img
          id="edit_photo"
          alt="照片"
          style="max-height: 200px"
          title="照片"
          src=""
        />
      </div>
      <form id="editForm" method="post">
        <table
          id="editTable"
          border="0"
          style="width: 800px; table-layout: fixed"
          cellpadding="6"
        >
          <tr>
            <td style="width: 40px">工号:</td>
            <td colspan="3">
              <input
                id="edit_number"
                data-options="readonly: true"
                class="easyui-textbox"
                style="width: 200px; height: 30px"
                type="text"
                name="number"
              />
            </td>
            <td style="width: 80px"></td>
          </tr>
          <tr>
            <td>姓名:</td>
            <td>
              <input
                id="edit_name"
                style="width: 200px; height: 30px"
                class="easyui-textbox"
                type="text"
                name="name"
                data-options="readonly: true"
              />
            </td>
          </tr>
          <tr>
            <td>性别:</td>
            <td>
              <input
                id="edit_sex"
                style="width: 200px; height: 30px"
                class="easyui-textbox"
                data-options="readonly:true"
                type="text"
                name="sex"
              />
            </td>
          </tr>
          <tr>
            <td>电话:</td>
            <td>
              <input
                id="edit_phone"
                style="width: 200px; height: 30px"
                class="easyui-textbox"
                type="text"
                name="phone"
                data-options="readonly: true"
              />
            </td>
          </tr>
          <tr>
            <td>QQ:</td>
            <td colspan="4">
              <input
                id="edit_qq"
                style="width: 200px; height: 30px"
                class="easyui-textbox"
                type="text"
                name="qq"
                data-options="readonly: true"
              />
            </td>
          </tr>
        </table>
      </form>
    </div>
  </body>
</html>
