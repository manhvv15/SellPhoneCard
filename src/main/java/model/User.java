package model;

import com.google.gson.Gson;
import lombok.*;

import java.sql.Timestamp;
import java.sql.Timestamp;

@Data
@Setter
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private int id;
    private String account;
    private String password;
    private String email;
    private int role;
    private String phoneNumber;
    private int balance;
    private boolean isDelete;
    private boolean isActive;
    private Timestamp createdAt;
    private int createdBy;
    private Timestamp updatedAt;
    private int updatedBy;
    private Timestamp deletedAt;
    private int deletedBy;

    public User(String account, String password, String email, int role, boolean isDelete, boolean isActive, Timestamp createdAt) {
        this.account = account;
        this.password = password;
        this.email = email;
        this.role = role;
        this.isDelete = isDelete;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    public User(String account) {
        this.account = account;
    }

    public String toJson() {
        return new Gson().toJson(this);
    }
    
}
