
CREATE TABLE accounts (user_id integer primary key, balance integer not null);

truncate table accounts;
INSERT INTO accounts(user_id, balance) VALUES (1, 300);

SELECT * from accounts;

SELECT balance FROM accounts WHERE user_id = 1;
UPDATE accounts  SET balance = 200 WHERE user_id = 1;

--Don’t transactions prevent this?
BEGIN;
SELECT balance FROM accounts WHERE user_id = 1;
UPDATE accounts  SET balance = 200 WHERE user_id = 1;
COMMIT;

-- Solutions to Concurrency Problems:
-- 1) Avoiding the read-modify-write cycle
UPDATE accounts SET balance = balance - 100 WHERE user_id = 1;
--(sets balance=200)

-- 2) Row level locking
BEGIN;
SELECT balance FROM accounts WHERE user_id = 1 FOR UPDATE; 
--(returns 300)
UPDATE balance SET balance = 200 WHERE user_id = 1;
--(300 – 100 = 200)
COMMIT;

-- 3) SERIALIZABLE transactions
BEGIN ISOLATION LEVEL SERIALIZABLE;
SELECT balance FROM accounts WHERE user_id = 1; 
--(returns 300)
UPDATE accounts SET balance = 200 WHERE user_id = 1;
--(300 – 100 = 200)
COMMIT;
--  COMMIT-succeeds, setting balance=200

-- 4) Optimistic concurrency control
ALTER TABLE accounts ADD COLUMN version integer NOT NULL DEFAULT 1;

BEGIN;
SELECT balance, version FROM accounts WHERE user_id = 1;
--(returns 1, 300)
COMMIT;
BEGIN;	
UPDATE accounts SET balance = 200, version = 2 WHERE user_id = 1 AND version = 1; 
--(300 – 100 = 200. Succeeds, reporting 1 row changed.)
COMMIT;










