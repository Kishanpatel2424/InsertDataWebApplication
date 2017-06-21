package Items;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Cashier
 */
@WebServlet("/Cashier")
public class Cashier extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Cashier() {
        super();
        // TODO Auto-generated constructor stub
    }

    
   
   ArrayList<ItemsDescription> itemList = new ArrayList<ItemsDescription>();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		Connection MyConn =null;
		Statement myStmt =null;
		
		response.setContentType("text/html");
		
		 ResultSet results = null;
		 
		String iName;
		double iPrice;
		double iQty = 0;
		double Amount = 0;
		double change, due = 0;
		int DeleteIndex=0;
		
		boolean Search 	= request.getParameter("Search") != null;
		boolean Tender 	= request.getParameter("Tender") != null;
		boolean Clear	= request.getParameter("Clear")  !=null;
		boolean DeleteI = request.getParameter("Delete") !=null;
		
		String Approved = (String) request.getAttribute("Approved");
		boolean Process = false;
		
		if(Approved=="Approved")
			Process=true;
		String iCode=null;
		String PaymentType="";
		
		int result;
		
		if(Clear){
			itemList.clear();
			Total(-1); 
			System.out.println(TotalTax);
			 request.getSession().setAttribute("Clear", "Clear");
			 request.setAttribute("TotalTax", TotalTax);
			 request.getRequestDispatcher("/Cashier.jsp").forward(request, response);
				 
				 
		}
		
		if(DeleteI){
			if(request.getParameter("DeleteIndex")!=null && request.getParameter("DeleteIndex")!=""){
				String I = request.getParameter("DeleteIndex");
				DeleteIndex = Integer.parseInt(I);
				
				if(DeleteIndex>0 && DeleteIndex<=itemList.size()){
					double a =itemList.get(DeleteIndex-1).getiPrice()*itemList.get(DeleteIndex-1).getiQty();
					System.out.println(a);
					itemList.remove(DeleteIndex-1);
					Total(-a);
					
					System.out.println(TotalTax+"After delet "+a);
				}
				request.setAttribute("TotalTax", TotalTax);
				request.getRequestDispatcher("/Cashier.jsp").forward(request, response);
				
			}
		}
		
		if(Process){
			System.out.println("Inside Process");
			if(request.getParameter("Amount") != null){
				Amount = Double.parseDouble(request.getParameter("Amount"));
				
				if(Integer.parseInt(request.getParameter("Type")) == 1){
					PaymentType = "Cash";
				}
				else if(Integer.parseInt(request.getParameter("Type")) == 2){
					PaymentType = "Card";
				}
					if(Amount == (TotalTax)){
						itemList.clear();
						Total(-1);
						PaymentType="";
						due=0;
						
						System.out.println("Amount Paid "+TotalTax);
						request.setAttribute("due", due);
						request.setAttribute("TotalTax", TotalTax);
						 request.getRequestDispatcher("/Cashier.jsp").forward(request, response);
						
					}
					/*if(Amount < (TotalTax)){
						
						change = (Math.round((TotalTax)-Amount)*100);
						due= change/100;
						
						System.out.println(due);
						request.setAttribute("due", due);
						 request.getRequestDispatcher("Pay.jsp").forward(request, response);
					}*/
					if(Amount > TotalTax){
						due=0;
						change= Math.round((Amount-TotalTax)*100);
						due=change/100;
						itemList.clear();
						Total(-1);
						System.out.println(due);
						 request.setAttribute("due", due);
						 request.setAttribute("TotalTax", TotalTax);
						 request.getRequestDispatcher("/Cashier.jsp").forward(request, response);
					}
					if(Amount<TotalTax){
						due = TotalTax-Amount;
						TotalTax = due;
						 request.setAttribute("Due", due);
						 request.getRequestDispatcher("/PayPage.jsp").forward(request, response);
					}
			}
		}
		
		if(Tender){
			request.setAttribute("Tender", "Tender");
			request.setAttribute("TotalTax", TotalTax);
			request.getRequestDispatcher("/PayPage.jsp").forward(request, response);
		}
			try{
				
				
					MyConn = ConnectionManager.getConnection();
					 myStmt = MyConn.createStatement();
					
					ItemsDescription item =null;
				
					//Search and display Begains
				if(Search){
					
					try{
						if(request.getParameter("iCode") != null &&request.getParameter("iCode")!="" ){
							  iCode = request.getParameter("iCode");
							  
							  String Q = request.getParameter(("Quantity"));
							  iQty = Double.parseDouble(Q);
							  
							  
						
						String sqlStatement = ("select * From Item where ItemCode ="+iCode);
						
						//Statement
						
						 results = myStmt.executeQuery(sqlStatement);
						 
							  item = new ItemsDescription();
							
							 while(results.next()){
								 iCode = results.getString("ItemCode");
								 iName = results.getString("ItemName");
								 iPrice = results.getDouble("ItemPrice");
								
								 item.setiCode(iCode);
								 item.setiName(iName);
								 item.setiPrice(iPrice);
								 item.setiQty(iQty);
	
								 Total(iPrice*iQty);
								 
								 
								itemList.add(item);
								
								
								
								
								  request.getSession().setAttribute("item", item);
						          request.getSession().setAttribute("itemList", itemList);
						          request.setAttribute("TotalTax", TotalTax);
						          request.getRequestDispatcher("Cashier.jsp").forward(request, response);
						          
						         
						          results.close();
						            
						          MyConn.close();
						          
							 }	
							
						 }
						
					}
					catch (NullPointerException e) {
			            System.out.print("Caught the NullPointerException");

							request.setAttribute("EnterItem", "EnterItem");
							 request.getRequestDispatcher("Cashier.jsp").forward(request, response);
					}
					
				}
				
				//Search and display Ends
				
				
				if(Process){
					
					
					double Tax = (TotalTax-Total);
					
					int InvoiceNumber = 0;
					PreparedStatement insertActor;
					Calendar cal = Calendar.getInstance();
					java.sql.Timestamp timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
					
					insertActor = MyConn.prepareStatement("INSERT INTO Invoice(InvoiceTotal,ChangeDue,PaymentType,Tax,Date) VALUES(?,?,?,?,?)");
					insertActor.setDouble(1,TotalTax);
					insertActor.setDouble(2, due);
					insertActor.setString(3,PaymentType);
					insertActor.setDouble(4, Tax);
					insertActor.setTimestamp(5, timestamp);
					
					result =insertActor.executeUpdate();
					
					insertActor = MyConn.prepareStatement("SELECT MAX(InvoiceNumber) from Invoice");
					ResultSet rs = insertActor.executeQuery();
					while(rs.next()){
						InvoiceNumber = rs.getInt(1);
						
					}
					
					System.out.println("Invoice created total "+TotalTax);
					
					try{
						
						for(ItemsDescription addItem: itemList){
							
							String code = addItem.iCode;
							String name = addItem.iName;
							double price = addItem.iPrice;
							double Quantity = addItem.iQty;
							double QtyTax = (price*Quantity)*1.0635;
							double ItemTax = QtyTax-(price*Quantity);
							
							insertActor = MyConn.prepareStatement("INSERT INTO InvoiceDetail(InvoiceNumber, ItemCode, ItemName,ItemPrice,Quantity,Tax) VALUES (?,?,?,?,?,?)");
							
							insertActor.setInt(1, InvoiceNumber);
							insertActor.setString(2, code);
							insertActor.setString(3, name);
							insertActor.setDouble(4, price);
							insertActor.setDouble(5, Quantity);
							insertActor.setDouble(6, ItemTax);
							
							System.out.println("Item add to InvoideDetail with Inv# "+InvoiceNumber+" Item"+name+" Qty"+Quantity);
							result =insertActor.executeUpdate();
							
						}
						
						
						System.out.println(result+" Execute result");
						if(result>0){
						
					 	results.close();
					 	MyConn.close();
					 	
						
						}
						///Passing Variables
							
					}
					
					catch (NullPointerException e) {
			           
					}
					
				}
				 
			}
			catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
			catch (SQLException exc){
				  
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} finally  {
				ConnectionManager.closeConnection(MyConn);
			}
			
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
			
	}
	static double Total = 0;
	static double Tax=0;
	static double TaxP=1.0635;
	static double TotalTax=0;
	public static double Total (double iPrice){
		
		if(iPrice!=-1){
		Total+=iPrice;
		Tax = Math.round(Total*TaxP*100);
		TotalTax=Tax/100;
		
		
		}
		else if(iPrice>=-1 && iPrice<0)
		{
			Total=0;
			//System.out.println(Total);
			return Total=0;
		}
		return Total;
	}
	

}
