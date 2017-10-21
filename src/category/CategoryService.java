package category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.DB;

public class CategoryService {
	//单例设计模式
	private CategoryService(){}
	private static CategoryService service;
	public static CategoryService getInstance()
	{
		if(service==null)
		{
			service=new CategoryService();
		}
		return service;
	}
	
	
	public Category loadById(int id)
	{
		Category c=null;
		Connection conn=DB.getConn();		
		Statement stmt=DB.getStmt(conn);
		String sql="select * from category where id="+id;
		ResultSet rs=DB.getRs(stmt, sql);
		try
		{
			if(rs.next())//就算只是从结果集中取一个值，也要用rs.next()，否则光标无法移动，意味着这条数据无法取出
			{
				c=this.getCategoryFromRs(rs);
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

	
	//拿到所有根类别
	public List<Category> getCategories()
	{		
		List<Category> categories=new ArrayList<Category>();
		Connection conn=DB.getConn();
		String sql="select * from category";
		Statement stmt=DB.getStmt(conn);
		ResultSet rs=DB.getRs(stmt, sql);
		
		try
		{
			while(rs.next())
			{
				Category c=this.getCategoryFromRs(rs);
				categories.add(c);
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
		return categories;
	}
	
	public List<Category> getCategoriesGradeTwo()
	{		
		List<Category> categories=new ArrayList<Category>();
		Connection conn=DB.getConn();
		String sql="select * from category where grade=2";
		Statement stmt=DB.getStmt(conn);
		ResultSet rs=DB.getRs(stmt, sql);
		
		try
		{
			while(rs.next())
			{
				Category c=this.getCategoryFromRs(rs);
				categories.add(c);
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
		return categories;
	}
	
	
	public int getCategories(List<Category>categories,int pageNo,int pageSize)
	{		
		int totalRecords = -1;
		Connection conn=DB.getConn();
		String sql="select * from category limit "+(pageNo-1)*pageSize+","+pageSize;
		Statement stmt=DB.getStmt(conn);
		Statement stmtCount=DB.getStmt(conn);

		ResultSet rs=DB.getRs(stmt, sql);
		ResultSet rsCount=DB.getRs(stmtCount, "select count(*) from category");
		
		try
		{
			rsCount.next();
			totalRecords=rsCount.getInt(1);		
			while(rs.next())
			{
				Category c=this.getCategoryFromRs(rs);
				categories.add(c);
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
			DB.close(rsCount);
			DB.close(stmtCount);
			DB.close(conn);
		}
		return totalRecords;
	}
	
	private Category getCategoryFromRs(ResultSet rs) 
	{
		Category c=new Category();
		try
		{
			c.setId(rs.getInt("id"));
			c.setPid(rs.getInt("pid"));
			c.setName(rs.getString("name"));
			c.setDescribe(rs.getString("descr"));
			c.setCno(rs.getInt("cno"));
			c.setGrade(rs.getInt("grade"));
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return c;
	}
	
	
	public List<Category> getTopCategories()
	{
		List<Category> categories =new ArrayList<Category>();
		Connection conn=DB.getConn();
		String sql="select * from category where grade = 1";
		Statement stmt=DB.getStmt(conn);
		ResultSet rs=DB.getRs(stmt, sql);
		
		try
		{
			while(rs.next())
			{
				Category c=this.getCategoryFromRs(rs);
				categories.add(c);				
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
		return categories;
	}
	
	
	private int getParentCno(Connection conn, Category child) {
		String sql = "select cno from category where id = " + child.getPid();
		Statement stmt = DB.getStmt(conn);
		ResultSet rs = DB.getRs(stmt, sql);
		
		int cno = -1;
		
		try {
			rs.next();
			cno = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
		}
		return cno;
	}
	
	
	public int getNextCno(Connection conn,Category c)
	{
		int cno=-1;
		String sqlMax="select max(cno) from category where pid="+c.getPid();
		Statement stmtMax=DB.getStmt(conn);
		ResultSet rsMax=DB.getRs(stmtMax, sqlMax);
		try
		{
			rsMax.next();
			int cnoMax=rsMax.getInt(1);
			//System.out.println(cnoMax);
			
			//计算节点的基数,如用两位表示就是100，三位表示就是1000等
			int baseNumber = (int)Math.pow(10, Category.LEVEL_LENGTH);
			
			//构建cstr要加上的数字
			int numberToAdd = (int)Math.pow(baseNumber, Category.MAX_GRADE - c.getGrade());
			
			if(cnoMax == 0) 
			{ 
				//要加入的节点是该父亲下面的第一个子节点
				if(c.getPid() == 0) 
				{ 
					//最顶层节点
					cno = numberToAdd;
				} 
				else 
				{ 
					//其他层节点
					int parentCno = getParentCno(conn, c); //拿到父亲代表串
					cno = parentCno + numberToAdd;
				}
			} 
			else 
			{ //加入的节点不是该父亲下面的第一个
				cno = cnoMax + numberToAdd;
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			DB.close(rsMax);
			DB.close(stmtMax);
		}
		return cno;		
	}
	
	
	public void add(Category c)
	{
		Connection conn=DB.getConn();
		try
		{
			conn.setAutoCommit(false);
		}
		catch(SQLException e1)
		{
			e1.printStackTrace();
		}
		
		String sql="insert into category values(null,?,?,?,?,?)";
		PreparedStatement pstmt=DB.getPstmt(conn, sql);
		try 
		{
			int cno=getNextCno(conn,c);
			
			pstmt.setInt(1, c.getPid());
			pstmt.setString(2, c.getName());
			pstmt.setString(3, c.getDescribe());
			pstmt.setInt(4, cno);
			pstmt.setInt(5, c.getGrade());//告诉sql准备要执行什么语句
			pstmt.executeUpdate();//这句不写无法更新。告诉sql可以执行了
			conn.commit();//从内存中将执行语句提交到Mysql	
		} 
		catch (Exception e) 
		{
			try 
			{
				conn.rollback();
			} 
			catch (SQLException e1) 
			{
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		finally 
		{
			try
			{
				conn.setAutoCommit(true);
			} 
			catch (SQLException e) 
			{
				e.printStackTrace();
			}
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	public void delete(int id)
	{
		Connection conn=DB.getConn();
		String sql="delete from category where id="+id;
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
	
}
