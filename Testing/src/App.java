import java.sql.*;
import java.util.Scanner;

public class App {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/jdbc_demo";
        String user = "root";
        String pass = "Papun@9337";

        String sql = "INSERT INTO students (id,name, email,age,phone,address) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, pass);
            

            PreparedStatement ps = con.prepareStatement(sql);
            Scanner sc = new Scanner(System.in);
                System.out.println("Enter id:");
                ps.setInt(1, sc.nextInt());
                System.out.println("Enter name:");
                ps.setString(2, sc.next());
                System.out.println("Enter email:");
                ps.setString(3, sc.next());
                System.out.println("Enter age:");
                ps.setInt(4, sc.nextInt());
                System.out.println("Enter phone:");
                ps.setString(5, sc.next());
                System.out.println("Enter address:");
                ps.setString(6, sc.next());

            int rows = ps.executeUpdate();
            System.out.println(rows + " record inserted");

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}