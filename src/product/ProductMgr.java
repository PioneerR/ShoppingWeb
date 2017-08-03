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

	
	ProductDAO dao=new ProductMySQLDAO();
	//单例设计模式
	private ProductMgr(){}
	private static ProductMgr mgr=null;
	public static ProductMgr getInstance()
	{
		if(mgr==null)
		{
			mgr=new ProductMgr();
		}
		return mgr;//静态函数下只能使用静态变量
	}
	
	
	public int find(List<Product> products, int pageNo, int pageSize, int categoryId) {
		String queryStr = " where p.categoryid = " + categoryId;
		return dao.find(products, pageNo, pageSize, queryStr);
	}
	public int find(List<Product>products,int pageNo,int pageSize,String keyword)
	{
		String queryStr=" where p.name like '%"+keyword+"%' or p.descr like '%"+keyword
					+"%' or p.id like '%"+keyword+"%' or p.normalprice like '%"+keyword
					+"%' or p.memberprice like '%"+keyword+"%' or p.categoryid like '%"+keyword
					+"%' or c.name like '%"+keyword+"%' or c.descr like '%"+keyword+"%'";
		return dao.find(products,pageNo,pageSize,queryStr);
	}
	public int find(List<Product>products,int pageNo,int pageSize,PruductSearchFormBean bean)
	{
		String queryStr=" where 1=1 ";
		if(bean.getCategoryId()!=-1)
		{
			queryStr+=" and p.categoryid="+bean.getCategoryId();
		}
//		else if(bean.getCategoryId()==-1)
//		{
//			queryStr+=" and p.categoryid !=-1";//由于是取交集，所以当id值为-1时，就是取得所有的产品类型
//		}									   //写这句就多此一举
		
		if(bean.getName() !=null && !bean.getName().trim().equals(""))
		{
			queryStr+=" and p.name like '%"+bean.getName()+"%'";
		}
		if(bean.getLowNormalPrice() > 0.0)
		{
			queryStr += " and p.normalprice >= "+bean.getLowNormalPrice();
		}
		if(bean.getHighNormalPrice() > 0.0) {
			queryStr += " and p.normalprice <= " + bean.getHighNormalPrice();
		}
		if(bean.getLowMemberPrice() > 0.0) {
			queryStr += " and p.memberprice >= " + bean.getLowMemberPrice();
		}
		if(bean.getHighMemberPrice() > 0.0) {
			queryStr += " and p.memberprice <= " + bean.getHighMemberPrice();
		}
		if(bean.getStartDate() != null && bean.getStartDate().trim().equals("") )
		{
			queryStr += " and p.pdate >= '"+bean.getStartDate()+" 00:00:00'";//这是什么写法？
		}
		if(bean.getEndDate() != null && bean.getEndDate().trim().equals("") )
		{
			queryStr += " and p.pdate <= '"+bean.getEndDate()+" 00:00:00'";//这是什么写法？
		}
		return dao.find(products, pageNo, pageSize, queryStr);
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
	public int getProducts(List<Product>products,int pageNo,int pageSize)
	{
		int totalRecords=-1;
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		Statement stmtCount=DB.getStmt(conn);
		String sql="select * from product limit "+(pageNo-1)*pageSize+","+pageSize;
		ResultSet rs=DB.getRs(stmt, sql);
		ResultSet rsCount=DB.getRs(stmtCount, "select count(*) from product");
		
		try
		{
			rsCount.next();
			totalRecords=rsCount.getInt(1);
			
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
			DB.close(rsCount);
			DB.close(stmt);
			DB.close(stmtCount);
			DB.close(conn);
		}
		return totalRecords;
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
		Product p=null;//这句话不能放在while里，否则最下方的p无法与之链接
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
