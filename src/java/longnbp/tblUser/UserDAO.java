/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.tblUser;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import longnbp.utilities.DBHelper;

/**
 *
 * @author Admin
 */
public class UserDAO implements Serializable{
    
    public boolean checkLogin(String username, String password) throws NamingException, SQLException{
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBHelper.getConnection();
            String url = "Select username, password, fullname "
                    + "From tblUser "
                    + "Where username=? and password=? and status = 1";
            ps = con.prepareStatement(url);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                return true;
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
        return false;
    }
    
    public UserDTO getUserDetail(String username) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.getConnection();
            if (con != null) {
                String sql = "Select username, password, fullname, role, status "
                       + "From tblUser "
                    + "Where username=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, username);
                rs = ps.executeQuery();
                if (rs.next()) {
                    String password = rs.getString("password");
                    String fullname = rs.getString("fullname");
                    String role = rs.getString("role");
                    boolean status = rs.getBoolean("status");
                    return new UserDTO(username, password, fullname, role, status);
                }
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
    
    public void addAcount(UserDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.getConnection();
            if (con != null) {
                String sql = "Insert Into tblUser (username, password, fullname, role, status) "
                       + "Values (?, ? ,? ,? ,?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, dto.getUsername());
                ps.setString(2, dto.getPassword());
                ps.setString(3, dto.getFullname());
                ps.setString(4, dto.getRole());
                ps.setBoolean(5, dto.isStatus());
                ps.executeUpdate();
            }
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    
}
