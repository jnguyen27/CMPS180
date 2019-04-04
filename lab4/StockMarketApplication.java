import java.sql.*;
import java.util.*;

/**
 * The class implements methods of the StockMarket database interface.
 *
 * All methods of the class receive a Connection object through which all
 * communication to the database should be performed. Note: the
 * Connection object should not be closed by any method.
 *
 * Also, no method should throw any exceptions. In particular, in case
 * an error occurs in the database, then the method should print an
 * error message and call System.exit(-1);
 */

public class StockMarketApplication {

    private Connection connection;

    /*
     * Constructor
     */
    public StockMarketApplication(Connection connection) {
        this.connection = connection;
    }

    public Connection getConnection()
    {
        return connection;
    }

    /**
     * Takes as argument an integer called numDifferentStocksSold.
     * Returns the customerID for each customer in Customers that has been the seller of at least
     * numDifferentStocksSold different stocks in Trades.
     * If numDifferentStocksSold is not positive, that's an error.
     */

    public List<Integer> getCustomersWhoSoldManyStocks(int numDifferentStocksSold)
    {
        List<Integer> result = new ArrayList<Integer>();
        // your code here

        // Query to find customer IDs of people who sold positive number of different stock
        String customerQuery = "SELECT c.customerID \n" +
                               "FROM Customers c, Trades t \n" +
                               "WHERE c.customerID = t.sellerID \n" +
                               "GROUP BY c.customerID \n" +
                               "HAVING COUNT(DISTINCT t.symbol) >= " + numDifferentStocksSold;

        // Check to see if numDifferentStocksSold is positive
        if(numDifferentStocksSold <= 0){
          System.out.println("Error: number of different stocks solder is not greater than 0");
          System.exit(-1);
        }

        try {
          Statement customerQueryStatement = connection.createStatement();
          ResultSet customerIDs = customerQueryStatement.executeQuery(customerQuery);
          while(customerIDs.next()){
            result.add(customerIDs.getInt(1));
          }
          customerQueryStatement.close();
          customerIDs.close();
        } catch (SQLException e) {
          e.printStackTrace();
          System.exit(-1);
        }

        // end of your code
        return result;
    }


    /**
     * The updateQuotesForBrexit method has one string argument, theExchangeID, which is the exchangeID
     * for an exchange. updateQuotesForBrexit should update price in Quotes for every quote that has
     * that exchangedID, multiplying price by 0.87.
     * updateQuotesForBrexit should return the number of quotes whose prices were updated.
     */

    public int updateQuotesForBrexit(String theExchangeID)
    {
        // your code here

        // variable to keep track of how many updates were executed
        int quotesUpdated = 0;

        // Statement to update the prices
        String updateQuery = "UPDATE Quotes \n" +
                              "SET price = price * 0.87 \n" +
                              "WHERE exchangeID = " + theExchangeID;

        try {
          Statement updateStatement = connection.createStatement();
          quotesUpdated = updateStatement.executeUpdate(updateQuery);
          updateStatement.close();
        } catch (SQLException e) {
          e.printStackTrace();
          System.exit(-1);
        }

        if(quotesUpdated < 0){
          System.out.println("Error: negative number of updates received");
          System.exit(-1);
        }

        return quotesUpdated;

        // end of your code
    }


    /**
     * rewardBestBuyers has two integer parameters, theSellerID and theCount.  It invokes a stored
     * function rewardBuyersFunction that you will need to implement and store in the database
     * according to the description in Section 5.  rewardBuyersFunction should have the same two
     * parameters, theSellerID and theCount.
     *
     * Trades has a volume attribute.  rewardBuyersFunction will increase the volume for some trades
     * whose sellerID is theSellerID; Section 5 explains which trade volumes should be increased,
     * and how much they should be increased.  The rewardBestBuyers method should return the same
     * integer result as the rewardBuyersFunction stored function.
     *
     * The rewardBestBuyers method must only invoke the stored function rewardBuyersFunction, which
     * does all of the assignment work; do not implement the rewardBestBuyers method using a bunch of
     * SQL statements through JDBC.  However, rewardBestBuyers should check to see whether theCount
     * is greater than 0, and report an error if it’s not.
     */

    public int rewardBestBuyers (int theSellerID, int theCount)
    {
        // There's nothing special about the name storedFunctionResult
        int storedFunctionResult = 0;

        // your code here

        String rewardBuyersQuery = "SELECT rewardBuyersFunction(?,?)";

        if(theCount <= 0){
          System.out.println("Error: non-positive count");
          System.exit(-1);
        }

        try {
          PreparedStatement rewardBuyersStatement = connection.prepareStatement(rewardBuyersQuery);
          rewardBuyersStatement.setInt(1, theSellerID);
          rewardBuyersStatement.setInt(2, theCount);
          ResultSet result = rewardBuyersStatement.executeQuery();
          if(result.next()){
            storedFunctionResult = result.getInt(1);
          }
          rewardBuyersStatement.close();
          result.close();
        } catch (SQLException e) {
          e.printStackTrace();
          System.exit(-1);
        }

        if(storedFunctionResult < 0){
          System.out.println("Error: negative storedFunctionResult");
          System.exit(-1);
        }

        // end of your code
        return storedFunctionResult;

    }

};
