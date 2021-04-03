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
import longnbp.tblUser.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DeleteServlet", urlPatterns = {"/DeleteServlet"})
public class DeleteServlet extends HttpServlet {

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
            String[] removeItem = request.getParameterValues("chkRemove");
            String search = request.getParameter("txtSearch");
            String page = request.getParameter("btnPage");
            String price = request.getParameter("cbPrice");
            String category = request.getParameter("txtCategory");
            ProductDAO pDAO = new ProductDAO();

            HttpSession session = request.getSession();
            if (removeItem != null) {
                for (String string : removeItem) {
                    int key = Integer.parseInt(string);
                    UserDTO user = (UserDTO) session.getAttribute("USER");
                        pDAO.deleteProduct(key);
                        HistoryDAO hDAO = new HistoryDAO();
                        hDAO.createHistory(new HistoryDTO(0, key, "", user.getUsername(), "", "Delete"));
                }
            } else {
                request.setAttribute("DELETE_ERR", "Please choose product");
            }
            url = "SearchServlet?"
                    + "txtSearch=" + search
                    + "&txtCategory=" + category
                    + "&cbPrice=" + price
                    + "&btnPage=" + page;

        } catch (SQLException ex) {
            log("DeleteServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("DeleteServlet_Naming " + ex.getMessage());
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
