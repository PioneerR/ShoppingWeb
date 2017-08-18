package order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import product.Product;
import user.User;
import util.DB;

public class OrderMySQLDAO implements OrderDAO {
	@Override
	public void update(SalesOrder so) 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "update salesorder set addr=? , status=?, payset=? where id=?";
			pstmt = DB.getPstmt(conn, sql);
			pstmt.setString(1, so.getAddress());
			pstmt.setInt(2, so.getStatus());
			pstmt.setInt(3, so.getPaySet());
			pstmt.setInt(4, so.getId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	@Override
	public int add(SalesOrder so) 
	{
		int orderId=-1;
		//System.out.println(orderId);
		Connection conn=DB.getConn();
		String sql="insert into salesorder values(null,?,?,?,?,?)";
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
			pstmt.setInt(5,so.getPaySet());
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
	public List<SalesOrder> getOrders() 
	{
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		String sql="select salesorder.id sid,salesorder.userid,salesorder.addr,salesorder.odate,"
				  +"salesorder.status,salesorder.payset,user.id uid,user.username,user.password,user.phone,"
				  + "user.addr,user.rdate from salesorder inner join user on user.id=salesorder.userid";
		ResultSet rs=DB.getRs(stmt, sql);
		List<SalesOrder> orders=null;
		try
		{
			orders=new ArrayList<SalesOrder>();
			while(rs.next())
			{
				User u=new User();
				u.setId(rs.getInt("uid"));
				u.setAddress(rs.getString("user.addr"));
				u.setDate(rs.getTimestamp("user.rdate"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setUsername(rs.getString("username"));
				
				
				SalesOrder so=new SalesOrder();
				so.setAddress(rs.getString("addr"));
				so.setODate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				so.setId(rs.getInt("sid"));
				so.setUser(u);
				so.setPaySet(rs.getInt("payset"));
				
				orders.add(so);				
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			DB.close(stmt);
			DB.close(rs);
			DB.close(conn);
		}
		return orders;
	}

	@Override
	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize)
	{
		int totalRecords=-1;
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		String sql="select salesorder.id,salesorder.userid,salesorder.odate,salesorder.addr,"
				+ "salesorder.status,salesorder.payset,user.id uid,user.username,user.password,"
				+ "user.addr uaddr,user.phone,user.rdate from salesorder left join user on "
				+ "salesorder.userid=user.id"+ " limit "+(pageNo-1)*pageSize+","+pageSize;
		ResultSet rs=DB.getRs(stmt, sql);
		
		Statement stmtCount=DB.getStmt(conn);
		ResultSet rsCount=DB.getRs(stmtCount, "select count(*) from salesorder");
		
		try
		{
			rsCount.next();
			totalRecords=rsCount.getInt(1);
			
			while(rs.next())
			{
				User u=new User();
				u.setId(rs.getInt("uid"));
				u.setAddress(rs.getString("uaddr"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setDate(rs.getTimestamp("rdate"));
				
				SalesOrder so=new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddress(rs.getString("addr"));
				so.setODate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				so.setPaySet(rs.getInt("payset"));
				so.setUser(u);
				
				orders.add(so);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();			
		}
		finally
		{
			DB.close(stmt);
			DB.close(stmtCount);
			DB.close(rs);
			DB.close(rsCount);
			DB.close(conn);
		}
		return totalRecords;
	}

	@Override
	public void delete(int id) 
	{
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		try
		{
			String sql="delete from salesorder where id="+id;
			stmt.execute(sql);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			DB.close(stmt);
			DB.close(conn);
		}
	}

	@Override
	public SalesOrder loadById(int id) 
	{
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		ResultSet rs=null;
		SalesOrder so=null;
		try
		{
			String sql = "select salesorder.id, salesorder.userid, salesorder.odate, "
					+ "salesorder.addr, salesorder.status , salesorder.payset," +
		 			 " user.id uid, user.username, user.password, user.addr uaddr, "
		 			 + "user.phone, user.rdate from salesorder " +
		 			 " join user on (salesorder.userid = user.id) where salesorder.id = " + id; 
			
			rs=DB.getRs(stmt, sql);
			while(rs.next())
			{
				User u=new User();
				u.setId(rs.getInt("uid"));
				u.setAddress(rs.getString("uaddr"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setDate(rs.getTimestamp("rdate"));			
				
				so=new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddress(rs.getString("addr"));
				so.setStatus(rs.getInt("status"));
				so.setODate(rs.getTimestamp("odate"));
				so.setPaySet(rs.getInt("payset"));
				so.setUser(u);
				
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return so;
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
	public List<SalesItem> getSalesItems(int orderId) 
	{
		List<SalesItem> items=new ArrayList<SalesItem>();
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		String sql="select salesorder.id,salesorder.userid,salesorder.odate,salesorder.addr,salesorder.status,"
				+ "salesitem.id itemid,salesitem.productid,salesitem.unitprice,salesitem.pcount,"
				+ "salesitem.orderid,product.id pid,product.name pname,product.descr pdescr,"
				+ "product.normalprice,product.memberprice,product.pdate,product.categoryid "
				+ " from salesorder join salesitem on salesorder.id=salesitem.orderid join "
				+ " product on salesitem.productid=product.id where salesorder.id= "+orderId;
		ResultSet rs=DB.getRs(stmt, sql);
		
		try
		{
			while(rs.next())
			{
				Product p=new Product();
				p.setId(rs.getInt("pid"));
				p.setCategoryId(rs.getInt("categoryid"));
				p.setName(rs.getString("pname"));
				p.setDescribe(rs.getString("pdescr"));
				p.setDate(rs.getTimestamp("pdate"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				
				SalesItem si=new SalesItem();
				si.setId(rs.getInt("itemid"));
				si.setUnitPrice(rs.getDouble("unitprice"));
				si.setCount(rs.getInt("pcount"));
				si.setProduct(p);
				
				items.add(si);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();			
		}
		finally
		{
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);			
		}	
		return items;
	}

//	@Override
//	public void updateStatus(SalesOrder order)
//	{
//		Connection conn=DB.getConn();
//		Statement stmt=DB.getStmt(conn);
//		
//		try
//		{
//			String sql="update salesorder set status="+order.getStatus()
//					  +" where id="+order.getId();
//			DB.executeUpdate(stmt, sql);
//		}
//		finally
//		{
//			DB.close(stmt);
//			DB.close(conn);
//		}
//	}
}
