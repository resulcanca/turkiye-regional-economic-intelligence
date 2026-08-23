import sqlite3
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "data" / "rei.db"

def run():
    con = sqlite3.connect(DB)
    top = pd.read_sql_query(
        "SELECT region_name, income_2025_tl FROM regional_income ORDER BY income_2025_tl DESC",
        con
    )
    con.close()
    print("\nTOP 10 REGIONS BY 2025 INCOME\n")
    print(top.head(10).to_string(index=False))
    print("\nDatabase:", DB)

if __name__ == "__main__":
    run()
