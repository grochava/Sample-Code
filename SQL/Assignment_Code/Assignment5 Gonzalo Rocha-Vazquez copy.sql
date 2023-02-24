-- Gonzalo Rocha-Vazquez, COMP B21 Assignment #5

USE ap;

-- 13_1
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE invoice_counts INT;

	SELECT COUNT(invoice_id) 
	INTO invoice_counts
	FROM invoices
	WHERE payment_total >= 5000;

	IF invoice_counts > 0 THEN
		SELECT CONCAT(invoice_counts,' invoice(s) exceed $5000') AS message;
	ELSE
		SELECT 'No invoices exceed $5000' AS message;
	END IF;
END//

DELIMITER ;

CALL test();

-- 13_2
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE num_due_invoices INT;
	DECLARE sum_due_invoices DECIMAL(9,2);

	SELECT COUNT(invoice_id), SUM(invoice_total - payment_total - credit_total)
	INTO num_due_invoices, sum_due_invoices
	FROM invoices
	WHERE invoice_total - payment_total - credit_total > 0;

	IF sum_due_invoices >= 30000 THEN
		SELECT num_due_invoices AS "number of overdue invoices",
			CONCAT("$",sum_due_invoices) AS "total overdue";
	ELSE
		SELECT "Total balance due is less than $30,000" AS message;
	END IF;		
END//

DELIMITER ;

CALL test();

-- 13_3
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE i INT DEFAULT 10;
	DECLARE ten_factorial INT DEFAULT 1;
	
	WHILE i > 0 DO
		SET ten_factorial = ten_factorial * i;
		SET i = i-1;
	END WHILE;

	SELECT CONCAT("The factorial of 10 is: ",FORMAT(ten_factorial,0),".") AS message;

END//

DELIMITER ;

CALL test();

-- 13_4
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE s 					VARCHAR(4000)	DEFAULT '';
	DECLARE vendor_name_var 	VARCHAR(50);
	DECLARE invoice_number_var 	VARCHAR(50);
	DECLARE balance_due_var		DECIMAL(9,2);
	
	-- cursor and row end declaration
	DECLARE row_not_found 		TINYINT 		DEFAULT FALSE;
	DECLARE vendor_cursor CURSOR FOR
		SELECT vendor_name, invoice_number, 
			invoice_total - payment_total - credit_total AS balance_due
		FROM vendors v JOIN invoices i 
			ON v.vendor_id = i.vendor_id
		WHERE invoice_total - payment_total - credit_total >= 5000
		ORDER BY balance_due DESC;

	-- cursor error handle
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;

	OPEN vendor_cursor;

	-- cursor loop
	WHILE row_not_found = FALSE DO
		FETCH vendor_cursor INTO vendor_name_var, invoice_number_var, balance_due_var;
	-- procedure for each row
		SET s = CONCAT(s,vendor_name_var,'|',invoice_number_var,'|',balance_due_var,'//');
	END WHILE;
	
	CLOSE vendor_cursor;

	-- print output
	SELECT s AS message;

END//

DELIMITER ;

CALL test();

-- 13_5
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN	
	-- declare error var
	DECLARE null_value 	TINYINT		DEFAULT FALSE;
	-- create conditions for error
	DECLARE CONTINUE HANDLER FOR 1048
		SET null_value = TRUE;
	
	UPDATE invoices
	SET invoice_due_date = NULL
	WHERE invoice_id = 1;

	IF null_value = TRUE THEN
		SELECT 'Row was not updated - column cannot be null.' AS message;
	ELSE
		SELECT '1 row was updated' AS message;
	END IF;	
END//

DELIMITER ;

CALL test();

-- 13_6
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE i INT			DEFAULT 3;
	DECLARE j INT;			
	DECLARE s VARCHAR(400) 	DEFAULT '2 |';
	DECLARE divisor_found	TINYINT	DEFAULT FALSE;

	WHILE i < 100 DO
		SET j = i-1;

		WHILE j>1 DO
			IF i%j = 0 THEN 
				SET j = 1;
				SET divisor_found=TRUE;
			ELSE SET j=j-1;
			END IF;
		END WHILE;	

		IF divisor_found = FALSE THEN
			SET s = CONCAT(s, i, ' | ');
		END IF;
		
		SET i = i+2;
		SET divisor_found = FALSE;
	END WHILE;
	SELECT s AS "prime number string";

END//

DELIMITER ;

CALL test();

-- 13_7
DROP PROCEDURE IF EXISTS test;

DELIMITER //

CREATE PROCEDURE test()
BEGIN
	DECLARE s 					VARCHAR(4000)	DEFAULT '';
	DECLARE vendor_name_var 	VARCHAR(50);
	DECLARE invoice_number_var 	VARCHAR(50);
	DECLARE balance_due_var		DECIMAL(9,2);
	DECLARE row_not_found 		TINYINT 		DEFAULT FALSE;

	DECLARE vendor_cursor CURSOR FOR
		SELECT vendor_name, invoice_number, 
			invoice_total - payment_total - credit_total AS balance_due
		FROM vendors v JOIN invoices i 
			ON v.vendor_id = i.vendor_id
		WHERE invoice_total - payment_total - credit_total >= 5000
		ORDER BY balance_due DESC;

	-- loop 1
	BEGIN
	-- cursor error handle
	DECLARE EXIT HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;
	OPEN vendor_cursor;
	-- cursor loop
	SET s = CONCAT(s,'$20,000 or More: ');
	WHILE row_not_found = FALSE DO
		FETCH vendor_cursor 
		INTO vendor_name_var, invoice_number_var, balance_due_var;
		IF balance_due_var >= 20000 THEN	
			SET s = CONCAT(s,vendor_name_var,'|',invoice_number_var,'|',balance_due_var,'//');
		END IF;
	END WHILE;
	END;
	CLOSE vendor_cursor;

	-- loop 2
	SET row_not_found = FALSE;
	BEGIN
	DECLARE EXIT HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;
	OPEN vendor_cursor;
	SET s = CONCAT(s,'$10,000 to $20,000: ');
	WHILE row_not_found = FALSE DO
		FETCH vendor_cursor 
		INTO vendor_name_var, invoice_number_var, balance_due_var;
		IF balance_due_var >= 10000 AND balance_due_var <20000 THEN	
			SET s = CONCAT(s,vendor_name_var,'|',invoice_number_var,'|',balance_due_var,'//');
		END IF;
	END WHILE;
	END;
	CLOSE vendor_cursor;

	-- loop 3
	SET row_not_found = FALSE;
	BEGIN
	DECLARE EXIT HANDLER FOR NOT FOUND
		SET row_not_found = TRUE;
	OPEN vendor_cursor;
	SET s = CONCAT(s,'$5,000 to $10,000: ');
	WHILE row_not_found = FALSE DO
		FETCH vendor_cursor 
		INTO vendor_name_var, invoice_number_var, balance_due_var;
		IF balance_due_var >= 5000 AND balance_due_var < 10000 THEN	
			SET s = CONCAT(s,vendor_name_var,'|',invoice_number_var,'|',balance_due_var,'//');
		END IF;
	END WHILE;
	END;
	CLOSE vendor_cursor;

	-- print output
	SELECT s AS message;

END//

DELIMITER ;

CALL test();
