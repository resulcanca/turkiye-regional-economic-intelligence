-- SQLite / PostgreSQL-friendly core schema
CREATE TABLE regional_income (
  region_code TEXT PRIMARY KEY,
  region_name TEXT NOT NULL,
  income_2024_tl REAL NOT NULL,
  income_2025_tl REAL NOT NULL,
  income_growth_pct REAL,
  vs_turkey_2025_pct REAL,
  ankara_gap_tl REAL,
  income_rank_2025 INTEGER
);

CREATE TABLE housing_snapshot (
  period TEXT,
  region TEXT,
  kfe_index REAL,
  kfe_yoy_pct REAL,
  ykke_index REAL,
  ykke_yoy_pct REAL
);

CREATE TABLE poverty_selected (
  region_code TEXT,
  year INTEGER,
  relative_poverty_rate_pct REAL
);
