/* we wanted only the string with no unwanted space in firstname cst and last name
so we use trim() to remove the unwanted space from both table
-- we also convert the gender f/m to the full word
*/


/*
Insert into silver layer
*/


truncate table silver.crm_cust_info;
insert into silver.crm_cust_info(
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date
)

select cst_id, cst_key,
trim(cst_firstname) as cst_firstname,
trim(cst_lastname) as cst_lastname,
case when upper(trim(cst_marital_status)) = 'S' then 'Single'
	 when upper(trim(cst_marital_status)) = 'M' then 'Married'
	 Else 'n/a'
end cst_marital_status,
case when upper(trim(cst_gndr)) = 'F' then 'Female'
	 when upper(trim(cst_gndr)) = 'M' then 'Male'
	 Else 'n/a'
end cst_gdr,
cst_create_date
from (select *,
row_number() over (partition by cst_id order by cst_create_date desc) as row_num 
from bronze.crm_cust_info
)t
where row_num = 1; -- select the last update row 1 (desc order)
go 



--- insert data into silver.crm_prd_info

truncate table silver.crm_prd_info;
insert into silver.crm_prd_info(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
select prd_id,
replace(substring(prd_key,1,5), '-', '_') as cat_id,  --- derive cat_id from prd_key
substring(prd_key, 7, len(prd_key)) as prd_key,  --- derive prd_key from prd_key(0riginal)
prd_nm,
isnull(prd_cost, 0) as prd_cost,
case 
	when upper(trim(prd_line)) = 'M' then 'Mountian'
	when upper(trim(prd_line)) = 'R' then 'Road'
	when upper(trim(prd_line)) = 'S' then 'Other Sales'
	when upper(trim(prd_line)) = 'T' then 'Touring'
	else 'n/a'
end prd_line,
prd_start_dt,
dateadd(day,-1,lead(prd_start_dt) over (partition by prd_key order by prd_start_dt) ) as prd_end_dt  -- use the st_dt of the bext record as the end_dt for the same prd_id ( but also substrac with 1) 
from bronze.crm_prd_info;
go
