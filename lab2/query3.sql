/* Query 3
Output the exchangeID and stockName of each stock for which there is at least
one quote whose price is less than 314.15. No duplicates should appear in your
result.
*/

/* Need to use distinct because HPE has 2 quotes under threshold */

SELECT DISTINCT s.exchangeID, s.stockName
FROM Stocks s, Quotes q
WHERE s.symbol = q.symbol
AND s.exchangeID = q.exchangeID
AND q.price < 314.15;
