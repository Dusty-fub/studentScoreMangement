let paginationOptions = {
  pageSize: 10,
  pageList: [10, 20, 30, 50, 100],
  beforePageText: "第",
  afterPageText: "页    共 {pages} 页",
  displayMsg: "当前显示 {from} - {to} 条记录   共 {total} 条记录",
};

function paginationHoverTip() {
  $(".pagination-page-list").prop("title", "每页显示记录条数");
  $(".datagrid-pager.pagination table td:nth-child(3) a").prop("title", "首页");
  $(".datagrid-pager.pagination table td:nth-child(4) a").prop(
    "title",
    "上一页"
  );
  $(".datagrid-pager.pagination table td:nth-child(10) a").prop(
    "title",
    "下一页"
  );
  $(".datagrid-pager.pagination table td:nth-child(11) a").prop(
    "title",
    "末页"
  );
  $(".datagrid-pager.pagination table td:last-child a").prop("title", "刷新");
}
