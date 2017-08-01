package product;

import category.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import util.DB;

public class ProductMgr {

	//�������ģʽ
	private ProductMgr(){}
	private static ProductMgr mgr=null;
	public static ProductMgr getInstance()
	{
		if(mgr==null)
		{
			mgr=new ProductMgr();
		}
		return mgr;//��̬������ֻ��ʹ�þ�̬����
	}
	
	public void add(Product p)
	{
		Connection conn=null;
		String sql="insert into product values(null,?,?,?,?,?,?)";
		PreparedStatement pstmt=null;
		
		try
		{	
			conn=DB.getConn();
			pstmt=DB.getPstmt(conn, sql);
			
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescribe());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setTimestamp(5, new Timestamp(p.getDate().getTime()));
			pstmt.setInt(6, p.getCategoryId());
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
	
	public List<Product> getProducts()
	{
		List<Product> products=new ArrayList<Product>();
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		String sql="select * from product";
		ResultSet rs=DB.getRs(stmt, sql);
		
		try
		{
			while(rs.next())
			{
				Product p=new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescribe(rs.getString("descr"));
				p.setNormalPrice(rs.getInt("normalprice"));
				p.setMemberPrice(rs.getInt("memberprice"));
				p.setDate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				products.add(p);
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
		return products;
	}
	
	
	public Category getCategory(int id)
	{
		Category c=new Category();
		
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		String sql="select * from category where id="+id;
		ResultSet rs=DB.getRs(stmt, sql);
		try
		{
			while(rs.next())
			{
				c.setId(rs.getInt("id"));
				c.setPid(rs.getInt("pid"));
				c.setName(rs.getString("name"));
				c.setDescribe(rs.getString("descr"));
				c.setCno(rs.getInt("cno"));
				c.setGrade(rs.getInt("grade"));				
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
		return c;
	}
	
	public void delete(int id)
	{
		Connection conn=DB.getConn();
		String sql="delete from product where id="+id;
		Statement stmt=DB.getStmt(conn);
		try
		{
			stmt.executeUpdate(sql);
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
	
	public Product getProduct(int id)
	{
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		String sql="select * from product where id="+id;
		ResultSet rs=DB.getRs(stmt, sql);
		Product p=null;//��仰���ܷ���while��������·���p�޷���֮����
		try
		{
			while(rs.next())
			{
				p=new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescribe(rs.getString("descr"));
				p.setNormalPrice(rs.getInt("normalprice"));
				p.setMemberPrice(rs.getInt("memberprice"));
				p.setDate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));	
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
		return p;
	}
	
	public void modify(Product p)
	{
		Connection conn=DB.getConn();
		String sql="update product set name=?,descr=?,normalprice=?"
				+ ",memberprice=?,categoryId=? where id="+p.getId();
		PreparedStatement pstmt=DB.getPstmt(conn, sql);
		
		try
		{
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescribe());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setInt(5, p.getCategoryId());
			
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
	
	
	
	
	
	
	
	
	
}
