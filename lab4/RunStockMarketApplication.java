import java.sql.*;
import java.io.*;
import java.util.*;

/**
 * A class that connects to PostgreSQL and disconnects.
 * You will need to change your credentials below, to match the usename and password of your account
 * in the PostgreSQL server.
 * The name of your database in the server is the same as your username.
 * You are asked to include code that tests the methods of the StockMarketApplication class
 * in a similar manner to the sample RunStoresApplication.java program.
*/


public class RunStockMarketApplication
{
    public static void main(String[] args) {

    	Connection connection = null;
    	try {
    	    //Register the driver
    		Class.forName("org.postgresql.Driver");
    	    // Make the connection.
            // You will need to fill in your real username abd password for your
            // Postgres account in the arguments of the getConnection method below.
            connection = DriverManager.getConnection(
                                                     "jdbc:postgresql://cmps180-db.lt.ucsc.edu/username",
                                                     "username",
                                                     "password");

            if (connection != null)
                System.out.println("Connected to the database!");

            /* Include your code below to test the methods of the StockMarketApplication class
             * The sample code in RunStoresApplication.java should be useful.
             * That code tests other methods for a different database schema.
             * Your code below: */

             StockMarketApplication App = new StockMarketApplication(connection);

             // ---------------------------------------------------------------
             // Test for getCustomersWhoSoldManyStocks
             /*
                Output of getCustomersWhoSoldManyStocks
                when the parameter numDifferentStocksSold is 3.
                1456
                1489
                9731
             */
             // ---------------------------------------------------------------
             int numDifferentStocksSold = 3;
             System.out.println("Output of getCustomersWhoSoldManyStocks on input numDifferentStocksSold = " + numDifferentStocksSold);

             List<Integer> customerIDs = App.getCustomersWhoSoldManyStocks(numDifferentStocksSold);
             for(int i : customerIDs){
               System.out.println(i);
             }

             // ---------------------------------------------------------------
             // Test for updateQuotesForBrexit
             /*
                Output of updateQuotesForBrexit when theExchangeID is 'LSE   '
                5
             */
             // ---------------------------------------------------------------
             String theExchangeID = "'LSE   '";
             System.out.println("Output of updateQuotesForBrexit on input theExchangeID = "
                + theExchangeID);

             int numUpdatedQuotes = App.updateQuotesForBrexit(theExchangeID);
             System.out.println(numUpdatedQuotes);

             // ---------------------------------------------------------------
             // Test 1 for rewardBestBuyers
             /*
                Output of rewardBestBuyers when theCount1 = 2 and theSellerID1 = 1456
                2
             */
             // ---------------------------------------------------------------
             int theCount1 = 2;
             int theSellerID1 = 1456;
             System.out.println("Output of rewardbestBuyers on input theCount1 = "
                + theCount1 + " and theSellerID1 = " + theSellerID1);
             int numTrades1 = App.rewardBestBuyers(theSellerID1, theCount1);
             System.out.println(numTrades1);

             // ---------------------------------------------------------------
             // Test 2 for rewardBestBuyers
             /*
                Output of rewardBestBuyers when theCount1 = 4 and theSellerID1 = 1456
                3
             */
             // ---------------------------------------------------------------
             int theCount2 = 4;
             int theSellerID2 = 1456;
             System.out.println("Output of rewardbestBuyers on input theCount2 = "
                + theCount2 + " and theSellerID2 = " + theSellerID2);
             int numTrades2 = App.rewardBestBuyers(theSellerID2, theCount2);
             System.out.println(numTrades2);

            /*******************
            * Your code ends here */

    	}
    	catch (SQLException | ClassNotFoundException e) {
    		System.out.println("Error while connecting to database: " + e);
    		e.printStackTrace();
    	}
    	finally {
    		if (connection != null) {
    			// Closing Connection
    			try {
					connection.close();
				} catch (SQLException e) {
					System.out.println("Failed to close connection: " + e);
					e.printStackTrace();
				}
    		}
    	}
    }
}
