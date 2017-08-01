package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Date;

import util.DB;

import java.util.ArrayList;
import java.util.List;


public class User {

	private int id;
	private String username;
	private String address;
	private String password;//为什么用String类型
	private String phone;//为什么用String类型
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
	public String getPasswor()
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
			//rdate是普通的Date时间类实例，Timestamp是JDBC中的时间且覆盖了Date中的getTime()方法
			//创建Timestamp实例，需要用毫秒时间值构造Timestamp对象，Date中的getTime()方法返回的就是毫秒时间值
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
	
	public static List<User> getUsers()//再写一遍/////////////////////////////////////////////
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
				User u=new User();//将数据从数据库取出，存放到内存中
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
	 * 传入集合，第几页，每页的条数，返回总共有多少条数据，返回某页的几条数据集合
	 * @param users
	 * @param pageNo
	 * @param pageSize
	 * @return 总共有多少条记录
	 */
	
	public static int getUsers(List<User>users,int pageNo,int pageSize)
	{
		int totalRecords=-1;
		
		Connection conn=DB.getConn();
		String sql="select*from user limit "+(pageNo-1)*pageSize+","+pageSize;
		Statement stmt=DB.getStmt(conn);
		ResultSet rs=DB.getRs(stmt, sql);//获取某几条作为某页的显示条目
		
		Statement stmtCount=DB.getStmt(conn);//获取总条数，计算总页数
		ResultSet rsCount=DB.getRs(stmtCount, "select count(*) from user");
		//将
		
		try
		{
			rsCount.next();//将总条数放进rsCount
			totalRecords=rsCount.getInt(1);
			
			while (rs.next()) //将某几条数据从数据库存放到内存中(user集合)
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
	
	
	
	
	
	
	
	
	
	
}
