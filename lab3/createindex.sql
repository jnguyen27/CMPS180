-- createindex.sql file

CREATE INDEX LookUpTrades ON Trades(buyerID, sellerID);
