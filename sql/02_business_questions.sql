-- 01 Top 10 regions by 2025 income
SELECT region_code, region_name, income_2025_tl, income_rank_2025
FROM regional_income
ORDER BY income_2025_tl DESC LIMIT 10;

-- 02 Bottom 10
SELECT region_code, region_name, income_2025_tl
FROM regional_income
ORDER BY income_2025_tl ASC LIMIT 10;

-- 03 Year-over-year income growth
SELECT region_code, region_name, ROUND(income_growth_pct,2) AS growth_pct
FROM regional_income
ORDER BY growth_pct DESC;

-- 04 Gap to Ankara
SELECT region_code, region_name,
       ROUND(ankara_gap_tl,0) AS gap_to_ankara_tl,
       ROUND(100.0*income_2025_tl/449618,1) AS pct_of_ankara_income
FROM regional_income
ORDER BY gap_to_ankara_tl ASC;

-- 05 Distance from Türkiye average
SELECT region_code, region_name,
       ROUND(vs_turkey_2025_pct,1) AS vs_turkey_pct
FROM regional_income
ORDER BY vs_turkey_2025_pct DESC;

-- 06 Window function: percentile/rank
SELECT region_code, region_name, income_2025_tl,
       RANK() OVER (ORDER BY income_2025_tl DESC) AS income_rank,
       ROUND(PERCENT_RANK() OVER (ORDER BY income_2025_tl)*100,1) AS percentile_position
FROM regional_income;

-- 07 Growth ranking
SELECT region_code, region_name, income_growth_pct,
       DENSE_RANK() OVER (ORDER BY income_growth_pct DESC) AS growth_rank
FROM regional_income;

-- 08 Housing: rent vs house price index
SELECT region, kfe_index, ykke_index,
       ROUND(ykke_index/kfe_index,3) AS rent_to_house_price_index_ratio,
       kfe_yoy_pct, ykke_yoy_pct
FROM housing_snapshot
ORDER BY ykke_yoy_pct DESC;

-- 09 2025 income + housing for the three major cities
SELECT i.region_code, i.region_name, i.income_2025_tl,
       h.kfe_index, h.kfe_yoy_pct, h.ykke_index, h.ykke_yoy_pct
FROM regional_income i
JOIN housing_snapshot h
  ON i.region_name = h.region
WHERE h.region IN ('İstanbul','Ankara','İzmir');

-- 10 Identify regions below national income and above-average income growth
SELECT region_code, region_name, income_2025_tl, income_growth_pct
FROM regional_income
WHERE income_2025_tl < 332882
  AND income_growth_pct > (SELECT AVG(income_growth_pct) FROM regional_income)
ORDER BY income_growth_pct DESC;

-- 11 Economic pressure proxy (illustrative, transparent weights)
-- Higher income reduces pressure; faster rent growth increases pressure.
WITH city AS (
  SELECT i.region_name, i.income_2025_tl,
         h.ykke_yoy_pct,
         h.kfe_yoy_pct
  FROM regional_income i JOIN housing_snapshot h
    ON i.region_name=h.region
)
SELECT *,
       ROUND(
         50*(1-income_2025_tl/449618.0)
         + 30*(ykke_yoy_pct/38.5)
         + 20*(kfe_yoy_pct/31.7), 1
       ) AS pressure_proxy
FROM city
ORDER BY pressure_proxy DESC;
