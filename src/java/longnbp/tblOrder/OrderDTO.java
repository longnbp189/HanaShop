/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.tblOrder;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class OrderDTO implements Serializable {

    private int orderid;
    private String username, currentDate;
    private boolean isOnlinePayment;
    private float total;

    public OrderDTO() {
    }

    public OrderDTO(int orderid, String username, String currentDate, boolean isOnlinePayment, float total) {
        this.orderid = orderid;
        this.username = username;
        this.currentDate = currentDate;
        this.isOnlinePayment = isOnlinePayment;
        this.total = total;
    }

    /**
     * @return the orderid
     */
    public int getOrderid() {
        return orderid;
    }

    /**
     * @param orderid the orderid to set
     */
    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the currentDate
     */
    public String getCurrentDate() {
        return currentDate;
    }

    /**
     * @param currentDate the currentDate to set
     */
    public void setCurrentDate(String currentDate) {
        this.currentDate = currentDate;
    }

    /**
     * @return the isOnlinePayment
     */
    public boolean isIsOnlinePayment() {
        return isOnlinePayment;
    }

    /**
     * @param isOnlinePayment the isOnlinePayment to set
     */
    public void setIsOnlinePayment(boolean isOnlinePayment) {
        this.isOnlinePayment = isOnlinePayment;
    }

    /**
     * @return the total
     */
    public float getTotal() {
        return total;
    }

    /**
     * @param total the total to set
     */
    public void setTotal(float total) {
        this.total = total;
    }

    
}
