<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>My Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f4f8;
            font-family: 'Arial', sans-serif;
        }

        .profile-container {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            margin-top: 50px;
            transition: transform 0.3s;
        }

        .profile-container:hover {
            transform: scale(1.01);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .profile-header h3 {
            color: #007bff;
            font-weight: bold;
        }

        .profile-header img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid #007bff;
            transition: transform 0.3s;
        }

        .profile-header img:hover {
            transform: scale(1.1);
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #ced4da;
            transition: border-color 0.3s;
            margin-bottom: 20px;
            padding: 10px;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .btn-custom {
            background-color: #007bff;
            color: #fff;
            border-radius: 8px;
            padding: 12px 20px;
            transition: background-color 0.3s, transform 0.3s;
            font-weight: bold;
        }

        .btn-custom:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .text-success, .text-danger {
            font-weight: bold;
        }

        hr {
            border-top: 2px solid #007bff;
            margin: 30px 0;
        }

        .form-label {
            font-weight: bold;
            color: #333;
        }

        @media (max-width: 768px) {
            .profile-container {
                padding: 30px;
            }

            .profile-header img {
                width: 100px;
                height: 100px;
            }
        }

        @media (max-width: 576px) {
            .btn-custom {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <section>
        <div class="container-fluid profile-container">
            <div class="row">
                <div class="col-md-10 offset-md-1">
                    <div class="profile-header">
                        <h3>My Profile</h3>

                        <c:if test="${not empty sessionScope.succMsg}">
                            <p class="text-success">${sessionScope.succMsg}</p>
                            <c:out value="${commnServiceImpl.removeSessionMessage()}" />
                        </c:if>

                        <c:if test="${not empty sessionScope.errorMsg}">
                            <p class="text-danger">${sessionScope.errorMsg}</p>
                            <c:out value="${commnServiceImpl.removeSessionMessage()}" />
                        </c:if>
                    </div>

                    <div class="text-center mb-4">
                        <img alt="Profile Image" src="${pageContext.request.contextPath}/img/profile_img/${user.profileImage}">
                    </div>

                    <form action="${pageContext.request.contextPath}/user/update-profile" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" id="name" name="name" class="form-control" value="${user.name}">
                        </div>
                        <div class="mb-3">
                            <label for="mobileNumber" class="form-label">Mobile Number</label>
                            <input type="text" id="mobileNumber" name="mobileNumber" class="form-control" value="${user.mobileNumber}">
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="text" id="email" name="email" class="form-control" readonly value="${user.email}">
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" id="address" name="address" class="form-control" value="${user.address}">
                        </div>
                        <div class="mb-3">
                            <label for="city" class="form-label">City</label>
                            <input type="text" id="city" name="city" class="form-control" value="${user.city}">
                        </div>
                        <div class="mb-3">
                            <label for="state" class="form-label">State</label>
                            <input type="text" id="state" name="state" class="form-control" value="${user.state}">
                        </div>
                        <div class="mb-3">
                            <label for="pincode" class="form-label">Pincode</label>
                            <input type="text" id="pincode" name="pincode" class="form-control" value="${user.pincode}">
                        </div>
                        <div class="mb-3">
                            <label for="img" class="form-label">Image</label>
                            <input type="file" id="img" name="img" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="role" class="form-label">Role</label>
                            <input type="text" id="role" name="role" class="form-control" readonly value="${user.role}">
                        </div>
                        <div class="mb-3">
                            <label for="isEnable" class="form-label">Account Status</label>
                            <input type="text" id="isEnable" name="isEnable" class="form-control" readonly value="${user.isEnable}">
                            <input type="hidden" name="id" value="${user.id}">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-custom">Update</button>
                        </div>
                    </form>

                    <hr>

                    <div class="mt-4">
                        <h4 class="text-center">Change Password</h4>
                        <form action="${pageContext.request.contextPath}/user/change-password" method="post">
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <input type="password" id="currentPassword" name="currentPassword" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" id="newPassword" name="newPassword" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control">
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-custom col-md-4">Update</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
