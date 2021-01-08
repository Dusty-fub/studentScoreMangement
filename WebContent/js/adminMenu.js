var _menus = {
  menus: [
    {
      menuid: "1",
      icon: "",
      menuname: "成绩统计分析",
      menus: [
        {
          menuid: "11",
          menuname: "考试列表",
          icon: "icon-exam",
          url: "ExamServlet?method=toExamListView",
        },
      ],
    },
    {
      menuid: "2",
      icon: "",
      menuname: "学生信息管理",
      menus: [
        {
          menuid: "21",
          menuname: "学生列表",
          icon: "icon-user-student",
          url: "StudentServlet?method=toStudentListView",
        },
      ],
    },
    {
      menuid: "3",
      icon: "",
      menuname: "教师信息管理",
      menus: [
        {
          menuid: "31",
          menuname: "教师列表",
          icon: "icon-user-teacher",
          url: "TeacherServlet?method=toTeacherListView",
        },
      ],
    },
    {
      menuid: "4",
      icon: "",
      menuname: "基础信息管理",
      menus: [
        {
          menuid: "41",
          menuname: "年级列表",
          icon: "icon-world",
          url: "GradeServlet?method=toGradeListView",
        },
        {
          menuid: "42",
          menuname: "班级列表",
          icon: "icon-house",
          url: "ClazzServlet?method=toClazzListView",
        },
        {
          menuid: "43",
          menuname: "课程列表",
          icon: "icon-book-open",
          url: "CourseServlet?method=toCourseListView",
        },
      ],
    },
    {
      menuid: "5",
      icon: "",
      menuname: "系统管理",
      menus: [
        {
          menuid: "51",
          menuname: "系统设置",
          icon: "icon-set",
          url: "SystemServlet?method=toAdminPersonalView",
        },
      ],
    },
  ],
};
