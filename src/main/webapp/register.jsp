<!DOCTYPE html>
<html>
	
	<head>
		<meta charset="UTF-8">		
		<script type='text/javascript' src='config.js'></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Lobster" />
		<link rel="stylesheet" type="text/css" href="style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Montserrat:wght@100&display=swap" rel="stylesheet">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <meta name="google-signin-client_id" content="159638605753-1v55702b8mk70qsugvbhnp0e2i0r9ig6.apps.googleusercontent.com">
    
		<title>Sign In</title>
		
	</head>
		<body>
			<% String er = (String) request.getAttribute("error");
			if (er != null) out.println(er);
			%>
	
      <div id="top">
				<h1 class="display-5 my-5"> <span style=" margin-left: 75px; color: #c73b4e ;" > <a href="logout.jsp" style="color: #c73b4e  ;font-family: 'Lobster', cursive;
				">USC GrubHub! </a>  </span> </h1>
				<hr size="1" width="100%" color="#e6e6e6" />
		</div>
		<div style="position: absolute; top: 70px; right: 100px; ">

					<a href="logout.jsp" style="color: black; font-weight: bold;"> Home &ensp; </a>
					<a href="register.jsp" style="color: black; font-weight: bold;"> Login / Sign Up &ensp; </a>
			
  		</div>
	
	    <div class="mx-auto" style="width: 90%;">
	    <div style="margin-top: 130px;" class="row">
			<div class="col">
				<p class="h2 mb-4"> Login </p>
				<form name="Login" action="log" method="POST">
					<div class="form-group">	
							<label class="mb-2" for="username"> Email </label>
							<input class="form-control mb-4" type="text" id="email" name="email" required/> 		
					</div>
					<div class="form-group">	
							<label class="mb-2" for="password"> Password </label>
							<input class="form-control mb-4" type="password" name="password" id="password" required/>
					</div>
					
					<button style="background-color: #af0606; color: white; font-family: Helvetica;" class="btn btn-large btn-block my-4" type="submit" name="submit" ><i class=" fa fa-sign-in"> </i> Sign In</button>	 <hr class ="mx-5" >
				     <div class="g-signin2" data-onsuccess="onSignIn" data-width="auto" data-height="40" data-longtitle="true" data-theme="dark"> </div>
				</form>
			</div>
			<div class="col">
				<p class="h2 mb-4"> Sign Up </p>
				<form  action="register" method="post">
					<div class="form-group">
						<label class="mb-2" name="email"> Email </label>
						<input class="form-control mb-4" type="email" id="email" name="email"  required/> 
					</div>
					<div class="form-group">
						<label class="mb-2" name="username">Username  </label>
						<input class="form-control mb-4" type="text" id="username" name="username" required/> 
					</div>
					<div class="form-group">
						<label class="mb-2" name="password">Password </label>
						<input class="form-control mb-4" type="password" name="password" id="password" required/>
					</div>
					<div class="form-group">
						<label class="mb-2" name="confirmpassword">Confirm Password </label>
						<input class="form-control mb-4" type="password" name="confirmpassword" id="confirmpassword" required/>
					</div>
					<div class="form-check">
						<input type="checkbox" name="checkbox" value="check" id="terms" class="form-check-input"/> 
						<label class="form-check-label" for="terms">  I have read and agree to all terms and conditions of SalEats.</label>
					</div>
						 <button style="background-color: #af0606; color: white; font-family: Helvetica;" class="btn  btn-large btn-block my-4" type="submit" name="submit" ><i class=" fa fa-user-plus"></i> Create Account</button>
				</form>
					
			</div>
		</div>
		</div>
		</body>
		
		<script>
		function onSignIn(googleUser) {
	        // Useful data for your client-side scripts:
	        
	        var profile = googleUser.getBasicProfile();
	        console.log("ID: " + profile.getId()); // Don't send this directly to your server!
	        console.log('Full Name: ' + profile.getName());
	        console.log('Given Name: ' + profile.getGivenName());
	        console.log('Family Name: ' + profile.getFamilyName());
	        console.log("Image URL: " + profile.getImageUrl());
	        console.log("Email: " + profile.getEmail());
	        var name = profile.getName();
	        var email = profile.getEmail();
			window.location.href = "http://localhost:8080/pa2_version3/logout.jsp";		        

	        
	      }
		
			function onSuccess(googleUser) {
		      console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
		      onSignIn(googleUser);
		    }
			
		    function onFailure(error) {
		      console.log(error);
		    }
		 
		    
		 
		 
		    	function signOut() {
		    	    var auth2 = gapi.auth2.getAuthInstance();
		    	    auth2.signOut().then(function () {
		    	      console.log('User signed out.');
		    	      
		    	    });
		    	  }
		      
		    
		    
		      var CLIENT_ID = '159638605753-1v55702b8mk70qsugvbhnp0e2i0r9ig6.apps.googleusercontent.com';
		      var API_KEY = config.API_KEY;
		      
		   
		      var authorizeButton = document.getElementById('g-signin2');
		      
		      function handleClientLoad() {
		        gapi.load('client:auth2', initClient);
		      }
		      function initClient() {
		          gapi.client.init({
		          apiKey: API_KEY,
		          clientId: CLIENT_ID,
		          discoveryDocs: DISCOVERY_DOCS,
		          scope: SCOPES
		        }).then(function () {
		          // Listen for sign-in state changes.
		          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);
		         
		          authorizeButton.onclick = handleAuthClick;
		        }, function(error) {
		          appendPre(JSON.stringify(error, null, 2));
		        });
		      }
		      function handleAuthClick(event) {
		        gapi.auth2.getAuthInstance().signIn();
		      }
		    
	</script>
	
		
		<script src="https://apis.google.com/js/platform.js?onload=renderButton" 
				onload="this.onload=function(){};handleClientLoad()"
      			onreadystatechange="if (this.readyState === 'complete') this.onload()" async defer></script>
	
		
</html>