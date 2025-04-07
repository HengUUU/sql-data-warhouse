/* 
==========
create tables for project
==========
scipts pupose 
this scrips is used to create table( only in brown layer).

warning
please back up your data before execute the script other wise yours would lose.
*/




if object_id ('bronze.crm_cust_info', 'U') is not null
	drop table bronze.crm_cust_info;
create table bronze.crm_cust_info(
	cst_id int,
	cst_key nvarchar(30),
	cst_firstname nvarchar(30),
	cst_lastname nvarchar(20),
	cst_marital_status nvarchar(2),
	cst_gndr nvarchar(2),
	cst_create_date DATE

);
go



if object_id ('bronze.crm_prd_info', 'U') is not null
	drop table bronze.crm_prd_info;
create table bronze.crm_prd_info(
	prd_id int,
	prd_key varchar(50),
	prd_nm varchar(50),
	prd_cost int,
	prd_line nvarchar(2),
	prd_start_dt Date,
	prd_end_dt Date
);
go

if OBJECT_ID('bronze.crm_sale_details','U') is not null
	drop table bronze.crm_sale_details;
create table bronze.crm_sale_details (
sls_ord_nm nvarchar(20),
sls_prd_key nvarchar(20),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt int,
sls_due_dt int,
sls_sales int,
sls_quantity int,
sls_price float
);
go

if object_id ('bronze.erp_cust_az12','U') is not null
	drop table bronze.erp_cust_az12
create table bronze.erp_cust_az12 (
cid varchar(20),
bdate Date,
gen nvarchar(10)
);
go


if object_id ('bronze.erp_loc_A101','U') is not null
	drop table bronze.erp_loc_A101
create table bronze.erp_loc_A101 (
cid varchar(30),
cntry nvarchar(30)

);
go

if object_id ('bronze.erp_px_cat_g1v2','U') is not null
	drop table bronze.erp_px_cat_g1v2
create table bronze.erp_px_cat_g1v2 (
id nvarchar(10),
cat nvarchar(20),
subcat nvarchar(20),
maintenance nvarchar(10)
);
go

