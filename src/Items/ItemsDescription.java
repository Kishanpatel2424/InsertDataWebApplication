package Items;

public class ItemsDescription {
	
	public String iCode;
	public String iName;
	public double iPrice;
	public double iQty;
	

	public void setiCode(String ItemCode){
		iCode = ItemCode;
	}
	public String getiCode(){
		return iCode;
	}
	public void setiName(String ItemName){
		iName = ItemName;
	}
	public String getiName(){
		return iName;
	}
	public void setiPrice(double ItemPrice){
		iPrice = ItemPrice;
	}
	public double getiPrice(){
		return iPrice;
	}
	public void setiQty(double Quantity){
		iQty = Quantity;
	}
	public double getiQty(){
		return iQty;
	}

}
