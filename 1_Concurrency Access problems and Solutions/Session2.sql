--Demo of Problem 
SELECT balance FROM accounts WHERE user_id = 1;
UPDATE accounts  SET balance = 200 WHERE user_id = 1;

--Demo of Problem when using transaction blocks
BEGIN;
SELECT balance FROM accounts WHERE user_id = 1;
UPDATE accounts SET balance = 200 WHERE user_id = 1;
commit;

SELECT * from accounts;

-- Solutions to Concurrency Problems:
-- 1) Avoiding the read-modify-write cycle
UPDATE accounts SET balance = balance - 100 WHERE user_id = 1; 
--(sets balance=100)

-- 2) Row level locking
BEGIN;
SELECT balance FROM accounts WHERE user_id = 1 FOR UPDATE;
--(gets stuck and waits for transaction 1 to complete)
UPDATE balance SET balance = 100 WHERE user_id = 1; 
--(200 – 100 = 100)
COMMIT;

-- 3) SERIALIZABLE transactions
BEGIN ISOLATION LEVEL SERIALIZABLE;
SELECT balance FROM accounts WHERE user_id = 1; 
--(returns 300)
UPDATE accounts SET balance = 200 WHERE user_id = 1; 
--(gets stuck on session1’s lock and doesn’t proceed)
COMMIT;
--COMMIT converted into forced ROLLBACK, leaving balance unchanged

-- 4) Optimistic concurrency control
BEGIN;
SELECT version, balance FROM accounts WHERE user_id = 1;
--(also returns 1, 300
COMMIT;
BEGIN;
UPDATE accounts SET balance = 200, version = 2 WHERE user_id = 1 AND version = 1;
--(300 – 100 = 200). Blocks on session 1’s lock.
-- (UPDATE returns, matching zero rows because it sees version=2 in the WHERE clause)
ROLLBACK; 
-- 	ROLLBACK; because of error detected














