
--- create view and insert data in gold layer for customer
create view gold.customer as	
select 
row_number() over (order by ci.cst_id) as row_numb,
ci.cst_id as customer_id,
ci.cst_key customer_key,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name, 
case when ci.cst_gndr != 'n\a' then ci.cst_gndr
	else coalesce(ea.gen, 'n\a')
end as gender,
la.cntry as country,
ea.bdate as birth_date,
ci.cst_create_date as created_date
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ea 
on ci.cst_key = ea.cid
left join silver.erp_loc_A101 la
on ci.cst_key = la.cid;
