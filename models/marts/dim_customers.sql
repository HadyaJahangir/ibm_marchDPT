with customer as (
    select * from {{ ref('stg_customer')}}
),
nation as (
    select * from {{ ref('stg_nation')}}
),
region as (
    select * from {{ ref('stg_regions')}}
),
final as(
    select
    customer.CUSTOMER_ID,
    customer.NAME,
    customer.ADDRESS,
    nation.NATION_ID as NATION_ID,
    nation.name as nation,
    region.REGION_ID as REGION_ID,
    region.name as region,
    customer.PHONE_NUMBER,
    customer.ACCOUNT_BALANCE,
    customer.MARKET_SEGMENT
     from customer
     inner join nation on customer.NATION_ID=nation.NATION_ID
     inner join region on nation.REGION_ID=region.REGION_ID
)
select * from final