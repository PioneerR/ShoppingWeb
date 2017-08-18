package order;

import client.Cart;

import java.util.List;

import user.User;

public class OrderMgr {

	private OrderMgr(){}
	private static OrderMgr mgr=null;
	public static OrderMgr getInstance()
	{
		if(mgr==null)
		{
			mgr=new OrderMgr();
		}
		return mgr;
	}
	
	private static OrderDAO dao=new OrderMySQLDAO();
	
//	public void updateStatus(SalesOrder so)
//	{
//		dao.updateStatus(so);
//	}
	
	public void update(SalesOrder so)
	{
		dao.update(so);
	}
	public int add(SalesOrder so)
	{
		return dao.add(so);
	}
	public void delete(SalesOrder so)
	{
		 dao.delete(so.getId());
	}
	
	public int userBuy(Cart c,User u)
	{
		return u.buy(c);
	}
	public List<SalesOrder> getOrders() {
		return dao.getOrders();
	}
	public int getOrders(List<SalesOrder> orders,int pageNo,int pageSize)
	{
		return dao.getOrders(orders, pageNo, pageSize);
	}
	public SalesOrder loadById(int id)
	{
		return dao.loadById(id);
	}
	public List<SalesItem> getSalesItems(SalesOrder so)
	{
		return dao.getSalesItems(so.getId());
	}

}
