package model;

import java.sql.*;



public class DataManager {
  
	private Connection con=null;
	private String message="";
	private ResultSet res=null;
	private Statement st=null;
	private int effected_rows=-1;
	private boolean flag=false;
	private String dbURL = "";
	private String dbUserName = "";
	private String dbPassword = "";


	public void connect()
		{
			try
			{
				flag=true;
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				con = DriverManager.getConnection(getDbURL(), getDbUserName(),getDbPassword());
				st=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);	
			}
			catch(Exception e)
			{
				message=e.getMessage();
			}
			
		}
  public void setDbURL(String dbURL) {
    this.dbURL = dbURL;
    }
  public String getDbURL() {
    return dbURL;
    }

  public void setDbUserName(String dbUserName) {
    this.dbUserName = dbUserName;
    }
	public Connection getConnection()
	{
		if(con!=null)
		{
			return con;
		}
		else
		{
			connect();
			return con;
		}
	}
  public String getDbUserName() {
    return dbUserName;
    }

  public void setDbPassword(String dbPassword) {
    this.dbPassword = dbPassword;
    }
  public String getDbPassword() {
    return dbPassword;
    }

  public boolean operation(String query,String operation)
	{
		try
		{
			if(con!=null)
			{
				flag=true;
					//Class.forName("com.mysql.jdbc.Driver").newInstance();
				//con = DriverManager.getConnection("jdbc:mysql:///ezlib","root", "tomweb");
				st=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);	

				if(operation.equals("select"))	
				{
					res=st.executeQuery(query);
					if(res.next())
					{
						message=operation+" success";
						return(true);
					}
					else 
					{
						message=operation+" no value in the resultset ";
						return(false);
					}
				}
				else 
				{
					message="** in else ** "+query;
					effected_rows=st.executeUpdate(query);
					message="** done ** ";
					message=operation+" success";
					return(true);
				}
			}
			else
			{
				message="NOT CONNECTED YET.";
				return false;
			}
		}
		catch(Exception e)
		{
			message = operation+" Failed "+e.getMessage()+" "+query;
			return(false);
		}
	}
	public ResultSetMetaData getMetaData() 
	{
		try
		{
			return(res.getMetaData());
		}
		catch(SQLException e)
		{
			message="MeataDataObject error "+e.getMessage();
			return(null);
		}
	}
	public String getErrorMessage()
	{
		return(message);
	}
	public ResultSet getResultSet()
	{
		return(res);
	}
	public int getEffectedRows()
	{
		return(effected_rows);
	}
	public void close()
	{
		try
		{
			if(flag)
			{
				st.close();
				con.close();
			}
		}
		catch(Exception e)
		{
		}
	}
  }
