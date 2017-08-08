package stat;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.DB;

public class StatService {

	public static List<ProductStatItem> getProductsBySaleCount() 
	{
		List<ProductStatItem> items=new ArrayList<ProductStatItem>();
		Connection conn=DB.getConn();
		Statement stmt=DB.getStmt(conn);
		String sql=null;
		ResultSet rs=null;
		
		try
		{
			sql="select productid,sum(pcount) totalsalescount,name from salesitem join "
				+"product on salesitem.productid=product.id group by productid order by totalsalescount desc";
			rs=DB.getRs(stmt, sql);
			while(rs.next())
			{
				ProductStatItem p=new ProductStatItem();
				p.setProductId(rs.getInt("productid"));
				p.setProductName(rs.getString("name"));
				p.setTotalSalesCount(rs.getInt("totalsalescount"));
				
				items.add(p);				
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
		return items;
	}
}
