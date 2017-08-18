package order;



import java.util.Date;
import java.util.List;

import user.User;

public class SalesOrder {

	private int id;
	private User user;
	private String address;
	private Date odate;
	private int status;
	private List<SalesItem> items;
	private int payset;
	
	public String getAddress()
	{
		return address;
	}
	public void setAddress(String address) 
	{
		this.address = address;
	}

	public int getId() 
	{
		return id;
	}
	public void setId(int id) 
	{
		this.id = id;
	}
	public int getPaySet() 
	{
		return payset;
	}
	public void setPaySet(int payset) 
	{
		this.payset = payset;
	}

	public List<SalesItem> getItems() 
	{
		return items;
	}
	public void setItems(List<SalesItem> items) 
	{
		this.items = items;
	}

	public Date getODate() 
	{
		return odate;
	}
	public void setODate(Date odate) 
	{
		this.odate = odate;
	}

	public int getStatus() 
	{
		return status;
	}
	public void setStatus(int status) 
	{
		this.status = status;
	}

	public User getUser() 
	{
		return user;
	}
	public void setUser(User user) 
	{
		this.user = user;
	}
	
//	public void updateStatus()
//	{
//		OrderMgr.getInstance().updateStatus(this);
//	}
}
