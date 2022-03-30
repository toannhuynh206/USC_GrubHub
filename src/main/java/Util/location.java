package Util;

public class location {
		String address1;
		String address2;
		String address3;
		String city;
		String zip_code;
		String country;
		String state;
		public location(String address1, String address2, String address3, String city, String zip_code, String country, String state) {
			if (address1 == null) address2 = "";
			if (address2 == null) address3 = "";
			if (address3 == null) address2 = "";
			this.address1 = address1;
			this.address2 = address2;
			this.address3 = address3;
			this.city = city;
			this.zip_code = zip_code;
			this.country = country;
			this.state = state;
				
		}
		public String get_display_address() {
			if (address1 == null) address1 = "";
			if (address2 == null) address2 = "";
			if (address3 == null) address3 = "";
			if (city == null) city = "";
			if (city == null) city = "";
			if (zip_code == null) zip_code = "";
			if (country == null) country = "";
			if (city == null) state = "";




			return address1 + " " + address2 + " " + address3 + " " + city + " " + zip_code + " " + state + " " + country;
		}
	}