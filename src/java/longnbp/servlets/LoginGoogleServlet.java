/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.StringTokenizer;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longnbp.tblUser.UserDAO;
import longnbp.tblUser.UserDTO;
import longnbp.google.GooglePojo;
import longnbp.utilities.GoogleUtils;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginGoogleServlet", urlPatterns = {"/login-google"})
public class LoginGoogleServlet extends HttpServlet {

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
        String code = request.getParameter("code");
        HttpSession s = request.getSession();
        String url = "SearchServlet";

        try {
            if (code == null || code.isEmpty()) {
                url = "login.jsp";
            } else {
                String accessToken = GoogleUtils.getToken(code);
                GooglePojo gDTO = GoogleUtils.getUserInfo(accessToken);
                String email = gDTO.getEmail();
                UserDAO uDAO = new UserDAO();
                UserDTO uDTO = uDAO.getUserDetail(email);

                if (uDTO != null) {
                    s.setAttribute("USER", uDTO);
                } else {
                    StringTokenizer stk = new StringTokenizer(email, "@");
                    String name = stk.nextToken();
                    uDTO = new UserDTO(email, "12354", name, "U", true);
                    uDAO.addAcount(uDTO);
                    s.setAttribute("USER", uDTO);
                }

            }

        } catch (SQLException ex) {
            log("LoginGoogleServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("LoginGoogleServlet_Naming " + ex.getMessage());
        } finally {
            response.sendRedirect(url);
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
