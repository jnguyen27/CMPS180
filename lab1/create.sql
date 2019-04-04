DROP SCHEMA Lab1 CASCADE;
CREATE SCHEMA Lab1;

ALTER ROLE duminguy SET SEARCH_PATH TO Lab1;

/* For Exchanges(exchangeID, exchangeName,a address) */
CREATE TABLE Exchanges (
  exchangeID        CHAR(6) PRIMARY KEY,
  exchangeName      VARCHAR(30),
  address           VARCHAR(30)
);

/* For Stocks(exchangeID, symbol, stockName, address) */
CREATE TABLE Stocks (
  exchangeID        CHAR(6),
  symbol            CHAR(4),
  stockName         VARCHAR(30),
  address           VARCHAR(30),
  PRIMARY KEY (exchangeID, symbol)
);

/* For Customers(customerID, custName, address, category, isValidCustomer) */
CREATE TABLE Customers (
  customerID        INTEGER PRIMARY KEY,
  custName          VARCHAR(30),
  address           VARCHAR(30),
  category          CHAR(1),
  isValidCustomer   BOOLEAN
);

/* For Trades(exchangeID, symbol, tradeTS, buyerID, sellerID, price, volume */
CREATE TABLE Trades (
  exchangeID        CHAR(6),
  symbol            CHAR(4),
  tradeTS           TIMESTAMP,
  buyerID           INTEGER,
  sellerID          INTEGER,
  price             DECIMAL(7,2),
  volume            INTEGER,
  PRIMARY KEY (exchangeID, symbol, tradeTS)
);

/* For Quotes(exchangeID, symbol, quoteTS, price)*/
CREATE TABLE Quotes (
  exchangeID        CHAR(6),
  symbol            CHAR(4),
  quoteTS           TIMESTAMP,
  price             DECIMAL(7,2),
  PRIMARY KEY (exchangeID, symbol, quoteTS)
);
