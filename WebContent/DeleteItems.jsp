<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<body onLoad="displayResult()">
	
<%@ include file = "index.jsp" %>
<br>
</br>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete Item</title>
</head>
<body>
<center><h1>Delete Item</h1></center>
<%
	String succ = (String)request.getAttribute("Product Deleted");
	if(succ!= null){
		%>
		 <script type="text/javascript">
	    var msg = "<%=succ%>";
	    alert(msg);
	</script><%
	}
%>
<%
	if(request.getAttribute("iName")!=null)
	{
		%>
		<h3><%= request.getAttribute("iName")%></h3>
		<%
	}
%>
<form name="MyForm" action="/InsertDataWebApplication/DeleteItems" method="GET" style="font-size:15pt;">
	<table>
		<tbody><center>
			<tr>
				<h3>Search By </h3>
				<td>Item Code:</td>
					<td><input type="text" name="iCode" value="" size="20" style="font-size:12pt;"/></td>
				
			</tr>
		</center></tbody>
	</table>
	<BR>
	</BR>
		<input type="reset" value="Clear" name="clear" style="font-size:15pt; WIDTH:100PX"/> 
		<input type="submit" value="Submit" name="Deletesubmit" style="font-size:15pt; WIDTH:100PX"/>
		
		
</form>

        
</body>
</html>