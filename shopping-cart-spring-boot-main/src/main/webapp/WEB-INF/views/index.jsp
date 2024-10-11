<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ include file="base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Homepage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Carousel image settings */
        .carousel-inner img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }

        /* Card styles */
        .product-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        /* Image containers */
        .product-image-container
   	    {
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            padding-top: 10px;
        }
         .category-image-container  {
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
          	margin-top:30px;
            border-radius: 40%;
            background-size: cover;
        }


		
        .product-image-container {
            height: 200px; /* Fixed height for products */
        }

        .category-image-container {
            height: 80px; /* Height for categories */
        }

        .product-image-container img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain; /* Maintain aspect ratio */
            border-radius: 5px;
            transition: transform 0.3s ease;
        }

        .product-image-container img:hover {
            transform: scale(1.1);
        }

        /* Wishlist heart */
        .wishlist-heart {
            position: absolute;
            top: 10px;
            left: 10px;
            font-size: 16px;
            background-color: white;
            color: #ff4b4b;
            border: 2px solid #ff4b4b;
            border-radius: 50%;
            padding: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .wishlist-heart:hover {
            color: white;
            background-color: #ff4b4b;
        }

        /* Product details */
        .product-details {
            text-align: center;
            margin-top: 10px;
        }

        .btn-view-details {
            background-color: #343a40;
            color: white;
        }

        .badge-discount {
            background-color: #ff5722;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            position: absolute;
            top: 10px;
            left: 10px;
        }

        /* Responsive adjustments */
        @media (max-width: 576px) {
            .product-card {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
    <section>
        <!-- Start Slider -->
        <div id="carouselAutoplaying" class="carousel slide carousel-dark mt-3 mb-3" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/img/Images/image1.jpg" class="d-block w-100" alt="A beautiful landscape image">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/Images/image2.jpg" class="d-block w-100" alt="A stunning city skyline">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/Images/image3.jpg" class="d-block w-100" alt="An artistic abstract image">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselAutoplaying" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselAutoplaying" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <!-- End of carousel -->

        <!-- Start Category Module -->
        <!-- Start Category Module -->
<div class="container my-5">
    <div class="row text-center">
        <p class="fs-4 mb-4">Categories</p>
        <div class="category-container d-flex justify-content-center flex-wrap">
            <c:forEach var="category" items="${categories}">
                <div class="col-md-3 col-sm-4 mb-4"> <!-- Adjusted column size -->
                    <div class="card rounded-circle shadow-sm">
                        <div class="category-image-container">
                            <img src="${pageContext.request.contextPath}/img/category_img/${category.imageName}" class="img-fluid" alt="${category.name}">
                        </div>
                        <div class="card-body text-center">
                            <a href="${pageContext.request.contextPath}/products?category=${category.name}" class="d-block mt-2 fs-6 text-dark">${category.name}</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- End Category Module -->


            </div>
        </div>
        <!-- End Category Module -->

        <!-- Start Latest Product Module -->
        <div class="container-fluid bg-light py-5">
            <div class="row text-center mb-4">
                <p class="fs-4 mb-0">Latest Products</p>
            </div>
            <div class="row row-cols-1 row-cols-md-4 g-4">
                <c:forEach var="p" items="${products}">
                    <div class="col mb-4">
                        <div class="card product-card position-relative">
                            <a href="${pageContext.request.contextPath}/user/addWishlist?productId=${p.id}" class="wishlist-heart">
                                <i class="fas fa-heart"></i>
                            </a>
                            <div class="product-image-container">
                                <img src="${pageContext.request.contextPath}/img/product_img/${p.image}" alt="${p.title}">
                            </div>
                            <div class="card-body product-details">
                                <h5 class="fs-5">${p.title}</h5>
                                <p class="fs-6 fw-bold">
                                    &#8377; ${p.discountPrice} <br>
                                    <span class="text-decoration-line-through text-secondary">&#8377; ${p.price}</span>
                                    <span class="fs-6 text-success">${p.discount}% off</span>
                                </p>
                                <a href="${pageContext.request.contextPath}/product/${p.id}" class="btn btn-primary btn-view-details">View Details</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <!-- End Latest Product Module -->
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
