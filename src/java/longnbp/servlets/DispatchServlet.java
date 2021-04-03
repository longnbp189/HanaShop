/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class DispatchServlet extends HttpServlet {

    private final String HOME_PAGE = "SearchServlet";
    private final String LOGIN_CONTROLLER = "LoginServlet";
    private final String LOGOUT_CONTROLLER = "LogoutServlet";
    private final String DELETE_CONTROLLER = "DeleteServlet";
    private final String FIND_PRODUCT_CONTROLLER = "FindProductServlet";
    private final String UPDATE_CONTROLLER = "UpdateServlet";
    private final String ADD_TO_CART_CONTROLLER = "AddToCartServlet";
    private final String CHECKOUT_CONTROLLER = "CheckoutServlet";
    private final String UPDATE_QUANTITY_CONTROLLER = "UpdateQuantityServlet";
    private final String CREATE_PRODUCT_CONTROLLER = "CreateProductServlet";
    private final String HISTORY_PRODUCT_CONTROLLER = "HistoryProductServlet";
    private final String GET_ORDER_DETAIL_CONTROLLER = "GetOrderDetailServlet";
    private final String REMOVE_ITEM_IN_CART_CONTROLLER = "RemoveItemInCartServlet";
    private final String SEARCH_HISTORY_CONTROLLER = "SearchHistoryServlet";
    private final String SHOW_CART_CONTROLLER = "ShowCartServlet";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = HOME_PAGE;
        String button = request.getParameter("btAction");
        try {
            if (button == null) {
            } else if (button.equals("Login")) {
                url = LOGIN_CONTROLLER;
            } else if (button.equals("Logout")) {
                url = LOGOUT_CONTROLLER;
            } else if (button.equals("Delete")) {
                url = DELETE_CONTROLLER;
            } else if (button.equals("UpdateProduct")) {
                url = FIND_PRODUCT_CONTROLLER;
            } else if (button.equals("Save")) {
                url = UPDATE_CONTROLLER;
            } else if (button.equals("Add")) {
                url = ADD_TO_CART_CONTROLLER;
            } else if (button.equals("Checkout")) {
                url = CHECKOUT_CONTROLLER;
            } else if (button.equals("History")) {
                url = HISTORY_PRODUCT_CONTROLLER;
            } else if (button.equals("Create")) {
                url = CREATE_PRODUCT_CONTROLLER;
            } else if (button.equals("Remove")) {
                url = REMOVE_ITEM_IN_CART_CONTROLLER;
            } else if (button.equals("Search History")) {
                url = SEARCH_HISTORY_CONTROLLER;
            } else if (button.equals("Update")) {
                url = UPDATE_QUANTITY_CONTROLLER;
            } else if (button.equals("Detail")) {
                url = GET_ORDER_DETAIL_CONTROLLER;
            } else if (button.equals("showCart")) {
                url = SHOW_CART_CONTROLLER;
            }

        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
