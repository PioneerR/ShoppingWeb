package util;

import java.io.IOException;
import java.util.Properties;

public class PropertyMgr {

	
	static Properties props=new Properties();
	
	static
	{
		try
		{
			props.load(PropertyMgr.class.getClassLoader().getResourceAsStream("web.xml"));
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}		
	}
	private PropertyMgr(){};
	
	
	public static String getProperty(String key) {
		return props.getProperty(key);
	}

}
