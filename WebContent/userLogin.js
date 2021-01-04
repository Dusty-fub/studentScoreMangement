$(function () {
  //点击图片切换验证码
  $("#vcodeImg").click(function () {
    this.src = "LoginServlet?method=GetVcode&t=" + new Date().getTime();
  });

  //登录
  $("#submitBtn").click(function () {
    if ($("#radio-2").attr("checked") && "${systemInfo.forbidStudent}" == 1) {
      $.messager.alert("消息提醒", "学生暂不能登录系统！", "warning");
      return;
    }
    if ($("#radio-3").attr("checked") && "${systemInfo.forbidTeacher}" == 1) {
      $.messager.alert("消息提醒", "教师暂不能登录系统！", "warning");
      return;
    }

    var data = $("#form").serialize();
    $.ajax({
      type: "post",
      url: "LoginServlet?method=Login",
      data: data,
      dataType: "text", //返回数据类型
      success: function (msg) {
        if ("vcodeError" == msg) {
          $.messager.alert("消息提醒", "验证码错误!", "warning");
          $("#vcodeImg").click(); //切换验证码
          $("input[name='vcode']").val(""); //清空验证码输入框
        } else if ("loginError" == msg) {
          $.messager.alert("消息提醒", "用户名或密码错误!", "warning");
          $("#vcodeImg").click(); //切换验证码
          $("input[name='vcode']").val(""); //清空验证码输入框
        } else if ("admin" == msg) {
          window.location.href = "SystemServlet?method=toAdminView";
        } else if ("student" == msg) {
          window.location.href = "SystemServlet?method=toStudentView";
        } else if ("teacher" == msg) {
          window.location.href = "SystemServlet?method=toTeacherView";
        }
      },
    });
  });

  //设置复选框
  $(".skin-minimal input").iCheck({
    radioClass: "iradio-blue",
    increaseArea: "25%",
  });
});
