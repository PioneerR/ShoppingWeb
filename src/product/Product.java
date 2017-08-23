package product;

import category.Category;

import java.util.Date;

public class Product {

	private int id;
	private String name;
	private String describe;
	private int normalPrice;//价格一般用double
	private int memberPrice;
	private Date pdate;
	private int categoryId;
	private Category category;
	
	public void setId(int id)
	{
		this.id=id;
	}
	public void setName(String name)
	{
		this.name=name;
	}
	public void setDescribe(String describe)
	{
		this.describe=describe;
	}
	public void setNormalPrice(int normalPrice)
	{
		this.normalPrice=normalPrice;
	}
	public void setMemberPrice(int memberPrice)
	{
		this.memberPrice=memberPrice;
	}
	public void setDate(Date pdate)
	{
		this.pdate=pdate;
	}
	public void setCategoryId(int categoryId)
	{
		this.categoryId=categoryId;
	}
	
	
	public int getId()
	{
		return id;
	}
	public String getName()
	{
		return name;
	}
	public String getDescribe()
	{
		return describe;
	}
	public int getNormalPrice()
	{
		return normalPrice;
	}
	public int getMemberPrice()
	{
		return memberPrice;
	}
	public Date getDate()
	{
		return pdate;
	}
	public int getCategoryId()
	{
		return categoryId;
	}
	
	
	public void setCategory(Category category)
	{
		this.category=category;
	}
	public Category getCategory()
	{
		return category;
	}
	

	
	
}
