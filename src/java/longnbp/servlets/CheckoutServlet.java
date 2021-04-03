/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longnbp.cart.CartObj;
import longnbp.cart.ProductInCart;
import longnbp.tblOrder.OrderDAO;
import longnbp.tblOrder.OrderDTO;
import longnbp.tblOrderDetail.OrderDetailDAO;
import longnbp.tblOrderDetail.OrderDetailDTO;
import longnbp.tblProduct.ProductDAO;
import longnbp.tblProduct.ProductDTO;
import longnbp.tblUser.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

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
            HttpSession s = request.getSession();
            if (s != null) {
                CartObj cart = (CartObj) s.getAttribute("CART");
                UserDTO dto = (UserDTO) s.getAttribute("USER");
                if (cart != null) {
                    ProductDAO pDAO = new ProductDAO();
                    OrderDAO oDAO = new OrderDAO();
                    Map<Integer, ProductInCart> list = cart.getItems();
                    Set<Integer> keys = list.keySet();
                    boolean check = true;
                    List<Integer> errKey = new ArrayList<>();
                    for (int key : keys) {
                        ProductDTO pDTO = pDAO.getProduct(key);
                        if (pDTO != null) {
                            if (pDTO.getQuantity() < cart.getItems().get(key).getQuantity()) {
                                errKey.add(key);
                                check = false;
                            }
                        } else {
                            check = false;
                            errKey.add(key);
                        }
                    }
                    if (check) {
                        oDAO.addOrder(new OrderDTO(0, dto.getUsername(), "", false, cart.getTotal()));
                        int row = oDAO.newestOrder(dto.getUsername());
                        OrderDetailDAO odDAO = new OrderDetailDAO();
                        for (int key : keys) {
                            ProductDTO pDTO = pDAO.getProduct(key);
                            odDAO.addOrderDetail(new OrderDetailDTO(0, row, cart.getItems().get(key).getQuantity(), key, "", cart.getItems().get(key).getPrice()));
                            pDAO.updateQuantity(key, pDTO.getQuantity() - list.get(key).getQuantity());
                            if ((pDTO.getQuantity() - list.get(key).getQuantity()) == 0) {
                                pDAO.deleteProduct(key);
                            }
                        }
                        s.removeAttribute("CART");
                    } else {
                        url = "ShowCartServlet";
                        request.setAttribute("CHECKOUT_ERR", errKey);
                    }
                } else {
                    url = "ShowCartServlet";
                }
            }
        } catch (SQLException ex) {
            log("CheckoutServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("CheckoutServlet_Naming " + ex.getMessage());
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
