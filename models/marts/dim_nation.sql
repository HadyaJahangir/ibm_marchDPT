-- {{ config(materialised='incremental')}}  --this is imp as incriment mai bar bar ye rin hoga nad create ot replace hoga which i dont want
-- WITH NATION AS (  --dimnation and stg nation in one command + use krp
--     SELECT
--      NATION_ID,
--      REGION_ID,
--       NAME,
--       COMMENT,
--       updated_ts
-- FROM {{ ref('stg_nation')}}

-- where updated_ts > (select max(updated_ts) from {{this}})
-- )
-- select * from nation;
-- -- we removed alise name as that is in the src file and we removed that source src
-- --reates a view and then adds
-- --

{{config(materialized='incremental')}}
WITH NATION AS (
    SELECT
      NATION_ID,
      REGION_ID,
      NAME,
      COMMENT,
      UPDATED_TS
FROM {{ref('stg_nation')}}
{% if is_incremental()%}
WHERE UPDATED_TS > (SELECT MAX(UPDATED_TS) FROM {{this}})   --when is it included for the first time it wont ciz pehla wala hai
{%endif%}
)
SELECT * from nation
-- Incremental makes sure the table is not created over and over again.

--added dublicat evalue and null for id then rum dbt run -s stg_nations+ and then the test