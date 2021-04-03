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
import java.util.StringTokenizer;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longnbp.tblCategory.CategoryDAO;
import longnbp.tblCategory.CategoryDTO;
import longnbp.tblProduct.ProductDAO;
import longnbp.tblProduct.ProductDTO;
import longnbp.tblUser.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/SearchServlet"})
public class SearchServlet extends HttpServlet {

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
        String url = "home.jsp";
        try {
            HttpSession s = request.getSession();
            UserDTO uDTO = (UserDTO) s.getAttribute("USER");

            int page = 1;
            if (request.getParameter("btnPage") != null) {
                if (!request.getParameter("btnPage").equals("")) {
                    page = Integer.parseInt(request.getParameter("btnPage"));
                }
            }
            request.setAttribute("CURRENT_PAGE", page);

            ProductDAO proDAO = new ProductDAO();
            String name = "";
            if (request.getParameter("txtSearch") != null) {
                name = request.getParameter("txtSearch");
            }

            String category = "";
            if (request.getParameter("txtCategory") != null) {
                category = request.getParameter("txtCategory");
            }
            request.setAttribute("SELECTED_CATEGORY", category);

            int min, max;
            String p = "All price";
            if (request.getParameter("cbPrice") != null) {
                p = request.getParameter("cbPrice");
            }
            if (p.equals("All price") || p.equals("")) {
                min = 0;
                max = proDAO.getMaxPrice();
            } else if(p.equals("300 Above")) {
                min = 300;
                max = proDAO.getMaxPrice();
            }else {
                StringTokenizer stk = new StringTokenizer(p, "-");
                min = Integer.parseInt(stk.nextToken().trim());
                max = Integer.parseInt(stk.nextToken().trim());
            }

            request.setAttribute("SELECTED_COMBOBOX", p);

            CategoryDAO cDAO = new CategoryDAO();
            List<CategoryDTO> cList = cDAO.getCategoryList();
            request.setAttribute("CATEGORY_LIST", cList);
            List<ProductDTO> prList;

            List<ProductDTO> pList;
            int pageCount;
            if (uDTO != null && uDTO.getRole().equals("AD")) {
                if (category.equals("")) {
                    pList = proDAO.getProductListForAdmin(name, min, max, page);
                    pageCount = proDAO.pageCountForAdmin(name, min, max);
                } else {
                    pList = proDAO.getProductListForAdminWithCategory(name, category, min, max, page);
                    pageCount = proDAO.pageCountForAdminWithCategory(name, category, min, max);
                }

            } else {
                if (uDTO != null) {
                    prList = proDAO.getRecomment();
                    request.setAttribute("RECOMMENT_LIST", prList);
                }
                if (category.equals("")) {
                    pList = proDAO.getProductListForUser(name, min, max, page);
                    pageCount = proDAO.pageCountForUser(name, min, max);
                } else {
                    pList = proDAO.getProductListForUserWithCategory(name, category, min, max, page);
                    pageCount = proDAO.pageCountForUserWithCategory(name, category, min, max);
                }
            }

            if (pList != null) {
                request.setAttribute("PAGE_COUNT", pageCount);
                request.setAttribute("PRODUCT_LIST", pList);
            } else {
                request.setAttribute("NOT_FOUND", "Not Found");
            }

        } catch (SQLException ex) {
            log("SearchServlet_SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("SearchServlet_Naming " + ex.getMessage());
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
