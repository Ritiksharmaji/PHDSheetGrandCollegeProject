import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DataManager;

public class FirstServlet extends javax.servlet.http.HttpServlet
    implements javax.servlet.Servlet {
  private static final long serialVersionUID = 1L;
String str = "";
  public FirstServlet() {
    super();
    }

  public void init(ServletConfig config) throws ServletException {
    System.out.println("*** initializing controller servlet.");
    super.init(config);

    DataManager dataManager = new DataManager();
    dataManager.setDbURL(config.getInitParameter("dbURL"));
    dataManager.setDbUserName(config.getInitParameter("dbUserName"));
    dataManager.setDbPassword(config.getInitParameter("dbPassword"));
	dataManager.connect();
	ServletContext context = config.getServletContext();
    //context.setAttribute("base", config.getInitParameter("base"));
    //context.setAttribute("imageURL", config.getInitParameter("imageURL"));
    //context.setAttribute("dataManager", dataManager);
	//str+="<br>"+config.getInitParameter("dbURL");
	//str+="<br>"+config.getInitParameter("dbUserName");
	//str+="<br>"+config.getInitParameter("dbPassword");
    //ServletContext context = config.getServletContext();
    //context.setAttribute("base", config.getInitParameter("base"));
    //context.setAttribute("imageURL", config.getInitParameter("imageURL"));
    context.setAttribute("db", dataManager);

    }

  protected void doGet(HttpServletRequest request,
      HttpServletResponse response) throws ServletException, IOException 
	{
		
	    //RequestDispatcher requestDispatcher =
		  //getServletContext().getRequestDispatcher("/login.html");
	    //requestDispatcher.forward(request, response);
    }
    
  }
