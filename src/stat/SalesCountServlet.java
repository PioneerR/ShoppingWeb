package stat;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

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
import util.PropertyMgr;
             
public class SalesCountServlet extends HttpServlet {

	public SalesCountServlet() {
		super();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;chaset=UTF-8");
		response.setHeader("content-type", "text/html;charset=UTF-8");
		
		System.out.println("ok");
		CategoryDataset dataset = getDataSet();
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

			fos_jpg = new FileOutputStream(PropertyMgr.getProperty("statImagePath") + fileName);
			//System.out.println(PropertyMgr.getProperty("statImagePath"));

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

		request.setAttribute("imgName", fileName);
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
