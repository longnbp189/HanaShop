<%-- 
    Document   : viewHistory
    Created on : Mar 14, 2021, 2:06:08 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View History</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <style>
            <%@include file="css/mystyle.css"%>
            th {
                background-color: #425d8a;
                color: white;
            }
            tr:hover {
                background-color: #e8e9f2;
            }
        </style>
    </head>
    <body class="text-center">
        <c:set var="user" value="${sessionScope.USER}"/>
        <c:if test="${user.role!='AD'}">
            <c:url var="url" value="DispatchServlet">
                <c:param name="btAction" value="Search"/>
            </c:url>
            <c:redirect url="${url}"/>
        </c:if>
        <c:if test="${user.role=='AD'}">
            <section class="py-5 text-center container">
                <div class="col-lg-10 mx-auto">
                    <h1>HISTORY UPDATE </h1>
                    <h3><font color="green">Hello, ${user.fullname}</font></h3> <br/>
                    <div class="row">
                        <div class="col-md-6">
                            <c:url var="cancel" value="DispatchServlet">
                                <c:param name="txtSearch" value="${requestScope.SEARCH_NAME}"/>
                                <c:param name="txtCategory" value="${requestScope.SEARCH_CATEGORY}"/>
                                <c:param name="cbPrice" value="${requestScope.SEARCH_PRICE}"/>
                                <c:param name="btnPage" value="${requestScope.SEARCH_PAGE}"/>
                            </c:url>
                            <h5><a href="${cancel}">Back</a></h5>
                        </div>
                        <div class="col-md-6">
                            <c:url var="logoutUrl" value="DispatchServlet">
                                <c:param name="btAction" value="Logout"/>
                            </c:url>
                            <h5><a href="${logoutUrl}">Logout</a></h5>
                        </div>
                    </div>
                </div>
            </section>
            <div class="py-5">
                <div class="row">
                    <div class="mx-auto">
                        <c:set var="hList" value="${requestScope.HISTORY_LIST}"/>
                        <c:if test="${empty hList}">
                            <h2>History Empty</h2>
                        </c:if>
                        <c:if test="${not empty hList}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Product Id</th>
                                        <th>Product Name</th>
                                        <th>Type</th>
                                        <th>Username</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="history" items="${hList}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>${history.productId}</td>
                                            <td>${history.productName}</td>
                                            <td>${history.type}</td>
                                            <td>${history.username}</td>
                                            <td>${history.date}</td>
                                        </tr>
                                    </c:forEach>
                                    
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
    </body>
</html>
