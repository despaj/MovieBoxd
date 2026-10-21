<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background:   
				linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
				url('/images/bg.jpg');
            color: white;
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
			background-size: cover;       /* Ensures it covers the full screen */
		    background-position: center;  /* Centers the image */
		    background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
        }
        h1 {
            font-size: 3rem;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.2rem;
            margin-bottom: 30px;
        }
		
		.content {
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    text-align: center;
		}

		.btn {
		    display: inline-block;
		    padding: 12px 25px;
		    background: #4CAF50;
		    color: white;
		    text-decoration: none;
		    border-radius: 5px;
		    font-weight: bold;
		}

        .btn:hover {
            background-color: #37763a;
        }
    </style>
</head>
<body>

    <h1>Welcome to Movieboxd</h1>
    <p>Your favorite place to explore amazing movies!</p>

    <a href="/register" class="btn">Get Started</a>

</body>
</html>
