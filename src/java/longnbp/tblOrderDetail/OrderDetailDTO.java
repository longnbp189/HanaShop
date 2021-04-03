/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.tblOrderDetail;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class OrderDetailDTO implements Serializable{
    private int orderDetailId, orderId, quantity, productId;
    private String productName;
    private float price;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(int orderDetailId, int orderId, int quantity, int productId) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.quantity = quantity;
        this.productId = productId;
    }

    public OrderDetailDTO(int orderDetailId, int orderId, int quantity, int productId, String productName, float price) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.quantity = quantity;
        this.productId = productId;
        this.productName = productName;
        this.price = price;
    }

    /**
     * @return the orderDetailId
     */
    public int getOrderDetailId() {
        return orderDetailId;
    }

    /**
     * @param orderDetailId the orderDetailId to set
     */
    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    /**
     * @return the orderId
     */
    public int getOrderId() {
        return orderId;
    }

    /**
     * @param orderId the orderId to set
     */
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    /**
     * @return the quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * @param quantity the quantity to set
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * @return the productId
     */
    public int getProductId() {
        return productId;
    }

    /**
     * @param productId the productId to set
     */
    public void setProductId(int productId) {
        this.productId = productId;
    }

    /**
     * @return the productName
     */
    public String getProductName() {
        return productName;
    }

    /**
     * @param productName the productName to set
     */
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /**
     * @return the price
     */
    public float getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(float price) {
        this.price = price;
    }
 

    
    
}
