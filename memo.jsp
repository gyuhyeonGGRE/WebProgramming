<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import= "java.util.Calendar" %>
<body>
<%!
	Calendar now=Calendar.getInstance();
	int c_day=now.get(Calendar.DATE); 
	int w_day=0;
%>
	<%
		if ((session.getAttribute("id") == null)) {
			/* memberLoginForm.jsp 에서 저장한 세션 값 */
			out.println("<script>");
			out.println("location.href='memberLoginForm.jsp'");
			out.println("</script>");
		}
	%>
	<form action="memo_ok.jsp" method="post">
		<table border=1 align="center">
			<tr>
				<td colspan=5 align=center width="650px">한 줄 메모장</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input name="name" type="text"
					VALUE="<%=session.getAttribute("id")%>"></td>
				<!-- 로그인하고 나면 이곳에서 이름 값에 값을 넣어줌 -->
				<td>비밀번호</td>
				<td><input name="pass" type="password"></td>
				<td rowspan=2><input value="저장하기" type="submit"></td>
			</tr>
			<tr>
				<td>내 용</td>
				<td colspan=3><input name="title" type="text" size="70"></td>
		</table>
	</form>
	<br>
	<%
		request.setCharacterEncoding("euc-kr");
		int i = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2=null;
		ResultSet rs = null;
		ResultSet rs2=null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, "kbs123", "pass123");
			// 여러 SQL  사용하려면 이 이하부터 다시 추가 하여 사용하면 됨.

			pstmt = conn.prepareStatement("SELECT * FROM memo_Test where name!='admin'order by indate desc");
			rs = pstmt.executeQuery();
			pstmt2 = conn.prepareStatement("SELECT * FROM memo_Test where name='admin'order by indate desc");
			rs2 = pstmt2.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	%>
	<%
		
		Statement stmt1=null;
		stmt1=conn.createStatement();
		String query1 = "select count(*)from memo_Test";
		ResultSet results = stmt1.executeQuery(query1);
		results.next();
		int res = results.getInt(1);
		
		Statement stmt2=null;
		stmt2=conn.createStatement();
		String query2 = "select * from memo_Test order by indate desc";
		ResultSet result2 = stmt1.executeQuery(query2);
		result2.next();
		String write_d="190504";
		if(result2.isBeforeFirst())
			write_d=result2.getString("indate").substring(8, 10);
		w_day = Integer.parseInt(write_d);
	%>
	<table border="1" cellspacing="1" align="center">
		<tr>
			<td colspan=5 align=center>총 <%=res %>개의 글이 있습니다.</td>
		</tr>
		<%
			while (i < 3) {
				if (rs2.next()) {
		%>
		<tr>
			<td width="40px"><%=rs2.getString(1)%></td>
			<td width="100px"><%=rs2.getString(2)%>
			<%if(w_day+2> c_day ){ %>
			<img src="new.png" width=16 height=16>
			<%} %></td>
			<td width="300px"><%=rs2.getString(3)%> </td>
			<td width="90px"><%=(rs2.getString("indate")).substring(0, 10)%></td>
			<%
				if (session.getAttribute("id").equals("admin")) {
			%>
			<td width="40px"><a
				href="memo_Delete.jsp?num=<%=rs2.getString(1)%>">삭제</a></td>
			<%
				}}
				i++;

			}
			%>
		</tr>
		<%
			while (rs.next()) {
		%>
		<tr>
			<td width="40px"><%=rs.getString(1)%></td>
			<td width="100px"><%=rs.getString(2)%>
			<%if(w_day+2> c_day ){ %>
			<img src="new.png" width=16 height=16>
			<%} %></td>
			<td width="300px"><%=rs.getString(3)%></td>
			<td width="90px"><%=(rs.getString("indate")).substring(0, 10)%></td>
			<%	if(session.getAttribute("id").equals("admin"))	{%>
					<td width="40px"><a href="memo_Delete.jsp?num=<%=rs.getString(1)%>">삭제</a></td>
<%       } %>
		</tr>
		<%} %>
		
</table>
</body>
