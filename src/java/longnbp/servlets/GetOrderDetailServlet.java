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
import longnbp.tblOrderDetail.OrderDetailDAO;
import longnbp.tblOrderDetail.OrderDetailDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "GetOrderDetailServlet", urlPatterns = {"/GetOrderDetailServlet"})
public class GetOrderDetailServlet extends HttpServlet {

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
        String url = "cartDetail.jsp";
        try {
            String search = request.getParameter("txtSearch");
            String page = request.getParameter("btnPage");
            String searchPrice = request.getParameter("cbPrice");
            String searchCategory = request.getParameter("txtCategory");
            request.setAttribute("SEARCH_NAME", search);
            request.setAttribute("SEARCH_PAGE", page);
            request.setAttribute("SEARCH_PRICE", searchPrice);
            request.setAttribute("SEARCH_CATEGORY", searchCategory);

            int orderId = Integer.parseInt(request.getParameter("txtOrderId"));
            String date = request.getParameter("txtDate");
            OrderDetailDAO odDAO = new OrderDetailDAO();
            List<OrderDetailDTO> list = odDAO.getOrderDetailDTOs(orderId);
            request.setAttribute("DETAIL_LIST", list);
            request.setAttribute("SEARCH_DATE", date);
        } catch (SQLException ex) {
            log("GetOrderDetailServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("GetOrderDetailServlet_Naming " + ex.getMessage());
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
