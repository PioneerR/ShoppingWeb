package order;

import java.util.List;

public class OrderMySQLDAO implements OrderDAO {

	@Override
	public void update(SalesOrder so) {
		// TODO Auto-generated method stub

	}

	@Override
	public int add(SalesOrder so) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<SalesOrder> getOrders() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub

	}

	@Override
	public SalesOrder loadById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(String conditionStr) {
		// TODO Auto-generated method stub

	}

	@Override
	public int find(List<SalesOrder> products, int pageNo, int pageSize,
			String queryStr) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<SalesItem> getSalesItems(int orderId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateStatus(SalesOrder order) {
		// TODO Auto-generated method stub

	}

}
