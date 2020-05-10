<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<% request.setCharacterEncoding("euc-kr");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<%
   String del = request.getParameter("num");
%>

<h3><%=del %>번 글 삭제하기 &nbsp;<br></h3>
<form action="del_ok.jsp?num=<%=del%>" method="post">
<table border="1">
	<tr><td> 글 번호 </td>
	<td><input type="text" value="<%=del %>"></td>
   <tr><td> 비밀번호 </td><td>
      <input type="password" name="pass"></td></tr>
   <tr><td colspan=2>
      <input type="submit" value="삭제"></td></tr>
</table>
</form>

</body>
</html>