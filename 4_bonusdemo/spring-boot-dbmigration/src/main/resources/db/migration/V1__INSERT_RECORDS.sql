create schema demo;
CREATE TABLE demo.accounts (user_id integer primary key, balance integer not null);
INSERT INTO demo.accounts(user_id, balance) VALUES (1, 1000000);
INSERT INTO demo.accounts(user_id, balance) VALUES (2, 2000000);