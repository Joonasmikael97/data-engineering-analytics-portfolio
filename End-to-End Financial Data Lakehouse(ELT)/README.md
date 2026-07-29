<h1>End-to-End Financial Data Lakehouse (ELT)</h1>

<p>This project demonstrates an automated cloud data lakehouse architecture that ingests daily stock market transactions, processes them via a Medallion architecture using Azure Databricks, and serves the curated data to a Power BI executive dashboard.</p>

<h2>Repository Structure</h2>

<pre><code>📁 End-to-End Financial Data Lakehouse(ELT)/
├── 📁 images
├── 📁 schemas
├── 📁 pbix 
└── README.md
</code></pre>

<h2>Project Overview</h2>

<p>The goal is to simulate a real-world financial data platform capable of highly reliable, daily data ingestion and executive reporting:</p>
<ol>
    <li>Ingest daily stock market data from the Finnhub REST API using a single-day fetch.</li>
    <li>Extract the data, Load it into a raw storage layer, and Transform it through Medallion architecture (Bronze, Silver, Gold).</li>
    <li>Process lightweight, daily increments to optimize compute performance and eliminate the need for complex upserts.</li>
    <li>Serve a clean star-schema model directly to Power BI for real-time reporting.</li>
</ol>

<p><strong>Business use case:</strong> Enable financial analysts and executives to track real-time market intelligence, daily return metrics, and cross-company stock volatility in a centralized Bloomberg-style terminal.</p>

<hr>

<h2>Architecture</h2>

<p>Core services used:</p>
<ul>
    <li><strong>Finnhub API</strong> &rarr; Source of daily stock quotes and market data.</li>
    <li><strong>Azure Databricks</strong> &rarr; Compute engine for data processing (PySpark).</li>
    <li><strong>Delta Lake</strong> &rarr; Storage format providing ACID transactions for the Lakehouse.</li>
    <li><strong>Power BI</strong> &rarr; Data visualization and DAX metric engine.</li>
</ul>

<h3>Architecture Diagram</h3>

```mermaid
flowchart LR
    %% Define Styles
    classDef api fill:#f9f9f9,stroke:#333,stroke-width:2px;
    classDef databricks fill:#f3f1fa,stroke:#663399,stroke-width:2px;
    classDef storage fill:#e1f5fe,stroke:#0288d1,stroke-width:2px;
    classDef pbi fill:#fff3e0,stroke:#f57c00,stroke-width:2px;

    %% Source Layer
    subgraph Source [Data Source]
        A[Finnhub REST API<br>Live Market Data]:::api
    end

    %% Data Lakehouse Layer (Databricks)
    subgraph Lakehouse [Azure Databricks - Medallion Architecture]
        direction LR
        B[(Bronze Zone<br>Raw JSON Delta Table)]:::storage
        C[(Silver Zone<br>Cleaned & Filtered)]:::storage
        D[(Gold Zone<br>Star Schema / Aggregated)]:::storage
        
        B -- Transform<br>(PySpark) --> C
        C -- Model<br>(Fact & Dim) --> D
    end

    %% Presentation Layer
    subgraph BI [Analytics & Reporting]
        E[Power BI<br>Executive Dashboard]:::pbi
    end

    %% Connections
    A -- Extract & Load<br>Daily Batch --> B
    D -- Direct Query / Import --> E
```

<h3>1. Extract (Finnhub API &rarr; Raw Data)</h3>
<ul>
    <li><strong>Action:</strong> The <code>Extract</code> script fetches a single day of JSON payload data from the Finnhub API for selected stock tickers.</li>
    <li><strong>Purpose:</strong> Pulls the daily market telemetry efficiently, focusing exclusively on the current day's performance metrics.</li>
</ul>

<h3>2. Load (Raw Data &rarr; Bronze)</h3>
<ul>
    <li><strong>Action:</strong> The <code>Load</code> script lands the extracted JSON data into a Delta Bronze table without any modifications.</li>
    <li><strong>Purpose:</strong> Acts as the raw, append-only landing zone in the data lakehouse, preserving historical API responses in their original format.</li>
</ul>

<h3>3. Transform (Bronze &rarr; Silver &rarr; Gold)</h3>
<ul>
    <li><strong>Action:</strong> The <code>Transform</code> script reads the Bronze table, standardizes column names, enforces data types, and structures the data into a final Star Schema (Fact and Dimension tables).</li>
    <li><strong>Purpose:</strong> Cleanses data and shapes it into dimensional models ready for Power BI consumption, processing daily batches cleanly without requiring complex <code>MERGE</code> (upsert) logic.</li>
</ul>

