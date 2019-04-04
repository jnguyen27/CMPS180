/* Query 4
The cost for a trade is price * volume for that trade. For each trade in which
a) the cost is greater than or equal to five thousand,
b) the buyer is a valid customer, and
c) the buyer’s category isn’t NULL,
output the exchangeID, symbol, buyerID, cost, and the category of the buyer.
The attribute for the cost of the trade should appear as theCost in your result.
No duplicates should appear in your result.
*/

/* Use distinct because of possible multiple buys of same stock */

SELECT DISTINCT t.exchangeID, t.symbol, t.buyerID, t.price * t.volume AS theCost, c.category
FROM Trades t, Customers c
WHERE t.price * t.volume >= 5000
AND t.buyerID = c.customerID
AND c.isValidCustomer = TRUE
AND c.category <> 'N';
