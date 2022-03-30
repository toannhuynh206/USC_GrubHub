package Util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

import javax.management.RuntimeErrorException;
import javax.print.DocFlavor.URL;

import org.apache.tomcat.util.json.JSONParser;

import com.google.gson.Gson;

/**
 * A class that pretends to be the Yelp API
 */
public class RestaurantDataParser {
    private static Boolean ready = false;
    private static Business[] parsedBuisnesses;
    private static HashMap<String,Business> buisnessIdentifier= new HashMap<String,Business>();
    /**
     * Initializes the DB with json data
     *
     * @param responseString the Yelp json string
     * @throws ClassNotFoundException 
     * @throws SQLException 
     * @throws IOException 
     * @throws URISyntaxException 
     */
    public static void Init(/*String responseString*/) throws ClassNotFoundException, SQLException, IOException, URISyntaxException {
       
        
        try {
        	java.net.URL ifstream = RestaurantDataParser.class.getClassLoader().getResource("restaurant_data.json");
      
        	File file = new File(ifstream.toURI());

 	        Scanner sc = new Scanner(file);
 	        String temp = "";
 	        while (sc.hasNext()) {
 	        	temp+=sc.nextLine();
 	        }
 	        
 	       parsedBuisnesses = new Gson().fromJson(temp, Business[].class);
 	        for(int i=0;i<parsedBuisnesses.length;i++) {
 	        	buisnessIdentifier.put(parsedBuisnesses[i].getID(), parsedBuisnesses[i]);
 	        }
 	       Class.forName("com.mysql.cj.jdbc.Driver");
 	       Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");
 	       PreparedStatement ps;
 	       PreparedStatement ps1;
 	       PreparedStatement ps2;
 	       PreparedStatement ps3;
 	       PreparedStatement ps4;
 	       PreparedStatement ps5;

           ResultSet rs;
          ps = con.prepareStatement("SET SQL_SAFE_UPDATES = 0;");
          ps.execute();
          ps = con.prepareStatement("DELETE FROM test.Rating_details");
          ps.execute();
          ps = con.prepareStatement("DELETE FROM test.Category");
          ps.execute();
          ps = con.prepareStatement("DELETE FROM test.Restaurant_details");
          ps.execute();
          ps = con.prepareStatement("DELETE FROM test.Restaurant");
          ps.execute();
        	for (int i = 0; i < parsedBuisnesses.length; i++) {
        		
        		//insert into the Restaurant table
        		ps1 = con.prepareStatement("INSERT INTO test.Restaurant (restaurant_id, restaurant_name,details_id,rating_id) VALUES (?, ?,?,?)");
        		ps1.setString(1, parsedBuisnesses[i].getID());
        		ps1.setString(2,  parsedBuisnesses[i].getName());
        		ps1.setInt(3, i+1);
        		ps1.setInt(4, i+1);

        		ps1.execute();
        		
        		//insert into Restaurant details
        		ps2 = con.prepareStatement("INSERT INTO test.Rating_details (rating_id,review_count, rating) VALUES (?, ?,?)");
        		ps2.setInt(1, i+1);
	        	ps2.setInt(2, parsedBuisnesses[i].getReviewcount());
	        	ps2.setDouble(3,  parsedBuisnesses[i].getRating());
	        	ps2.execute();
	        	
	        	//insert into Categories
	     
	        	List<String> t = parsedBuisnesses[i].getCategories();
	        	for (int j = 0; j < t.size(); j++) {
	            	ps3 = con.prepareStatement("INSERT INTO test.Category (category_name,restaurant_id) VALUES (?,?)");
	            	ps3.setString(1, t.get(j)); 
	            	ps3.setString(2, parsedBuisnesses[i].getID());
	            	try {
						ps3.execute();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	        	}
        		
	        	
	        	
        		//insert into Restaurant data table
        		ps3 = con.prepareStatement("INSERT INTO test.Restaurant_details (details_id,image_url, address, phone_no, estimated_price, yelp_url) VALUES (?,?, ?, ?, ?, ?)");
        		ps3.setInt(1, i+1);
	        	ps3.setString(2, parsedBuisnesses[i].getImageurl());
	        	ps3.setString(3, parsedBuisnesses[i].getDisplayAddress());
	        	ps3.setString(4,  parsedBuisnesses[i].getPhone());
	        	ps3.setString(5, parsedBuisnesses[i].getPrice());
	        	ps3.setString(6,  parsedBuisnesses[i].getUrl());
	        	ps3.execute();
	        	

        		
        	}
        	con.close();
        }
        
	        	

        catch(RuntimeErrorException e) {
        	e.printStackTrace();
        }
        
        
    }
        
        

		
        
        //TODO iterate the businessHelper array and insert every business into the DB
       
       
         
    /**
     * @param keyWord    the search keyword
     * @param sort       the sort option (price, review count, rating)
     * @param searchType search in category or name
     * @return the list of business matching the criteria
     */
    public static ArrayList<Business> getBusinesses(String keyWord, String sort, String searchType) {
        ArrayList<Business> sorted = new ArrayList<Business>();
        try {
        	 Class.forName("com.mysql.cj.jdbc.Driver");
     	     Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");
             PreparedStatement ps;

 	        
            if( searchType.equals("name"))  { // searching by name
 	        	ps = con.prepareStatement("SELECT r.restaurant_id,r.restaurant_name, c.category_name, rd.estimated_price, rd.yelp_url, rd.image_url, rat.review_count, rat.rating "
 						+	"FROM test.Restaurant r, test.Restaurant_details rd, test.Rating_details rat, test.Category c "
 						+	"WHERE r.details_id = rd.details_id "
 						+	"AND r.rating_id = rat.rating_id "
 						+	"AND r.restaurant_id = c.restaurant_id "
 						+	"AND r.restaurant_name LIKE ? "
 						+	"ORDER BY " + sort);
 	        	System.out.println(keyWord);
 	        	String searchName = "%" + keyWord + "%";
 	        	ps.setString(1, searchName);

 	        }
 	        else {
	        	ps = con.prepareStatement("SELECT r.restaurant_id, r.restaurant_name, c.category_name, rd.estimated_price, rd.yelp_url, rd.image_url, rat.review_count, rat.rating "
						+	"FROM test.Restaurant r, test.Restaurant_details rd, test.Rating_details rat, test.Category c "
						+	"WHERE r.details_id = rd.details_id "
						+	"AND r.rating_id = rat.rating_id "
						+	"AND r.restaurant_id = c.restaurant_id "
						+	"AND c.category_name LIKE ? "
						+	"ORDER BY " + sort);
	        	
	        	String cat = "%" + keyWord + "%";
	        	ps.setString(1, cat);
  
	        }
 	       
 	        ResultSet rs = ps.executeQuery();
 	        sorted.clear();
 	        while(rs.next()) {
 	        	String id = rs.getString("restaurant_id");
 	        	
 	        	Business b = buisnessIdentifier.get(id);
 	        	if(!sorted.contains(b)) {
 	        		sorted.add(b);
 	        	}
 	        	
 	        }

 					

 	      

            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
        	e.printStackTrace();
        }
		return sorted;
        
        
        
        
        
        //TODO get list of business based on the param
        
    

    }
}

