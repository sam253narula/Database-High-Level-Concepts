-- Types of indexes
select * from film;

-- 1) Single-Column Indexes
-- note: A single-column index is one that is created based on only one table column

CREATE INDEX title_index
ON film (title);

-- 2) Multicolumn Indexes

-- note: Whether to create a single-column index or a multicolumn index,
-- take into consideration the column(s) that you may use very frequently in a query's WHERE clause as filter conditions
select * from city;

CREATE INDEX cityAndCoutryId_Index
ON city (city, country_id);

-- Transform a non-clustered index into a clustered one
ALTER TABLE city CLUSTER ON cityAndCoutryId_Index;

-- Now, re-cluster the table so that the table can follow the cluster index role 
CLUSTER city;


-- To verify the table is clustered with your selected index above, use the below query:
SELECT
  i.relname AS index_for_cluster
FROM
  pg_index AS idx
JOIN
  pg_class AS i
ON
  i.oid = idx.indexrelid
WHERE
  idx.indisclustered
  AND idx.indrelid::regclass = 'city'::regclass;

-- To show all the indexes of a table, you use the following statement:
SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'city';
--Note: PostgreSQL provides several index types: B-tree, Hash, GiST, SP-GiST and GIN

-- to Drop index
-- DROP INDEX cityAndCoutryId_Index;


-- 3) Unique Indexes 
-- Note : Unique indexes are used not only for performance, but also for data integrity
select * from country;

CREATE UNIQUE INDEX countryname_index
on country (country);

SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'country';
	
-- 4) Partial Indexes	
-- Note : As the name suggest, its indexing only on a certain where clause conditions in your select query
select * from inventory;
select film_id, count(film_id) from inventory group by film_id order by count DESC ;

CREATE INDEX film_id_index
ON inventory(film_id)
WHERE film_id=193;

SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'inventory';
	
-- 5) Implicit Indexes
-- note: Implicit indexes are indexes that are automatically created by the database server when an object is created.
-- Indexes are automatically created for primary key constraints and unique constraints.
	


	