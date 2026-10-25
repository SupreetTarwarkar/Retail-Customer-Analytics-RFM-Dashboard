# Python RFM analysis — Google Colab

The complete executed `.ipynb` notebook will be added when the final file is supplied and verified. This folder is reserved for the real notebook, not invented code.

### Implemented analysis (from saved validation notes)

- Load `RetailCleaned.csv` with headers, 1,033,036 rows × 9 fields.
- Convert `invoicedate` to a datetime type.
- Filter to the eligible purchase universe; calculate customer-level Recency, distinct-invoice Frequency and Monetary value.
- Snapshot date: **2011-12-10**.
- Score R, F and M by quantiles, reversing Recency so more recent purchases score higher.
- Assign six segments: Champions, Loyal, At Risk, New, Needs Attention and Lost.
- Flag `Recency > 90` days as **historical inactivity**.
- Merge customer-level features into transaction-level records; output was **779,495 × 19**.
- Customer-level RFM: **5,881** customers.

### Data-grain rule

RFM features recur on each qualifying transaction row after the merge. Do not SUM customer-level measures across transaction lines in Power BI.

### Known environment differences

Colab files under `/content/` may be lost when the runtime resets. Keep raw data locally or on Drive, and preserve the notebook. The instructor uses Anaconda/local Jupyter; this project uses Google Colab. CSV header handling differs because this project's SQL export included headers, not because Pandas behaves differently.
