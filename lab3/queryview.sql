-- queryview.sql

-- Query
SELECT e.exchangeName, s.stockName, COUNT(*) AS numHighClosings
FROM QuotesSummary qs, Exchanges e, Stocks s
WHERE qs.closingPrice = qs.highPrice
AND qs.symbol = s.symbol
AND s.exchangeID = e.exchangeID
AND e.exchangeID = qs.exchangeID
GROUP BY e.exchangeName, s.stockName
HAVING COUNT(*) >= 2;

-- Before deleting
-- exchangename             |   stockname   | numhighclosings
-- -------------------------+---------------+-----------------
-- New York Stock Exchange  | Cloudera,Inc. |               3
-- New York Stock Exchange  | HP Enterprise |               2
-- (2 rows)

-- Delete statements 
DELETE FROM Quotes WHERE exchangeID = 'NYSE' AND symbol = 'CLDR';
DELETE FROM Quotes WHERE exchangeID = 'NASDAQ' AND symbol = 'ANF';

-- Query
SELECT e.exchangeName, s.stockName, COUNT(*) AS numHighClosings
FROM QuotesSummary qs, Exchanges e, Stocks s
WHERE qs.closingPrice = qs.highPrice
AND qs.symbol = s.symbol
AND s.exchangeID = e.exchangeID
AND e.exchangeID = qs.exchangeID
GROUP BY e.exchangeName, s.stockName
HAVING COUNT(*) >= 2;

-- Was confused about which after delete to put because running them together
-- deletes one that shouldn't be deleted, so I listed them all out

---------------------------------------------------------------------------
-- AFTER DELETE FROM FIRST DELETE STATEMENT
-- DELETE FROM Quotes WHERE exchangeID = 'NYSE' AND symbol = 'CLDR';
---------------------------------------------------------------------------
-- exchangename            | stockname     | numhighclosings
-- ------------------------+---------------+-----------------
-- New York Stock Exchange | HP Enterprise |               2
-- (1 row)

---------------------------------------------------------------------------
-- AFTER DELETE FROM SECOND DELETE STATEMENT
-- DELETE FROM Quotes WHERE exchangeID = 'NASDAQ' AND symbol = 'ANF';
---------------------------------------------------------------------------
-- exchangename             |   stockname   | numhighclosings
-- -------------------------+---------------+-----------------
-- New York Stock Exchange  | Cloudera,Inc. |               3
-- New York Stock Exchange  | HP Enterprise |               2
-- (2 rows)

---------------------------------------------------------------------------
-- AFTER DELETE FROM BOTH DELETE STATEMENTS TOGETHER
-- DELETE FROM Quotes WHERE exchangeID = 'NYSE' AND symbol = 'CLDR';
-- DELETE FROM Quotes WHERE exchangeID = 'NASDAQ' AND symbol = 'ANF';
---------------------------------------------------------------------------
-- exchangename  | stockname | numhighclosings
-- --------------+-----------+-----------------
-- (0 rows)
