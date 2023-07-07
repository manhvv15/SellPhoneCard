/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import lombok.*;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author hp
 */

@Data
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Supplier {
    private int id;
    private String name;
    private Timestamp createdAt,deletedAt,updatedAt;
    private boolean isDelete;
    private String image;
    private User createdBy,deletedBy,updatedBy;

    public Supplier(int id, String image) {
        this.id = id;
        this.image = image;
    }
}
