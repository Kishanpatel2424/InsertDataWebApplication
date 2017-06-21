package Items;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.simplify.payments.Authentication;
import com.simplify.payments.PaymentsApi;
import com.simplify.payments.PaymentsMap;
import com.simplify.payments.domain.Authorization;
import com.simplify.payments.domain.Payment;
import com.simplify.payments.exception.ApiCommunicationException;
import com.simplify.payments.exception.AuthenticationException;
import com.simplify.payments.exception.InvalidRequestException;
import com.simplify.payments.exception.NotAllowedException;
import com.simplify.payments.exception.SystemException;

/**
 * Servlet implementation class Payment
 */
@WebServlet("/Payment")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		PaymentsApi.PUBLIC_KEY = "sbpb_YTEwN2U0MWQtMWZlZS00NjczLThkYjAtMmUwNDJmZWQ0N2Uz";
		PaymentsApi.PRIVATE_KEY = "dbT1VYinuA/Qyy3XFYkJhV3j0f7yrJQnf6dg0AIVNnp5YFFQL0ODSXAOkNtXTToq";
		
		
		String parameter = request.getParameter("currency");
		String paymentDescription = request.getParameter("description");
		String tokenId = request.getParameter("simplifyToken");
		 Double amount =  Double.parseDouble(request.getParameter("amount"));
		String reference ="7a6ef6be31RRRTEST343";
		paymentDescription = "payment description";
		System.out.println("Amount :" +  amount +  "Token id:" + tokenId + "  Payment desc:" +paymentDescription + " currentcy:" +parameter);
		
		Payment payment = null;
		
	
		try {
			PaymentsMap map = new PaymentsMap()
	        .set("amount", amount*100)
	        .set("currency", "USD")
	        .set("description", paymentDescription)
	        .set("reference", reference)
	        .set("token", tokenId);
 			payment = Payment.create(map);
			
			
		} catch (ApiCommunicationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (AuthenticationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidRequestException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NotAllowedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(amount+" AMount is");
		System.out.println("Payment Response is: "+payment);
		if (payment != null && "APPROVED".equals(payment.get("paymentStatus"))) {
			System.out.println("Payment Id:"+payment.get("id"));
		    PrintWriter writer = response.getWriter();
		    writer.write("Payment approved");
		    writer.write("Use this Payment Id for Refund:" + ""+payment.get("id")+"");
		    request.setAttribute("Approved", "Approved");
		    request.getRequestDispatcher("/Cashier.java").forward(request, response);
		} else {
			PrintWriter writer = response.getWriter();
			System.out.println("Payment Response is: "+payment);
		    writer.write("Fails" +  ". Payment Response is: "+payment);
		}
	}

}
