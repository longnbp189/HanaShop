/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longnbp.cart.CartObj;
import longnbp.tblProduct.ProductDAO;
import longnbp.tblProduct.ProductDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {

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
        String url = "SearchServlet";
        try {
            
            int productId = Integer.parseInt(request.getParameter("txtProductId"));
            String productName = request.getParameter("txtProductName");
            float price = Float.parseFloat(request.getParameter("txtPrice"));

            HttpSession s = request.getSession();
            if (s != null) {
                if (s.getAttribute("USER") != null) {
                    CartObj cart = (CartObj) s.getAttribute("CART");
                    if (cart == null) {
                        cart = new CartObj();
                    }
                    String search = request.getParameter("txtSearch");
                    String page = request.getParameter("btnPage");
                    String searchPrice = request.getParameter("cbPrice");
                    String category = request.getParameter("txtCategory");
                    
                    ProductDAO pDAO = new ProductDAO();
                    ProductDTO productDTO = pDAO.getProduct(productId);
                    if (productDTO.getQuantity() > 0) {
                        if (cart.getItems().get(productId) == null || cart.getItems().get(productId).getQuantity() < productDTO.getQuantity()) {
                            cart.addItemToCart(productId, price, productName);
                            s.setAttribute("CART", cart);
                            url = "SearchServlet?"
                                    + "txtSearch=" + search
                                    + "&txtCategory=" + category
                                    + "&cbPrice=" + searchPrice
                                    + "&btnPage=" + page;
                        } else {
                            request.setAttribute("ADD_QUANTITY_ERR", productId);
                        }
                    }
                } else {
                    url = "login.jsp";
                }
            }
        } catch (SQLException ex) {
            log("AddToCartServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("AddToCartServlet_Naming " + ex.getMessage());
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
