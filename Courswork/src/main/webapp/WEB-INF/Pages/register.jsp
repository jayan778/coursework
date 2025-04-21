<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/Register.css"/>
</head>
<body>
    <!-- Image Section -->
    <div class="image-section">
        <img src="https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-83.jpg" alt="Login Illustration" />
    </div>

    <div class="register-box">
        <div class="register-content">
            <!-- Display messages -->
            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>
            <c:if test="${not empty success}">
                <p class="success">${success}</p>
            </c:if>

            <!-- Form Section -->
            <div class="form-section">
                <h1>Registration</h1>
                <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">
                    <div class="detail">
                        <label for="firstName">First Name:</label>
                        <input type="text" id="firstName" name="firstName" value="${firstName}" required>
                    </div>

                    <div class="detail">
                        <label for="lastName">Last Name:</label>
                        <input type="text" id="lastName" name="lastName" value="${lastName}" required>
                    </div>

                    <div class="detail">
                        <label for="username">Username:</label>
                        <input type="text" id="username" name="username" value="${username}" required>
                    </div>

                    <div class="detail">
                        <label for="dob">Date of Birth:</label>
                        <input type="date" id="dob" name="dob" value="${dob}" required>
                    </div>

                    <div class="detail">
                        <label>Gender:</label>
                        <select name="gender" required>
                            <option value="" disabled ${empty gender ? 'selected' : ''}>Select your gender</option>
                            <option value="male" ${gender == 'male' ? 'selected' : ''}>Male</option>
                            <option value="female" ${gender == 'female' ? 'selected' : ''}>Female</option>
                        </select>
                    </div>

                    <div class="detail">
                        <label for="email">Email:</label>
                        <input type="text" id="email" name="email" value="${email}" required>
                    </div>

                    <div class="detail">
                        <label for="phoneNumber">Phone Number:</label>
                        <input type="text" id="phoneNumber" name="phoneNumber" value="${phoneNumber}" required>
                    </div>

                    <div class="detail">
                        <label for="subject">Subject:</label>
                        <input type="text" id="subject" name="subject" value="${subject}" required>
                    </div>

                    <div class="detail">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required>
                    </div>

                    <div class="detail">
                        <label for="retypePassword">Confirm Password:</label>
                        <input type="password" id="retypePassword" name="retypePassword" required>
                    </div>

                    <div class="detail">
                        <label for="image">Profile Image:</label>
                        <input type="file" id="image" name="image" accept="image/*" required>
                    </div>

                    <div class="button">
                        <button type="submit" class="login-button">Register</button>
                    </div>

                    <div class="signuptext">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/logincontroller">Login</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
