<%-- 
    Document   : home
    Created on : Jan 9, 2021, 12:58:24 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home page</title> 
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"/>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <style>
            <%@include file="css/mystyle.css"%>
        </style>
    </head>
    <body class="text-center">
        <div class="cover-container p-3 mx-auto">
            <section class="jumbotron" style="background: #e8e9f2">
                <div class="row">
                    <div class="col-lg-7 mx-auto">
                        <h1>HANA SHOP</h1>
                        <c:set var="user" value="${sessionScope.USER}"/>
                        <c:set var="cList" value="${requestScope.CATEGORY_LIST}"/>
                        <c:if test="${not empty user}">
                            <h3><font color="green">Welcome, ${user.fullname}</font></h3> <br/>
                            </c:if>
                        <div class="row">
                            <div class="col-md-4">
                                <c:if test="${user.role=='U'}">
                                    <c:url var="history" value="DispatchServlet">
                                        <c:param name="btnPage" value="${requestScope.CURRENT_PAGE}"/>
                                        <c:param name="txtSearch" value="${param.txtSearch}"/>
                                        <c:param name="cbPrice" value="${requestScope.SELECTED_COMBOBOX}"/>
                                        <c:param name="txtCategory" value="${requestScope.SELECTED_CATEGORY}"/>
                                        <c:param value="Search History" name="btAction"/>
                                    </c:url>
                                    <h5><a href="${history}">Search History</a></h5>
                                </c:if>
                            </div>
                            <div class="col-md-4">
                                <c:if test="${not empty user}">
                                    <c:url var="logoutUrl" value="DispatchServlet">
                                        <c:param name="btAction" value="Logout"/>
                                    </c:url>
                                    <h5><a href="${logoutUrl}">Logout</a></h5>
                                    <br/>
                                </c:if>
                            </div>
                            <div class="col-md-4">
                                <c:if test="${user.role=='U'}">
                                    <c:url var="viewCartUrl" value="DispatchServlet">
                                        <c:param name="btnPage" value="${requestScope.CURRENT_PAGE}"/>
                                        <c:param name="btAction" value="showCart"/>
                                        <c:param name="txtSearch" value="${param.txtSearch}"/>
                                        <c:param name="cbPrice" value="${requestScope.SELECTED_COMBOBOX}"/>
                                        <c:param name="txtCategory" value="${requestScope.SELECTED_CATEGORY}"/>
                                    </c:url>
                                    <h5><a href="${viewCartUrl}">View your cart</a></h5>
                                </c:if>
                            </div>

                            <c:if test="${user.role=='AD'}">
                                <div class="col-md-6">
                                    <c:url var="createUrl" value="DispatchServlet">
                                        <c:param name="btAction" value="Create"/>
                                        <c:param name="check" value="true"/>
                                        <c:param name="btnPage" value="${requestScope.CURRENT_PAGE}"/>
                                        <c:param name="txtSearch" value="${param.txtSearch}"/>
                                        <c:param name="cbPrice" value="${requestScope.SELECTED_COMBOBOX}"/>
                                        <c:param name="txtCategory" value="${requestScope.SELECTED_CATEGORY}"/>
                                    </c:url>
                                    <h5><a href="${createUrl}">Create new product</a></h5>
                                </div>
                                <div class="col-md-6">
                                    <c:url var="HistoryUrl" value="DispatchServlet">
                                        <c:param name="btAction" value="History"/>
                                        <c:param name="btnPage" value="${requestScope.CURRENT_PAGE}"/>
                                        <c:param name="txtSearch" value="${param.txtSearch}"/>
                                        <c:param name="cbPrice" value="${requestScope.SELECTED_COMBOBOX}"/>
                                        <c:param name="txtCategory" value="${requestScope.SELECTED_CATEGORY}"/>
                                    </c:url>
                                    <h5><a href="${HistoryUrl}">View history</a></h5>
                                </div>

                            </c:if>
                        </div>
                        <c:if test="${empty user}">
                            <h5><a href="login.jsp">Login</a></h5>
                        </c:if>
                        <!--search-->
                        <form action="DispatchServlet" method="POST">
                            <div class="row">
                                <div class="col-md-4">
                                    <p><strong>Product name:</strong></p>
                                    <input type="text" class="form-control" placeholder="Search" value="${param.txtSearch}" name="txtSearch">
                                    <br/>
                                </div>
                                <div class="col-md-3">
                                    <p><strong>Category:</strong></p>
                                    <c:set var="selectedCate" value="${requestScope.SELECTED_CATEGORY}"/>

                                    <select name="txtCategory" class="form-control">
                                        <option value="" <c:if test="${selectedCate == ''}">
                                                selected="true"</c:if>>
                                                All category
                                            </option>
                                        <c:forEach var="cDTO" items="${cList}">
                                            <option value="${cDTO.categoryId}"<c:if test="${selectedCate == cDTO.categoryId}">
                                                    selected="true"</c:if>>
                                                ${cDTO.categoryName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">

                                    <c:set var="selected" value="${requestScope.SELECTED_COMBOBOX}"/>
                                    <p><strong>Price:</strong></p>
                                    <select name="cbPrice" class="form-control">
                                        <option <c:if test="${selected=='All price'}">
                                                selected="true"
                                            </c:if>>All price</option>
                                        <option<c:if test="${selected=='0 - 10'}">
                                                selected="true"
                                            </c:if>>0 - 10</option>
                                        <option<c:if test="${selected=='10 - 100'}">
                                                selected="true"
                                            </c:if>>10  - 100</option>
                                        <option<c:if test="${selected=='100 - 200'}">
                                                selected="true"
                                            </c:if>>100 - 200</option>
                                        <option<c:if test="${selected=='200 - 300'}">
                                                selected="true"
                                            </c:if>>200 - 300</option>
                                        <option<c:if test="${selected=='300 Above'}">
                                                selected="true"
                                            </c:if>>300 Above</option>
                                    </select> 
                                </div>
                                <div class="col-lg-2">
                                    <input type="submit" value="Search" class="btn btn1" name="btAction"
                                           style="margin-top: 37px"/> 
                                </div>
                            </div>
                            <div class="col-md-12">
                                <c:if test="${not empty requestScope.DELETE_ERR}">
                                    <font color="red">${requestScope.DELETE_ERR}</font>
                                </c:if>
                            </div>
                        </form>
                        <!--show page-->
                        <form action="DispatchServlet">
                            <c:set var="countPage" value="${requestScope.PAGE_COUNT}"/>
                            <div>
                                <input type="hidden" value="${param.txtSearch}" name="txtSearch" />
                                <input type="hidden" value="${requestScope.SELECTED_CATEGORY}" name="txtCategory" />
                                <input type="hidden" value="${requestScope.SELECTED_COMBOBOX}" name="cbPrice" />
                                <c:forEach var="num" begin="${1}" end="${countPage}">
                                    <input type="submit" value="${num}" class="btn1 btn" name="btnPage"/>
                                </c:forEach>
                            </div>
                        </form>    
                    </div>
                </div>
            </section>
            <!--remote form delete-->
            <form action="DispatchServlet" method="POST" id="delete-form">
            </form>
            <div class="container">
                <c:if test="${not empty requestScope.RECOMMENT_LIST}">
                    <div class="row">
                        <div class="col-md-12">
                            <h5>BestSeller</h5>
                        </div>
                        <c:set var="rList" value="${requestScope.RECOMMENT_LIST}"/>
                        <c:forEach var="rdto" items="${rList}">
                            <div class="col-md-12" style="margin-top: 20px">
                                <div class="card shadow-sm">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <img src="${rdto.image}" alt="Picture not found" 
                                                 style="margin: 50px 0px 0px 50px; width: 250px; height: 250px;"/>
                                        </div>
                                        <div class="col-md-1">
                                        </div>
                                        <div class="col-lg-6">
                                            <!--add product-->
                                            <br/><br/>
                                            <p><strong>Product name: </strong> ${rdto.productName} </p>
                                            <p><strong>Price: </strong> ${rdto.price} </p>
                                            <p><strong>Description: </strong>${rdto.description}</p>
                                            <p><strong>Category:</strong> ${rdto.categoryId}</p> 
                                            <c:if test="${user.role!='AD'}">
                                                <form action="DispatchServlet" method="POST">
                                                    <div class="card-body">
                                                        <input type="hidden" name="txtProductId" value="${rdto.productId}" />
                                                        <input type="hidden" name="txtProductName" value="${rdto.productName}" />
                                                        <input type="hidden" name="txtPrice" value="${rdto.price}" />
                                                        <input type="hidden" name="btnPage" value="${requestScope.CURRENT_PAGE}"/>
                                                        <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                                                        <input type="hidden" name="cbPrice" value="${requestScope.SELECTED_COMBOBOX}"/>
                                                        <input type="hidden" name="txtCategory" value="${requestScope.SELECTED_CATEGORY}"/>
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <div class="btn-group">
                                                                <input type="submit" value="Add" name="btAction" class="btn btn1"/>
                                                            </div>
                                                            <small class="text-muted">${rdto.createDate}</small>
                                                        </div>
                                                    </div>
                                                    <c:if test="${requestScope.ADD_QUANTITY_ERR == rdto.productId}">
                                                        <font color="red">Out of stock</font>
                                                    </c:if>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                    <br/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${not empty requestScope.PRODUCT_LIST}">
                    <h5>Product list</h5>
                    <div class="row">
                        <c:set var="list" value="${requestScope.PRODUCT_LIST}"/>
                        <c:forEach var="dto" items="${list}">
                            <div class="col-md-12" style="margin-top: 20px">
                                <div class="card shadow-sm">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <img src="${dto.image}" alt="Picture not found" 
                                                 style="margin: 25px 0px 0px 25px; width: 250px; height: 250px;"/>
                                        </div>
                                        <div class="col-md-1">
                                        </div>
                                        <div class="col-lg-6">
                                            <!--add product-->
                                            <br/><br/>
                                            <p><strong>Product name: </strong> ${dto.productName} </p>
                                            <p><strong>Price: </strong> ${dto.price} </p>
                                            <p><strong>Description: </strong>${dto.description}</p>
                                            <p><strong>Category:</strong> ${dto.categoryId}</p> 
                                            <c:if test="${user.role=='AD'}">
                                                <p><strong>Quantity: </strong> ${dto.quantity}</p> 
                                                <p><strong>Status:</strong> 
                                                    <c:if test="${dto.status}">
                                                        Active
                                                    </c:if>
                                                    <c:if test="${not dto.status}">
                                                        Inactive
                                                    </c:if>
                                                </p> 
                                            </c:if>
                                            <c:if test="${user.role!='AD'}">
                                                <form action="DispatchServlet" method="POST">
                                                    <div class="card-body">
                                                        <input type="hidden" name="txtProductId" value="${dto.productId}" />
                                                        <input type="hidden" name="txtProductName" value="${dto.productName}" />
                                                        <input type="hidden" name="txtPrice" value="${dto.price}" />
                                                        <input type="hidden" name="btnPage" value="${requestScope.CURRENT_PAGE}"/>
                                                        <input type="hidden" name="txtSearch" value="${param.txtSearch}"/>
                                                        <input type="hidden" name="cbPrice" value="${requestScope.SELECTED_COMBOBOX}"/>
                                                        <input type="hidden" name="txtCategory" value="${requestScope.SELECTED_CATEGORY}"/>
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <div class="btn-group">
                                                                <input type="submit" value="Add" name="btAction" class="btn btn1"/>
                                                            </div>
                                                            <small class="text-muted">${dto.createDate}</small>
                                                        </div>
                                                    </div>
                                                    <c:if test="${requestScope.ADD_QUANTITY_ERR == dto.productId}">
                                                        <font color="red">Out of stock</font>
                                                    </c:if>
                                                </form>

                                            </c:if>
                                            <!--update product-->
                                            <c:if test="${user.role=='AD'}">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div class="btn-group">
                                                        <c:url var="updateUrl" value="DispatchServlet">
                                                            <c:param name="txtProductId" value="${dto.productId}"/>
                                                            <c:param name="btnPage" value="${requestScope.CURRENT_PAGE}"/>
                                                            <c:param name="txtSearch" value="${param.txtSearch}"/>
                                                            <c:param name="cbPrice" value="${requestScope.SELECTED_COMBOBOX}"/>
                                                            <c:param name="txtCategory" value="${requestScope.SELECTED_CATEGORY}"/>
                                                            <c:param name="btAction" value="UpdateProduct"/>
                                                        </c:url>
                                                        <a href="${updateUrl}" class="btn btn1">Update</a>
                                                    </div>
                                                    <small class="text-muted">${dto.createDate}</small>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="col-md-1">
                                            <br/><br/>
                                            <c:if test="${user.role=='AD'}">
                                                <c:if test="${dto.status}">
                                                    <p><strong>Delete: </strong></p>
                                                    <input type="checkbox" name="chkRemove" value="${dto.productId}" form="delete-form"/>
                                                </c:if>
                                            </c:if>
                                        </div>
                                    </div>
                                    <br/>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${user.role=='AD'}">
                            <div class="mx-auto" style="margin: 30px;">
                                <input type="hidden" name="txtSearch" value="${param.txtSearch}" form="delete-form"/>
                                <input type="hidden" name="btnPage" value="${requestScope.CURRENT_PAGE}" form="delete-form"/>
                                <input type="hidden" name="cbPrice" value="${requestScope.SELECTED_COMBOBOX}" form="delete-form"/>
                                <input type="hidden" name="txtCategory" value="${requestScope.SELECTED_CATEGORY}" form="delete-form"/>
                                <input type="button" value="Delete" name="btAction"
                                       class="btn btn1" data-toggle="modal" data-target="#exampleModalLong"/>
                            </div>
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
                                            Do you want to delete?
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            <input type="submit" value="Delete" name="btAction" class="btn btn1" form="delete-form"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </c:if>
                <c:if test="${empty requestScope.PRODUCT_LIST}">
                    <h2 class="mx-auto">Not found</h2>
                </c:if>
            </div>
        </div>


    </body>
</html>
