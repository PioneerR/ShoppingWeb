package category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import util.DB;

//该javabean只用于存放set与get方法，其他管理类的方法，存放与CagegoryService类中

public class Category {

	public static final int MAX_GRADE=3;//最多三个级别
	public static final int LEVEL_LENGTH=2;//每个级别用两位数表示
	
	private int id;
	private String name;
	private String describe;
	private int pid;
	private int cno;
	private int grade;
	
	public int getId()
	{
		return id;
	}
	public String getName()
	{
		return name;
	}
	public String getDescribe()
	{
		return describe;
	}
	public int getPid()
	{
		return pid;
	}	
	public int getCno()
	{
		return cno;
	}
	public int getGrade()
	{
		return grade;
	}
	
	
	public void setId(int id)
	{
		this.id=id;
	}
	public void setName(String name)
	{
		this.name=name;
	}
	public void setDescribe(String describe)
	{
		this.describe=describe;
	}
	public void setPid(int pid)
	{
		this.pid=pid;
	}
	public void setCno(int cno)
	{
		this.cno=cno;
	}
	public void setGrade(int grade)
	{
		this.grade=grade;
	}
	
	public void update()
	{
		Connection conn=DB.getConn();
		String sql="update category set name=?,descr=? where id=?";
		PreparedStatement pstmt=DB.getPstmt(conn, sql);
		
		try
		{
			pstmt.setString(1, name);
			pstmt.setString(2, describe);
			pstmt.setInt(3, id);
			
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
