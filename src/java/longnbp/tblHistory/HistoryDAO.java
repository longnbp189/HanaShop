/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.tblHistory;

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
public class HistoryDAO implements Serializable {

    public void createHistory(HistoryDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.getConnection();
            String sql = "INSERT INTO tblHistory (productId, date, username, type) "
                    + "VALUES (?,?,?,?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, dto.getProductId());
            ps.setString(3, dto.getUsername());
            ps.setString(4, dto.getType());
            ps.setTimestamp(2, new Timestamp(new Date().getTime()));
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

    public List<HistoryDTO> getAllHistory() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<HistoryDTO> list = null;
        try {
            con = DBHelper.getConnection();
            String sql = "SELECT h.id, h.productId, h.date, h.username, p.productName, h.type "
                    + "FROM tblHistory h JOIN tblProduct p ON h.productId = p.productId "
                    + "ORDER BY h.date DESC";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                int productId = rs.getInt("productId");
                String username = rs.getString("username");
                String productName = rs.getString("productName");
                String type = rs.getString("type");
                int id = rs.getInt("id");
                Date date = rs.getTimestamp("date");
                SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy hh:mm");
                String d = format.format(date);
                list.add(new HistoryDTO(id, productId, productName, username, d, type));
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
