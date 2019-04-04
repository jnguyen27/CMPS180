CREATE OR REPLACE FUNCTION rewardBuyersFunction(theSellerID integer, theCount integer)
  RETURNS integer AS $$

  DECLARE
    highestBuyerID INTEGER;
    totalTrades INTEGER;
    loopCount INTEGER;

  DECLARE highestTotalCost CURSOR FOR
    --SELECT t.buyerID, t.sellerID, SUM(t.price*t.volume) AS totalCost
    --FROM Trades t
    --WHERE t.sellerID = theSellerID
    --GROUP BY t.buyerID, t.sellerID
    --ORDER BY SUM(t.price*t.volume) DESC;
    SELECT bstc.buyerID
    FROM BuyerSellerTotalCost bstc
    WHERE bstc.sellerID = theSellerID
    ORDER BY bstc.totalCost DESC;

  BEGIN
    totalTrades := 0;
    loopCount   := 0;
    OPEN highestTotalCost;

  LOOP

    FETCH highestTotalCost INTO highestBuyerID;
    EXIT WHEN NOT FOUND;
    totalTrades := totalTrades + 1;

    --Update high status customer
    UPDATE Trades
    SET volume = volume + 50
    FROM Customers
    WHERE category = 'H'
    AND customerID = buyerID
    AND buyerID = highestBuyerID;


    --Updating medium status customer
    UPDATE Trades
    SET volume = volume + 20
    FROM Customers
    WHERE category = 'M'
    AND customerID = buyerID
    AND buyerID = highestBuyerID;

    --Updating low status customer
    UPDATE Trades
    SET volume = volume + 5
    FROM Customers
    WHERE category = 'L'
    AND customerID = buyerID
    AND buyerID = highestBuyerID;

    --Updating other category customer
    UPDATE Trades
    SET volume = volume + 1
    FROM Customers
    WHERE category <> 'H'
    AND category <> 'M'
    AND category <> 'L'
    AND customerID = buyerID
    AND buyerID = highestBuyerID;

    loopCount := loopCount + 1;
    EXIT WHEN loopCount = theCount;

  END LOOP;

  CLOSE highestTotalCost;

  RETURN totalTrades;

END;
$$ LANGUAGE plpgsql;
