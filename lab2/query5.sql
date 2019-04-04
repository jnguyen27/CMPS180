/* Query 5
Output the names of the buyers and sellers of stocks that were traded (that is,
for which there was a trade) that occurred before ‘2018-01-01 12:00:00’. Your
result should have attributes exchangeID, stockName, buyerName, and sellerName.
No duplicates should appear in your result.
*/

SELECT DISTINCT t.exchangeID, s.stockName, c1.custName AS buyerName, c2.custName AS sellerName
FROM Trades t, Stocks s, Customers c1, Customers c2
WHERE t.tradeTS < DATE '2018-01-01 12:00:00'
AND t.symbol = s.symbol
AND t.buyerID = c1.customerID
AND t.sellerID = c2.customerID;
