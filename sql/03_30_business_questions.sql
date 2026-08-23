-- ============================================================
-- 30 BUSINESS QUESTIONS — Türkiye Regional Economic Intelligence
-- SQLite-compatible
-- ============================================================

-- Q01 Top 10 regions by income
SELECT region_code, region_name, income_2025_tl
FROM regional_income ORDER BY income_2025_tl DESC LIMIT 10;

-- Q02 Bottom 10
SELECT region_code, region_name, income_2025_tl
FROM regional_income ORDER BY income_2025_tl LIMIT 10;

-- Q03 National-average gap
SELECT region_code, region_name,
 ROUND(income_2025_tl - 332882,0) AS gap_tl
FROM regional_income ORDER BY gap_tl DESC;

-- Q04 Percentage above/below national average
SELECT region_code, region_name,
 ROUND((income_2025_tl/332882.0-1)*100,1) AS vs_national_pct
FROM regional_income ORDER BY vs_national_pct DESC;

-- Q05 Ankara purchasing-power proxy
SELECT region_code, region_name,
 ROUND(income_2025_tl/449618.0*100,1) AS income_as_pct_of_ankara
FROM regional_income ORDER BY income_as_pct_of_ankara DESC;

-- Q06 Ankara gap
SELECT region_code, region_name,
 ROUND(449618-income_2025_tl,0) AS ankara_gap_tl
FROM regional_income ORDER BY ankara_gap_tl;

-- Q07 Growth ranking
SELECT region_code, region_name, ROUND(income_growth_pct,1) growth_pct,
 DENSE_RANK() OVER(ORDER BY income_growth_pct DESC) growth_rank
FROM regional_income;

-- Q08 Income ranking with percentile
SELECT region_code, region_name, income_2025_tl,
 RANK() OVER(ORDER BY income_2025_tl DESC) AS income_rank,
 ROUND(PERCENT_RANK() OVER(ORDER BY income_2025_tl)*100,1) AS percentile
FROM regional_income;

-- Q09 Above-average income AND above-average growth
SELECT region_code, region_name, income_2025_tl, income_growth_pct
FROM regional_income
WHERE income_2025_tl > (SELECT AVG(income_2025_tl) FROM regional_income)
  AND income_growth_pct > (SELECT AVG(income_growth_pct) FROM regional_income)
ORDER BY income_2025_tl DESC;

-- Q10 Below-average income AND above-average growth
SELECT region_code, region_name, income_2025_tl, income_growth_pct
FROM regional_income
WHERE income_2025_tl < (SELECT AVG(income_2025_tl) FROM regional_income)
  AND income_growth_pct > (SELECT AVG(income_growth_pct) FROM regional_income)
ORDER BY income_growth_pct DESC;

-- Q11 Income dispersion
SELECT ROUND(MIN(income_2025_tl),0) min_income,
 ROUND(MAX(income_2025_tl),0) max_income,
 ROUND(AVG(income_2025_tl),0) avg_region_income,
 ROUND(MAX(income_2025_tl)/MIN(income_2025_tl),2) max_min_ratio
FROM regional_income;

-- Q12 Median region
WITH r AS (
 SELECT income_2025_tl,
 ROW_NUMBER() OVER(ORDER BY income_2025_tl) rn,
 COUNT(*) OVER() n
 FROM regional_income
)
SELECT AVG(income_2025_tl) median_income
FROM r WHERE rn IN ((n+1)/2,(n+2)/2);

-- Q13 Top quartile threshold
WITH r AS (
 SELECT income_2025_tl,
 NTILE(4) OVER(ORDER BY income_2025_tl DESC) quartile
 FROM regional_income
)
SELECT quartile, MIN(income_2025_tl) floor_income,
 MAX(income_2025_tl) ceiling_income
FROM r GROUP BY quartile ORDER BY quartile;

-- Q14 Highest growth regions
SELECT region_name, income_growth_pct
FROM regional_income ORDER BY income_growth_pct DESC LIMIT 5;

-- Q15 Lowest growth regions
SELECT region_name, income_growth_pct
FROM regional_income ORDER BY income_growth_pct LIMIT 5;

-- Q16 Income growth contribution in TL
SELECT region_name,
 ROUND(income_2025_tl-income_2024_tl,0) AS nominal_increase_tl
FROM regional_income ORDER BY nominal_increase_tl DESC;

