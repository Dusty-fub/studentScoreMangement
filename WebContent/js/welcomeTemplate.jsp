<% request.setCharacterEncoding("utf-8") ; String role =
request.getParameter("role") ; pageContext.setAttribute("role", role); %>

<jsp:include page="/WEB-INF/view/${role}/welcome.jsp" />

<script>
  console.log("hhh");
  console.log("食虫植物：", "${role}");
</script>
