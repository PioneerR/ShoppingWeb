package stat;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
             
public class SalesCountServlet extends HttpServlet {

	//一、Tomcat把servlet对象new出来，接下来调用init方法进行初始化。普通的类直接调用空参数的构造函数进行初始化
	//但servlet调用init()方法进行初始化，而且是带有参数的init()方法进行初始化
	//普通类继承父类，进行初始化的时候，会在子类的空参数构造函数的第一行有一句super()方法，访问父类的空参数的构造函数
	//进而知道父类是如何对这些数据进行初始化的，如果是带参数的构造函数，那就要super(参数)的方式访问父类带参数的构造函数
	//由于servlet是用init方法进行初始化，所以子类servlet访问父类中带参数的init(参数)的方法时，就用super.init(参数)
	//这样子类servlet才算是初始化完毕
	
	//构造函数只能用于单次初始化，而init()方法的初始化可以让servlet对象被复用，至始至终只有一个servlet对象
	//所以一般都不写构造函数
	
	
	//1、创建子类的私有变量config
	private ServletConfig config=null;
	@Override
	//2、重写init方法，获得config对象，从而获取配置信息中的参数
	public void init(ServletConfig config) throws ServletException
	{
		super.init(config);
		this.config=config;
		//子类的config(左边的config) 等于  Tomcat传进来的config对象，这样，子类的config才真正拥有config实体对象
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;chaset=UTF-8");
		response.setHeader("content-type", "text/html;charset=UTF-8");
		

		CategoryDataset dataset = getDataSet();
		
		//double randomNum=Math.random();
		
		String fileName = "SalesCount.jpg";
		JFreeChart chart = ChartFactory.createBarChart3D("产品销量图", // 图表标题
				"产品", // 目录轴的显示标签
				"销量", // 数值轴的显示标签
				dataset, // 数据集
				PlotOrientation.VERTICAL, // 图表方向：水平、垂直
				true, // 是否显示图例(对于简单的柱状图必须是false)
				false, // 是否生成工具
				false // 是否生成URL链接
				);

		FileOutputStream fos_jpg = null;
		try {

String path=this.getServletConfig().getInitParameter("statImagePath");
			fos_jpg = new FileOutputStream(path + fileName);

			ChartUtilities.writeChartAsJPEG(fos_jpg, 0.5f, chart, 400, 300, null);
		} 
		finally 
		{ 
			try 
			{
				fos_jpg.close();
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
		}
		request.setAttribute("imgName", fileName);//servlet中并没有session对象，只有在jsp中有session对象
		
		//response.sendRedirect("/Gouwu/admin/SalesCount1.jsp");
		//根目录WebRoot不必写，因为整个项目Gouwu就代表了根目录
		
		//config.getServletContext().getRequestDispatcher("/admin/SalesCount1.jsp").forward(request, response);
		this.getServletContext().getRequestDispatcher("/admin/SalesCount1.jsp").forward(request, response);
	}
	

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
	
	private CategoryDataset getDataSet()//设置数据集
	{
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		//获取存放数据的数据对象productStatItem
		List<ProductStatItem> items = StatService.getProductsBySaleCount();
		for (int i = 0; i < items.size(); i++) 
		{
			ProductStatItem p = items.get(i);
			//addValue的右边三个参数，第一个参数是数据，第二个是y轴关键字，第三个是x轴关键字
			dataset.addValue(p.getTotalSalesCount(), "销量", p.getProductName());
		}
		return dataset;
	}
	
}
