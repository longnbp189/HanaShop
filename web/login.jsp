<%-- 
    Document   : login
    Created on : Jan 9, 2021, 12:57:16 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"/>
        <style>
            <%@include file="css/mystyle.css"%>
            body{
                background: grey;
            }
            form{
                width:  350px;
                border: 3px solid #f1f1f1;
                padding: 20px;
                left: 38%;
                top: 15%;
                position: absolute;
                background: white;
                height: 420px;
                border-radius: 10px;
            }
            #submit-btn{
                cursor: not-allowed;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login page</title>
    </head>
    <body class="text-center">
        <c:set var="user" value="${sessionScope.USER}"/>
        <c:if test="${not empty user}">
            <c:url var="url" value="DispatchServlet">
                <c:param name="btAction" value="Search"/>
            </c:url>
            <c:redirect url="${url}"/>
        </c:if>
        <c:if test="${empty user}">
            <form action="DispatchServlet" method="POST">
                <h1>Login</h1>
                <p><strong>Username: </strong></p> 
                <input type="text" class="form-control form-signin" name="txtUsername" value="" placeholder="Username"/>
                <br/>
                <p><strong>Password: </strong></p> 
                <input type="password" class="form-control form-signin" name="txtPassword" value="" placeholder="Password"/>
                <br/>
                <input type="submit" class="btn btn1" value="Login" name="btAction"/> 
                <br/>
                <br/>
                <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8084/HanaShop/login-google&response_type=code
                   &client_id=207880440989-nisjal4c4n9p8bahcu4hubsu4b9g7gpd.apps.googleusercontent.com&approval_prompt=force">Login With Google</a>  
                <br/>
                <c:if test="${not empty requestScope.LOGIN_ERROR}">
                    <font color="red">${requestScope.LOGIN_ERROR}</font>
                </c:if>
            </form>

        </c:if>
    </body>
</html>