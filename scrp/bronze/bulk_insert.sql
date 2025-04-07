/* 
	Use Bulk method to insert data!!!

*/


Bulk insert bronze.crm_cust_info
from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
	first_row = 2,
	fieldterminator = ',',
	tablock,
	CODEPAGE = '65001'
);
