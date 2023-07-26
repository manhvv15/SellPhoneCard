package model;

import com.google.gson.Gson;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Order {
    private long id;
    private User user;
    private String status;
    private int totalAmount;
    private Product product;
    private int quantity;
    private boolean isDelete;
    private Timestamp createdAt;
    private User createdBy;
    private Timestamp updatedAt;
    private User updatedBy;
    private Timestamp deletedAt;
    private User deletedBy;
    private List<Storage> listStorage;

    public Order(long id, User user, String status, int totalAmount, Product product, int quantity, boolean isDelete, Timestamp createdAt, User createdBy, Timestamp updatedAt, User updatedBy, Timestamp deletedAt, User deletedBy) {
        this.id = id;
        this.user = user;
        this.status = status;
        this.totalAmount = totalAmount;
        this.product = product;
        this.quantity = quantity;
        this.isDelete = isDelete;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
        this.updatedAt = updatedAt;
        this.updatedBy = updatedBy;
        this.deletedAt = deletedAt;
        this.deletedBy = deletedBy;
    }

    public String toJson() {
        return new Gson().toJson(this);
    }
}