<h3>4. Dependency Gate (Databricks Workflows)</h3>

<ul>
    <li><strong>Action:</strong> Databricks orchestrates the scripts sequentially on a strict Cron schedule (<code>0 30 16 ? * MON-FRI</code>).</li>
    <li><strong>Purpose:</strong> Runs daily at 16:30 EST (30 minutes after US market close) to guarantee all final trade settlements are captured and loaded in correct sequential order.</li>
</ul>
<img src="./images/ScheduledPipeline.png" alt="workflow" width="600">

<h3>5. Analytics &amp; Visualization (Power BI)</h3>
<ul>
    <li><strong>Action:</strong> Power BI connects to the Gold Delta tables.</li>
    <li><strong>Purpose:</strong> Transforms the cleaned Star Schema into a dark-themed financial dashboard utilizing dynamic DAX measures for daily returns and maximum ingested date indicators.</li>
</ul>

<hr>

<h2>Data Layer</h2>

<p><strong>Source Dataset</strong></p>
<ul>
    <li>Live REST API payload containing real-time metrics: <code>current_price</code>, <code>previous_close</code>, <code>day_high</code>, <code>day_low</code>, and <code>fetched_at</code> timestamp.</li>
</ul>

<p><strong>Dataset Size &amp; Scope</strong></p>
<ul>
    <li><strong>Volume:</strong> Highly scalable; fetching 1-day windows for a portfolio of tech stocks (e.g., AAPL, MSFT, TSLA).</li>
    <li><strong>Format:</strong> API JSON &rarr; Delta Parquet.</li>
</ul>

<p><strong>Why Use Single-Day Ingestion?</strong></p>
<p>By fetching only a single day's data instead of overlapping historical windows, the pipeline becomes lightweight and highly performant. It eliminates the need for complex <code>MERGE</code> logic in the Delta tables, significantly reducing cloud compute overhead and execution time while still providing accurate, day-to-day market intelligence.</p>

<hr>

<h2>Data Processing (Databricks Medallion Architecture)</h2>

<p>The pipeline separates data processing into three distinct zones, maximizing data governance and traceability:</p>

<ol>
    <li><strong>Bronze (Raw):</strong> Append-only layer. Retains all historical API responses without alteration.</li>
    <li><strong>Silver (Cleansed):</strong> Filtered and standardized. Datetime logic and basic transformations are applied here.</li>
    <li><strong>Gold (Business-Level):</strong> Aggregated and structured specifically for Power BI consumption (<code>dim_company</code> and <code>fact_stock_quotes</code>).</li>
</ol>

<hr>

<h2>Orchestration (Databricks Workflows)</h2>

<p>The job execution sequence runs through the configured files:</p>
<img src="./images/workflow.png" alt="workflow" width="600">
<ul>
    <li><strong>Task 1:</strong> Execute <code>Extract</code>.</li>
    <li><strong>Task 2:</strong> Execute <code>Load</code> (Depends on Task 1).</li>
    <li><strong>Task 3:</strong> Execute <code>Transform</code> (Depends on Task 2).</li>
</ul>

<p>By orchestrating natively in Databricks, the cluster spins up automatically, executes the ETL/ELT pipeline in under a few minutes, and immediately terminates to save cloud compute costs.</p>

<hr>

<h2>Data Warehouse Modeling (Gold Layer)</h2>

<p>The analytical data model uses a standard Star Schema to ensure high performance in Power BI:</p>

<ul>
    <li><strong>Dimension Table (<code>dim_company</code>):</strong> Contains static details about the tracked entities (e.g., <code>ticker</code>, <code>company_name</code>, <code>sector</code>).</li>
    <li><strong>Fact Table (<code>fact_stock_quotes</code>):</strong> Contains the rapidly changing daily telemetry (prices, daily returns) linked via <code>ticker</code>.</li>
</ul>

<hr>

<h2>Dashboard Showcase</h2>

<p>The Power BI report is styled as a professional Executive Market Intelligence Dashboard.</p>

<p><strong>Key Features:</strong></p>
<ul>
    <li><strong>Dynamic Time Intelligence:</strong> Uses Relative Date slicers that automatically shift forward as the pipeline updates daily.</li>
    <li><strong>Advanced DAX:</strong> Measures dynamically calculate <code>Latest Price</code> and <code>Daily Return %</code> based on the maximum ingested date.</li>
    <li><strong>UI/UX:</strong> Organized into three distinct zones: high-level KPI cards, a primary trend line chart for time-series analysis, and a detailed cross-company comparison matrix.</li>
</ul>

<p><em>(Insert Dashboard Screenshot Here)</em></p>
