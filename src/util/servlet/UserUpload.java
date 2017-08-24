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

	//init方法有两种，一种是有带参数的，一种是没带参数的
	//一般复写有带参数的，并将Tomcat生成的servlet config对象传给子类FileUpload，从而子类拥有了config对象
	
	//1、创建私有变量
	private ServletConfig config=null;
	@Override
	//2、重写init方法，获得config对象，从而获取配置信息中的参数
	public void init(ServletConfig config) throws ServletException 
	{
		this.config=config;
	}
	
	//File在io包，该路径用于存放临时文件
	private File tempPath=new File("C:\\Users\\Administrator\\Workspaces\\MyEclipse Professional 2014\\upload\\temp\\");
	
	public void destroy()//用于关闭servlet服务进程的一部分
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
		//3、获得配置文档中<init-param>标签下的参数uploadPath为name，uploadpath为value
		String uploadPath=this.config.getInitParameter("uploadPath");
		PrintWriter out=response.getWriter();
		//System.out.println(uploadPath);
		//System.out.println(request.getContentLength());//获取文件大小
		//获取本次请求过程中，页面的编码格式,返回mime类型，MIME类型的默认值是“text/html”
		//System.out.println(request.getContentType());
		
		//使用Apache文件上传组件处理文件上传
		//4、创建一个DiskFileItemFactory工厂
		DiskFileItemFactory factory=new DiskFileItemFactory();//在upload包
		//设置最多只允许在内存中存储的数据大小,单位:字节,该内存是给JVM使用的内存空间，相当于JVM的工作空间大小
		//一旦上传文件超出这个限值，在内存中无法保存该文件内容，就会将超出的数据存放在硬盘中，解析时再调用
		factory.setSizeThreshold(4096);
		//设置一旦文件超过getSizeThreshold()的值时，数据存放在硬盘的目录
		factory.setRepository(tempPath);
		
		//5、创建一个文件上传解析器
		//使用ServletFileUpload()默认构造器创建未初始化的实
		//需要以factory作为构造函数或者setFileItemFactory()方法对factory进行配置
		ServletFileUpload upload=new ServletFileUpload(factory);//在upload包
		upload.setSizeMax(5000000);//设置上传文件最大值
		
		try
		{
			//获取请求中的文件对象FileItem，通过上传解析器的parseRequest()方法获取所有上传(传递)的文件
			//即返回一个文件对象集合，该对象集合中的对象有的是上传的文件，封装在文件对象中
			//有的是参数对象，也一样封装在文件对象中了
			List<FileItem> fileItems=upload.parseRequest(request);
			Iterator it=fileItems.iterator();
			
			// 正则匹配，过滤路径取文件名
			String regExp = ".+\\.(.+)$";
			//.表示任何字符，$表示行的结尾，\\表示反斜杠
			//www.zcool.com.cn/work/ZMTg1MzIxNzY=/2.html
			//C:\Users\Administrator\Desktop\阅读
			
			//过滤掉的文件类型
			String [] errorType={".exe",".com",".cgi",".jsp"};
			Pattern p=Pattern.compile(regExp);//pattern在util.regex包
			
			while(it.hasNext())
			{
				//拿到一个文件对象
				FileItem item=(FileItem)it.next();//FileItem在upload包	
				if(item.isFormField())//判断该表单项是否是form表单类型，比如传递过来的参数id=1
				{
					if(item.getFieldName().equals("id"))//文件对象.getFieldName()用于获取文件对象中的名
					{
						id=Integer.parseInt(item.getString());
						//文件对象.getString()用户获取文件对象的值，类似request.getParameter()
					}
				}
				System.out.println("上传文件类型："+item.getContentType());//获取上传文件类型
				System.out.println("是否保存在内存中："+item.isInMemory());//判断文件是保存在内存(true)中还是硬盘(false)中
				
				//忽略错误类型的文件对象
				if(!item.isFormField())
				{
					String name=item.getName();//获取上传文件的文件名,不包含文件路径
					long size=item.getSize();//获取上传文件的大小
					//System.out.println(name+size);
					
					if(name==null || name.equals("") && size==0)
					{
						continue;//如果拿到的文件对象是上传文件的类型，但文件名和大小有误
								 //那么下面的代码就不执行，继续拿下一个文件对象
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
							//保存上传的文件到指定的目录
							item.write(new File(uploadPath+id+".jpg"));							
							//文件名不能包含\，所以upload无法写入文件名。文件名为：id值.jpg
							//out.print("上传文件"+name+"至路径："+uploadPath + "&nbsp;&nbsp;成功！！&nbsp;文件大小：" + size + "<br>");
							item.delete();//如果文件保存在临时文件夹中，会清空临时文件，一般写在最后，因为要将文件上传完毕，才能删除临时文件
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
