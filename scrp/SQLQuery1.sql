/* 
==========
create database and schema,  and table
==========
scipts pupose 
this scrips is used to create database and schemas( brown, silver, and gold).

warning
please back up your data before execute the script other wise yours would lose.
*/






use master;

create database datawarhouse;
use datawarhouse;
go


create schema bronze;
go
create schema silver;
go
create schema gold;
go



if object_id ('bronze.crm_cust_info', 'U') is not null
	drop table bronze.crm_cust_info;
create table bronze.crm_cust_info(
	cst_id int,
	cst_firstname varchar(20),
	cst_marital_status char(2),
	cst_gndr char(2),
	cst_create_date Date

);
go



if object_id ('bronze.crm_prd_info', 'U') is not null
	drop table bronze.crm_prd_info;

create table crm_prd_info(
	prd_id int,
	prd_key varchar(30),
	prd_nm varchar(30),
	prd_cost int,
	prd_line nvarchar(2),
	prd_start_dt Date,
	prd_end_dt Date
);
go

create table crm_sale_details (
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


create table erp_cust_az12 (
cid int,
bdate Date,
gen nvarchar(2)
);
go


create table erp_loc_A101 (
cid int,
cntry nvarchar(20)

);
go

create table erp_px_cat_g1v2 (
id nvarchar(10),
cat nvarchar(20),
subcat nvarchar(20),
maintenance nvarchar(10)
);
go

