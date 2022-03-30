<html>
<head>
   <meta name="google-signin-client_id" content="159638605753-1v55702b8mk70qsugvbhnp0e2i0r9ig6.apps.googleusercontent.com">
   	 <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script> 
		<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
		<meta charset="UTF-8">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        		<script type='text/javascript' src='config.js'></script>
        
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="index.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

        <script src="https://kit.fontawesome.com/3204349982.js" crossorigin="anonymous"></script>

		<title>USC GrubHub!</title>
		<link rel = "stylesheet" href="stylesheet.css" >
	<link href="https://fonts.googleapis.com/css2?family=Lobster&family=Montserrat:wght@100&display=swap" rel="stylesheet">		
</head>
<body>
<head>
	</head>
		<body onLoad="test();">		
			<div id="top">
				<h1 class="display-5 my-5"> 
				<span style=" margin-left: 75px; color: #af0606;" > <a href="logout.jsp" style="color: #c73b4e  ;font-family: 'Lobster', cursive;
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
		
	<hr>
	
	<br>
	
		<c:set var="name" value="${param.name}" scope="request"/>
		<c:set var="address" value="${param.address}"/>
		<c:set var="phone" value="${param.phone}"/>
		<c:set var="categories" value="${param.categories}"/>
		<c:set var="price" value="${param.price}"/>
		<c:set var="rating" value="${param.rating}"/>
		<c:set var="image" value="${param.image}"/>
		<h2 style="margin-left: 65px;"> <c:out value="${name}" /> </h2>
		
		<hr style="margin: 20px 75px;">
		 
		 <div class="media">
			<div class="media-left">
				<a  href="${url}"> <img style="object-fit:cover; border-radius:25px; width: 200px; height: 200px; margin: 10px 60px 10px 100px;" src = "${image}" /> </a> 
			</div>
			<div class="media-body" style="font-size: large; line-height: 50px; margin-top: 5px;">
				<span style="color: black; font-weight: 900;"> Address:    </span>  <c:out value="${address}" /> <br>
				<span style="color: black; font-weight: 900;"> Phone:      </span>  <c:out value="${phone}" /> <br>
				<span style="color: black; font-weight: 900;"> Categories: </span>  <c:out value="${categories}" /> <br>
				<span style="color: black; font-weight: 900;"> Price:      </span>  <c:out value="${price}" /> <br>
				<span style="color: black; font-weight: 900;"> Rating:     </span>  <span class="rstars"><c:out value="${rating}" /></span><br>
			</div>
		</div>
		
		
	</body>
	

  <script>
 
  var auth2;
  var googleUser; 
  var profile;
  window.onload = function afterWebPageLoad() { 
	  gapi.load('auth2', function(){
	  	    auth2 = gapi.auth2.init({
	  	        client_id: '159638605753-1v55702b8mk70qsugvbhnp0e2i0r9ig6.apps.googleusercontent.com'
	  	    });
	  	    auth2.attachClickHandler('signin-button', {}, onSuccess, onFailure);

	  	    auth2.isSignedIn.listen(signinChanged);
	  	    auth2.currentUser.listen(userChanged); // This is what you use to listen for user changes

	  	});
	   stars_();
		var auth2 = gapi.auth2.getAuthInstance();
		var profile = auth2.currentUser.get().getBasicProfile();
		console.log(profile.getName());
		console.log(profile.getEmail());
		const test = document.getElementsByClassName("username");
		test[0].innerText = "Hello "+ profile.getName();
	    // Function to be executed 
	}
  
  function stars_(){
	  
	     const element = document.querySelectorAll(".rstars");

		  for(var i=0;i<element.length;i++){
			  var num = parseFloat(element[i].innerText);
			  element[i].innerHTML = getStars(num);
		  }
}

  function getStars(rating) {

	  let output = [];

	  // Append all the filled whole stars
	  for (var i = rating; i >= 1; i--)
	    output.push("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-star-fill' viewBox='0 0 16 16'> <path d='M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z'/>  </svg>");

	  // If there is a half a star, append it
	  if (i == .5) output.push("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-star-half' viewBox='0 0 16 16'><path d='M5.354 5.119 7.538.792A.516.516 0 0 1 8 .5c.183 0 .366.097.465.292l2.184 4.327 4.898.696A.537.537 0 0 1 16 6.32a.548.548 0 0 1-.17.445l-3.523 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256a.52.52 0 0 1-.146.05c-.342.06-.668-.254-.6-.642l.83-4.73L.173 6.765a.55.55 0 0 1-.172-.403.58.58 0 0 1 .085-.302.513.513 0 0 1 .37-.245l4.898-.696zM8 12.027a.5.5 0 0 1 .232.056l3.686 1.894-.694-3.957a.565.565 0 0 1 .162-.505l2.907-2.77-4.052-.576a.525.525 0 0 1-.393-.288L8.001 2.223 8 2.226v9.8z'/></svg>");

	  // Fill the empty stars
	  for (let i = (5 - rating); i >= 1; i--)
	    output.push("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-star' viewBox='0 0 16 16'><path d='M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z'/> </svg>");

	  return output.join('');

	}
  

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
		 gapi.load('auth2', function(){
		  	    auth2 = gapi.auth2.init({
		  	        client_id: '159638605753-1v55702b8mk70qsugvbhnp0e2i0r9ig6.apps.googleusercontent.com'
		  	    });
		  	    auth2.attachClickHandler('signin-button', {}, onSuccess, onFailure);

		  	});
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