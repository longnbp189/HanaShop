/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longnbp.cart;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Admin
 */
public class CartObj implements Serializable{
    private Map<Integer, ProductInCart> items;
    private float total;

    public CartObj() {
        items = new HashMap<>();
    }

    public Map<Integer, ProductInCart> getItems() {
        return items;
    }

    public float getTotal() {
        return total;
    }

    public void addItemToCart(int id, float price, String name) {
        if (this.items == null) {
            this.items = new HashMap<>();
            total = 0;
        }
        if (items.containsKey(id)) {
            items.get(id).setQuantity(items.get(id).getQuantity() + 1);
            items.get(id).setPrice(items.get(id).getPrice() + price);
            total += price;
        }
        else {
            ProductInCart item = new ProductInCart(name, 1, price);
            total += price;
            items.put(id, item);
        }
    }

    public void removeItemToCart(int id) {
        if (this.items == null) {
            total = 0;
            return;
        }

        if (this.items.containsKey(id)) {
            float price = this.items.get(id).getPrice();
            this.total -= price;
            this.items.remove(id);
            if (this.items.isEmpty()) {
                this.items = null;
            }
        }
    }
    
     public void updateItem(int id, int quantity, float price, String productName) {
        if (this.items == null) {
            this.items = new HashMap<>();
            this.total = 0;
        }
        ProductInCart cart = new ProductInCart(productName, quantity, price*quantity);
        if (this.items.containsKey(id)) {
                total = total - this.getItems().get(id).getPrice() + cart.getPrice();
        } else {
            total += quantity * price;
        }
        this.items.put(id, cart);
    }
}
