--- check record from the dim_customer that doesn't match with fact_table
select fs.order_number, fs.product_key, fs.customer_key, fs.shipping_date, fs.due_date, fs.sales_amount, fs.quantity, fs.price, 
dc.customer_id, dc.first_name, dc.last_name, dc.gender, dc.birth_date, dc.created_date
from gold.fact_sales fs
left join gold.dim_customer dc
on fs.customer_key = dc.customer_key
where dc.customer_key is null;
