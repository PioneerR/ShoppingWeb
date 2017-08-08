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

	//һ��Tomcat��servlet����new����������������init�������г�ʼ������ͨ����ֱ�ӵ��ÿղ����Ĺ��캯�����г�ʼ��
	//��servlet����init()�������г�ʼ���������Ǵ��в�����init()�������г�ʼ��
	//��ͨ��̳и��࣬���г�ʼ����ʱ�򣬻�������Ŀղ������캯���ĵ�һ����һ��super()���������ʸ���Ŀղ����Ĺ��캯��
	//����֪����������ζ���Щ���ݽ��г�ʼ���ģ�����Ǵ������Ĺ��캯�����Ǿ�Ҫsuper(����)�ķ�ʽ���ʸ���������Ĺ��캯��
	//����servlet����init�������г�ʼ������������servlet���ʸ����д�������init(����)�ķ���ʱ������super.init(����)
	//��������servlet�����ǳ�ʼ�����
	
	//���캯��ֻ�����ڵ��γ�ʼ������init()�����ĳ�ʼ��������servlet���󱻸��ã���ʼ����ֻ��һ��servlet����
	//����һ�㶼��д���캯��
	
	
	//1�����������˽�б���config
	private ServletConfig config=null;
	@Override
	//2����дinit���������config���󣬴Ӷ���ȡ������Ϣ�еĲ���
	public void init(ServletConfig config) throws ServletException
	{
		super.init(config);
		this.config=config;
		//�����config(��ߵ�config) ����  Tomcat��������config���������������config������ӵ��configʵ�����
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;chaset=UTF-8");
		response.setHeader("content-type", "text/html;charset=UTF-8");
		

		CategoryDataset dataset = getDataSet();
		
		//double randomNum=Math.random();
		
		String fileName = "SalesCount.jpg";
		JFreeChart chart = ChartFactory.createBarChart3D("��Ʒ����ͼ", // ͼ�����
				"��Ʒ", // Ŀ¼�����ʾ��ǩ
				"����", // ��ֵ�����ʾ��ǩ
				dataset, // ���ݼ�
				PlotOrientation.VERTICAL, // ͼ����ˮƽ����ֱ
				true, // �Ƿ���ʾͼ��(���ڼ򵥵���״ͼ������false)
				false, // �Ƿ����ɹ���
				false // �Ƿ�����URL����
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
		request.setAttribute("imgName", fileName);//servlet�в�û��session����ֻ����jsp����session����
		
		//response.sendRedirect("/Gouwu/admin/SalesCount1.jsp");
		//��Ŀ¼WebRoot����д����Ϊ������ĿGouwu�ʹ����˸�Ŀ¼
		
		//config.getServletContext().getRequestDispatcher("/admin/SalesCount1.jsp").forward(request, response);
		this.getServletContext().getRequestDispatcher("/admin/SalesCount1.jsp").forward(request, response);
	}
	

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
	
	private CategoryDataset getDataSet()//�������ݼ�
	{
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		//��ȡ������ݵ����ݶ���productStatItem
		List<ProductStatItem> items = StatService.getProductsBySaleCount();
		for (int i = 0; i < items.size(); i++) 
		{
			ProductStatItem p = items.get(i);
			//addValue���ұ�������������һ�����������ݣ��ڶ�����y��ؼ��֣���������x��ؼ���
			dataset.addValue(p.getTotalSalesCount(), "����", p.getProductName());
		}
		return dataset;
	}
	
}
