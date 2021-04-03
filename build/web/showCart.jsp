<%-- 
    Document   : showCart
    Created on : Jan 10, 2021, 2:30:34 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show cart</title>
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
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6 mx-auto">
                                <h1>CART DETAIL </h1>
                                <h3><font color="green">Hello, ${user.fullname}</font></h3> <br/>
                                <div class="row">
                                    <div class="col-md-5">
                                        <c:url var="searchUrl" value="DispatchServlet">
                                            <c:param name="btnPage" value="${requestScope.SEARCH_PAGE}"/>
                                            <c:param name="txtSearch" value="${requestScope.SEARCH_NAME}"/>
                                            <c:param name="cbPrice" value="${requestScope.SEARCH_PRICE}"/>
                                            <c:param name="txtCategory" value="${requestScope.SEARCH_CATEGORY}"/>
                                            <c:param name="btAction"/>
                                        </c:url>
                                        <h5><a href="${searchUrl}">Back to shopping</a></h5>
                                    </div>
                                    <div class="col-md-2">
                                    </div>
                                    <div class="col-md-5">
                                        <c:url var="logoutUrl" value="DispatchServlet">
                                            <c:param name="btAction" value="Logout"/>
                                        </c:url>
                                        <h5><a href="${logoutUrl}">Logout</a></h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <c:if test="${not empty requestScope.DELETE_ERR}">
                                <font color="red">${requestScope.DELETE_ERR}</font>
                            </c:if>
                        </div>
                    </div>
                </section>
                <div class="py-5">
                    <div class="row">
                        <div class="mx-auto">
                            <c:set var="cart" value="${sessionScope.CART}"/>
                            <form action="DispatchServlet" method="POST" id="remove-form">
                            </form>
                            <c:if test="${empty cart}">
                                <h2>Cart Empty</h2>
                            </c:if>
                            <c:if test="${not empty cart}">
                                <table border="1">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Product Name</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                            <th>Remove</th>
                                        </tr>
                                    </thead>
                                    <c:set var="list" value="${cart.items}"/>
                                    <tbody>
                                        <c:forEach var="product" items="${list}" varStatus="counter">
                                            <c:set var="dto" value="${product.value}"/>
                                            <tr>
                                                <td>${counter.count}</td>
                                                <td>${dto.name}</td>
                                                <!--change quantity-->
                                                <td>
                                                    <form action="DispatchServlet" method="POST" style="width: 300px">
                                                        <div class="row">
                                                            <input type="hidden" name="txtSearch" value="${requestScope.SEARCH_NAME}"/>
                                                            <input type="hidden" name="txtCategory" value="${requestScope.SEARCH_CATEGORY}"/>
                                                            <input type="hidden" name="cbPrice" value="${requestScope.SEARCH_PRICE}"/>
                                                            <input type="hidden" name="btnPage" value="${requestScope.SEARCH_PAGE}"/>
                                                            <div class="col-md-7">
                                                                <input type="text" name="txtQuantity" value="${dto.quantity}" class="form-control" style="margin-top: 15px; width: 150px;"
                                                                       onkeydown="javascript: return event.keyCode === 8 ||
                                                                                       event.keyCode === 46 ? true : !isNaN(Number(event.key))"/>
                                                                <input type="hidden" name="txtProductId" value="${product.key}" />
                                                            </div>
                                                            <div class="col-md-3">
                                                                <input type="submit" value="Update" name="btAction" class="btn btn1" style="margin-top: 13px"/>
                                                            </div>
                                                            <div class="col-md-10">
                                                                <c:if test="${requestScope.ERROR == product.key}">
                                                                    <font color="red">Out of stock</font>
                                                                </c:if>
                                                                <c:if test="${requestScope.QUANTITY_ERROR == product.key}">
                                                                    <font color="red">Quantity can not = 0</font>
                                                                </c:if>
                                                                <c:set var="checkoutErr" value="${requestScope.CHECKOUT_ERR}"/>
                                                                <c:forEach var="err" items="${checkoutErr}">
                                                                    <c:if test="${err == product.key}">
                                                                        <font color="red">Out of stock</font>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </div>  
                                                        </div>
                                                    </form>
                                                </td>
                                                <td>${dto.price}</td>
                                                <td>
                                                    <input type="checkbox" name="chkRemove" value="${product.key}" form="remove-form"/>
                                                    <input type="hidden" name="txtSearch" value="${requestScope.SEARCH_NAME}" form="remove-form"/>
                                                    <input type="hidden" name="txtCategory" value="${requestScope.SEARCH_CATEGORY}" form="remove-form"/>
                                                    <input type="hidden" name="cbPrice" value="${requestScope.SEARCH_PRICE}" form="remove-form"/>
                                                    <input type="hidden" name="btnPage" value="${requestScope.SEARCH_PAGE}" form="remove-form"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td colspan="3"><h2>Total</h2></td>
                                            <td colspan="1">${cart.total}</td>
                                            <td colspan="1">
                                                <input type="button" value="Remove" name="btAction"
                                                       class="btn btn1" data-toggle="modal" data-target="#exampleModalLong"/></td>
                                        </tr>

                                        <!-- Modal -->
                                    <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    Do you want to remove?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <input type="submit" value="Remove" name="btAction" class="btn btn1" form="remove-form"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    </tbody>
                                </table>
                                <form action="DispatchServlet">
                                    <input type="submit" value="Checkout" name="btAction" class="btn btn1"/>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

        </c:if>

    </body>
</html>