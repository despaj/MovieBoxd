<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>register</title>
	<style>
		* {
		    box-sizing: border-box;
		  }
		 
		  body {
			background:   
				linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
				url('/images/bg.jpg');
			background-size: cover;       /* Ensures it covers the full screen */
		    background-position: center;  /* Centers the image */
		    background-repeat: no-repeat;
		    font-family: 'Poppins', sans-serif;
		    color: #f5f5f5;
		  }
		  .container {
		    width: 600px;
		    background-color:rgba(14, 11, 11, 0.9);
		    margin: 100px auto;
		    padding: 40px 30px;
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
		    color: rgb(255, 255, 255);
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
		  .topTab p:hover {
		    background-color: #747070;
		  }
		  .tab.active {
		      text-decoration: underline;
		  }
		  label {
		    font-size: 15px;
		    color: rgb(255, 255, 255);
		  }
		  #createAccBtn {
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
		  form input[type="number"] {
		    width: 100%;
		    padding: 10px;
		    margin: 8px 0;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    box-sizing: border-box;
		  }
		  #confirmPass, #pass{
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
		    margin-bottom: -10px;
		    display: flex;
		    justify-content: center;
		  }
		  p {
		    font-size: 14px;
		    color: #ffffff;
		    display: flex;
		    justify-content: center;
		  }
		  
		  #registerError, #registerMessage {
		      font-size: 0.9rem;
		      transition: all 0.3s ease;
		  }
	</style>
</head>
<body>
   <div class = container>
       <div class="topTab">
		   <p class="tab active" data-url="/register">Create Account</p>
		   <p class="tab" data-url="/login">Sign In</p>
		</div>
       <h1>Account Registration</h1>
       <p>Create your account</p>
	   <form id="registerForm" method="post" action="/register">
	       <input type="text" placeholder="First Name:" id="fname" name="fname" required><br><br>
	       <input type="text" placeholder="Last Name:" id="lname" name="lname" required><br><br>
	       <input type="text" placeholder="Email Address:" id="email" name="email" required><br><br>
	       <input type="text" placeholder="Phone Number:" id="num" name="num"><br><br>
	       <input type="password" placeholder="Password: " id="pass" name="pass" required><br><br>
		   <input type="password" placeholder="Confirm Password" id="confirmPass" name="confirmPass" required><br><br>

		   <div id="registerError" style="color:red; text-align:center; margin-top:10px;">
		       <c:if test="${not empty error}">
		           ${error}
		       </c:if>
		   </div>

		   <div id="registerMessage" style="color:green; text-align:center; margin-top:10px;">
		       <c:if test="${not empty message}">
		           ${message}
		       </c:if>
			   
			<input type="checkbox" id="terms" name="terms">
	       <label for="terms">I accept the terms and conditions</label><br><br>
	       <input type="submit" value="Create Account" id="createAccBtn">
	   </form>

	   <script>
		document.addEventListener("DOMContentLoaded", function () {
		    const tabs = document.querySelectorAll('.tab');

		    tabs.forEach(tab => {
		        tab.addEventListener('click', () => {
		            // Remove 'active' class from all tabs
		            tabs.forEach(t => t.classList.remove('active'));

		            // Add 'active' class to clicked tab
		            tab.classList.add('active');

		            // Redirect to the URL specified in data-url
		            const url = tab.getAttribute('data-url');
		            if(url) {
		                window.location.href = url;
		            }
		        });
		    });
		});
		
	   document.getElementById('registerForm').addEventListener('submit', function(e) {
	       const fname = document.getElementById('fname').value.trim();
	       const lname = document.getElementById('lname').value.trim();
	       const email = document.getElementById('email').value.trim();
	       const pass = document.getElementById('pass').value.trim();
	       const confirmPass = document.getElementById('confirmPass').value.trim();
	       const terms = document.getElementById('terms').checked;
	       const errorDiv = document.getElementById('registerError');

	       errorDiv.textContent = '';

	       if (!fname || !lname || !email || !pass || !confirmPass) {
	           errorDiv.textContent = "Please fill in all required fields.";
	           e.preventDefault();
	           return;
	       }

	       const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	       if (!emailRegex.test(email)) {
	           errorDiv.textContent = "Please enter a valid email address.";
	           e.preventDefault();
	           return;
	       }

	       if (pass !== confirmPass) {
	           errorDiv.textContent = "Passwords do not match.";
	           e.preventDefault();
	           return;
	       }

	       if (!terms) {
	           errorDiv.textContent = "You must accept the terms and conditions.";
	           e.preventDefault();
	           return;
	       }
	   });
	   </script>
  
</body>
</html>
