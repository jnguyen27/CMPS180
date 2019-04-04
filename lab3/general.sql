-- general.sql file

-- In Quotes, price must be positive_quantity
ALTER TABLE Quotes ADD CHECK (price > 0);

-- In Trades, cost is price * volume
ALTER TABLE Trades ADD CONSTRAINT positive_cost CHECK ((price * volume) > 0);

-- In Trades, buyerID and sellerID must be different
ALTER TABLE Trades ADD CHECK (buyerID <> sellerID);

-- In Customers, if category is 'H' then isValidCustomer must be TRUE
ALTER TABLE Customers ADD CHECK ((category <> 'H') OR (isValidCustomer = TRUE));
