-- combine.sql file

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE Customers
  SET custName = n.custName,
      address = n.address,
      isValidCustomer = TRUE
  FROM NewCustomers n
  WHERE Customers.customerID = n.customerID;

INSERT INTO Customers (customerID, custName, address, category, isValidCustomer)
  SELECT n.customerID, n.custName, n.address, NULL, TRUE
  FROM NewCustomers n
  WHERE NOT EXISTS (SELECT * FROM Customers c
      WHERE c.customerID = n.customerID);

COMMIT;
