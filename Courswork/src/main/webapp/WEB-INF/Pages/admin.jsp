<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Dashboard</title>
  <style>
    * { box-sizing: border-box; 
        margin: 0; 
        padding: 0; 
    }
    body {
      display: flex;
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
      height: 100vh;
    }

    .sidebar {
      width: 220px;
      background: #2c3e50;
      color: white;
      padding: 20px;
    }

    .sidebar h2 {
      margin-bottom: 20px;
      font-size: 22px;
    }

    .sidebar ul {
      list-style: none;
    }

    .sidebar ul li {
      padding: 10px;
      margin: 10px 0;
      background: #34495e;
      cursor: pointer;
      border-radius: 5px;
    }

    .sidebar ul li:hover,
    .sidebar ul li.active {
      background: #1abc9c;
    }

    .main {
      flex: 1;
      padding: 30px;
      overflow-y: auto;
    }

    .section {
      display: none;
    }

    .section.active {
      display: block;
    }

    h3 {
      margin-bottom: 15px;
    }

    form {
      background: #fff;
      padding: 20px;
      border-radius: 8px;
      margin-bottom: 20px;
      max-width: 600px;
    }

    input, select, textarea {
      width: 100%;
      margin: 10px 0;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    button {
      background: #1abc9c;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      background: white;
    }

    table, th, td {
      border: 1px solid #ccc;
    }

    th, td {
      padding: 10px;
    }

    th {
      background-color: #ecf0f1;
    }

    .action-btn {
      background: #e74c3c;
      padding: 5px 10px;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    
  </style>
</head>
<body>
  <div class="sidebar">
    <h2>Admin Panel</h2>
    <ul>
      <li class="tab active" onclick="switchTab('products')">Product Management</li>
      <li class="tab" onclick="switchTab('orders')">Order Management</li>
      <li class="tab" onclick="switchTab('analytics')">Reports and Analytics</li>
      <li class="tab" onclick="switchTab('users')">User Management</li>
    </ul>
  </div>

  <div class="main">
    <!-- Product Management -->
    <div id="products" class="section active">
      <h3>Product Management</h3>
      <form>
        <input type="text" placeholder="Product Name" />
        <input type="number" placeholder="Price" />
        <input type="number" placeholder="Stock Quantity" />
        <textarea placeholder="Description"></textarea>
        <input type="file" />
        <button type="submit">Add/Update Product</button>
      </form>

      <table>
        <tr><th>Product</th><th>Price</th><th>Stock</th><th>Sales</th><th>Action</th></tr>
        <tr><td>Wireless Headphones</td><td>$59</td><td>120</td><td>300</td><td><button>Delete</button></td></tr>
        <tr><td>Smartwatch</td><td>$99</td><td>80</td><td>150</td><td><button>Delete</button></td></tr>
      </table>
    </div>

    <!-- Order Management -->
    <div id="orders" class="section">
      <h3>Order Management</h3>
      <table>
        <tr><th>Order ID</th><th>Customer</th><th>Status</th><th>Total</th><th>Update</th></tr>
        <tr>
          <td>#1021</td>
          <td>Alex Lee</td>
          <td>
            <select>
              <option>Pending</option>
              <option>Shipped</option>
              <option>Delivered</option>
              <option>Cancelled</option>
            </select>
          </td>
          <td>$120</td>
          <td><button>Update</button></td>
        </tr>
        <tr>
          <td>#1022</td>
          <td>Maria Gomez</td>
          <td>
            <select>
              <option>Pending</option>
              <option selected>Shipped</option>
              <option>Delivered</option>
              <option>Cancelled</option>
            </select>
          </td>
          <td>$85</td>
          <td><button>Update</button></td>
        </tr>
      </table>
    </div>

    <!-- Reports & Analytics -->
    <div id="analytics" class="section">
      <h3>Reports and Analytics</h3>
      <table>
        <tr><th>Metric</th><th>Value</th></tr>
        <tr><td>Top-Selling Product</td><td>Wireless Headphones</td></tr>
        <tr><td>Monthly Sales</td><td>$15,000</td></tr>
        <tr><td>Returning Customers</td><td>45%</td></tr>
        <tr><td>Average Order Value</td><td>$75</td></tr>
      </table>
    </div>

    <!-- User Management -->
    <div id="users" class="section">
      <h3>User Management</h3>
      <form>
        <input type="text" placeholder="Username" />
        <input type="email" placeholder="Email" />
        <select>
          <option>Customer</option>
          <option>Delivery Staff</option>
          <option>Support Team</option>
          <option>Admin</option>
        </select>
        <button type="submit">Create/Update User</button>
      </form>
      <table>
        <tr><th>Username</th><th>Email</th><th>Role</th><th>Action</th></tr>
        <tr><td>john_d</td><td>john@example.com</td><td>Customer</td><td><button>Delete</button></td></tr>
        <tr><td>kate_admin</td><td>kate@shop.com</td><td>Admin</td><td><button>Delete</button></td></tr>
      </table>
    </div>
  </div>

  <script>
    function switchTab(tabId) {
      document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
      document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
      document.getElementById(tabId).classList.add('active');
      event.target.classList.add('active');
    }
  </script>
</body>
</html>