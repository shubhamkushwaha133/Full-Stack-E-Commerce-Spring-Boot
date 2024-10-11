<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Order Success</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #e9ecef;
            font-family: 'Arial', sans-serif;
        }

        .success-container {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            padding: 40px;
            margin-top: 50px;
            transition: transform 0.3s;
        }

        .success-container:hover {
            transform: scale(1.01);
        }

        .success-icon {
            color: #28a745;
        }

        .btn-custom {
            background-color: #007bff;
            color: #fff;
            border-radius: 8px;
            padding: 12px 20px;
            transition: background-color 0.3s, transform 0.3s;
            font-weight: bold;
            margin: 10px;
        }

        .btn-custom:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .message {
            margin-top: 20px;
        }

        @media (max-width: 576px) {
            .success-container {
                padding: 20px;
            }

            .success-icon {
                font-size: 4rem;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-6 offset-md-3 success-container text-center">
                    <i class="fa-solid fa-circle-check fa-5x success-icon"></i>
                    <h3 class="message">Product Ordered Successfully</h3>
                    <p class="fs-5">Your product will be delivered within 7 days.</p>
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-custom">Home</a>
                        <a href="${pageContext.request.contextPath}/user/user-orders" class="btn btn-custom">Your Orders</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
