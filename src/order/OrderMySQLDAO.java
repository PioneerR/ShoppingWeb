package order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Iterator;
import java.util.List;

import user.User;
import util.DB;

public class OrderMySQLDAO implements OrderDAO {

	@Override
	public void update(SalesOrder so) {
		// TODO Auto-generated method stub

	}

	@Override
	public int add(SalesOrder so) 
	{
		int orderId=-1;
		//System.out.println(orderId);
		Connection conn=DB.getConn();
		String sql="insert into salesorder values(null,?,?,?,?)";
		PreparedStatement pstmt=DB.getPstmt(conn, sql,Statement.RETURN_GENERATED_KEYS);
		ResultSet rsKey =null;
		User u=so.getUser();
		//System.out.println("yonghu"+u.getAddress());
		
		String sqlDetail="insert into salesitem values(null,?,?,?,?)";
		PreparedStatement pstmtDetail=DB.getPstmt(conn, sqlDetail);
		
		try
		{
			conn.setAutoCommit(false);
			pstmt.setInt(1, u.getId());
			pstmt.setString(2, u.getAddress());
			pstmt.setTimestamp(3, new Timestamp(so.getODate().getTime()));
			pstmt.setInt(4,so.getStatus());
			pstmt.executeUpdate();
			
			rsKey=pstmt.getGeneratedKeys();
			rsKey.next();
			orderId=rsKey.getInt(1);
			//System.out.println(orderId);
			
			List<SalesItem> items=so.getItems();
			Iterator<SalesItem> it=items.iterator();
			
			while(it.hasNext())
			{
				SalesItem si=it.next();
				pstmtDetail.setInt(1 , si.getProduct().getId());
				pstmtDetail.setDouble(2 , si.getUnitPrice() );
				pstmtDetail.setInt(3, si.getCount());
				pstmtDetail.setInt(4, orderId);
				pstmtDetail.addBatch();//该句用于提交sql命令到缓存	
			}
			pstmtDetail.executeBatch();
			conn.commit();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				conn.setAutoCommit(true);
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			
			DB.close(rsKey);
			DB.close(pstmtDetail);
			DB.close(pstmt);
			DB.close(conn);
		}
		//System.out.println("orderId"+orderId);
		return orderId;
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
