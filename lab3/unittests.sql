-- unittests.sql file

-------------------------------------------------------------------------------
-- 4 FOREIGN KEY CONSTRAINTS
-------------------------------------------------------------------------------

-- For ALTER TABLE Trades ADD FOREIGN KEY (buyerID) REFERENCES Customers(customerID);
-- ERROR:  insert or update on table "trades" violates foreign key constraint "trades_buyerid_fkey"
-- DETAIL:  Key (buyerid)=(7) is not present in table "customers".
INSERT INTO Trades VALUES ('ASDF', 'GHJK', '2011-11-11 11:11:11', 7, 12345, 12.50, 1000);

-- For ALTER TABLE Trades ADD FOREIGN KEY (sellerID) REFERENCES Customers(customerID);
-- ERROR:  insert or update on table "trades" violates foreign key constraint "trades_buyerid_fkey"
-- DETAIL:  Key (buyerid)=(12345) is not present in table "customers".
INSERT INTO Trades VALUES ('ZXCV', 'BNML', '2012-12-12 12:12:12', 12345, 7, 153.75, 520);

-- For ALTER TABLE Trades ADD FOREIGN KEY (exchangeID, symbol) REFERENCES Stocks(exchangeID, symbol);
-- ERROR:  insert or update on table "trades" violates foreign key constraint "trades_buyerid_fkey"
-- DETAIL:  Key (buyerid)=(7) is not present in table "customers".
INSERT INTO Trades VALUES ('ASDF', 'GHJK', '2010-10-10 10:10:10', 7, 12345, 51.25, 975);

-- For ALTER TABLE Quotes ADD FOREIGN KEY (exchangeID, symbol) REFERENCES Stocks(exchangeID, symbol);
-- ERROR:  insert or update on table "quotes" violates foreign key constraint "quotes_exchangeid_fkey"
-- DETAIL:  Key (exchangeid, symbol)=(ZXCV  , BNML) is not present in table "stocks".
INSERT INTO Quotes VALUES ('ZXCV', 'BNML', '2018-11-11 11:11:11', 715.48);

-------------------------------------------------------------------------------
-- 4 GENERAL CONSTRAINTS
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- For ALTER TABLE Quotes ADD CHECK (price > 0);
-------------------------------------------------------------------------------

-- Passing test
UPDATE Quotes
SET price = 11500.00,
    quoteTS = '2018-11-21 13:03:24'
WHERE exchangeID = 'NYSE'
AND symbol = 'CVX';

-- Failing test
-- ERROR:  new row for relation "quotes" violates check constraint "quotes_price_check"
-- DETAIL:  Failing row contains (NYSE  , CVX , 2018-11-22 13:03:24, 0.00).
UPDATE Quotes
SET price = 0,
    quoteTS = '2018-11-22 13:03:24'
WHERE exchangeID = 'NYSE'
AND symbol = 'CVX';

-------------------------------------------------------------------------------
-- For ALTER TABLE Trades ADD CONSTRAINT positive_cost CHECK ((price * volume) > 0);
-------------------------------------------------------------------------------

-- Passing test
UPDATE Trades
SET price = 12500.00,
    volume = 750
WHERE exchangeID = 'NYSE'
AND symbol = 'INL'
AND tradeTS = '2018-12-13 04:53:03';

-- Failing test
-- ERROR:  new row for relation "trades" violates check constraint "positive_cost"
-- DETAIL:  Failing row contains (NYSE  , INL , 2018-12-13 04:53:03, 1456, 7257, 0.00, 750).
UPDATE Trades
SET price = 0,
    volume = 750
WHERE exchangeID = 'NYSE'
AND symbol = 'INL'
AND tradeTS = '2018-12-13 04:53:03';

-------------------------------------------------------------------------------
-- For ALTER TABLE Trades ADD CHECK (buyerID <> sellerID);
-------------------------------------------------------------------------------

-- Passing test
UPDATE Trades
SET buyerID = 1456
WHERE exchangeID = 'NYSE'
AND symbol = 'MSFT'
AND tradeTS = '2018-12-26 12:19:40';

-- Failing test
-- ERROR:  new row for relation "trades" violates check constraint "trades_check"
-- DETAIL:  Failing row contains (NYSE  , MSFT, 2018-12-26 12:19:40, 7777, 7777, 1780.05, 100).
UPDATE Trades
SET buyerID = 7777
WHERE exchangeID = 'NYSE'
AND symbol = 'MSFT'
AND tradeTS = '2018-12-26 12:19:40';

-------------------------------------------------------------------------------
-- For ALTER TABLE Customers ADD CHECK ((category IS NOT NULL) OR (isValidCustomer = TRUE));
-------------------------------------------------------------------------------

-- Passing test
UPDATE Customers
SET category = 'H'
WHERE customerID = 1456;

-- Failing test
-- ERROR:  new row for relation "customers" violates check constraint "customers_check"
-- DETAIL:  Failing row contains (2048, Nancy White, 1102 Ravenwood, New York, NY, H, f).
UPDATE Customers
SET category = 'H'
WHERE customerID = 2048;
