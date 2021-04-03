<%-- 
    Document   : cartDetail
    Created on : Mar 13, 2021, 9:21:08 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <title>Detail</title>
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
    <div class="cover-container p-3 mx-auto">
        <section class="jumbotron" style="background: #e8e9f2">
            <div class="container">
                <h1>RENTAL DETAIL</h1>
                <c:set var="user" value="${sessionScope.USER}"/>
                <h3><font color="green">Hello, ${user.fullname}</font></h3> <br/>
                <div class="row mx-auto" style="width: 50%">
                    <div class="col-md-4">
                        <c:url var="back" value="DispatchServlet">
                            <c:param name="btAction" value="Search History"/>
                            <c:param value="${requestScope.SEARCH_DATE}" name="txtDate"/>
                            <c:param name="txtSearch" value="${requestScope.SEARCH_NAME}"/>
                            <c:param name="cbPrice" value="${requestScope.SEARCH_PRICE}"/>
                            <c:param name="txtCategory" value="${requestScope.SEARCH_CATEGORY}"/>
                            <c:param name="btnPage" value="${requestScope.SEARCH_PAGE}"/>
                        </c:url>
                        <h5><a href="${back}">Back</a></h5>
                    </div>
                    <div class="col-md-4">
                        <c:url var="searchPage" value="DispatchServlet">
                            <c:param name="txtSearch" value="${requestScope.SEARCH_NAME}"/>
                            <c:param name="cbPrice" value="${requestScope.SEARCH_PRICE}"/>
                            <c:param name="txtCategory" value="${requestScope.SEARCH_CATEGORY}"/>
                            <c:param name="btnPage" value="${requestScope.SEARCH_PAGE}"/>
                        </c:url>
                        <h5><a href="${searchPage}">Shopping</a></h5>
                    </div>
                    <div class="col-md-4">
                        <h5><a href="logout">Logout</a></h5>
                    </div>
                </div>
            </div>
        </section>

        <div class="row">
            <div class="mx-auto row">
                <div class="col-md-10" style="margin-left: 75px">
                    <c:set var="list" value="${requestScope.DETAIL_LIST}"/>

                    <!--table history-->
                    <table border="1" style="margin-top: 50px">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Product name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${list}" varStatus="counter">
                                <tr>
                                    <td>${counter.count}</td>
                                    <td>${dto.productName}</td>
                                    <td>${dto.quantity}</td>
                                    <td>${dto.price}</td>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

</body>
</html>