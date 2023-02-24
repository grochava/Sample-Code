-- Gonzalo Rocha-Vazquez, COMP B21 Assignment #1

USE premiereproducts;

-- 1

SELECT * FROM customer;

-- 2

SELECT customerNum, customerName, balance
FROM customer;

-- 3

SELECT customerNum, customerName, balance
FROM customer
ORDER BY customerName;

-- 4

SELECT customerNum, customerName, 
	creditLimit - balance AS remainingCredLim
FROM customer
ORDER BY remainingCredLim;

-- 5

SELECT repNum,
	CONCAT(lastname, ' ', firstname) AS "Representative's Name"
FROM rep
ORDER BY repNum;

-- 6

SELECT repNum, 
	CONCAT(lastname, ' ', firstname) AS "Representative's Name"
FROM rep
ORDER BY CONCAT(lastname, ' ', firstname);


USE henrybooks;

-- 7

SELECT authorNum, authorLast
FROM author;

-- 8

SELECT * FROM branch;

-- 9

SELECT publisherName
FROM publisher
WHERE city = 'Boston';

-- 10

SELECT publisherName
FROM publisher
WHERE city != 'Boston';

-- 11

SELECT bookCode
FROM wrote
WHERE sequence >= 2;

-- 12 

SELECT bookCode, title
FROM book
WHERE bookType = 'SFI';

-- 13 

SELECT bookCode, title
FROM book
WHERE bookType = 'SFI' AND paperback = 'Yes';

-- 14

SELECT bookCode, title
FROM book
WHERE bookType = 'SFI' OR publisherCode = 'PE';

-- 15

SELECT bookCode, price
FROM copy
WHERE price >= 5 AND price <= 10;

-- 16 

SELECT bookCode, price, 
	ROUND(price * .85, 2) AS discountPrice
FROM copy;

-- 17

SELECT bookCode, title
FROM book
WHERE bookType IN ('SFI', 'HOR', 'ART');

-- 18

SELECT publisherCode, bookCode, title
FROM book
ORDER BY publisherCode, title;