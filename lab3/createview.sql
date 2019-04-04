-- createview.sql file
-- organized it in ascending exchangeID, symbol and date for neatness

CREATE VIEW QuotesSummary AS
  SELECT DISTINCT
    exchangeID,
    symbol,
    DATE(quoteTS) AS theDate,
    FIRST_VALUE(price) OVER (PARTITION BY DATE(quoteTS), symbol) AS openingPrice,
    LAST_VALUE(price) OVER (PARTITION BY DATE(quoteTS), symbol) AS closingPrice,
    MIN(price) OVER (PARTITION BY DATE(quoteTS), symbol) AS lowPrice,
    MAX(price) OVER (PARTITION BY DATE(quoteTS), symbol) AS highPrice
  FROM Quotes q
  GROUP BY exchangeID, symbol, DATE(quoteTS), price
  HAVING COUNT(*) >= 1
  ORDER BY exchangeID ASC, symbol ASC, DATE(quoteTS) ASC;
