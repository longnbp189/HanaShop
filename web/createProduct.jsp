<%-- 
    Document   : createProduct
    Created on : Mar 14, 2021, 12:35:54 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<c:url value="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />" rel="stylesheet">
        <title>Create </title>
        <style>
            <%@include file="css/mystyle.css"%>
        </style>
    </head>
    <body class="text-center">
        <div class="cover-container p-3 mx-auto">
            <section class="jumbotron" style="background: #e8e9f2">
                <div class="row">
                    <div class="col-lg-5 mx-auto">
                        <h1>Update Page</h1> <br/>
                        <c:set var="user" value="${sessionScope.USER}"/>
                        <h3><font color="green">Welcome, ${user.fullname}</font></h3> 
                        <br/>
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
                </div>
            </section>
        </div>
        <c:set var="cList" value="${requestScope.CATEGORY_LIST}"/>
        <c:set var="err" value="${requestScope.ERROR}"/>
        <div class="container">
            <form action="DispatchServlet" method="POST">
                <div class="card-body">
                    <input type="hidden" name="txtProductId" value="${dto.productId}" />
                    <div class="row">
                        <div class="col-md-12">
                            <p><strong>Product name:</strong></p>
                            <input type="text" class="form-control" id="recipient-name" name="txtName" value="${param.txtName}"> 
                            <c:if test="${not empty err.nameError}">
                                <font color="red">${err.nameError}</font>
                            </c:if>
                            <c:if test="${empty err.nameError}">
                                <br/>
                            </c:if>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <p><strong>Description:</strong> </p>
                            <textarea name="txtDescription" class="form-control">${param.txtDescription}</textarea>
                            <c:if test="${not empty err.decriptionError}">
                                <font color="red">${err.decriptionError}</font>
                            </c:if>
                            <c:if test="${empty err.decriptionError}">
                                <br/>
                            </c:if>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Price:</strong> </p>
                            <input type="text" class="form-control" id="recipient-name" name="txtPrice" value="${param.txtPrice}">
                            <c:if test="${not empty err.priceError}">
                                <font color="red">${err.priceError}</font>
                            </c:if>
                            <c:if test="${empty err.priceError}">
                                <br/>
                            </c:if> 
                        </div>
                        <div class="col-md-6">
                            <p><strong>Quantity:</strong> </p>
                            <input type="text" class="form-control" id="recipient-name" name="txtQuantity" value="${param.txtQuantity}">
                            <c:if test="${not empty err.quantityError}">
                                <font color="red">${err.quantityError}</font>
                            </c:if>
                            <c:if test="${empty err.quantityError}">
                                <br/>
                            </c:if>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <c:set var="select" value="${requestScope.CATEGORY}"/>
                            <p><strong>Category:</strong> </p>
                            <select name="cbCategory" class="form-control">
                                <c:forEach var="cDTO" items="${cList}">
                                    <option value="${cDTO.categoryId}"
                                            <c:if test="${cDTO.categoryId == select}">
                                                selected="true"</c:if>>
                                            ${cDTO.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="col-md-12">
                            <p><strong>Image link: </strong> </p>
                            <input type="text" name="txtImage" value="${param.txtImage}" class="form-control"/>
                            <c:if test="${not empty err.imageError}">
                                <font color="red">${err.imageError}</font>
                            </c:if>
                            <input type="hidden" name="txtSearch" value="${requestScope.SEARCH_NAME}" />
                            <input type="hidden" name="btnPage" value="${requestScope.SEARCH_PAGE}"/>
                            <input type="hidden" name="cbPrice" value="${requestScope.SEARCH_PRICE}"/>
                            <input type="hidden" name="txtCategory" value="${requestScope.SEARCH_CATEGORY}" />
                            <br/>
                        </div>
                    </div>
                </div>
                <input type="submit" value="Create" name="btAction" class="btn btn1"/>
            </form>

        </div>

    </body>
</html>
