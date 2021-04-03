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
import longnbp.tblHistory.HistoryDAO;
import longnbp.tblHistory.HistoryDTO;
import longnbp.tblProduct.ProductDAO;
import longnbp.tblProduct.ProductDTO;
import longnbp.tblProduct.UpdateProductError;
import longnbp.tblUser.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateServlet", urlPatterns = {"/UpdateServlet"})
public class UpdateServlet extends HttpServlet {

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
        String url = "FindProductServlet";
        HttpSession session = request.getSession();
        try {
            String search = request.getParameter("txtSearch");
            String page = request.getParameter("btnPage");
            String searchPrice = request.getParameter("cbPrice");
            String searchCategory = request.getParameter("txtCategory");
            request.setAttribute("SEARCH_NAME", search);
            request.setAttribute("SEARCH_PAGE", page);
            request.setAttribute("SEARCH_PRICE", searchPrice);
            request.setAttribute("SEARCH_CATEGORY", searchCategory);

            ProductDAO pDAO = new ProductDAO();

            UpdateProductError errors = new UpdateProductError();
            boolean err = false;
            int productID = Integer.parseInt(request.getParameter("txtProductId"));
            String name = "";
            if (request.getParameter("txtName") != null && !request.getParameter("txtName").trim().equals("")) {
                name = request.getParameter("txtName").trim();
            }
            if (name.length() < 3 || name.length() > 50) {
                errors.setNameError("Name length 3 to 50");
                err = true;
            }
            String p = "";
            float price = 0;
            if (request.getParameter("txtPrice") != null) {
                p = request.getParameter("txtPrice").trim();
            }
            try {
                price = Float.parseFloat(p);
                if (price <= 0) {
                    errors.setPriceError("Price must not smaller than 0");
                    err = true;
                }
            } catch (NumberFormatException e) {
                errors.setPriceError("Price is a float");
                err = true;
            }
            String q = "";
            int quantity = 0;
            if (request.getParameter("txtQuantity") != null) {
                q = request.getParameter("txtQuantity").trim();
            }
            try {
                quantity = Integer.parseInt(q);
                if (quantity <= 0) {
                    errors.setQuantityError("Quantity must not smaller than 0");
                    err = true;
                }
            } catch (NumberFormatException e) {
                errors.setQuantityError("Quantity is an integer");
                err = true;
            }

            String description = "";
            if (request.getParameter("txtDescription") != null && !request.getParameter("txtDescription").trim().equals("")) {
                description = request.getParameter("txtDescription").trim();
            }
            if (description.length() < 3 || description.length() > 300) {
                errors.setDecriptionError("Description length 3 to 300");
                err = true;
            }

            String image = "";
            if (request.getParameter("txtImage") != null && !request.getParameter("txtImage").equals("")) {
                image = request.getParameter("txtImage");
            }
            if (image.length() < 1 || image.length() > 1000) {
                errors.setImageError("Please enter link image");
                err = true;
            }

            String category = "";
            if (request.getParameter("cbCategory") != null) {
                category = request.getParameter("cbCategory");
            }
            String s;
            boolean status = true;
            if (request.getParameter("cbStatus") != null) {
                s = request.getParameter("cbStatus");
                if (s.equals("Inactive")) {
                    status = false;
                }
            }

            if (!err) {
                ProductDTO checkProduct = pDAO.getProductForAdmin(productID);
                ProductDTO pDTO = new ProductDTO(productID, name, image, description, category, "", price, quantity, status);
                if (!checkProduct.getProductName().equals(name) || !checkProduct.getImage().equals(image)
                        || !checkProduct.getDescription().equals(description) || !checkProduct.getCategoryId().equals(category)
                        || checkProduct.getPrice() != price || checkProduct.getQuantity() != quantity
                        || checkProduct.isStatus() != status) {
                    pDAO.updateProduct(pDTO);
                    UserDTO user = (UserDTO) session.getAttribute("USER");
                    HistoryDAO hDAO = new HistoryDAO();
                    hDAO.createHistory(new HistoryDTO(0, productID, "", user.getUsername(), "", "Update"));
                }
                url = "SearchServlet?"
                        + "txtSearch=" + search
                        + "&txtCategory=" + searchCategory
                        + "&cbPrice=" + searchPrice
                        + "&btnPage=" + page;
            } else {
                request.setAttribute("ERROR", errors);
            }
        } catch (SQLException ex) {
            log("UpdateServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("UpdateServlet_Naming " + ex.getMessage());
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
