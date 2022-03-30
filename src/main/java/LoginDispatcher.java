import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serial;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class LoginDispatcher
 */
@WebServlet("/log")
public class LoginDispatcher extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		

	String error = "";
	String pass = request.getParameter("password");
	String email = request.getParameter("email");
	System.out.println(email);
	System.out.println(pass);

	PreparedStatement psEmail = null;
	PreparedStatement psUser = null;
	ResultSet rsEmail = null;
	ResultSet rsUser = null;
	RequestDispatcher dispatcher = null;
	Connection con= null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");
			
			psEmail= con.prepareStatement("select * from users WHERE email=?");
			psEmail.setString(1, email);
			rsEmail = psEmail.executeQuery();
			
			if(!rsEmail.next()) {
				error += " <div style=\"color:black; font-size:20px; background-color: red; width:100%; height:60px; text-align: center;\"> This Email doesn't exist</div>";
			}		
			if (!error.equals("")) {
				request.setAttribute("error", error);
	    		request.getRequestDispatcher("register.jsp").include(request, response);
			}
			else {
			
			
         	psUser = con.prepareStatement("select user from users WHERE email=? and password = ?");
         	psUser.setString(1, email);
         	psUser.setString(2, pass);
         	rsUser= psUser.executeQuery();
         	
         	if(!rsUser.next()) {
				error += " <div style=\"color:black; font-size:20px; background-color: red; width:100%; height:60px; text-align: center;\"> Incorrect Password </div>";
				request.setAttribute("error", error);
	    		request.getRequestDispatcher("register.jsp").include(request, response);
			}
         	else {
         		String cookieName = rsUser.getString("user");
        		Cookie cookie = new Cookie("name", cookieName);
        		cookie.setMaxAge(60*60);
        		response.addCookie(cookie);
        		response.sendRedirect(request.getContextPath() + "/logout.jsp");
         		
         	}
			
   
			}
			con.close();


  	}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	

}
			

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
