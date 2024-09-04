package model;

public class StudentManager 
{
  
	private String ips="";
	static int count=0;


  public static void incCount()
{
count++;
}
public static int getCount()
{
return count;
}

	public void append(String ip)
		{
			this.ips+=ip;
			
		}

  public boolean find(String ip) 
	{
		boolean ret=false;
		if(ips.contains(ip))
			{
				ret=true;
			}
		return ret;
	}
   

  
	
  }
