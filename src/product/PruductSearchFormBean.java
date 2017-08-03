package product;

import category.Category;
public class PruductSearchFormBean {

	private int id;
	private String name;
	private String describe;
	
	private double lowNormalPrice;
	private double highNormalPrice;
	
	private double lowMemberPrice;
	private double highMemberPrice;
	
	private String startDate;//用String类，为什么？？？？？？？？？？？？？？？？
	private String endDate;
	
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
	public void setLowNormalPrice(double lowNormalPrice)
	{
		this.lowNormalPrice=lowNormalPrice;
	}
	public void setHighNormalPrice(double highNormalPrice)
	{
		this.highNormalPrice=highNormalPrice;
	}
	public void setLowMemberPrice(double lowMemberPrice)
	{
		this.lowMemberPrice=lowMemberPrice;
	}
	public void setHighMemberPrice(double highMemberPrice)
	{
		this.highMemberPrice=highMemberPrice;
	}
	public void setStartDate(String startDate)
	{
		this.startDate=startDate;
	}
	public void setEndDate(String endDate)
	{
		this.endDate=endDate;
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
	public double getLowNormalPrice()
	{
		return lowNormalPrice;
	}
	public double getHighNormalPrice()
	{
		return highNormalPrice;
	}
	public double getLowMemberPrice()
	{
		return lowMemberPrice;
	}
	public double getHighMemberPrice()
	{
		return highMemberPrice;
	}
	public String getStartDate()
	{
		return startDate;
	}
	public String getEndDate()
	{
		return endDate;
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
