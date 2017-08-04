package user;

import client.Cart;
import client.CartItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import order.SalesItem;
import order.SalesOrder;
import util.DB;


public class User {

	private int id;
	private String username;
	private String address;
	private String password;//Ϊʲô��String����
	private String phone;//Ϊʲô��String����
	private Date rdate;
	
	public void setUsername(String username)
	{
		this.username=username;
	}
	public String getUsername()
	{
		return username;
	}
	
	public void setAddress(String address)
	{
		this.address=address;
	}
	public String getAddress()
	{
		return address;
	}
	
	public void setPassword(String password)
	{
		this.password=password;
	}
	public String getPassword()
	{
		return password;
	}
	
	public void setPhone(String phone)
	{
		this.phone=phone;
	}
	public String getPhone()
	{
		return phone;
	}
	
	public void setId(int id)
	{
		this.id=id;
	}
	public int getId()
	{
		return id;
	}
	
	public void setDate(Date rdate)
	{
		this.rdate=rdate;
	}
	public Date getDate()
	{
		return rdate;
	}
	
	public void save()
	{
		Connection conn=DB.getConn();
		String sql="insert into user values(null,?,?,?,?,?)";
		PreparedStatement pstmt=DB.getPstmt(conn, sql);
		try
		{
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, phone);
			pstmt.setString(4, address);
			pstmt.setTimestamp(5, new Timestamp(rdate.getTime()));
			//rdate����ͨ��Dateʱ����ʵ����Timestamp��JDBC�е�ʱ���Ҹ�����Date�е�getTime()����
			//����Timestampʵ������Ҫ�ú���ʱ��ֵ����Timestamp����Date�е�getTime()�������صľ��Ǻ���ʱ��ֵ
			pstmt.executeUpdate();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	public static List<User> getUsers()//��дһ��/////////////////////////////////////////////
	{
		List<User> users=new ArrayList<User>();
		Connection conn=DB.getConn();
		String sql="select * from user";
		Statement stmt=DB.getStmt(conn);
		ResultSet rs=DB.getRs(stmt, sql);	
		try
		{
			while(rs.next())
			{
				User u=new User();//�����ݴ����ݿ�ȡ������ŵ��ڴ���
				u.setId(rs.getInt("id"));
				u.setPhone(rs.getString("phone"));
				u.setAddress(rs.getString("addr"));
				u.setPassword(rs.getString("password"));
				u.setUsername(rs.getString("username"));
				u.setDate(rs.getTimestamp("rdate"));
				users.add(u);				
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
		return users;		
	}
	
	/**
	 * ���뼯�ϣ��ڼ�ҳ��ÿҳ�������������ܹ��ж��������ݣ�����ĳҳ�ļ������ݼ���
	 * @param users
	 * @param pageNo
	 * @param pageSize
	 * @return �ܹ��ж�������¼
	 */
	
	public static int getUsers(List<User>users,int pageNo,int pageSize)
	{
		int totalRecords=-1;
		
		Connection conn=DB.getConn();
		String sql="select*from user limit "+(pageNo-1)*pageSize+","+pageSize;
		Statement stmt=DB.getStmt(conn);
		ResultSet rs=DB.getRs(stmt, sql);//��ȡĳ������Ϊĳҳ����ʾ��Ŀ
		
		Statement stmtCount=DB.getStmt(conn);//��ȡ��������������ҳ��
		ResultSet rsCount=DB.getRs(stmtCount, "select count(*) from user");
		//��
		
		try
		{
			rsCount.next();//���������Ž�rsCount
			totalRecords=rsCount.getInt(1);
			
			while (rs.next()) //��ĳ�������ݴ����ݿ��ŵ��ڴ���(user����)
			{
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddress(rs.getString("addr"));
				u.setDate(rs.getTimestamp("rdate"));
				users.add(u);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			DB.close(rsCount);
			DB.close(stmtCount);
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return totalRecords;
	}
	
	public static boolean delete(int id)
	{
		boolean b=false;
		Connection conn=DB.getConn();
		String sql="delete from user where id="+id;
		Statement stmt=DB.getStmt(conn);
		
		try
		{
			DB.executeUpdate(stmt, sql);
			b=true;
		}
		finally
		{
			DB.close(stmt);
			DB.close(conn);
		}
		return b;
	}
	
	public static User check(String username,String password)
			throws UserNotFoundException,PasswordNotCorrectException
	{
		User u=null;
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		String sql="select * from user where username ='"+username+"'";
		ResultSet rs=DB.getRs(stmt, sql);
		
		try
		{
			if(!rs.next())
			{
				throw new UserNotFoundException("�û������ڣ����������룡");
			}
			else
			{
				if(!password.equals(rs.getString("password")))
				{
					throw new PasswordNotCorrectException("���벻��ȷ�����������룡");
				}
				u=new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddress(rs.getString("addr"));
				u.setDate(rs.getTimestamp("rdate"));
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
		return u;
	}
	 public int buy(Cart c)
	 {
		SalesOrder so=new SalesOrder(); 
		so.setUser(this);
		so.setAddr(this.getAddress());
		so.setStatus(0);
		so.setODate(new Date());
		
		List<SalesItem> salesItems=new ArrayList<SalesItem>();
		List<CartItem> cartItems=c.getItems();
		for(int i=0;i<cartItems.size();i++)
		{
			SalesItem si=new SalesItem();
			CartItem ci=cartItems.get(i);
			
			si.setProduct(ci.getProduct());
			si.setCount(ci.getCount());
			si.setUnitPrice(ci.getProduct().getMemberPrice());
			salesItems.add(si);
			
		}
		return OrderMgr.getInstance().add(so);		 
	 }
	
	
	
	
	
	
	
}
