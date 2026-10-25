# Python - Google Colab

**[Open the complete RFM segmentation notebook](Dunelm_RFM_Segmentation.ipynb)**

Google Colab and Pandas were used to process the cleaned transactions and build the customer-level RFM analysis.

- Calculated **Recency** from each customer's latest purchase.
- Counted distinct invoices for **Frequency** and purchase value for **Monetary**.
- Assigned RFM scores from **1 to 5**.
- Grouped customers into six segments: **Champions, Loyal, At Risk, New, Needs Attention and Lost**.
- Classified customers with **Recency > 90 days** as churned.
- Prepared the customer-level results for the Power BI analysis.

**Result:** **5,881** customer profiles and **779,495** enriched transaction records.

In the original video, [Mansi Goel](https://www.youtube.com/@Mansi.goel.offical) uses Anaconda and Jupyter Notebook. The equivalent workflow here was completed in Google Colab.

[Watch the Python section (34:40)](https://www.youtube.com/watch?v=LQa0SiuZfhA&t=2080s)

[Back to the main README](../README.md)
