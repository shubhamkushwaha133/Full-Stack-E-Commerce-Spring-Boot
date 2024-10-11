<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Wishlist</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            color: #343a40;
        }

        .container {
            margin-top: 100px;
        }

        h3 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: bold;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card img {
            border-radius: 15px;
            transition: transform 0.3s ease;
        }

        .card img:hover {
            transform: scale(1.05);
        }

        .btn {
            border-radius: 20px;
            width: 100%;
        }

        .alert {
            border-radius: 15px;
        }

        @media (max-width: 768px) {
            .col-md-3 {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Display messages if any -->
    <c:if test="${not empty succMsg}">
        <div class="alert alert-success">
            ${succMsg}
        </div>
        <c:remove var="succMsg" />
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">
            ${errorMsg}
        </div>
        <c:remove var="errorMsg" />
    </c:if>

    <section>
        <div class="container">
            <h3>Your Wishlist</h3>
            <c:if test="${not empty wishlist}">
                <div class="row">
                    <c:forEach var="item" items="${wishlist}">
                        <div class="col-md-3 mt-2">
                            <div class="card">
                                <div class="card-body text-center">
                                    <img alt="${item.product.title}" src="/img/product_img/${item.product.image}" width="150px" height="150px">
                                    <p class="fs-5 text-center">${item.product.title}</p>
                                    <a href="/product/${item.product.id}" class="btn btn-primary mb-2">
                                        <i class="fas fa-eye"></i> View Details
                                    </a>
                                    <a href="/user/removeWishlist?productId=${item.product.id}" class="btn btn-danger">
                                        <i class="fas fa-trash-alt"></i> Remove from Wishlist
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty wishlist}">
                <p class="text-center">Your wishlist is empty</p>
            </c:if>
        </div>
    </section>
</body>
</html>
