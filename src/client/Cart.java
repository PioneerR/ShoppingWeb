package client;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {

	List<CartItem> items=new ArrayList<CartItem>();
	
	public List<CartItem> getItems()
	{
		return items;
	}
	public void setItems(List<CartItem> items)
	{
		this.items=items;
	}
	
	
	public void add(CartItem ci)
	{
		Iterator<CartItem> it=items.iterator();
		while(it.hasNext())
		{
			CartItem item=it.next();
			if(item.getProduct().getId() == ci.getProduct().getId())
			{
				item.setCount(item.getCount()+ci.getCount());
				return;
			}
		}
		items.add(ci);
	}
	
	public double getTotalMemberPrice()
	{
		double d=0.0;
		Iterator<CartItem> it= items.iterator();
		while(it.hasNext())
		{
			CartItem current=it.next();
			d+=current.getCount()*current.getProduct().getMemberPrice();
		}		
		return d;
	}
	
	public void deleteItemById(int productId)
	{
		Iterator<CartItem> it=items.iterator();
		while(it.hasNext())
		{
			CartItem item=it.next();
			if(item.getProduct().getId() == productId)
			{
				it.remove();
			}
		}		
	}
	
	
	
	
	
	
	
	
	
	
}
