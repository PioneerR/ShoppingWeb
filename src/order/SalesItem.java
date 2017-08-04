package order;

import product.Product;

public class SalesItem {
	
	private int id;
	private Product product;
	private double unitPrice;
	private int count;
	private int orderId;
	
	public void setCount(int count)
	{
		this.count=count;
	}
	public int getCount()
	{
		return count;
	}
	
	public void setUnitPrice(double unitPrice)
	{
		this.unitPrice=unitPrice;
	}
	public double getUnitPrice()
	{
		return unitPrice;
	}
	
	public void setOrderId(int orderId)
	{
		this.orderId=orderId;
	}
	public int getOrderId()
	{
		return orderId;
	}
	
	public int getId() 
	{
		return id;
	}
	public void setId(int id) 
	{
		this.id = id;
	}
	
	public Product getProduct()
	{
		return product;
	}
	public void setProduct(Product product)
	{
		this.product = product;
	}
	
	
	
	
}
