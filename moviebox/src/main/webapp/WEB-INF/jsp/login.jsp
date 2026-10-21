<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>login</title>
	<style>
		* {
		    box-sizing: border-box;
		  }
		  body {
		    margin: 0;
		    font-family: Arial, Helvetica, sans-serif;
			background:   
				linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
				url('/images/bg.jpg');
			background-size: cover;       /* Ensures it covers the full screen */
		    background-position: center;  /* Centers the image */
		    background-repeat: no-repeat;
		  }
		  .container {
		    width: 600px;
		    background-color: rgba(14, 11, 11, 0.9);
		    margin: 140px auto;
		    padding: 30px;
		    border-radius: 10px;
		    box-shadow: 0 5px 15px rgba(0,0,0,0.4);
		    font-family: Arial, Helvetica, sans-serif;
		  }
		  .topTab {
		    display: flex;
		    justify-content: flex-start;
		    margin-bottom: 20px;
		    display: flex;
		    justify-content: center;
		  }
		  .topTab p {
		    color: white;
		  }
		  .topTab p {
		    font-size: 14px;
		    margin: 0;
		    padding: 10px 20px;
		    cursor: pointer;
		    border-radius: 5px;
		    transition: background-color 0.3s;
		    color: rgb(255, 255, 255);
		  }
		  .tab.active {
		      text-decoration: underline;
		  }
		  .topTab p:hover {
		    background-color: #d0d0d0;
		  }
		  label {
		    font-size: 15px;
		    color: rgb(248, 248, 248);
		  }
		  #loginBtn {
		    width: 100%;
		    background-color: #4CAF50;
		    color: white;
		    padding: 12px;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    font-size: 16px;
		    margin-top: 15px;
		  }
		  form input[type="text"] {
		    width: 100%;
		    padding: 10px;
		    margin: 8px 0;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    box-sizing: border-box;
		  }
		    #pass{
		    width: 100%;
		    padding: 10px;
		    margin: 8px 0;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    box-sizing: border-box;
		  }
		  form input [type = "checkbox"] {
		    margin-right: 5px;
		  }
		  form input [type ="submit"]:hover {
		    background-color: #45a049;
		  }
		  h1 {
		    font-size: 24px;
		    margin-bottom: 30px;
		    display: flex;
		    color: white;
		    justify-content: center;
		  }
		  .p1 {
		      font-size: 14px;
		      color: #ccc;  
		      text-align: center;
		  }

		  .signup-btn {
		      background: transparent;
		      border: none;
		      color: #1dc979;
		      font-weight: bold;
		      cursor: pointer;
		      padding: 0;
		      margin-left: 5px;
		      text-decoration: underline;
		  }

		  .signup-btn:hover {
		      color: #ffffff;
		      text-decoration: none;
		  }
		  
		  #loginError {
		      font-size: 0.9rem;
		      color: #e74c3c;
		      text-align: center;
		      margin-top: 5px;
		      transition: all 0.3s ease;
		  }

	</style>
</head>
<body>
   <div class = container>
       	<div class="topTab">
		    <p class="tab" data-url="/register">Create Account</p>
		    <p class="tab active" data-url="/login">Sign In</p>
		</div>
   <h1>Sign In to Your Account</h1>
   <form id = "loginForm" action = "/login" method = "post">
       <input type = "text" placeholder = "Email Address" id = "email" name = "email"><br><br>
       <input type = "password" placeholder = "Password" id = "pass" name = "pass"><br><br>
	   
	   <div id="loginError" style="color: red; text-align: center; margin-top: 5px;">
	             <c:if test="${not empty error}">
	                 ${error}
	             </c:if>
	         </div>
	   
       <input type = "checkbox">
       <label for = "terms">Remember me</label><br><br>
       <input type = "submit" value = "Sign In" id = "loginBtn"><br>
   </form>
   
   <div id="loginError" style="color: red; text-align: center; margin-top: 10px;"></div>
   	
   <p class = "p1">
	Don't have an account?
       <button onclick="window.location.href='/register'" class = "signup-btn">Sign Up</button>
       </p>
	   
	   <script>
	       document.addEventListener("DOMContentLoaded", function () {
	           const tabs = document.querySelectorAll('.tab');

	           tabs.forEach(tab => {
	               tab.addEventListener('click', () => {
	                   tabs.forEach(t => t.classList.remove('active'));
	                   tab.classList.add('active');
	                   window.location.href = tab.getAttribute('data-url');
	               });
	           });
	       });
		   
		   document.getElementById('loginForm').addEventListener('submit', function(e) {
		       e.preventDefault(); 
		       const email = document.getElementById('email').value.trim();
		       const pass = document.getElementById('pass').value.trim();
		       const errorDiv = document.getElementById('loginError');

		       errorDiv.textContent = '';

		       if(email === '' || pass === '') {
		           errorDiv.textContent = 'Please fill in all fields.';
		           return;
		       }
			   
		       this.submit();
		   });
				    
	   </script>


</body>
</html>
