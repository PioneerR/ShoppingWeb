package stat;

public class ProductStatItem {

	private int productId;
	private String productName;
	private int totalSalesCount;
	
	public void setProductId(int productId)
	{
		this.productId=productId;
	}
	public void setProductName(String productName)
	{
		this.productName=productName;
	}
	public void setTotalSalesCount(int totalSalesCount)
	{
		this.totalSalesCount=totalSalesCount;
	}
	
	public int getProductId()
	{
		return productId;
	}
	public String getProductName()
	{
		return productName;
	}
	public int getTotalSalesCount()
	{
		return totalSalesCount;
	}	
	
}
