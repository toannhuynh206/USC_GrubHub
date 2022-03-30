

import java.io.IOException;

import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class regServlet
 */
@WebServlet("/login")
public class JavaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public static boolean validateEmail(String str)
    {
		 String regex = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@" 
			        + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(str);
        return m.matches();
    }
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	String error = "";

	String pass = request.getParameter("password");

	String email = request.getParameter("username");
	
	if(!validateEmail(email)) {
		error += "<div style=\"color:black; font-size:20px; background-color: red; width:100%; height:60px; text-align: center;\"> Invalid Email!</div>";
		request.setAttribute("error", error);
		request.getRequestDispatcher("register.jsp").include(request, response);
	}

	Connection con= null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","password");
			PreparedStatement pst = con.prepareStatement("select * FROM users where email = ? and password = ?");
			pst.setString(1,email);
			pst.setString(2,pass);
			ResultSet res = pst.executeQuery();
			if(res.next()) {
				request.setAttribute("username", res.getString("user"));
				request.getRequestDispatcher("Loggedin.jsp").forward(request, response);
    		}
    		else {
    			PreparedStatement ps2 = con.prepareStatement("select * from users where email = ?");
				ps2.setString(1, email);
				ResultSet rs2 = ps2.executeQuery();
				if(rs2.next()) {
					error += " <div style=\"color:black; font-size:20px; background-color: #ff6e6e; width:100%; height:60px; text-align: center;\">Incorrect Password</div>";
					request.setAttribute("error", error);
					request.getRequestDispatcher("register.jsp").include(request, response);

				}
				else {
					error += " <div style=\"color:black; font-size:20px; background-color: #ff6e6e; width:100%; height:60px; text-align: center;\"> User does not exist</div>";
					request.setAttribute("error", error);
					request.getRequestDispatcher("register.jsp").include(request, response);

				}
    		}
		}
		catch(Exception e) {
			e.printStackTrace();
		}	
	}
}
