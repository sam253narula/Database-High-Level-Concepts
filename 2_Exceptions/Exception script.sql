select * from film limit 100;

-- 1) Handling no_data_found exception example
do
$$
declare
	rec record;
	v_film_id int = 2000;
begin
	-- select a film 
	select film_id, title 
	into strict rec
	from film
	where film_id = v_film_id;
end;
$$

-- 2) Handling too_many_rows exception example
do
$$
declare
	rec record;
begin
	-- select film 
	select film_id, title 
	into strict rec
	from film
	where title LIKE 'A%';
	
	exception 
	   when too_many_rows then
	      raise exception 'Search query returns too many rows';
end;
$$


-- 3) Handling multiple exceptions &  Handling exceptions as SQLSTATE codes
do
$$
declare
	rec record;
	v_length int = 90;
begin
	-- select a film 
	select film_id, title 
	into strict rec
	from film
	where length = v_length;
	
        -- catch exception
	exception 
	   when sqlstate 'P0002' then 
	      raise exception 'film with length % not found', v_length;
	   when sqlstate 'P0003' then 
	      raise exception 'The with length % is not unique', v_length;
end;
$$


--   Retry Scenario Example or take some other action when exception caught
create table DEMO1(n integer);
 create table DEMO2(n integer);
insert into DEMO1 values(42);
alter table DEMO1 add unique(n); 
 select * from DEMO1;
 select * from DEMO2;


do
$$
begin
 insert into DEMO1 (n)  values (1);
 insert into DEMO1 (n)  values (42);
exception 
	when others then 
 	insert into DEMO2 select * from DEMO1;
end;
$$



select * from DEMO2;






