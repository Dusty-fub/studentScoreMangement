var _menus = {
  menus: [
    {
      menuid: "1",
      icon: "",
      menuname: "成绩信息",
      menus: [
        {
          menuid: "11",
          menuname: "成绩查询",
          icon: "icon-find",
          url: "StudentServlet?method=toExamStudentView",
        },
      ],
    },
    {
      menuid: "2",
      icon: "",
      menuname: "班级信息",
      menus: [
        {
          menuid: "21",
          menuname: "班级通讯录",
          icon: "icon-note",
          url: "StudentServlet?method=toStudentNoteListView",
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
          url: "StudentServlet?method=toStudentPersonalView",
        },
      ],
    },
  ],
};
