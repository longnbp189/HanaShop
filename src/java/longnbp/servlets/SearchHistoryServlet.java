/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longnbp.tblOrder.OrderDAO;
import longnbp.tblOrder.OrderDTO;
import longnbp.tblUser.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SearchHistoryServlet", urlPatterns = {"/SearchHistoryServlet"})
public class SearchHistoryServlet extends HttpServlet {

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
        String url = "shoppingHistory.jsp";
        try {
            String search = request.getParameter("txtSearch");
            String page = request.getParameter("btnPage");
            String searchPrice = request.getParameter("cbPrice");
            String searchCategory = request.getParameter("txtCategory");
            request.setAttribute("SEARCH_NAME", search);
            request.setAttribute("SEARCH_PAGE", page);
            request.setAttribute("SEARCH_PRICE", searchPrice);
            request.setAttribute("SEARCH_CATEGORY", searchCategory);
            
            String date = "";
            if (request.getParameter("txtDate") != null) {
                date = request.getParameter("txtDate");
            }
            HttpSession s = request.getSession();
            UserDTO uDTO = (UserDTO) s.getAttribute("USER");
            OrderDAO oDAO = new OrderDAO();
            List<OrderDTO> list;
            if (date.equals("")) {
                list = oDAO.getOrderbyUsername(uDTO.getUsername());
            } else {
                list = oDAO.getOrderbyUsernameWithDate(uDTO.getUsername(), date);
            }
            request.setAttribute("HISTORY", list);
        } catch (SQLException ex) {
            log("SearchHistoryServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("SearchHistoryServlet_Naming " + ex.getMessage());

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
