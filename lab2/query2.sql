/* Query 2
Find the name and symbol for each stock that is not listed on the ‘NASDAQ Stock
Exchange’. The attributes in your result should appear as name and symbol. No
duplicates should appear in your result.
*/

/* No duplicates should appear beacuse symbol is a primary key */

SELECT s.stockName AS name, s.symbol
FROM Stocks s, Exchanges e
WHERE s.exchangeID = e.exchangeID
AND e.exchangeName <> 'NASDAQ Stock Exchange';