-- Q17 Relative income category
SELECT region_name, income_2025_tl,
 CASE
  WHEN income_2025_tl >= 400000 THEN 'High'
  WHEN income_2025_tl >= 300000 THEN 'Medium'
  ELSE 'Low'
 END income_band
FROM regional_income ORDER BY income_2025_tl DESC;

-- Q18 Growth category
SELECT region_name, income_growth_pct,
 CASE
  WHEN income_growth_pct >= 80 THEN 'Very high'
  WHEN income_growth_pct >= 75 THEN 'High'
  ELSE 'Below 75%'
 END growth_band
FROM regional_income ORDER BY income_growth_pct DESC;

-- Q19 Istanbul vs Ankara vs Izmir
SELECT i.region_name, i.income_2025_tl,
 h.kfe_yoy_pct, h.ykke_yoy_pct
FROM regional_income i
LEFT JOIN housing_snapshot h ON i.region_name=h.region
WHERE i.region_name IN ('İstanbul','Ankara','İzmir');

-- Q20 Housing pressure ratio
SELECT region,
 ROUND(ykke_yoy_pct-kfe_yoy_pct,1) AS rent_growth_minus_house_growth,
 ROUND(ykke_index/kfe_index,3) AS rent_house_index_ratio
FROM housing_snapshot ORDER BY rent_growth_minus_house_growth DESC;

-- Q21 Which big city has fastest rent growth?
SELECT region, ykke_yoy_pct
FROM housing_snapshot
WHERE region IN ('İstanbul','Ankara','İzmir')
ORDER BY ykke_yoy_pct DESC LIMIT 1;

-- Q22 Which big city has fastest house-price growth?
SELECT region, kfe_yoy_pct
FROM housing_snapshot
WHERE region IN ('İstanbul','Ankara','İzmir')
ORDER BY kfe_yoy_pct DESC LIMIT 1;

-- Q23 Rent growth above house-price growth
SELECT region, kfe_yoy_pct, ykke_yoy_pct
FROM housing_snapshot
WHERE ykke_yoy_pct > kfe_yoy_pct;

-- Q24 Combine income and rent growth for big cities
SELECT i.region_name, i.income_2025_tl, h.ykke_yoy_pct,
 ROUND(h.ykke_yoy_pct / (i.income_2025_tl/332882.0),2) AS rent_pressure_proxy
FROM regional_income i JOIN housing_snapshot h ON i.region_name=h.region;

-- Q25 City ranking by income/rent-growth proxy
SELECT i.region_name,
 ROUND(i.income_2025_tl / h.ykke_yoy_pct,1) AS income_per_rent_growth_point
FROM regional_income i JOIN housing_snapshot h ON i.region_name=h.region
ORDER BY income_per_rent_growth_point DESC;

-- Q26 P80/P20 selected poverty inequality evidence
SELECT p.region_code, p.relative_poverty_rate_pct
FROM poverty_selected p ORDER BY p.relative_poverty_rate_pct DESC;

-- Q27 Regions where income growth exceeds national income growth (77.3%)
SELECT region_name, income_growth_pct
FROM regional_income WHERE income_growth_pct > 77.3
ORDER BY income_growth_pct DESC;

-- Q28 Regions within 10% of national average
SELECT region_name, income_2025_tl,
 ROUND((income_2025_tl/332882.0-1)*100,1) vs_national_pct
FROM regional_income
WHERE ABS(income_2025_tl/332882.0-1) <= 0.10
ORDER BY income_2025_tl DESC;

-- Q29 Regional score: income + growth (portfolio construct, not official)
WITH z AS (
 SELECT *,
  PERCENT_RANK() OVER(ORDER BY income_2025_tl) income_pct,
  PERCENT_RANK() OVER(ORDER BY income_growth_pct) growth_pct
 FROM regional_income
)
SELECT region_name,
 ROUND(100*(0.7*income_pct+0.3*growth_pct),1) economic_attractiveness_score
FROM z ORDER BY economic_attractiveness_score DESC;

-- Q30 Decision shortlist: strong income + strong growth
WITH z AS (
 SELECT *,
  PERCENT_RANK() OVER(ORDER BY income_2025_tl) income_pct,
  PERCENT_RANK() OVER(ORDER BY income_growth_pct) growth_pct
 FROM regional_income
)
SELECT region_code, region_name, income_2025_tl, income_growth_pct,
 ROUND(100*(0.7*income_pct+0.3*growth_pct),1) score
FROM z
WHERE income_pct >= 0.60 AND growth_pct >= 0.60
ORDER BY score DESC;
