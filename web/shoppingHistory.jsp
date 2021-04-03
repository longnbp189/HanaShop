<%-- 
    Document   : shoppingHistory
    Created on : Jan 16, 2021, 6:18:34 PM
    Author     : Admin
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <style>
            <%@include file="css/mystyle.css"%>
            th {
                background-color: #425d8a;
                color: white;
            }
        </style>
    </head>
    <body class="text-center">
        <c:set var="user" value="${sessionScope.USER}"/>
        <c:if test="${user.role!='U'}">
            <c:url var="url" value="DispatchServlet">
                <c:param name="btAction" value="Search"/>
            </c:url>
            <c:redirect url="${url}"/>
        </c:if>
        <c:if test="${user.role=='U'}">
            <div class="cover-container p-3 mx-auto">
                <section class="jumbotron" style="background: #e8e9f2">
                    <div class="row">
                        <div class="col-lg-7 mx-auto">
                            <h1>ORDER HISTORY</h1>
                            <h3><font color="green">Hello, ${user.fullname}</font></h3> <br/>
                            <div class="row">
                                <div class="col-md-4">
                                    <c:url var="searchUrl" value="DispatchServlet">
                                        <c:param name="btAction"/>
                                        <c:param name="txtSearch" value="${requestScope.SEARCH_NAME}"/>
                                        <c:param name="txtCategory" value="${requestScope.SEARCH_CATEGORY}"/>
                                        <c:param name="cbPrice" value="${requestScope.SEARCH_PRICE}"/>
                                        <c:param name="btnPage" value="${requestScope.SEARCH_PAGE}"/>
                                    </c:url>
                                    <h5><a href="${searchUrl}">Back to shopping</a></h5>
                                </div>
                                <div class="col-md-4">
                                </div>
                                <div class="col-md-4">
                                    <c:url var="logoutUrl" value="DispatchServlet">
                                        <c:param name="btAction" value="Logout"/>
                                    </c:url>
                                    <h5><a href="${logoutUrl}">Logout</a></h5>
                                    <br/>
                                </div>
                            </div>
                            <c:set var="cart" value="${sessionScope.CART}"/>
                            <!--search-->
                            <div class="row">
                                <form action="DispatchServlet" method="POST" class="col-lg-9 mx-auto">
                                    <div class="row">
                                        <div class="col-md-7">
                                            <p><strong>Search date: </strong></p>
                                            <input type="date" name="txtDate" value="${param.txtDate}" class="form-control"/>
                                            <input type="hidden" name="txtSearch" value="${requestScope.SEARCH_NAME}"/>
                                            <input type="hidden" name="txtCategory" value="${requestScope.SEARCH_CATEGORY}"/>
                                            <input type="hidden" name="cbPrice" value="${requestScope.SEARCH_PRICE}"/>
                                            <input type="hidden" name="btnPage" value="${requestScope.SEARCH_PAGE}"/>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="submit" value="Search History" name="btAction" class="btn btn1" style="margin-top: 37px;"/>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <!--table history-->
            <section class="py-5 container">
                <div class="row">
                    <div class="mx-auto">
                        <c:set var="list" value="${requestScope.HISTORY}"/>
                        <c:if test="${not empty list}">
                            <table border="1">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Date</th>
                                        <th>Total</th>
                                        <th>Payment</th>
                                        <th>Detail</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="dto" items="${list}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>${dto.currentDate}</td>
                                            <td>${dto.total}</td>
                                            <td>
                                                <c:if test="${dto.isOnlinePayment}">
                                                    PayPal
                                                </c:if> 
                                                <c:if test="${not dto.isOnlinePayment}">
                                                    Cash
                                                </c:if> 
                                            </td>
                                            <td>
                                                <c:url var="showDetail" value="DispatchServlet">
                                                    <c:param name="txtOrderId" value="${dto.orderid}"/>
                                                    <c:param name="btAction" value="Detail"/>
                                                    <c:param name="txtDate" value="${param.txtDate}"/>
                                                    <c:param name="txtSearch" value="${requestScope.SEARCH_NAME}"/>
                                                    <c:param name="txtCategory" value="${requestScope.SEARCH_CATEGORY}"/>
                                                    <c:param name="cbPrice" value="${requestScope.SEARCH_PRICE}"/>
                                                    <c:param name="btnPage" value="${requestScope.SEARCH_PAGE}"/>
                                                </c:url>
                                                <a href="${showDetail}">Detail</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${empty list}">
                            <h3>Can not found</h3>
                        </c:if>
                    </div>
                </div>
            </section>
        </c:if>
    </body>
</html>