
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %> 
<%@ page import="java.lang.*" %> 
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file = "index.jsp" %>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register</title>

<style>
* {
    box-sizing: border-box;
}

.scrollit {
    overflow:scroll;
    height:430px;
   	/* background: linear-gradient(to top right, #ffffff 10%, #ffff99 80%); */
   	background: linear-gradient(to top, #ffffff -22%, #ffffcc 132%);
   	style="font-size: 20px";
}

tbody div{
    overflow:scroll;
    height:500px;
}

.td {
    border: 1px solid black;
    background: linear-gradient(to bottom right, #33ccff 0%, #ffffff 100%);
    width:10%;
    height:70pt;
    style="font-size: 30px";
    
}

input[type=submit] {
    
    cursor:pointer;
    -webkit-border-radius: 5px;
    border-radius: 5px; 
    font-size : 25px;
    width:100%;
    height:100%;
    background: linear-gradient(to bottom right, #33ccff 0%, #ffffff 100%);
   
}
</style>
</head>
<body onload="document.MyForm.iCode.focus();">

<%
	String succ = (String)request.getAttribute("Paid");
	String NotAvailable =(String)request.getAttribute("NotAvailable");
	
	if(succ!= null){
		%>
		 <script type="text/javascript">
	    var msg = "<%=succ%>";
	    alert(msg);
	</script><%
	}
	if(NotAvailable!=null){
		%>
		 <script type="text/javascript">
	    var msg = "Item Not Available Please add this Item";
	    alert(msg);
	</script><%
	}
	%>

<center>
<br>
<form id="MyForm" name="MyForm" action="/InsertDataWebApplication/Cashier" method="GET" style="font-size:18p;">
<div class="table-responsive"> 
<TABLE class="table" style="font-size:18pt; width:80%;" BORDER=3 CELLSPACING=3 CELLPADDING=6 > 
	<tr>
		<td style=" color:Black;" class="td">Qty:
			<input type="text" value="1" size="2" name="Quantity" style="font-size : 25px; width: 30px; height: 30px; border:1px solid black"/>
		</td>
			
		<td style="font-size:30px; background: linear-gradient(to bottom, #ffffff 0%, #c0c0c0 100%); width:80%" align="center" class="td" >Scan Bar Code:<br>
			<input type="text" id="iCode" name=iCode value="" size="20" style="font-size:20pt; border:1px solid red"/>
			
		</td>
			
		<td class="td">
			<input type="submit" value="Enter" name="Search"/>
		</td>
	</tr>
	<TR> 
		<td class="td" align="center"><input type="submit"  value="Void #" name="Delete" style="color:#FF0000; width:80%; height:50px">
		<input type="text" value="" size="1" name="DeleteIndex" style="font-size : 15px;"/></td>
		
		<TD ROWSPAN=8 valign="top">
		
			<table border="1" style="font-size:22pt; width:100%;" align="center">
				<tr >
					<td style="width:50px; padding:10px">#</td>
					<td style="width:500px">Item Name</td>
					<td style="width:70px">Qty</td>
					<td style="width:150px">Price</td>
				</tr>
			</table>
			<div class="scrollit">
			<table border="1" style="font-size:18px; width:100%;" align="center">
				<c:choose>
				 	 <c:when test="${empty itemList}">
			         <c:set var="TotalNonTax" value="${0}" /> 
			         <c:set var="Tax" value="${0}"/>
			         <c:set var="Total" value="${0}"/>
			         <c:set var="Number" value="${0}"/>
		         
		        </c:when>
			        <c:otherwise>
					    <c:forEach var="item" items="${itemList}">
					        <c:set var="Number" value="${Number+1}"></c:set>
					        <c:set var="ItemName" value="${item.getiName()}"/>
					        <c:set var="Quantity" value="${item.getiQty()}"/>
					        <c:set var="ItemPrice" value="${Quantity*item.getiPrice()}"/>
					        <c:set var="TotalNonTax" value="${TotalNonTax+ItemPrice}"/>  
					        <tr height="10px"> 
					            <td style="width:50px; padding:10px">${Number}</td>
					            <td style="width:500px">${ItemName}</td>
					            <td style="width:70px">${Quantity}</td>
					            <td style="width:150px">${ItemPrice}</td>
					        
					        </tr>
			            </c:forEach>
			        </c:otherwise>
				</c:choose>
			</table>
			</div>
		</TD>	
			<td class="td"><input type =submit value="Clear" name="Clear" style=" color:#FF0000"/></td> 
	</TR> 
	<TR> 
		<td class="td">(cell 8)</td>
		<td class="td">(cell 9)</TD>
	</TR>
	 
	<TR> 
		<td class="td">(cell 10)</TD> 
		<td class="td">(cell 11)</TD>
	</TR>  
	
	<TR> 
		<td class="td">(cell 14)</TD> 
		
		<td class="td" style="color:Red"> Change $ ${due}
		</td>
	</TR> 
	<TR> 
		<td class="td"></td>
		<td class="td" >
			<input type="submit" Value="PAY" name="Tender">
		</TD>
	</TR>
	
	
</TABLE>
</div>
</form>
</center>

<center>
<div class="table-responsive"> 
	<TABLE class="table" style="font-size:18pt; background-color:black" BORDER=3 CELLSPACING=3 CELLPADDING=6 >
	<tr style="width:20%; color:#00FFFF">
		
		<td> Total Non Tax:- </td>
		<td> <fmt:formatNumber type = "currency" pattern = "####.##" value = "${TotalNonTax}" /></td>
		
		
	</tr>
	<tr style="width:20%; color:#00FFFF">
		<td>Tax:-</td>
		<td><fmt:formatNumber type = "currency" pattern = "####.##" value = "${TotalNonTax*1.0635-TotalNonTax}" /></td>
		
	</tr>
	<tr style="width:20%; color:red">
	
		<td style=" font-size:25pt;">Total:-</td>
		<td style=" font-size:25pt; width:150px"><fmt:formatNumber type = "currency" pattern = "####.##" value = "${TotalTax}" /></td>
		
	</tr>
	
	</table>
	</div>
</center>

</body>
</html>