/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;
import lombok.*;
/**
 *
 * @author hp
 */
@Data
@Setter
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Orders {
    private int id;
    private int user ;
    private double total;
    private String status ;
    private Timestamp createdAt ;
    private int createdBy ;
    private Timestamp updatedAt ;
    private int updatedBy ;
}
