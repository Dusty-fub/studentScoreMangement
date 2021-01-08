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
