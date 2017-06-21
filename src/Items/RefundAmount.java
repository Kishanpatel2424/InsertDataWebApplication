package Items;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.simplify.payments.PaymentsApi;
import com.simplify.payments.PaymentsMap;
import com.simplify.payments.domain.Refund;
import com.simplify.payments.exception.ApiCommunicationException;
import com.simplify.payments.exception.AuthenticationException;
import com.simplify.payments.exception.InvalidRequestException;
import com.simplify.payments.exception.NotAllowedException;
import com.simplify.payments.exception.SystemException;

/**
 * Servlet implementation class Refund
 */
@WebServlet("/Refund")
public class RefundAmount extends HttpServlet {
	private static final long serialVersionUID = 1L;
  

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("refund.jsp");
		requestDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PaymentsApi.PUBLIC_KEY = "sbpb_YTEwN2U0MWQtMWZlZS00NjczLThkYjAtMmUwNDJmZWQ0N2Uz";
		PaymentsApi.PRIVATE_KEY = "dbT1VYinuA/Qyy3XFYkJhV3j0f7yrJQnf6dg0AIVNnp5YFFQL0ODSXAOkNtXTToq";
		String paymentId= request.getParameter("paymentId");
		Double amount =  Double.parseDouble(request.getParameter("amount"));
		System.out.println("Refund Amount:  "+amount + "  paymentId:" +paymentId);
		Refund refund  = null;
		try {
			refund = Refund.create(new PaymentsMap()
			        .set("amount", amount)
			        .set("payment", paymentId)
			        .set("reason", "Refund Description")
			        .set("reference", "76398734634")
			);
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
		
		if (refund != null && "APPROVED".equals(refund.get("paymentStatus"))) {
		    PrintWriter writer = response.getWriter();
		    writer.write("Refund approved.");
		} else {
			PrintWriter writer = response.getWriter();
			System.out.println("Payment Response is: "+refund);
		    writer.write("Fails" +  ". Payment Response is: "+refund);
		}
		
	}

}
