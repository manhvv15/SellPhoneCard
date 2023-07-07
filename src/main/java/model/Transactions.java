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
public class Transactions {
    private int id ;
    private User user ;
    private long orderId ;
    private int money ;
    private String note ;
    private boolean type ;
    private boolean status ;
    private Timestamp updatedAt ;
    private User updatedBy ;
    private Timestamp createAt ;
    private User createBy ;
}
