-- Gonzalo Rocha-Vazquez, COMP B21 Assignment #3

USE ap;

-- 4_1
SELECT * FROM vendors v 
INNER JOIN invoices i
	ON v.vendor_id = i.vendor_id;

-- 4_2
SELECT vendor_name, invoice_number, invoice_date, 
	(invoice_total - payment_total - credit_total) AS balance_due
FROM invoices i JOIN vendors v
	ON i.vendor_id = v.vendor_id
WHERE (invoice_total - payment_total - credit_total) > 0
ORDER BY vendor_name;

-- 4_3
SELECT vendor_name, 
	default_account_number AS default_account, 
	account_description AS "description"
FROM vendors v JOIN general_ledger_accounts g
	ON v.default_account_number = g.account_number
ORDER BY account_description, vendor_name;

-- 4_4
SELECT vendor_name, invoice_date, invoice_number, 
	il.invoice_sequence AS li_sequence, 
    il.line_item_amount AS li_amount
FROM vendors v JOIN invoices i
	ON v.vendor_id = i.vendor_id
JOIN invoice_line_items il
	ON i.invoice_id = il.invoice_id
ORDER BY vendor_name, invoice_date, invoice_number, invoice_sequence;

-- 4_5
SELECT DISTINCT v1.vendor_id, v1.vendor_name, 
	CONCAT(v1.vendor_contact_first_name, " ", v1.vendor_contact_last_name) AS contact_name
FROM vendors v1 JOIN vendors v2
	ON v1.vendor_id <> v2.vendor_id AND
	   v1.vendor_contact_last_name = v2.vendor_contact_last_name;

-- 4_6 
SELECT g.account_number, account_description
FROM general_ledger_accounts g 
	LEFT JOIN invoice_line_items i 
	ON g.account_number = i.account_number
WHERE invoice_id IS NULL    
ORDER BY account_number;

-- 4_7
SELECT vendor_name, vendor_state
FROM vendors
WHERE vendor_state = "CA"
	UNION
SELECT vendor_name, "Outside CA" AS vendor_state
FROM vendors
WHERE vendor_state != "CA"
ORDER BY vendor_name;

USE ap;

-- 5_1
INSERT INTO terms
	(terms_id, terms_description, terms_due_days)
VALUES 
	(6, "Net due 120 days", 120);

-- 5_2
UPDATE terms
SET terms_description = "Net due 125 days",
	terms_due_days = 125
WHERE terms_id = 6;

-- 5_3
DELETE FROM terms
WHERE terms_id = 6;

-- 5_4
INSERT INTO invoices VALUES 
(DEFAULT, 32, "AX-014-027", "2018-08-01", "434.58", "0.00", 
		"0.00", 2, "2018-08-31", NULL);

-- 5_5
INSERT INTO invoice_line_items 
	(invoice_id, invoice_sequence, account_number, line_item_amount, line_item_description)
VALUES
(115, 1, 160, 180.23, "Hard Drive"),
(115, 2, 527, 254.35, "Exchange Server update");

USE ap; 

-- 6_1
SELECT vendor_id, SUM(invoice_total)
FROM invoices
GROUP BY vendor_id;

-- 6_2
SELECT vendor_name, SUM(payment_total)
FROM vendors v JOIN invoices i
	ON v.vendor_id = i.vendor_id
GROUP BY v.vendor_id
ORDER BY SUM(payment_total) DESC;

USE ap; 

-- 7_1
SELECT DISTINCT vendor_name
FROM vendors
WHERE vendor_id IN
	(SELECT vendor_id
     FROM invoices)
ORDER BY vendor_name;

-- 7_2
SELECT invoice_number, invoice_total
FROM invoices
WHERE payment_total > 
	(SELECT AVG(payment_total)
     FROM invoices
     WHERE payment_total > 0)
ORDER BY invoice_total DESC;