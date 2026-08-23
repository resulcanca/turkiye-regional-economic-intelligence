# Case Study

## The problem
Nominal income is not enough to answer whether a region is economically attractive.
A region can have high income but also fast-rising housing pressure.

## What this project answers
1. Which Turkish regions have the highest income?
2. Which regions are catching up fastest?
3. Which regions sit materially below the national average?
4. How different are Ankara, Istanbul and Izmir?
5. Where does new-tenant rent inflation outpace house-price inflation?
6. Which regions combine a strong income base with strong growth?

## Key official facts
TÜİK's 2025 Income Distribution Statistics report a national mean annual equivalised
household disposable income of 332,882 TL. Ankara is highest at 449,618 TL,
Istanbul is 434,929 TL, Izmir is 405,896 TL and TRB2 is lowest at 172,552 TL.
The income reference period for the 2025 release is the previous calendar year (2024).

TCMB's January 2026 release reports a national KFE annual increase of 27.7%;
the annual changes were 28.7% in Istanbul, 31.7% in Ankara and 29.0% in Izmir.

## SQL techniques demonstrated
- CTEs
- JOINs
- Window functions
- RANK / DENSE_RANK / PERCENT_RANK
- NTILE
- CASE expressions
- Aggregation
- Subqueries
- Derived metrics
- Decision scoring

## Caveat
The Economic Attractiveness Score and Housing Pressure Proxy are analyst-created
portfolio metrics. They are not official TÜİK or TCMB indices.
