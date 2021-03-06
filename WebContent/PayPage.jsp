<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script>
function simplifyResponseHandler(data) {
    var $paymentForm = $("#simplify-payment-form");
    // Remove all previous errors
    $(".error").remove();
    // Check for errors
    if (data.error) {
    	console.log('in error');
        // Show any validation errors
        if (data.error.code == "validation") {
            var fieldErrors = data.error.fieldErrors,
                fieldErrorsLength = fieldErrors.length,
                errorList = "";
            for (var i = 0; i < fieldErrorsLength; i++) {
                errorList += "<div class='error'>Field: '" + fieldErrors[i].field +
                             "' is invalid - " + fieldErrors[i].message + "</div>";
            }
            // Display the errors
            $paymentForm.after(errorList);
        }
        // Re-enable the submit button
        $("#process-payment-btn").removeAttr("disabled");
    } else {
    	console.log('in else part');
        // The token contains id, last4, and card type
        var token = data["id"];
        // Insert the token into the form so it gets submitted to the server
        $paymentForm.append("<input type='hidden' name='simplifyToken' value='" + token + "' />");
        // Submit the form to the server
        $paymentForm.get(0).submit();
    }
}

	$(document).ready(function() {
		$("#simplify-payment-form").on("submit", function() {
			// Disable the submit button
			$("#process-payment-btn").attr("disabled", "disabled");
			// Generate a card token & handle the response
			SimplifyCommerce.generateToken({
				key : "sbpb_YTEwN2U0MWQtMWZlZS00NjczLThkYjAtMmUwNDJmZWQ0N2Uz",
				card : {
					number : $("#cc-number").val(),
					cvc : $("#cc-cvc").val(),
					expMonth : $("#cc-exp-month").val(),
					expYear : $("#cc-exp-year").val()
				}
			}, simplifyResponseHandler);
			// Prevent the form from submitting
			return false;
		});
	});
</script>

</head>
<body>

<div data-role="page">
  <div data-role="header">
    <h1>Payment Page</h1>
  </div>

  <div data-role="main" class="ui-content">
    <a href="#myPopup" data-rel="popup" class="ui-btn ui-btn-inline ui-corner-all ">Cash</a>
    <a href="#myPopup2" data-rel="popup" class="ui-btn ui-btn-inline ui-corner-all ">Card</a>
	<a href="http://localhost:8080/InsertDataWebApplication/Cashier.jsp">Go Back</a>
    
    <div data-role="popup" id="myPopup" class="ui-content" style="min-width:250px;">
      <form method="post" action="/action_page_post.php">
        <div>
          <h3>Cash</h3>
          <label for="amountdue" class="ui-hidden-accessible">Amount Due</label>
        	 Amount Due:- <input type="text" name= "user" id="amountdue" placeholder="Amount Due" value="${TotalTax}">
          <label for="amount" class="ui-hidden-accessible">Amount</label>
          	Amount:-<input type="text" name="amount" id="amount" placeholder="" value="">
          <input type="submit" data-inline="true" value="Pay">
        </div>
      </form>
    </div>
    
    <div data-role="popup" id="myPopup2" class="ui-content" style="min-width:250px;">
     

    <div class="container">
<form id="simplify-payment-form" class="form-horizontal" action="Payment" method="POST">
    <div class="form-group">
        <label class="control-label col-sm-2">Credit Card Number: </label>
        <div class="col-sm-10">
        <input id="cc-number" type="text" maxlength="20" autocomplete="off" value="" autofocus />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-2">CVC: </label>
        <div class="col-sm-10">
        <input id="cc-cvc" type="text" maxlength="4" autocomplete="off" value=""/>
        </div>
    </div>
     <div class="form-group">
        <label class="control-label col-sm-2">Amount: </label>
        <div class="col-sm-10">
        <input type="number" step="0.01" name="amount" maxlength="300" autocomplete="off" value="${TotalTax}"required value=""/>
        </div>
    </div>
    <table>
    	<tr>
    	<label class="control-label col-sm-2">Expiry Date: </label>
    	<td>
    	
	    <div class="form-group">
	        <div class="col-sm-10">
	        <select id="cc-exp-month">
	            <option value="01">Jan</option>
	            <option value="02">Feb</option>
	            <option value="03">Mar</option>
	            <option value="04">Apr</option>
	            <option value="05">May</option>
	            <option value="06">Jun</option>
	            <option value="07">Jul</option>
	            <option value="08">Aug</option>
	            <option value="09">Sep</option>
	            <option value="10">Oct</option>
	            <option value="11">Nov</option>
	            <option value="12">Dec</option>
	        </select>
	        </td>
	        <td>
	        <select id="cc-exp-year">
	           
	            <option value="17">2017</option>
	            <option value="18">2018</option>
	            <option value="19">2019</option>
	            <option value="20">2020</option>
	            <option value="21">2021</option>
	            <option value="22">2022</option>
	            <option value="23">2023</option>
	            <option value="24">2024</option>
	            <option value="25">2025</option>
	        </select>
	        </div>
	    </div> <div class="form-group">
	    </td>
    </tr>
    </table>
   <div class="form-group"> 
    <div class="col-sm-offset-2 col-sm-10">
         <button id="process-payment-btn" type="submit" >Card Checkout</button>
					<br /> <br /> <br />  <a href="Refund"><button id="process-payment-btn" type="button" >Refund Amount</button></a>
    </div>
  </div>
    
    </div>
</form>
</div>

     
      <!-- <form method="post" action="/action_page_post.php">
        <div>
          <h3>Login information</h3>
          <label for="usrnm" class="ui-hidden-accessible">Username:</label>
          <input type="text" name="user" id="usrnm" placeholder="Username">
          <label for="pswd" class="ui-hidden-accessible">Password:</label>
          <input type="password" name="passw" id="pswd" placeholder="Password">
          
          <input type="submit" data-inline="true" value="Log in">
        </div>
      </form> -->
    </div>
  </div>

  
</div> 

</body>


</html>


