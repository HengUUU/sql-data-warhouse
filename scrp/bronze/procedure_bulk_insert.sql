/* 
===============================
this file is used to create store procedure for inserting the data from sources
(.csv file) into bronze layer using bulk method.

*** this proc does not acept any parameters:
ex: exec bronze.load_bronze;
==========================
*/

create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @start_batch datetime, @end_batch datetime;
	begin try
		print '===================='
		print 'Loading Bronze Layer'
		print '===================='

		set @start_time = getdate();
		set @start_batch = GETDATE();
		truncate table bronze.crm_cust_info;
		Bulk insert bronze.crm_cust_info
		from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			first_row = 2,
			fieldterminator = ',',
			tablock,
			CODEPAGE = '65001'
		);
		set @end_time = getdate();
		print 'time for loading cust_info:' + cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print '-------------------'




		set @start_time = getdate();
		truncate table bronze.crm_prd_info;
		bulk insert bronze.crm_prd_info
		from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			first_row = 2,
			fieldterminator = ',',
			tablock,
			CODEPAGE = '65001'
		);
		set @end_time = getdate();
		print 'time for loading prd_info:' + cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print '-------------------'

		set @start_time = getdate();
		truncate table bronze.crm_sale_details;
		bulk insert bronze.crm_sale_details
		from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			first_row = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print 'time for loading sale_details:' + cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print '-------------------'


		set @start_time = GETDATE();
		truncate table bronze.erp_cust_az12;
		bulk insert bronze.erp_cust_az12
		from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			first_row = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print 'time for loading cust_az12:' + cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print '-------------------'


		set @start_time = GETDATE();
		truncate table bronze.erp_loc_A101;
		bulk insert bronze.erp_loc_A101
		from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			first_row = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print 'time for loading loc_a101:' + cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print '-------------------'

		set @start_time = GETDATE();
		truncate table bronze.erp_px_cat_g1v2;
		bulk insert bronze.erp_px_cat_g1v2
		from 'E:\Year_4\Sem 2\Big data\YT\Data with Bara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			first_row = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print 'time for loading cat_g1v2:' + cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print '-------------------'

		print '****************'
		set @end_batch = GETDATE();
		print 'total time for loading bronze is:' + cast( datediff(second,@start_batch,@end_batch) as nvarchar) + ' seconds'
		print '****************'

		print '======================'
	end try
		

	begin catch
		print '======================'
		print 'Error occur in loading bronze layer'
		print 'error message: ' + Error_message();
		print 'error message: ' + cast (error_number() as nvarchar)
		print 'error message: ' + cast (error_state() as nvarchar)
	end catch
end



