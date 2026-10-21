<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard</title>
<style>
    :root {
        --accent: #ff6b6b;
        --bg: #1a1a1a;
        --card: #fff;
        --dark: #2f3640;
        --muted: #718093;
        --success: #2ecc71;
        --warning: #e74c3c;
    }
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: Arial, Helvetica, sans-serif;
        }
    body {
        display: flex;
        height: 100vh;
        background: var(--bg);
        color: var(--dark);
    }

    .sidebar {
        width: 220px;
        background: #1e272e;
        color: #dcdde1;
        display: flex;
        flex-direction: column;
        padding: 20px 0;
    }
    .sidebar h2 {
        text-align: center;
        margin-bottom: 30px;
        font-size: 20px;
    }

    .sidebar a {
        color: #dcdde1;
        text-decoration: none;
        padding: 12px 20px;
        display: block;
        transition: background 0.3s;
        }

    .sidebar a:hover {
        background: #485460;
        border-radius: 4px;
    }
   
    .main {
        flex: 1;
        padding: 20px 30px;
        display: flex;
        flex-direction: column;
    }
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        }
    .header h1 {
        font-size: 24px;
        color: white;
    }
    .logout-btn {
        background: var(--accent);
        border: none;
        color: #fff;
        padding: 8px 16px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        }
    .cards {
        display: flex;
        gap: 20px;
        margin: 20px 0;
        }
    .card {
        background: var(--card);
        flex: 1;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        text-align: center;
        }
    .card h3 {
        font-size: 14px;
        color: var(--muted);
        margin-bottom: 10px;
        }
    .card p {
        font-size: 24px;
        font-weight: bold;
        }

    .table-container {
        background: var(--card);
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        padding: 20px;
        margin-top: 10px;
        }
    .table-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
        font-weight: 600;
        }
    table {
        width: 100%;
        border-collapse: collapse;
        }
    table th, table td {
        text-align: left;
        padding: 12px;
        font-size: 14px;
        border-bottom: 1px solid #eee;
        }
    .status-completed {
        color: var(--success);
        font-weight: 600;
        }
    .status-pending {
        color: var(--warning);
        font-weight: 600;
        }
    </style>
</head>
<body>

    <div class="sidebar">
    <h2>Movieboxd</h2>
        <a href="#">Dashboard</a>
        <a href="http://localhost:8080/home">Movies</a>
        <a href="#">Orders</a>
        <a href="#">Customers</a>
        <a href="#">Settings</a>
    </div>

    <div class="main">
    <div class="header">
        <h1>Dashboard</h1>
        <button class="logout-btn">Logout</button>
    </div>
    
    <div class="cards">
    <div class="card">
        <h3>Total Movie Bought</h3>
        <p></p>
    </div>
    <div class="card">
        <h3>Revenue</h3>
        <p></p>
    </div>
    <div class="card">
        <h3>Customers</h3>
        <p></p>
    </div>
    </div>
    <div class="table-container">
    <div class="table-header">
    <span>Recent Orders</span>
    <a href="#" style="color: var(--accent); font-size: 14px; text-decoration:none;">View All</a>
    </div>
    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Status</th>
                <th>Total</th>
                <th>Date</th>
            </tr>
        </thead>
		<tbody id="ordersTableBody">
		    <!-- Orders will be injected here -->
		</tbody>
    </table>
    </div>
    </div>
	
	<script>
	document.addEventListener("DOMContentLoaded", function() {
	    fetch('/api/orders')
	        .then(response => response.json())
	        .then(data => {
	            const tbody = document.getElementById('ordersTableBody');
	            tbody.innerHTML = ''; // clear default rows

	            data.forEach(order => {
	                const tr = document.createElement('tr');

	                const statusClass = order.status === 'Completed' ? 'status-completed' : 'status-pending';

	                tr.innerHTML = `
	                    <td>#${order.id}</td>
	                    <td>${order.movieTitle}</td>
	                    <td class="${statusClass}">${order.status}</td>
	                    <td>$${order.total}</td>
	                    <td>${order.date}</td>
	                `;

	                tbody.appendChild(tr);
	            });
	        });
	});
	</script>
	
    </body>
</html>