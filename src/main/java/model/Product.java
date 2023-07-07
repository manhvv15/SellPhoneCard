/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import lombok.*;

import java.sql.Timestamp;
@Data
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Product {
    private int id;
    private String name;
    private int quantity;
    private int price;
    private Supplier supplier;
    private Timestamp createdAt;
    private User createdBy;
    private boolean isDelete;
    private Timestamp deletedAt;
    private User deletedBy;
    private Timestamp updatedAt;
    private User updatedBy;

    public Product(int price) {

        this.price = price;
    }
}
