create view gold.dim_products as
select  
ROW_NUMBER() over (order by prd_id) as product_key,
ci.prd_id as product_id,
ci.prd_key as product_number,
ci.prd_nm as product_name,
ci.cat_id as category_id,
eg.cat as category,
eg.subcat as sub_category,
eg.maintenance as maintenance_required,
ci.prd_cost as product_cost,
ci.prd_line as prducts_line,
ci.prd_start_dt as start_date
from silver.crm_prd_info ci
left join silver.erp_px_cat_g1v2 eg
on ci.cat_id = eg.id
where ci.prd_end_dt is null; --- Filter to only show the latest imported product from the product history
go


--- create view and insert data in gold layer for customer
create view gold.dim_customer as	
select 
row_number() over (order by ci.cst_id) as customer_key,
ci.cst_id as customer_id,
ci.cst_key as customer_number,
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
go
