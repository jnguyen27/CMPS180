-- foreign.sql file

-- The buyerID field in Trades should references the customerID primary key Customers.
ALTER TABLE Trades ADD FOREIGN KEY (buyerID) REFERENCES Customers(customerID);

-- The sellerId field in Trades should references the customerID primary key in Customers.
ALTER TABLE Trades ADD FOREIGN KEY (sellerID) REFERENCES Customers(customerID);

-- The (exchangeID, symbol) fields in Trades should reference the corresponding primary key in Stocks.
ALTER TABLE Trades ADD FOREIGN KEY (exchangeID, symbol) REFERENCES Stocks(exchangeID, symbol);

-- The (exchangeID, symbol) fields in Quotes should reference the corresponding primary key in Stocks.
ALTER TABLE Quotes ADD FOREIGN KEY (exchangeID, symbol) REFERENCES Stocks(exchangeID, symbol);
