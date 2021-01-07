function insertPage(schoolName, notice) {
  let welcome = document.querySelector(".welcomeHtmlMountEl");
  let noticePart;
  welcome.title = "欢迎使用";
  welcome.style["padding"] = "20px";
  welcome.style["overflow"] = "hidden";
  welcome.style["color"] = "#d2e0f2";

  if (arguments.length === 1) {
    noticePart = `<h2>系统环境</h2>
				      <p>系统环境：Windows</p>
				      <p>开发工具：Eclipse</p>
				      <p>Java版本：JDK 1.8</p>
				      <p>服务器：tomcat 9.0</p>
				      <p>数据库：MySQL 5.5</p>
				      <p>
				        系统采用技术： Servlet+Jsp+Jdbc+dbutils+EasyUI+jQuery+Ajax+面向接口编程
				      </p>`;
  } else {
    noticePart = `<p style="font-size: 18px">最新通知：</p>
				      <p style="width: 500px; font-size: 18px">${notice}</p>`;
  }

  welcome.innerHTML = ` 
				      <p style="font-size: 50px; line-height: 60px; height: 60px">
				        ${schoolName}
				      </p>
				      <p style="font-size: 25px; line-height: 30px; height: 30px">
				        欢迎使用学生成绩管理系统
				      </p>
				      <hr />
				      ${noticePart}
						`;
}
