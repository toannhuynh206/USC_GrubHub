package Util;
import java.util.ArrayList;
import java.util.List;



import java.io.Serializable;


/**
 * The class used to model a business
 */
public class Business {
	private String id;
	private String name;
	private String image_url;
	private double rating;
	private location location;
	private Category[] categories;
	private String price;
	private String phone;
	private String url;
	private int review_count;
	
	 // add back location soon
	public Business(String id, String name, String image_url, double rating, location location, Category[] categories, String price, String phone, String url, int review_count) {
        //TODO Initialization code
		this.id = id;
    	this.name = name;
    	this.image_url = image_url;
    	this.rating = rating;
    	this.url = url;
    	this.categories = categories;
    	this.price = price;
    	this.location = location;
    	this.phone = phone;
    	this.review_count = review_count;
    }
	public String getName() {
		return name;
	}
	public String getID() {
		return id;
	}
	public int getReviewcount() {
		return review_count;
	}
	
	public String getImageurl() {
		return image_url;
	}
	public double getRating() {
		return rating;
	}
	public String getUrl() {
		return url;
	}
	public String getPrice() {
		return price;
	}
	public String getDisplayAddress() {
		return location.get_display_address();
	}
	
	public StringBuffer getCatString() {
		StringBuffer t = new StringBuffer();
		for (int i = 0; i < categories.length-1; i++) {		
			t.append(categories[i].getTitle() + ", ");
		}
		t.append(categories[categories.length-1].getTitle());
		return t;
	}
	

	

	
	
	public List<String> getCategories() {
		List<String> returnList = new ArrayList<>();
		for (int i = 0; i < categories.length; i++) {
						
			returnList.add(categories[i].getTitle());
		}
		return returnList;
	}
	
	public String getPhone() {
		return phone;
	}
}








