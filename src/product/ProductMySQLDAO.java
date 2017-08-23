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

public class ProductMySQLDAO implements ProductDAO{

	public List<Product> getProducts()
	{
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		String sql="select *from product order by pdate";
		ResultSet rs=DB.getRs(stmt, sql);
		
		List<Product> products=new ArrayList();
		try
		{
			while(rs.next())
			{
				Product p=getProductFromRs(rs);
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
	/**
	 * @param lazy 为true时，只取Product的信息，否则同时取出Product内Category对象的信息
	 */
	public int getProducts(List<Product>products,int pageNo,int pageSize,boolean lazy)
	{
		int totalRecords = -1;
		Connection conn = DB.getConn();
		Statement stmt = DB.getStmt(conn);
		
		String sql = "";
		if(lazy) {
			sql = "select * from product order by pdate desc";
		} else {
			sql = "select p.id productid, p.name pname, p.descr pdescr, p.normalprice, " +
					" p.memberprice, p.pdate, p.categoryid , " +
					" c.id categoryid, c.name cname, c.descr cdescr, c.pid, c.cno, c.grade " +
					" from product p join category c on (p.categoryid = c.id) order by p.pdate desc";
		}
		sql +=  " limit " + (pageNo - 1) * pageSize + "," + pageSize;
				
		
		ResultSet rs = DB.getRs(stmt, sql);
		
		Statement stmtCount = DB.getStmt(conn);
		ResultSet rsCount = DB.getRs(stmtCount,
				"select count(*) from product");
		
		//products = new ArrayList<Product>(); 千万小心这句话不要添加
		try {
			rsCount.next();
			totalRecords = rsCount.getInt(1);
			
			while (rs.next()) {
				Product p = null;
				if(lazy) {
					p = this.getProductFromRs(rs);
				} else {
					p = new Product();
					p.setId(rs.getInt("productid"));
					p.setName(rs.getString("pname"));
					p.setDescribe(rs.getString("pdescr"));
					p.setNormalPrice(rs.getInt("normalprice"));
					p.setMemberPrice(rs.getInt("memberprice"));
					p.setDate(rs.getTimestamp("pdate"));
					p.setCategoryId(rs.getInt("categoryid"));
					
					Category c = new Category();
					c.setId(rs.getInt("categoryid"));
					c.setName(rs.getString("cname"));
					c.setDescribe(rs.getString("cdescr"));
					c.setPid(rs.getInt("pid"));
					c.setCno(rs.getInt("cno"));
					c.setGrade(rs.getInt("grade"));
					
					p.setCategory(c);
				}
				
				
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsCount);
			DB.close(stmtCount);
			DB.close(stmt);
			DB.close(rs);
			DB.close(conn);
		}

		return totalRecords;
		
	}
	public void add(Product p)
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "insert into product values (null, ?, ?, ?, ?, ?, ?)";
			pstmt = DB.getPstmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescribe());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setTimestamp(5, new Timestamp(p.getDate().getTime()));
			pstmt.setInt(6, p.getCategoryId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	public void delete(int id)
	{
		Connection conn = null;
		Statement stmt = null;
		String sql;
		try {
			conn = DB.getConn();
			sql = "delete from product where id = " + id;
			stmt = DB.getStmt(conn);
			DB.executeUpdate(stmt, sql);
		} finally {
			DB.close(stmt);
			DB.close(conn);
		}	
	}
	public void update(Product p)
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "update product set name=? , descr=?, normalprice=?, memberprice=?, categoryid=? where id=?";
			pstmt = DB.getPstmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescribe());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setInt(5, p.getCategoryId());
			pstmt.setInt(6, p.getId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	public Product loadById(int id)
	{
		Connection conn = null;
		ResultSet rs = null;
		Statement stmt = null;
		Product p = null;

		try {
			String sql = "select * from product where id = " + id;
			conn = DB.getConn();
			stmt = DB.getStmt(conn);
			rs = DB.getRs(stmt, sql);
			if (rs.next()) {
				p = getProductFromRs(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(stmt);
			DB.close(rs);
			DB.close(conn);
		}
		return p;		
	}
	public void delete(String conditionStr)
	{
		Connection conn = null;
		Statement stmt = null;
		String sql;
		try {
			conn = DB.getConn();
			sql = "delete from product " + conditionStr;
			stmt = DB.getStmt(conn);
			DB.executeUpdate(stmt, sql);
		} finally {
			DB.close(stmt);
			DB.close(conn);
		}
	}
	//输入集合，页码，每页显示数量，查询的内容，获得数据总条数以及将数据装入集合中，显示到前台
	public int find(List<Product>products,int pageNo,int pageSize,String queryStr)
	{
		int totalRecords=-1;
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		
		String sql="";
		sql="select p.id productid,p.name pname,p.descr pdescr,p.normalprice,"
			+ "p.memberprice ,p.pdate,p.categoryid,"+" c.id categoryid,c.name cname,"
			+ " c.descr cdescr,c.pid,c.cno,c.grade from product p join category c "
			+ " on (p.categoryid=c.id) "+queryStr+" order by p.pdate asc "
			+" limit "+(pageNo-1)*pageSize+","+pageSize;
		//本次操作中，将两个表中的键进行统一，即键被该句重命名了。之后的句子可以沿用这里的命名
		//c.id后面注意空格（衔接的位置注意空格），因为queryStr是where。。
		//写sql长句，注意检查，有没有少空格，有没有少标点符号，比如逗号，引号等等，否则会报空指针异常
		
		ResultSet rs=DB.getRs(stmt, sql);
		Statement stmtCount=DB.getStmt(conn);//一个statement只能获取一个ResultSet?
		ResultSet rsCount=DB.getRs(stmtCount, "select count(*) from product"
						 +queryStr.replaceAll("p\\.", "").replaceAll("c\\.",""));
		
		//该句要用回原名？？？？？？？？？？？？？不是特别理解
		//？？？？？？？？？？？？？？？？？？？？？？？？？？
		//？？？？？？？？？？？？？？？？？？？？？？？？？？
		
		try
		{
			rsCount.next();
			totalRecords=rsCount.getInt(1);//注意如何使用，不太熟悉
			
			while(rs.next())
			{
				Product p=new Product();
				p.setId(rs.getInt("productid"));
				p.setName(rs.getString("pname"));
				p.setDescribe(rs.getString("pdescr"));
				p.setNormalPrice(rs.getInt("normalprice"));
				p.setMemberPrice(rs.getInt("memberprice"));
				p.setDate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				
				Category c=new Category();
				c.setId(rs.getInt("categoryid"));
				c.setName(rs.getString("cname"));
				c.setDescribe(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setCno(rs.getInt("cno"));
				c.setGrade(rs.getInt("grade"));
				
				p.setCategory(c);	
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
	public Product getProductFromRs(ResultSet rs)
	{
		Product p=null;
		try
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
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return p;
	}
}
