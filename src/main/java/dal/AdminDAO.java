package dal;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AdminDAO extends  DAO{
    public void AddMoneyUser(int userID,int balance){
        try{
            String sql = "update user set balance = balance + ? where id = ? and isActive = true;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDouble(1,balance);
            ps.setInt(2,userID);
            ps.executeUpdate();
            ps.close();




        }catch (SQLException e){
            System.out.println("AddMoneyUser"  + e.getMessage());
        }
    }
}
