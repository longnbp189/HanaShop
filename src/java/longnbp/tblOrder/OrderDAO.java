/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.tblOrder;

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
public class OrderDAO implements Serializable {

    public void addOrder(OrderDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.getConnection();
            String sql = "INSERT INTO tblOrder ( username, isOnlinePayment, currentDate, total ) "
                    + "VALUES (?, ?, ?, ?) ";
            ps = con.prepareStatement(sql);
            ps.setString(1, dto.getUsername());
            Date d = new Date();
            Timestamp t = new Timestamp(d.getTime());
            ps.setTimestamp(3, t);
            ps.setBoolean(2, dto.isIsOnlinePayment());
            ps.setFloat(4, dto.getTotal());
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

    public List<OrderDTO> getOrderbyUsername(String username) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<OrderDTO> list = null;
        try {
            con = DBHelper.getConnection();
            String sql = "Select orderid, username, currentDate, isOnlinePayment, total "
                    + "from tblOrder "
                    + "Where username = ? "
                    + "ORDER BY currentDate DESC";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                int id = rs.getInt("orderid");
                float total = rs.getFloat("total");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                String date = format.format(rs.getTimestamp("currentDate"));
                boolean isOnlinePayment = rs.getBoolean("isOnlinePayment");
                list.add(new OrderDTO(id, username, date, isOnlinePayment, total));
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

    public int newestOrder(String username) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT TOP 1 orderId  "
                    + "FROM tblOrder "
                    + "WHERE username= ? "
                    + "ORDER BY orderId DESC ";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("orderId");
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

    public List<OrderDTO> getOrderbyUsernameWithDate(String username, String date) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<OrderDTO> list = null;
        try {
            con = DBHelper.getConnection();
            String sql = "Select orderid, username, currentDate, isOnlinePayment, total "
                    + "from tblOrder "
                    + "Where username = ? AND CAST(currentDate AS date) = CAST(? AS date) "
                    + "ORDER BY currentDate DESC ";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, date);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                int id = rs.getInt("orderid");
                float total = rs.getFloat("total");
                boolean isOnlinePayment = rs.getBoolean("isOnlinePayment");
                Timestamp dateDB = rs.getTimestamp("currentDate");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                String createDate = format.format(dateDB);
                list.add(new OrderDTO(id, username, createDate, isOnlinePayment, total));
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
