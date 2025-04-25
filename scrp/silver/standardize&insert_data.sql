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
prd_id,cat_id,prd_key,prd_nm,prd_cost,prd_line,prd_start_dt, prd_end_dt
)
select prd_id,
replace(substring(prd_key,1,5), '-', '_') as cat_id,
substring(prd_key, 7, len(prd_key)) as prd_key,
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
dateadd(day,-1,lead(prd_start_dt) over ( partition by prd_key order by prd_start_dt)) as prd_end_dt
from bronze.crm_prd_info;
go


	

--- insert data into silver.crm_sale_detailts
truncate table silver.crm_sale_details;
insert into silver.crm_sale_details(
sls_ord_nm, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price
)
select sls_ord_nm,
sls_prd_key,
sls_cust_id,
case	
	when len(sls_order_dt) < 8 then null
	else cast(cast(sls_order_dt as varchar) as date)
end as sls_order_dt,
case	
	when len(sls_ship_dt) < 8 then null
	else cast(cast(sls_ship_dt as varchar) as date)
end as sls_ship_dt,
case	
	when len(sls_due_dt) < 8 then null
	else cast(cast(sls_due_dt as varchar) as date)
end as sls_due_dt,
case
	when sls_sales is null or sls_sales < 0 or sls_sales != sls_quantity * abs(sls_price) then sls_quantity * abs(sls_price)
	else sls_sales
end as sls_sales,
sls_quantity,
case 
	when sls_price is null or sls_price < 0 then sls_sales / nullif(sls_quantity, 0 )
	else sls_price
end as sls_price
from bronze.crm_sale_details;
go

--- insert data into silver.erp_cust_az12
truncate table silver.erp_cust_az12;
insert into silver.erp_cust_az12(cid,bdate,gen) 
select 
case when left(cid,3) = 'NAS' then substring(cid,4,Len(cid))
	else cid
end as cid,
case when bdate > GETDATE() then NULL 
	else bdate
end as bdate,
case gen
	when 'F' then 'Female'
	when 'M' then 'Male'
	else 'n\a'
	
end as gen
from bronze.erp_cust_az12 ;
go



