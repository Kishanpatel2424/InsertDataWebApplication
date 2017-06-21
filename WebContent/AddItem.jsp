
<%-- <%@page import="java.sql.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>
 --%>
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<body>
	
<%@ include file = "index.jsp" %>
<br>
</br>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Item</title>
</head>
<body onload="ClearForm()">
<center><h1>Add Item</h1></center>

<%
	String succ = (String)request.getAttribute("Successfull");
	String Exist = (String)request.getAttribute("Exist");
	if(succ!= null){
		%>
		 <script type="text/javascript">
	    var msg = "<%=succ%>";
	    alert(msg);
	</script><%
	}
	if(Exist!=null){
	%>
		 <script type="text/javascript">
	    var msg = "Item Already Exist";
	    alert(msg);
	</script><%
	}
%>

<script type="text/javascript"> 
  function tabE(obj,e){ 
   var e=(typeof event!='undefined')?window.event:e;// IE : Moz 
   if(e.keyCode==13){ 
     var ele = document.forms[0].elements; 
     for(var i=0;i<ele.length;i++){ 
       var q=(i==ele.length-1)?0:i+1;// if last element : if any other 
       if(obj==ele[i]){ele[q].focus();break} 
     } 
  return false; 
   } 
  } 

</script>

	<form name="MyForm" action="/InsertDataWebApplication/AddItems" method="POST" style="font-size:15pt;" >
		<table border="1 solid black" cellpadding="10">
			<tbody>
					<tr>
					<td>Item Code:</td>
					<td><input type="text" name="iCode" value=""  onkeypress="return tabE(this,event)" size="20" style="font-size:12pt; border: 1px solid RED"/></td>
					<td>Tax:<input type="checkbox"name="Tax" Value="Tax"/></td>
					</tr>
					<tr>
					<td>Item Name:</td>
					<td><input type="text" name="iName" value="" size="20"style="font-size:12pt;border: 1px solid RED""/></td>
					</tr>
					<tr>
					<td>Category</td>
					<td><select name="Department" style="font-size:12pt;">
							<option value="None">None</option>
							<option value="Wine">Wine</option>
							<option value="Beer">Beer</option>
							<option value="Liquor">Liquor</option>
							<option value="Chanpagne">Champagne</option>
							<option value="Rum">Rum</option>
							<option value="Vodka">Vodka</option>
							<option value="Gin">Gin</option>
							<option value="Whiskey">Whiskey</option>
							<option value="Cigarettes">Cigarettes</option>
					</select></td>
					</tr>
			
			<tr>
					<td>Item Cost:</td>
					<td><input type="text" id="iCost" name="iCost"size="10" style="font-size:12pt; border: 1px solid RED""/></td>
				
					<td>Case Cost:</td>
					<td><input type="text" id="iCCost" name="iCCost" onkeyup="sum()"size="10" style="font-size:12pt; border: 1px solid RED""/></td>
				
					<td>Case Quantity:</td>
					<td><input type="text" id="iCQ" name="iCQ" onkeyup="sum()"size="10" style="font-size:12pt;"/></td>
						
						<tr>
						<td>Item Price:</td>
						<td><input type="text" name="iPrice" value="" size="10" style="font-size:12pt; border: 1px solid RED"/></td>
						<td>Quantity On Hand:</td>
						<td><input type="number" id="OtyOnHand" name="OtyOnHand"  style="font-size:12pt; border: 1px solid RED"/></td>
						
						<td></td>
						<td>GP%:
						<input type="text" name="GP" value="" size="10" style="font-size:12pt;"/></td>
						</tr>
						
					</tr>
					</tbody>
		</table>

		<input type="reset" value="Clear" name="clear" style="font-size:15pt; WIDTH:100PX"/> 
		<input type="submit" value="ADD" name="Addsubmit" style="font-size:15pt;WIDTH:100PX"/>

</form>

 <script type="text/javascript">
 function sum() {
     var txtFirstNumberValue = document.getElementById('iCCost').value;
     var txtSecondNumberValue = document.getElementById('iCQ').value;
     var result = (parseFloat(txtFirstNumberValue) / parseFloat(txtSecondNumberValue)).toFixed(2);
     if (!isNaN(result)) {
    	 if(document.getElementById('iCCost').value!=null)
    		 {
    		 document.getElementById('iCost').value = result;
    		 }
    	 else
         	document.getElementById('iCost').value = result;
     }
 }
 
 </script>
</body>
</html>