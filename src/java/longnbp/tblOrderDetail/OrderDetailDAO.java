/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.tblOrderDetail;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import longnbp.utilities.DBHelper;

/**
 *
 * @author Admin
 */
public class OrderDetailDAO implements Serializable{
    
    public void addOrderDetail(OrderDetailDTO dto) throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBHelper.getConnection();
            String sql = "INSERT INTO tblOrderDetail ( orderId, productId, quantity, price ) "
                    + "VALUES (?, ?, ?, ?) ";
            ps = con.prepareStatement(sql);
            ps.setInt(1, dto.getOrderId());
            ps.setInt(2, dto.getProductId());
            ps.setInt(3, dto.getQuantity());
            ps.setFloat(4, dto.getPrice());
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
    
    public List<OrderDetailDTO> getOrderDetailDTOs(int orderId) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<OrderDetailDTO> list = null;
        try {
            con = DBHelper.getConnection();
            String sql = "Select od.orderDetailId, p.productName, od.quantity, od.price "
                    + "from tblOrderDetail od join tblProduct p on od.productId = p.productId "
                    + "Where orderId = ? ";
            ps = con.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (list == null) {
                    list = new ArrayList<>();
                }
                int id = rs.getInt("orderDetailId");
                String productName = rs.getString("productName");
                int quantity = rs.getInt("quantity");
                float price = rs.getFloat("price");
                list.add(new OrderDetailDTO(id, orderId, quantity, 0, productName, price));

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
