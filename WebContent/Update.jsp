<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Item</title>

<%@ include file = "index.jsp" %>
<br>
</head>

<%
	
	String Empty = (String)request.getAttribute("BarCodeEmpty");
	String NotExist = (String)request.getAttribute("NotExist");
	String succ = (String)request.getAttribute("Successfull");
	if(Empty!=null){
	%>
		 <script type="text/javascript">
	    var msg = "Enter Barcode";
	    alert(msg);
	</script><%
	}
	
	if(NotExist!=null){
		%>
			 <script type="text/javascript">
		    var msg = "Item Not Exist";
		    alert(msg);
		</script><%
		}
	
	if(succ!= null){
		%>
		 <script type="text/javascript">
	    var msg = "<%=succ%>";
	    alert(msg);
	</script><%
	}
%>



<body onload="document.MyForm.iCode.focus();" onload="ClearForm()">
	<form name="MyForm" action="/InsertDataWebApplication/Update" method="POST" style="font-size:15pt;" >
		<table border="1 solid black" cellpadding="10">
			<tbody>
				<tr>
					<td>Item Code:</td>
					<td><input type="text" id="iCode" name="iCode" value="" size="20" style="font-size:12pt; border: 1px solid RED"/></td>
					<td><input type="Submit" name="search" style="font-size:30px"/></td>
					<td><input type="reset" value="Clear" name="clear" style="font-size:15pt; WIDTH:100PX"/></td> 
				</tr>
			</tbody>
		</table>
	</form>
<br>${Department}
	<form name="MyForm2" action="/InsertDataWebApplication/Update" method="POST" style="font-size:25pt;" >
		<table>
			<tr>
				<td>Item Code:</td><td><input type="text" name="iCode" value="${iCode}" size="10" style="font-size:22pt; border: 1px solid RED"/></td>
				<td>Item Name:</td><td><input type="text" name="iName" value="${iName}" size="10" style="font-size:22pt; border: 1px solid RED"/></td>
			</tr>
			<tr>
				<td>Item Cost:</td><td><input type="text" name="iCost" value="${iCost}" size="10" style="font-size:22pt; border: 1px solid RED"/></td>
				<td>Item Price:</td><td><input type="text" name="iPrice" value="${iPrice}" size="10" style="font-size:22pt; border: 1px solid RED"/></td>
			</tr>
			<tr>
			
				<td>Qty OnHand:</td><td><input type="text" name="QtyOnHand" value="${QuantityOnHand}" size="10" style="font-size:22pt; border: 1px solid RED"/></td>
				<td>Department:-</td><td><input type="text" name="Department" value="${Department}" size="10" style="font-size:22pt; border: 1px solid RED"/></td>
				
			</tr>
			<tr>
				<td><input type="Submit" name="Update" value="Update" style="font-size:30px"/></td>
				<td><input type="reset" value="Clear" name="clear" style="font-size:15pt; WIDTH:100PX"/></td>
			</tr>
		</table>
	</form>
				
</body>
</html>