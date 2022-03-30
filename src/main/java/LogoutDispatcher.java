import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serial;

/**
 * Servlet implementation class LogoutDispatcher
 */
@WebServlet("/logout")

public class LogoutDispatcher extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * @throws ServletException 
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        // TODO Remove userID cookie
    	Cookie[] cookies = request.getCookies();
	  	for(Cookie cookie: cookies){
		  	if(cookie.getName().equals("name")) {	
	  			System.out.println(cookie.getName() + " " + cookie.getValue());
		  		cookie.setMaxAge(0);
		  		response.addCookie(cookie);
		  	}	
	  	}
	  	
		response.sendRedirect(request.getContextPath() + "/logout.jsp");
    }

    /**
     * @throws ServletException 
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doGet(request, response);
    }

}
