package util.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


public class UserUpload extends HttpServlet {

	//init���������֣�һ�����д������ģ�һ����û��������
	//һ�㸴д�д������ģ�����Tomcat���ɵ�servlet config���󴫸�����FileUpload���Ӷ�����ӵ����config����
	
	//1������˽�б���
	private ServletConfig config=null;
	@Override
	//2����дinit���������config���󣬴Ӷ���ȡ������Ϣ�еĲ���
	public void init(ServletConfig config) throws ServletException 
	{
		this.config=config;
	}
	
	//File��io������·�����ڴ����ʱ�ļ�
	private File tempPath=new File("C:\\Users\\Administrator\\Workspaces\\MyEclipse Professional 2014\\upload\\temp\\");
	
	public void destroy()//���ڹر�servlet������̵�һ����
	{
		config=null;
		super.destroy();
	}
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;chaset=UTF-8");
		response.setHeader("content-type","text/html;charset=UTF-8");
		
		int id=-1;
		//3����������ĵ���<init-param>��ǩ�µĲ���uploadPathΪname��uploadpathΪvalue
		String uploadPath=this.config.getInitParameter("uploadPath");
		PrintWriter out=response.getWriter();
		//System.out.println(uploadPath);
		//System.out.println(request.getContentLength());//��ȡ�ļ���С
		//��ȡ������������У�ҳ��ı����ʽ,����mime���ͣ�MIME���͵�Ĭ��ֵ�ǡ�text/html��
		//System.out.println(request.getContentType());
		
		//ʹ��Apache�ļ��ϴ���������ļ��ϴ�
		//4������һ��DiskFileItemFactory����
		DiskFileItemFactory factory=new DiskFileItemFactory();//��upload��
		//�������ֻ�������ڴ��д洢�����ݴ�С,��λ:�ֽ�,���ڴ��Ǹ�JVMʹ�õ��ڴ�ռ䣬�൱��JVM�Ĺ����ռ��С
		//һ���ϴ��ļ����������ֵ�����ڴ����޷�������ļ����ݣ��ͻὫ���������ݴ����Ӳ���У�����ʱ�ٵ���
		factory.setSizeThreshold(4096);
		//����һ���ļ�����getSizeThreshold()��ֵʱ�����ݴ����Ӳ�̵�Ŀ¼
		factory.setRepository(tempPath);
		
		//5������һ���ļ��ϴ�������
		//ʹ��ServletFileUpload()Ĭ�Ϲ���������δ��ʼ����ʵ
		//��Ҫ��factory��Ϊ���캯������setFileItemFactory()������factory��������
		ServletFileUpload upload=new ServletFileUpload(factory);//��upload��
		upload.setSizeMax(5000000);//�����ϴ��ļ����ֵ
		
		try
		{
			//��ȡ�����е��ļ�����FileItem��ͨ���ϴ���������parseRequest()������ȡ�����ϴ�(����)���ļ�
			//������һ���ļ����󼯺ϣ��ö��󼯺��еĶ����е����ϴ����ļ�����װ���ļ�������
			//�е��ǲ�������Ҳһ����װ���ļ���������
			List<FileItem> fileItems=upload.parseRequest(request);
			Iterator it=fileItems.iterator();
			
			// ����ƥ�䣬����·��ȡ�ļ���
			String regExp = ".+\\.(.+)$";
			//.��ʾ�κ��ַ���$��ʾ�еĽ�β��\\��ʾ��б��
			//www.zcool.com.cn/work/ZMTg1MzIxNzY=/2.html
			//C:\Users\Administrator\Desktop\�Ķ�
			
			//���˵����ļ�����
			String [] errorType={".exe",".com",".cgi",".jsp"};
			Pattern p=Pattern.compile(regExp);//pattern��util.regex��
			
			while(it.hasNext())
			{
				//�õ�һ���ļ�����
				FileItem item=(FileItem)it.next();//FileItem��upload��	
				if(item.isFormField())//�жϸñ����Ƿ���form�����ͣ����紫�ݹ����Ĳ���id=1
				{
					if(item.getFieldName().equals("id"))//�ļ�����.getFieldName()���ڻ�ȡ�ļ������е���
					{
						id=Integer.parseInt(item.getString());
						//�ļ�����.getString()�û���ȡ�ļ������ֵ������request.getParameter()
					}
				}
				System.out.println("�ϴ��ļ����ͣ�"+item.getContentType());//��ȡ�ϴ��ļ�����
				System.out.println("�Ƿ񱣴����ڴ��У�"+item.isInMemory());//�ж��ļ��Ǳ������ڴ�(true)�л���Ӳ��(false)��
				
				//���Դ������͵��ļ�����
				if(!item.isFormField())
				{
					String name=item.getName();//��ȡ�ϴ��ļ����ļ���,�������ļ�·��
					long size=item.getSize();//��ȡ�ϴ��ļ��Ĵ�С
					//System.out.println(name+size);
					
					if(name==null || name.equals("") && size==0)
					{
						continue;//����õ����ļ��������ϴ��ļ������ͣ����ļ����ʹ�С����
								 //��ô����Ĵ���Ͳ�ִ�У���������һ���ļ�����
					}

					Matcher m=p.matcher(name);
					boolean result=m.find();					
					if(result)
					{
						for(int temp=0;temp<errorType.length;temp++)
						{
							if(m.group(1).endsWith(errorType[temp]))
							{
								throw new IOException(name+":wrong type");
							}
						}
						try
						{
							//�����ϴ����ļ���ָ����Ŀ¼
							item.write(new File(uploadPath+id+".jpg"));							
							//�ļ������ܰ���\������upload�޷�д���ļ������ļ���Ϊ��idֵ.jpg
							//out.print("�ϴ��ļ�"+name+"��·����"+uploadPath + "&nbsp;&nbsp;�ɹ�����&nbsp;�ļ���С��" + size + "<br>");
							item.delete();//����ļ���������ʱ�ļ����У��������ʱ�ļ���һ��д�������ΪҪ���ļ��ϴ���ϣ�����ɾ����ʱ�ļ�
							response.sendRedirect("/Gouwu/Usermodify1.jsp");
						}
						catch(Exception e)
						{
							out.println(e);
						}
					}
					else
					{
						throw new IOException("fail to upload");
					}
				}
			}
		}
		catch(IOException e)
		{
			
			out.println(e);
		}
		catch(FileUploadException e)
		{
			out.println(e);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request,response);
	}
}
