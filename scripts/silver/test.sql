/*

>>>>>>>> needed to be Cleaning in crm_cust_info table

*/


-- Except No Result
select cst_id, count(*) 
from bronze.crm_cust_info 
group by cst_id
having count(*) > 1;

select *,
	ROW_NUMBER() over(partition by cst_id order by cst_create_date DESC) as Flag
from
	bronze.crm_cust_info
where cst_id is not null;

-- Except No Result
select * from bronze.crm_cust_info
where cst_firstname <> TRIM(cst_firstname);

-- Except No Result >>> need fix
select * from bronze.crm_cust_info
where cst_lastname <> TRIM(cst_lastname);

select distinct cst_marital_status from bronze.crm_cust_info;

select distinct cst_gndr from bronze.crm_cust_info;

select MAX(cst_create_date), min(cst_create_date) from bronze.crm_cust_info;

/*

>>>>>>> needed to be cleaning in crm_prd_info

*/
select * from bronze.erp_px_cat_g1v2;

select top(100) * from bronze.crm_prd_info;
select top(100) * from bronze.crm_sales_details;

select 
	replace(SUBSTRING(prd_key, 1, 5), '-', '_') as cat_id,
	SUBSTRING(prd_key, 7, len(prd_key)) as prd_key
from bronze.crm_prd_info;

select 
	ISNULL(prd_cost, 0)
from bronze.crm_prd_info
where prd_cost <0 or prd_cost is null;

select
	prd_key,
	cast(prd_start_dt as date),
	cast(
		lead(prd_start_dt) over(partition by prd_key order by prd_start_dt) -1
		as date
	) as end_dt
from bronze.crm_prd_info
-- solve the date problem

-- Sales Details

select top(100) * from bronze.crm_sales_details;

select * from bronze.crm_sales_details
where LEN(sls_order_dt) <> 8 or LEN(sls_ship_dt) <> 8 or LEN(sls_due_dt) <> 8;

select *
from bronze.crm_sales_details
where sls_sales <= 0 or sls_sales is null

select *
from bronze.crm_sales_details
where sls_sales <> sls_quantity * ABS(sls_price)

select *
from bronze.crm_sales_details
where sls_price is null or sls_price <=0
 
 --erp_cust_az12
select * from bronze.erp_cust_az12 
where cid like 'NAS%';
select max(bdate), min(bdate) from bronze.erp_cust_az12;

select distinct gen from bronze.erp_cust_az12;

-- erp_loc_a101

select distinct cntry from bronze.erp_loc_a101

select * from bronze.erp_px_cat_g1v2;