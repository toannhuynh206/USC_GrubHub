<html>
<head>
   <meta name="google-signin-client_id" content="159638605753-1v55702b8mk70qsugvbhnp0e2i0r9ig6.apps.googleusercontent.com">
   	 <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script> 
		
		<meta charset="UTF-8">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <script type='text/javascript' src='config.js'></script>
        
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="index.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

        <script src="https://kit.fontawesome.com/3204349982.js" crossorigin="anonymous"></script>

		<title>SalEats</title>
	<link href="https://fonts.googleapis.com/css2?family=Lobster&family=Montserrat:wght@100&display=swap" rel="stylesheet">	
		  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>   
</head>
<body>

<head>
	</head>
		<body onLoad="test();">		
		
			<div id="top">
				<h1 class="display-5 my-5"> 
				<span style=" margin-left: 75px; color: #c73b4e ;" > <a href="logout.jsp" style="color: #c73b4e ;font-family: 'Lobster', cursive;
				">USC GrubHub ! </a> 
				 </span>
				 </h1>
				<hr size="1" width="100%" color="#e6e6e6" />
			</div>
			
			<div class = "username" style="position: absolute; top: 70px; left: 225px; ">
			<% String name = "";
			  	Cookie[] cookies = request.getCookies();
			  	if(cookies != null){
			  		for(Cookie cookie: cookies){
			  			if(cookie.getName().equals("name")){
			  				name = cookie.getValue();
			  			}
			  		}
			  	}
				if (!name.equals("")){
					String printName = name.replace("&"," ");
					out.println("Hello " + printName + "!"); 
				} %>
	 	 </div>
		
		<div style="position: absolute; top: 70px; right: 100px; ">
			<a href="logout.jsp" style="color: black; font-weight: bold;"> Home &ensp; </a>
			
		<%
			  	boolean loggedIn = false;
		        if(cookies != null){
			  		for(Cookie cookie: cookies){
			  			if(cookie.getName().equals("name")){
			  				loggedIn = true;
			  			}
			  		}
			  	}
		        if(loggedIn){
		        	out.println("<form class='form-inline'; action='logout'; method='POST'><button onclick = 'signOut();';>Logout</button> </form>");
		        }
		        else{
		        	out.println("<span class='bar'><a style='color:black; font-weight:bold' href='register.jsp'> Login / Sign Up </a></span>");
		        }
		        
		 %>
  		</div>			
		<br> <br>
		<img src = "https://www.food-management.com/sites/food-management.com/files/styles/article_featured_retina/public/usc-dining-0.jpg?itok=QL_s_e0r" style="border-radius:25px; height: 50%; width: 90%; margin-left: auto; margin-right: auto; display: block;"/>
		<br>
		 <div class=" mx-auto " style="width: 90%;" >
		 	<form name="restaurantInfo" action="Search" method="POST">
				<div class="row my-4">
					<div class="col-7">
		
					 		<input class="form-control" type="text" id="restaurantname" name="name" placeholder="Restaurant Name" required/> 
					 </div>
					 <div class="col-1">
					 		<button style="background-color: #af0606; color: white;" class="form-control" type="submit" name="submit" ><i class=" fa fa-search"></i></button>
				 	</div>
				 	<div class="col-1">
				 		<div class="form-check ml-4">
					 		 <input class="form-check-input" type="radio" name="sorter" value="price" id="sorter" required/> 	  
							 <label class="form-check-label" for="match">  Price </label>
						</div>
						<div class="form-check ml-5">
							 <input class="form-check-input" type="radio" name="sorter" value="rating" id="sorter" required/> 
							 <label class="form-check-label" for="rating">  Rating </label>
						</div>
					</div>
					<div class="col-3">
						<div class="form-check ml-6">	 
						 	 <input class="form-check-input" type="radio" name="sorter" value="review_count" id="sorter" required/> 
							 <label class="form-check-label" for="count">  Review Count </label>
						</div>
				 	</div>
				 </div>
					<div class="col-4">
							<label for="selector">Choose by Name or Category:</label>
							<select name="selector" id="selector">
 							 <option value="name">Name</option>
 							 <option value="category" selected>Category</option>
 							 </select>
					</div>
					</form>
				</div>
			
	</body>
  <script>
  var auth2;
  var googleUser; // The current user
  var auth2;
  var profile;
  function test(){
      gapi.load('auth2', function(){
  	    auth2 = gapi.auth2.init({
  	        client_id: '159638605753-1v55702b8mk70qsugvbhnp0e2i0r9ig6.apps.googleusercontent.com'
  	    });
  	    auth2.attachClickHandler('signin-button', {}, onSuccess, onFailure);

  	    auth2.isSignedIn.listen(signinChanged);
  	    auth2.currentUser.listen(userChanged); // This is what you use to listen for user changes

  	}); 
  }
 

	var signinChanged = function (val) {
	    console.log('Signin state changed to ', val);
		var auth2 = gapi.auth2.getAuthInstance();
		var profile = auth2.currentUser.get().getBasicProfile();
		console.log(profile.getName());
		console.log(profile.getEmail());
		const test = document.getElementsByClassName("username");
		test[0].innerText = "Hello "+ profile.getName();
		  var b = document.querySelector(".bar")
		  	b.innerHTML="<form class='form-inline'; action='logout'; method='POST'><button onclick = 'signOut();';>Logout</button> </form>";
	};

	var onSuccess = function(user) {
	    console.log('Signed in as ' + user.getBasicProfile().getName());
	    // Redirect somewhere
	};

	var onFailure = function(error) {
	    console.log(error);
	};

	function signOut() {
	    auth2.signOut().then(function () {
	        console.log('User signed out.');
	    });
	
	}        

    
  </script>
 		<script src="https://apis.google.com/js/platform.js?onload=renderButton" 
				onload="this.onload=function(){};handleClientLoad()"
      			onreadystatechange="if (this.readyState === 'complete') this.onload()" async defer></script>
	
</body>
</html>