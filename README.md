# Türkiye Regional Economic Intelligence 🇹🇷

> **A SQL-first portfolio project that turns official Turkish economic data into regional business insights.**

[![SQL](https://img.shields.io/badge/SQL-SQLite-blue)](#sql-analysis)
[![Python](https://img.shields.io/badge/Python-Pandas-yellow)](#python)
[![Data](https://img.shields.io/badge/Data-TÜİK%20%7C%20TCMB-red)](#data-sources)
[![Status](https://img.shields.io/badge/status-complete-success)](#)

## Why this project?

A salary number does not tell the whole story.

This project asks a more useful business question:

**Which Turkish regions combine a strong income base with favorable economic dynamics, and how does housing pressure change that picture?**

Instead of a generic "Türkiye economy" dashboard, the project is structured as a **decision-support case study**.

## What is inside?

- **26 NUTS-2 regions**
- Real TÜİK regional income data
- Real TCMB January 2026 housing indicators for Türkiye / İstanbul / Ankara / İzmir
- SQLite database with populated tables
- **30 business questions**
- Window functions and ranking analysis
- Python analysis runner
- Standalone HTML dashboard
- Power BI specification
- Data provenance and methodology
- SQL validation report

## Executive snapshot

| Metric | Result |
|---|---:|
| Türkiye 2025 published mean income | **332,882 TL** |
| Highest region | **TR51 Ankara — 449,618 TL** |
| İstanbul | **434,929 TL** |
| İzmir | **405,896 TL** |
| Lowest region | **TRB2 — 172,552 TL** |

> **Data note:** TÜİK's 2025 income-distribution release uses the previous calendar year as the income reference period. The project preserves the official release naming and documents the reference period in `docs/methodology.md`.

## Dashboard

<img width="1600" height="1000" alt="dashboard" src="https://github.com/user-attachments/assets/c959cb38-1bde-4830-96b4-6332d0cba5c8" />
<img width="1600" height="1000" alt="01_regional_income_ranking" src="https://github.com/user-attachments/assets/bf5f3514-67e2-4bf4-a28b-7d7562d31cf5" />
<img width="1600" height="1000" alt="02_income_growth_ranking" src="https://github.com/user-attachments/assets/5e111cf5-4279-41aa-963f-b55aa2654b5c" />
<img width="1600" height="1000" alt="03_major_city_housing_pressure" src="https://github.com/user-attachments/assets/c6cb911a-456a-4bc3-8762-3e45ba919bee" />
<img width="1600" height="1000" alt="04_income_gap_to_ankara" src="https://github.com/user-attachments/assets/37e048a5-8f2b-4f8f-a53d-f95ed8876c8e" />
<img width="1600" height="1000" alt="05_economic_attractiveness_score" src="https://github.com/user-attachments/assets/94d9c6b8-e173-47a0-a514-a787fcb8d8ee" />
<img width="1600" height="1000" alt="06_data_to_insight_workflow" src="https://github.com/user-attachments/assets/4f102a74-e0a7-4cd6-8edd-1b7d34c0db9a" />

Open:

`dashboard/index.html`

It is a standalone browser dashboard with no server or API dependency.

## SQL Analysis

The project contains **30 recruiter-facing business questions**, not just syntax exercises.

Examples:

- Which regions have the highest income?
- Which regions are catching up fastest?
- Which regions are below the national average but growing quickly?
- How large is the income gap to Ankara?
- What is each region's percentile position?
- Which major city has the fastest rent growth?
- Does new-tenant rent growth exceed house-price growth?
- Which regions combine strong income and strong growth?

### SQL techniques

`JOIN` · `CTE` · `CASE` · `GROUP BY` · `HAVING` · `RANK()` · `DENSE_RANK()` · `PERCENT_RANK()` · `NTILE()` · `ROW_NUMBER()` · subqueries · derived metrics · decision scoring

## Data Sources

- **TÜİK** — Income Distribution Statistics 2025
- **TCMB** — House Price Index / New Tenant Rent Index, January 2026
- **TEDAŞ** — documented as a future extension source; no unverified values are inserted

Official source register: `data/source_register.csv`

## Data Integrity

This repository follows one strict rule:

**If a value cannot be verified from an official source, it is not presented as real data.**

The derived scores are explicitly labeled as analyst-created metrics and are not presented as official TÜİK/TCMB indices.

## Project Architecture

```text
data/
├── regional_income_2024_2025.csv
├── tcmb_housing_jan_2026.csv
├── poverty_selected_2025.csv
└── rei.db

sql/
├── 01_schema.sql
├── 02_business_questions.sql
└── 03_30_business_questions.sql

src/
└── run_analysis.py

dashboard/
└── index.html

docs/
├── case_study.md
├── methodology.md
├── sources.md
├── powerbi_spec.md
├── github_upload.md
└── sql_validation.txt
```

## Run locally

```bash
pip install -r requirements.txt
python src/run_analysis.py
```

Then open `dashboard/index.html`.

## Portfolio Positioning

This project demonstrates a complete analyst workflow:

**Official data → data model → SQL → business questions → derived metrics → visualization → decision support**

The goal is not to demonstrate that I can write `SELECT *`.

The goal is to demonstrate that I can use SQL to answer a business question.

## Disclaimer

The Economic Attractiveness Score and Housing Pressure Proxy are analytical constructs created for this portfolio project. They are not official economic indicators.

## Author

**Resul Canca**

Data Analyst | SQL · Python · Power BI · Tableau
