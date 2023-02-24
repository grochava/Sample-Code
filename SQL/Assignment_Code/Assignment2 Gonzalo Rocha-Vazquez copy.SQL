-- Gonzalo Rocha-Vazquez, COMP B21 Assignment #2

USE premiereproducts;

-- 1. 
/* List the total of all the customer balances. Label the column heading “Total Balance”. */
SELECT SUM(balance) AS 'Total Balance'
FROM customer;

-- 2. 
/* Same as #1, but list only those living in Grove. */
SELECT SUM(balance) AS 'Total Balance'
FROM customer
WHERE city = 'Grove';

-- 3. 
/* List the customer number and the customer name, along with the REMAINING credit. Sort the
	list by the remaining credit limit. */
SELECT customerNum, customerName, 
		(creditLimit - balance) AS remainingCreditLimit
FROM customer
ORDER BY (creditLimit - balance);

-- 4. 
/* List the number of parts on hand by warehouse. */
SELECT warehouse, SUM(onHand) As numParts
FROM part
GROUP BY warehouse;

-- 5. 
/* List by warehouse, the TOTAL number of parts on hand by classification. */
SELECT warehouse, class, SUM(onHand) AS numParts
FROM part
GROUP BY class, warehouse;

-- 6. 
/* Create the SQL statement that will list the customer number, customer name, representative
number, representative first name and representative last name. Format the representative’s
name as (lastname, firstname) and label the column “Representative’s Name”. Sort the list by
the representative’s first name within the representative’s last name. */
SELECT customerNum, customerName, c.repNum, 
	CONCAT(lastname, ', ', firstname) AS "Representative’s Name"
FROM customer c JOIN rep r
	ON c.repNum = r.repNum
ORDER BY lastName, firstName;

-- 7. 
/* Create the SQL statement that will list the customer name, order number, order date, part
description, quoted part price. Sort by order number within customer name. */
SELECT customerName, o.orderNum, orderDate, p.description, quotedPrice
FROM customer c 
	JOIN orders o
		ON c.customerNum = o.customerNum
	JOIN orderLine ol
		ON o.orderNum = ol.orderNum 
	JOIN part p
		ON ol.partNUm = p.partNum
ORDER BY customerName, orderNum;

-- 8. 
/* We want to find out how much a customer has spent on each of their orders. Create the SQL
statement that will list the customer name, order number and the total cost of all items on
each order for each customer. Hint: you will need to calculate using (number ordered * quoted
price). */
SELECT customerName, o.orderNum, (numOrdered * quotedPrice) AS totalCost
FROM customer c 
	JOIN orders o 
		ON c.customerNum = o.customerNum
    JOIN orderLine ol
		ON o.orderNum = ol.orderNum;

USE henrybooks;

-- 9. 
/* List those publishers who publish paperbacks and the number of paperbacks published by each. */
SELECT publisherName, COUNT(paperback) AS numPaperback
FROM book b JOIN publisher p
	ON b.publisherCode = p.publisherCode
GROUP BY publisherName;

-- 10. 
/* For every book published by “Taunton Press”, list the book title, the copy number, and book
price. Must use the publisher’s name, not their code. */
SELECT title, copyNum, price
FROM book b 
	JOIN copy c 
		ON b.bookCode = c.bookCode
    JOIN publisher p
		ON b.publisherCode = p.publisherCode
WHERE publisherName = "Taunton Press";

-- 11. 
/* Show the SQL statement that can calculate the average book price (rounded to 2 decimal
places). */
SELECT ROUND(AVG(price), 2) AS avgBookPrice
FROM copy;

-- 12. 
/* For every book, list the book code, book title, publisher code, and publisher name. */
SELECT bookCode, title, b.publisherCode, publisherName
FROM book b JOIN publisher p
	ON b.publisherCode = p.publisherCode;

-- 13. 
/* Show the SQL statement that can answer this question: How many books have the type SFI? */
SELECT COUNT(bookType) AS numSFI
FROM book
WHERE bookType = "SFI";

-- 14. 
/* List the book title and book code for every book published by “Putnam Publishing Group” that
has a book price greater than $15. Must use the publisher’s name, not their code. Remove
duplicates. */
SELECT DISTINCT title, b.bookCode
FROM book b 
	JOIN copy c 
		ON b.bookCode = c.bookCode
    JOIN publisher p
		ON b.publisherCode = p.publisherCode
WHERE publisherName = "Putnam Publishing Group" AND price > 15;
