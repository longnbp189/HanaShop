/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.tblProduct;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import longnbp.utilities.DBHelper;

/**
 *
 * @author Admin
 */
public class ProductDAO implements Serializable {

    public List<ProductDTO> getProductListForUser(String search, int min, int max, int page) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ProductDTO> list = null;
        int num = (page - 1) * 20;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT p.productID, p.productName, p.image, p.description, p.quantity, p.price, p.createDate, c.categoryName "
                    + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID "
                    + "WHERE quantity > 0 AND status = 1 AND p.productName LIKE ? AND p.price > ? AND p.price <= ? "
                    + "ORDER BY createDate DESC "
                    + "OFFSET ? ROWS "
                    + "FETCH NEXT 20 ROWS ONLY";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setFloat(2, min);
            ps.setFloat(3, max);
            ps.setInt(4, num);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                int productID = rs.getInt("productID");
                String name = rs.getString("productName");
                String image = rs.getString("image");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
                int quantity = rs.getInt("quantity");
                Timestamp date = rs.getTimestamp("createDate");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                String createDate = format.format(date);
                String cate = rs.getString("categoryName");
                list.add(new ProductDTO(productID, name, image, description, cate, createDate, price, quantity, true));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }

    public List<ProductDTO> getProductListForUserWithCategory(String search, String category, int min, int max, int page) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ProductDTO> list = null;
        int num = (page - 1) * 20;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT p.productID, p.productName, p.image, p.description, p.quantity, p.price, p.createDate, c.categoryName "
                    + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID "
                    + "WHERE quantity > 0 AND status = 1 AND p.productName LIKE ? AND c.categoryId = ?  AND p.price > ? AND p.price <= ? "
                    + "ORDER BY createDate DESC "
                    + "OFFSET ? ROWS "
                    + "FETCH NEXT 20 ROWS ONLY";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, category);
            ps.setFloat(3, min);
            ps.setFloat(4, max);
            ps.setInt(5, num);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                int productID = rs.getInt("productID");
                String name = rs.getString("productName");
                String image = rs.getString("image");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
                int quantity = rs.getInt("quantity");
                Timestamp date = rs.getTimestamp("createDate");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                String createDate = format.format(date);
                String cate = rs.getString("categoryName");
                list.add(new ProductDTO(productID, name, image, description, cate, createDate, price, quantity, true));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }

    public List<ProductDTO> getProductListForAdmin(String search, int min, int max, int page) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ProductDTO> list = null;
        int num = (page - 1) * 20;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT p.productID, p.productName, p.image, p.description, p.quantity, p.price, p.createDate, c.categoryName, p.status "
                    + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID "
                    + "WHERE p.productName LIKE ?  AND p.price > ? AND p.price <= ? "
                    + "ORDER BY createDate DESC "
                    + "OFFSET ? ROWS "
                    + "FETCH NEXT 20 ROWS ONLY";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setFloat(2, min);
            ps.setFloat(3, max);
            ps.setInt(4, num);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                int productID = rs.getInt("productID");
                String name = rs.getString("productName");
                String image = rs.getString("image");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
                int quantity = rs.getInt("quantity");
                Timestamp date = rs.getTimestamp("createDate");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                String createDate = format.format(date);
                String cate = rs.getString("categoryName");
                boolean status = rs.getBoolean("status");
                list.add(new ProductDTO(productID, name, image, description, cate, createDate, price, quantity, status));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }

    public List<ProductDTO> getProductListForAdminWithCategory(String search, String category, int min, int max, int page) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ProductDTO> list = null;
        int num = (page - 1) * 20;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT p.productID, p.productName, p.image, p.description, p.quantity, p.price, p.createDate, c.categoryName, p.status "
                    + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID "
                    + "WHERE p.productName LIKE ? AND c.categoryId = ?  AND p.price > ? AND p.price <= ? "
                    + "ORDER BY createDate DESC "
                    + "OFFSET ? ROWS "
                    + "FETCH NEXT 20 ROWS ONLY";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, category);
            ps.setFloat(3, min);
            ps.setFloat(4, max);
            ps.setInt(5, num);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                int productID = rs.getInt("productID");
                String name = rs.getString("productName");
                String image = rs.getString("image");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
                int quantity = rs.getInt("quantity");
                Timestamp date = rs.getTimestamp("createDate");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                String createDate = format.format(date);
                String cate = rs.getString("categoryName");
                boolean status = rs.getBoolean("status");
                list.add(new ProductDTO(productID, name, image, description, cate, createDate, price, quantity, status));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }

    public int getMaxPrice() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT TOP 1 price "
                    + "FROM tblProduct "
                    + "ORDER BY price DESC";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("price");
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return 0;
    }

    public int pageCountForUser(String search, int min, int max) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT count(p.productID) AS row "
                    + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID "
                    + "WHERE quantity > 0 AND status = 1 AND p.productName LIKE ? AND p.price > ? AND p.price <= ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setFloat(2, min);
            ps.setFloat(3, max);
            rs = ps.executeQuery();
            if (rs.next()) {
                int count = (rs.getInt("row") - 1) / 20;
                return count + 1;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return 0;
    }

    public int pageCountForUserWithCategory(String search, String category, int min, int max) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT count(p.productID) AS row "
                    + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID "
                    + "WHERE quantity > 0 AND status = 1 AND p.productName LIKE ? AND c.categoryId = ? AND p.price > ? AND p.price <= ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, category);
            ps.setFloat(3, min);
            ps.setFloat(4, max);
            rs = ps.executeQuery();
            if (rs.next()) {
                int count = (rs.getInt("row") - 1) / 20;
                return count + 1;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return 0;
    }

    public int pageCountForAdmin(String search, int min, int max) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT count(p.productID) AS row "
                    + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID "
                    + "WHERE p.productName LIKE ? AND p.price > ? AND p.price <= ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setFloat(2, min);
            ps.setFloat(3, max);
            rs = ps.executeQuery();
            if (rs.next()) {
                int count = (rs.getInt("row") - 1) / 20;
                return count + 1;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return 0;
    }

    public int pageCountForAdminWithCategory(String search, String category, int min, int max) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT count(p.productID) AS row "
                    + "FROM tblProduct p JOIN tblCategory c ON p.categoryID = c.categoryID "
                    + "WHERE p.productName LIKE ? AND c.categoryId = ? AND p.price > ? AND p.price <= ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, category);
            ps.setFloat(3, min);
            ps.setFloat(4, max);
            rs = ps.executeQuery();
            if (rs.next()) {
                int count = (rs.getInt("row") - 1) / 20;
                return count + 1;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return 0;
    }

    public void deleteProduct(int productId) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.getConnection();
            String sql = "UPDATE tblProduct "
                    + "SET status = 0 "
                    + "WHERE productId = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.executeUpdate();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public void updateProduct(ProductDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.getConnection();
            String sql = "UPDATE tblProduct "
                    + "SET productName = ?, image = ?, description = ?, quantity = ?, price = ?, status = ?, categoryId = ? "
                    + "WHERE productId = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, dto.getProductName());
            ps.setString(2, dto.getImage());
            ps.setString(3, dto.getDescription());
            ps.setInt(4, dto.getQuantity());
            ps.setFloat(5, dto.getPrice());
            ps.setBoolean(6, dto.isStatus());
            ps.setString(7, dto.getCategoryId());
            ps.setInt(8, dto.getProductId());
            ps.executeUpdate();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public void createProduct(ProductDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.getConnection();
            String sql = "INSERT INTO tblProduct (productName, image, description, quantity, price, status, categoryId, createDate) "
                    + "VALUES (?,?,?,?,?,?,?,?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, dto.getProductName());
            ps.setString(3, dto.getDescription());
            ps.setInt(4, dto.getQuantity());
            ps.setFloat(5, dto.getPrice());
            ps.setBoolean(6, dto.isStatus());
            ps.setString(7, dto.getCategoryId());
            ps.setString(2, dto.getImage());
            ps.setTimestamp(8, new Timestamp(new Date().getTime()));
            ps.executeUpdate();

        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public ProductDTO getProduct(int productID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT productName, image, description, quantity, price, categoryId, status "
                    + "FROM tblProduct "
                    + "WHERE productId = ? AND status = 1";
            ps = con.prepareStatement(sql);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                String description = rs.getString("description");
                String cateId = rs.getString("categoryId");
                int quantity = rs.getInt("quantity");
                float price = rs.getFloat("price");
                boolean status = rs.getBoolean("status");
                return new ProductDTO(productID, productName, image, description, cateId, "", price, quantity, status);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }

    public ProductDTO getProductForAdmin(int productID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT productName, image, description, quantity, price, categoryId, status "
                    + "FROM tblProduct "
                    + "WHERE productId = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                String description = rs.getString("description");
                String cateId = rs.getString("categoryId");
                int quantity = rs.getInt("quantity");
                float price = rs.getFloat("price");
                boolean status = rs.getBoolean("status");
                return new ProductDTO(productID, productName, image, description, cateId, "", price, quantity, status);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;
    }

    public void updateQuantity(int productID, int quantity) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.getConnection();
            String sql = "UPDATE tblProduct "
                    + "SET quantity = ? "
                    + "WHERE productId = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, productID);
            ps.executeUpdate();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }

    }

    public List<ProductDTO> getRecomment() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ProductDTO> list = null;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT p.productID, p.productName, p.image, p.description, p.quantity, p.price, p.createDate, c.categoryName "
                    + "FROM tblProduct p  JOIN tblOrderDetail od ON od.productId = p.productId "
                    + "JOIN tblCategory c ON c.categoryId = p.categoryId "
                    + "WHERE  p.quantity > 0 AND p.status = 1 "
                    + "GROUP BY p.productID, p.productName, p.image, p.description, p.quantity, p.price, p.createDate, c.categoryName "
                    + "ORDER BY SUM(od.quantity) DESC "
                    + "OFFSET 0 ROWS  "
                    + "FETCH NEXT 3 ROWS ONLY";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                int productID = rs.getInt("productID");
                String name = rs.getString("productName");
                String image = rs.getString("image");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
                int quantity = rs.getInt("quantity");
                Timestamp date = rs.getTimestamp("createDate");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                String createDate = format.format(date);
                String cate = rs.getString("categoryName");
                list.add(new ProductDTO(productID, name, image, description, cate, createDate, price, quantity, true));
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }
}
