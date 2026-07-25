## Analytics & Visualization (Power BI)

This project features an interactive Power BI dashboard designed to analyze B2B and wholesale retail transactions. It provides executive and operational visibility into financial growth, order velocity, customer retention health, and product performance driven by custom DAX logic and an optimized dimensional model.

---

### Dashboard Pages

#### Executive Overview (`B2B & Wholesale Performance Data 2011`)
Focuses on macro business performance, revenue trajectories, order dynamics, and month-over-month growth patterns.

![Overview Dashboard](./images/Dashboard_Overview.png)

* **Key Performance Indicators (KPIs):**
  * **Total Revenue:** **$8.34M**
  * **Average Order Value (AOV):** **$486.73**
  * **Total Orders:** **17K**
  * **Purchase Frequency:** **4.06**
  * **Total Quantity Sold:** **5M units**
  * **Average Units / Order:** **283 units**

* **Analytical Visualizations:**
  * **Monthly Revenue Trend (Line Chart):** Tracks revenue performance throughout 2011, highlighting baseline stability (~$0.5M–$0.7M) and a massive Q4 sales surge peaking in November at over $1.15M.
  * **MoM Growth Rate % (Line Chart):** Evaluates month-over-month sales velocity, pinpointing growth acceleration spikes (May and September reaching ~50% growth) versus seasonal dips.

---

#### Customer Insights (`Customer Insight 2011`)
Provides granular analysis on customer retention, lifetime value proxies, top-selling product lines, and global revenue distribution.

![Customer Insight Dashboard](./images/Dashboard_CustomerInsight.png)

* **Customer Health KPIs:**
  * **Total Customers:** **4.22K**
  * **Active Customers (90 Days):** **2.55K**
  * **Repeat Purchase Rate:** **64%**
  * **Repeat Customers:** **2.72K**
  * **CLV Proxy:** **$5.93K**
  * **Avg Revenue / Customer:** **$1.98K**

* **Analytical Visualizations:**
  * **Top 5 Products by Quantity Sold (Bar Chart):** Ranks top SKUs by unit volume sold, led by *Paper Craft*, *Medium Ceramic Top Table*, *World War 2 Gliders*, *Jumbo Bag Red Retrospot*, and *White Hanging Heart T-Light Holder*.
  * **Total Revenue by Country (Map Visual):** Maps global sales distribution, highlighting core market density in the UK and Western Europe alongside secondary international expansion.

### Data Model & DAX Architecture

#### Star Schema Semantic Model
The Power BI semantic model is structured in a clean **Star Schema** to deliver optimal filter propagation and fast report rendering:

![Power BI Model View](./images/PowerBI_Model.png)

* **Fact Table (`Online Retail`):** Contains core line-item transactional data (`Quantity`, `UnitPrice`, `InvoiceNo`, `InvoiceDate`).
* **Dimension Tables:**
  * `DimCustomer`: Stores customer attribute metadata (`CustomerID`, `Country`).
  * `Date`: A dedicated calendar dimension supporting time-intelligence functions (`Date`, `Month Name`, `Month Number`, `Quarter`, `Year`).
* **Relationships:** Standard 1 : * (One-to-Many) single-directional relationships linking dimensions to the central fact table.

---

#### DAX Measure Repository
All calculations are organized within a central `Measures` folder for clean governance and maintainability:

![DAX Measures List](./images/PowerBI_Measures.png)

| Measure | Description / Purpose |
| :--- | :--- |
| **`TotalRevenue`** | Calculates aggregate sales volume (`Quantity * UnitPrice`). |
| **`TotalOrders`** | Counts unique invoices/orders processed. |
| **`TotalQuantity`** | Measures total units sold across all line items. |
| **`ActiveCustomers`** | Filters distinct customers with purchase activity in the past 90 days. |
| **`RepeatPurchaseRate`** | Computes the percentage of total customers with more than one historical order. |
| **`CLVProxy`** | Estimates Customer Lifetime Value proxy based on purchase frequency and average spend. |
| **`MoMGrowth%`** | Time-intelligence calculation evaluating percentage revenue change vs. previous month. |
| **`AvgRevenuePerCustomer`** | Evaluates mean revenue generated per customer profile. |
| **`PurchaseFrequency`** | Tracks average order frequency per customer. |
