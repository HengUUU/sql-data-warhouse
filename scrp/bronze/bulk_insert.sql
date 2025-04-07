/* 
	Use Bulk method to insert data!!!

*/


/* make it empty, otherwise it would duplicate if we execute two times */

truncate table bronze.crm_cust_info;
Bulk insert bronze.crm_cust_info
from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
	first_row = 2,
	fieldterminator = ',',
	tablock,
	CODEPAGE = '65001'
); 
go




truncate table bronze.crm_prd_info;
bulk insert bronze.crm_prd_info
from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (
	first_row = 2,
	fieldterminator = ',',
	tablock,
	CODEPAGE = '65001'
);
go

truncate table bronze.crm_sale_details;
bulk insert bronze.crm_sale_details
from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (
	first_row = 2,
	fieldterminator = ',',
	tablock
);
go


truncate table bronze.erp_cust_az12;
bulk insert bronze.erp_cust_az12
from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with (
	first_row = 2,
	fieldterminator = ',',
	tablock
);
go


truncate table bronze.erp_loc_A101;
bulk insert bronze.erp_loc_A101
from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with (
	first_row = 2,
	fieldterminator = ',',
	tablock
);
go

truncate table bronze.erp_px_cat_g1v2;
bulk insert bronze.erp_px_cat_g1v2
from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with (
	first_row = 2,
	fieldterminator = ',',
	tablock
);
go


