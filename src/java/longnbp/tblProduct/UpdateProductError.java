/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.tblProduct;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class UpdateProductError implements Serializable{
    private String nameError, priceError, quantityError, dateError, decriptionError, imageError;

    public UpdateProductError() {
    }

    public UpdateProductError(String nameError, String priceError, String quantityError, String dateError, String decriptionError, String imageError) {
        this.nameError = nameError;
        this.priceError = priceError;
        this.quantityError = quantityError;
        this.dateError = dateError;
        this.decriptionError = decriptionError;
        this.imageError = imageError;
    }

    

    

    /**
     * @return the nameError
     */
    public String getNameError() {
        return nameError;
    }

    /**
     * @param nameError the nameError to set
     */
    public void setNameError(String nameError) {
        this.nameError = nameError;
    }

    /**
     * @return the priceError
     */
    public String getPriceError() {
        return priceError;
    }

    /**
     * @param priceError the priceError to set
     */
    public void setPriceError(String priceError) {
        this.priceError = priceError;
    }

    /**
     * @return the quantityError
     */
    public String getQuantityError() {
        return quantityError;
    }

    /**
     * @param quantityError the quantityError to set
     */
    public void setQuantityError(String quantityError) {
        this.quantityError = quantityError;
    }

    /**
     * @return the dateError
     */
    public String getDateError() {
        return dateError;
    }

    /**
     * @param dateError the dateError to set
     */
    public void setDateError(String dateError) {
        this.dateError = dateError;
    }

    /**
     * @return the decriptionError
     */
    public String getDecriptionError() {
        return decriptionError;
    }

    /**
     * @param decriptionError the decriptionError to set
     */
    public void setDecriptionError(String decriptionError) {
        this.decriptionError = decriptionError;
    }

    /**
     * @return the imageError
     */
    public String getImageError() {
        return imageError;
    }

    /**
     * @param imageError the imageError to set
     */
    public void setImageError(String imageError) {
        this.imageError = imageError;
    }
    
}
