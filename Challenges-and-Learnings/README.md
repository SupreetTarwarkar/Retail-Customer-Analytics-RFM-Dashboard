# Challenges, decisions and lessons learned

This documents implementation differences and data-quality caveats of the recreated guided project. It does not claim these challenges were part of Mansi Goel's own environment unless explicitly stated.

## 1. Recreating a SQL Server tutorial in PostgreSQL

The original demonstration uses **SQL Server Express with SQL Server Management Studio (SSMS)**. This implementation used PostgreSQL staging tables, manual CSV imports, PostgreSQL casts, `TO_TIMESTAMP`, `UNION ALL`, and a window-based deduplication query.

**Lesson:** preserve raw tables and validate every transformation with row counts.

## 2. CSV encoding and large exports

An original CSV import encountered a non-UTF-8 pound-sign byte. A pgAdmin grid export stalled on a large output. A PostgreSQL server-side `COPY` export returned `COPY 1033036` and included a CSV header.

**Lesson:** know whether the file is on the database server or the client, specify the correct encoding, and validate exported row counts.

## 3. Duplicate groups versus duplicate rows

There were **32,907** groups containing repeated transaction values, but removing extra occurrences eliminated **34,335** rows.

**Lesson:** count redundant *rows*, not merely groups, when reporting cleaning outcomes. The existing SQL chooses an arbitrary survivor when source-sheet labels differ.

## 4. Why exclude unidentified or nonpurchase transactions?

RFM requires a customer ID and purchase eligibility. Missing IDs cannot be attributed to an individual, and negative quantities can represent returns or cancellations.

**Lesson:** filtering for a defined question is not the same as declaring the underlying records erroneous.

## 5. Computing RFM correctly

Frequency is the number of **unique invoices**, not number of product lines. The Recency measure uses a fixed historical snapshot date of 2011-12-10. Recency scores are reversed. Frequency ties are ranked to enable quantile binning.

**Lesson:** document measurement grain, score direction, and reproducibility decisions.

## 6. Churn definition is an assumption

`Recency > 90` is a rule-based inactivity label, not predictive churn.

**Lesson:** a descriptive segment flag should not be presented as model accuracy, observed customer loss or campaign impact.

## 7. Transaction-level versus customer-level grain

Joining RFM attributes back onto each transaction line repeats those attributes. The resulting report table has **779,495** transaction-level records, while RFM is built for **5,881** individual customers.

**Lesson:** never naively sum RFM features across repeated lines; use appropriately scoped measures.

## 8. Colab adaptation

The original tutorial launches **Jupyter Notebook from Anaconda**; this implementation instead runs the Python analysis with **Google Colab**. Inputs and exports live under an ephemeral `/content/` path unless saved persistently.

**Lesson:** environment changes affect file paths, persistence and resources; they should not change analytical logic.

## 9. Dashboard customization and attribution

The original reference uses IKEA-inspired branding. The new Power BI design uses forest green and sage, a redesigned Home Page, navigation controls, formatted KPIs, and interactive report pages.

**Lesson:** separate a guided foundation from original implementation work, and never imply a real corporate engagement. Explicit instructor credit preserves provenance.

## 10. User-friendly churn labels without changing classification

The tutorial exposes the churn status as a Boolean (`True` / `False`). To make legends, slicers and tooltips clearer to business users, a **`Churn Status`** field was added in Power BI so `True` reads **Churned** and `False` reads **Not Churned**.

**Lesson:** readable report labels improve communication, but the underlying `Recency > 90` historical inactivity rule is unchanged.

## 11. Analytical limitations

- Historical data, not current sales.
- Report uses a displayed dollar symbol, but the original source is a UK retailer; FX conversion is **not** established.
- Potential source sheet-year label mismatch requires validation before relying on `sourcesheet`.
- Reported Q4 uplift is descriptive, not proven seasonality causation.
- Marketing and retention actions are **suggestions**, not executed interventions.

## Credit

**Guided project:** [Mansi Goel](https://github.com/the-mansi-goel/IKEA).  
**Independent implementation and redesign:** Supreet Jayant Tarwarkar.
