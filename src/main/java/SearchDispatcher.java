import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Util.Business;
import Util.RestaurantDataParser;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Serial;
import java.net.URISyntaxException;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Servlet implementation class SearchDispatcher
 */
@WebServlet("/Search")
public class SearchDispatcher extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    static ArrayList<Business> order =null;

    /**
     * Default constructor.
     */
    public SearchDispatcher() {
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext servletContext = getServletContext();
        // TODO get json file as stream, Initialize FakeYelpAPI by calling its initalize
        // method
        try {
			RestaurantDataParser.Init();
			//order = RestaurantDataParser.getBusinesses();
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
    	String searchVal = request.getParameter("name");	
    	String selectBy = request.getParameter("selector");
    	String sorter = request.getParameter("sorter");
    	String sqlS;
    	if(sorter.equals("review_count")) {
    		sqlS = "rat.review_count DESC";
    	}
    	else if(sorter.equals("rating")) {
    		sqlS = "rat.rating DESC";
    	}
    	else {
    		sqlS = "rd.estimated_price ASC";
    	}
    	
    	order = RestaurantDataParser.getBusinesses( searchVal,sqlS,selectBy);
    	request.setAttribute("data", order);
    	request.getRequestDispatcher("results.jsp").forward(request,response);
      
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }
}