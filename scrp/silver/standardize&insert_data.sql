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
