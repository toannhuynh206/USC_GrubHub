

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class regServlet
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		

	String error = "";
	String userName = request.getParameter("username");
	String pass = request.getParameter("password");
	String confirmPass = request.getParameter("confirmpassword");
	String email = request.getParameter("email");
	PreparedStatement psEmail = null;
	PreparedStatement psUser = null;
	ResultSet rsEmail = null;
	ResultSet rsUser = null;
	if(!pass.equals(confirmPass)) {
		error += " <div style=\"color:black; font-size:20px; background-color: red; width:100%; height:60px; text-align: center;\"> Passwords do not match!</div>";
	}
	RequestDispatcher dispatcher = null;
	Connection con= null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");
			
			psEmail= con.prepareStatement("select * from users WHERE email=?");
			psEmail.setString(1, email);
			rsEmail = psEmail.executeQuery();
			String regex = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@" 
	                + "[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
	        Pattern p = Pattern.compile(regex);
	        Matcher m = p.matcher(email);
	        if(!m.matches()) {
	        	error += " <div style=\"color:white; font-size:20px; background-color: #ff6e6e; width:100%; height:60px; text-align: center;\"> Email is not formatted correctly</div>";
	        } 
			
			if(rsEmail.next()) {
				error += " <div style=\"color:black; font-size:20px; background-color: red; width:100%; height:60px; text-align: center;\"> This Email is already registered!</div>";
			}
			psUser= con.prepareStatement("select * from users WHERE user=?");
			psUser.setString(1, userName);
			rsUser = psUser.executeQuery();
			
			if(rsUser.next()) {
				error += " <div style=\"color:black; font-size:20px; background-color: red; width:100%; height:60px; text-align: center;\"> Username already exists!</div>";
				
			}
			
			if (!error.equals("")) {
				System.out.println("bruh");
				request.setAttribute("error", error);
	    		request.getRequestDispatcher("register.jsp").include(request, response);
			}
			else {
			
			
			PreparedStatement pst = con.prepareStatement("insert into users(user,password,email) values(?,?,?)");
			pst.setString(1, userName);
			pst.setString(2, pass);
			pst.setString(3, email);
			int rowCount = pst.executeUpdate();
			con.close();
			String cookieName = userName.replace(" ", "&");
    		
    		Cookie cookie = new Cookie("name", cookieName);
    		cookie.setMaxAge(60*60);
    		response.addCookie(cookie);
    		response.sendRedirect(request.getContextPath() + "/logout.jsp");
			}

  	}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	

}
			

	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
