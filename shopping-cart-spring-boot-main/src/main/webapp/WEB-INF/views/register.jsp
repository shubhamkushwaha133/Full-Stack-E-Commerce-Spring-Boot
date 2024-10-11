<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <style>
        body {
            background-color: #212529; /* Dark background */
            font-family: Arial, sans-serif;
            color: #fff; /* White text */
        }

        .form-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #343a40; /* Darker container */
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
        }

        .card-header {
            background-color: #000; /* Black header */
            color: white;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .form-group label {
            font-weight: bold;
            color: #fff; /* White labels */
        }

        .input-form {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            transition: border 0.3s;
            background-color: #495057; /* Darker input background */
            color: white; /* White text for inputs */
        }

        .input-form:focus {
            border-color: #ffc107; /* Bootstrap yellow */
            outline: none;
        }

        .button {
            background-color: #ffc107; /* Bootstrap yellow */
            color: black;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #e0a800; /* Darker yellow on hover */
        }

        .card-footer a {
            color: #ffc107; /* Bootstrap yellow */
            text-decoration: none;
        }

        .card-footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 576px) {
            .form-container {
                margin: 20px;
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="card">
            <div class="card-header text-center">
                <h3>Register</h3>
            </div>
            <div class="card-body">
                <c:if test="${not empty sessionScope.succMsg}">
                    <div class="alert alert-success" role="alert">${sessionScope.succMsg}</div>
                </c:if>
                <c:if test="${not empty sessionScope.errorMsg}">
                    <div class="alert alert-danger" role="alert">${sessionScope.errorMsg}</div>
                </c:if>
                <form action="/saveUser" enctype="multipart/form-data" method="post">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input id="name" class="input-form form-control" placeholder="Enter your Full Name" type="text" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="mobileNumber">Mobile Number</label>
                        <input id="mobileNumber" class="input-form form-control" placeholder="Enter your Mobile Number" type="number" name="mobileNumber" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input id="email" class="input-form form-control" placeholder="Enter your Email" type="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input id="address" class="input-form form-control" placeholder="Enter your Address" type="text" name="address" required>
                    </div>
                    <div class="form-group">
                        <label for="city">City</label>
                        <input id="city" class="input-form form-control" placeholder="Enter your City" type="text" name="city" required>
                    </div>
                    <div class="form-group">
                        <label for="state">State</label>
                        <input id="state" class="input-form form-control" placeholder="Enter your State" type="text" name="state" required>
                    </div>
                    <div class="form-group">
                        <label for="pincode">Pincode</label>
                        <input id="pincode" class="input-form form-control" placeholder="Enter your Pincode" type="number" name="pincode" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input id="password" class="input-form form-control" placeholder="Enter your Password" type="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmpassword">Confirm Password</label>
                        <input id="confirmpassword" class="input-form form-control" placeholder="Confirm your Password" type="password" name="confirmpassword" required>
                    </div>
                    <div class="form-group">
                        <label for="img">Profile Image</label>
                        <input id="img" class="input-form form-control" type="file" name="img">
                    </div>
                    <div class="form-group">
                        <label for="userRole">User Role</label>
                        <select id="userRole" class="input-form form-control" name="role" required>
                            <option value="buyer" selected>Buyer</option>
                            <option value="seller">Seller</option>
                        </select>
                    </div>
                    <button type="submit" class="button">Register</button>
                </form>
            </div>
            <div class="card-footer text-center">
                Have an account? <a href="/signin">Login</a>
            </div>
        </div>
    </div>
</body>
</html>
