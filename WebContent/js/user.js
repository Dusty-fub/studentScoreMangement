function insertTopNav(userName) {
  let topNav = document.createElement("div");
  topNav.className = "northRegion";
  topNav.setAttribute("region", "north");
  topNav.setAttribute("split", "false");

  topNav.innerHTML = `
                      <span style="float: right; padding-right: 20px" class="head">
                        <span> ${userName}&nbsp;</span>
                        您好&nbsp;&nbsp;&nbsp;
                        <a href="SystemServlet?method=LoginOut" id="logout"> 安全退出 </a>
                      </span>
                      <span style="padding-left: 10px; font-size: 16px">学生信息管理系统</span>
                      `;

  document.body.appendChild(topNav);
}

function insertFooter() {
  let footerEl = document.createElement("div");
  footerEl.className = "southRegion";
  footerEl.setAttribute("region", "south");
  footerEl.setAttribute("split", "false");

  footerEl.innerHTML = `
                      <div class="footer">Copyright &copy;</div>
                        `;

  document.body.appendChild(footerEl);
}

function insertLeftSideMenu() {
  let leftSideMenuEl = document.createElement("div");
  leftSideMenuEl.setAttribute("region", "west");
  leftSideMenuEl.setAttribute("hide", "true");
  leftSideMenuEl.setAttribute("split", "false");
  leftSideMenuEl.setAttribute("title", "导航菜单");
  leftSideMenuEl.className = "westRegion";

  leftSideMenuEl.innerHTML = `
                              <div id="nav" class="easyui-accordion" fit="true" border="false"></div>
                              `;

  document.body.appendChild(leftSideMenuEl);
}

function insert(userName) {
  insertTopNav(userName);
  insertLeftSideMenu();
  insertFooter();
}
