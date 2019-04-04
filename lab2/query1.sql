/* Query 1
A customer is valid if isValidCustomer is true for that customer. Find the
customerID, custName and address for each valid customer whose name has the
string ‘FAKE’ (all capitals) appearing anywhere in their name. No duplicates
should appear in your result.
*/

/* No duplicates should appear because customerID is a primary key */

SELECT c.customerID, c.custName, c.address
FROM Customers c
WHERE c.custName LIKE '%FAKE%';
