package Items;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class ConnectionManager {
   
	 private static java.sql.Connection MyConn = null;
	static java.sql.Connection getConnection() throws Exception {

	        String url = "jdbc:mysql://localhost:8889/test";
	        String dbName = "test";
	        String driver = "com.mysql.jdbc.Driver";
	        String userName = "root";
	        String password = "root";

	/*	// Connect to database
        String hostName = "your_server";
        String dbName = "your_database";
        String user = "your_username";
        String password = "your_password";
        String url = String.format("jdbc:sqlserver://test1-pos.database.windows.net:1433;database=test;user=kishan@test1-pos;password=Shivam2424;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30");
        */
	        Connection connection = null;
	        Class.forName(driver).newInstance();
	         MyConn = (Connection) DriverManager.getConnection(url, userName,password);

	        return MyConn;
	    }
	 public static void closeConnection(java.sql.Connection myConn) {

	        try {

	            MyConn.close();

	        } catch (SQLException e) {

	        }

	    }
}