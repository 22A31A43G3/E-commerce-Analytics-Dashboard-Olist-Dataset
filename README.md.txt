# E-commerce Analytics Dashboard (SQL + Power BI)

## Project Overview
This project is an end-to-end E-commerce analytics solution built using the Olist Brazilian E-commerce dataset.  
The objective is to transform raw transactional data into meaningful business insights for decision-makers using SQL and Power BI.

The project covers the complete analytics lifecycle:  
**Data Ingestion → Data Cleaning → Data Modeling → KPI Creation → Dashboarding → Business Insights**

## Business Objectives
The dashboard answers the following business questions:

**Revenue & Growth**  
- What is the total revenue generated from delivered orders?  
- How does revenue trend monthly and yearly?  
- Which payment methods contribute most to revenue?  

**Customer & Satisfaction**  
- How does delivery performance affect customer reviews?  
- What percentage of orders are delivered late?  
- How do review scores vary by order status and month?  

**Product & Demand**  
- Which product categories generate the highest revenue?  
- Which categories show low demand and low revenue?  
- What products have the highest quantity sold?  

**Logistics & Delivery**  
- Early vs On-time vs Late delivery distribution  
- Comparison of actual delivery days vs estimated delivery days  
- Impact of delivery delays on customer satisfaction  

## Dataset
- **Source:** Olist Brazilian E-commerce Dataset (Kaggle)  
- **Data Type:** Real-world transactional data  
- **Total Records:** ~100k orders  
- **Key Tables Used:**  
  - orders  
  - order_items  
  - order_payments  
  - order_reviews  
  - customers  
  - products  
  - sellers  
  - geolocation  
  - category_translation  

## Data Ingestion
- Most datasets were ingested using SQL.  
- The geolocation dataset was ingested using Python (Pandas + SQLAlchemy) due to file size and encoding constraints.  
- This hybrid approach ensures reliable and scalable ingestion.  

## Data Cleaning & Transformation (SQL)
- Converted invalid date strings to proper datetime formats  
- Handled empty strings and NULL values explicitly  
- Filtered revenue calculations to delivered orders only  
- Created derived columns:  
  - Delivery days  
  - Estimated delivery days  
  - Delivery status (Early / On-time / Late)  
  - Combined price and freight for realistic revenue analysis  
- Validated duplicates and missing values before modeling  

## Data Modeling (Power BI)
- Orders used as the primary fact table (order-level grain)  
- Order_items treated as a separate item-level fact table  
- Star-schema based design  
- Removed fact-to-fact relationships  
- Single-direction relationships to avoid ambiguity  

This design ensures:  
- No ambiguous filter paths  
- Accurate aggregations  
- Interview-ready and scalable data model  

## Key KPIs
- Total Revenue (Delivered Orders)  
- Total Orders  
- % Late Deliveries  
- Average Review Score  
- Monthly Revenue Trend  
- Revenue by Payment Method  
- Top & Bottom Product Categories  
- Customer Satisfaction Distribution  

## Dashboard Pages
- **Executive Summary:** Revenue, orders, delivery performance  
- **Customer Analysis:** Reviews, satisfaction, delivery impact  
- **Product Analysis:** Revenue, demand, top & bottom categories  
- **Geographic Analysis:** Revenue and demand by city and state  

## Key Insights
- Total revenue generated is 15.2M from delivered orders  
- Peak revenue occurs in August, with a noticeable drop in September  
- Revenue shows a consistent year-over-year increase  
- Credit card is the most preferred payment method  
- Delivery performance is strong, with most orders delivered earlier than estimated  
- March records the lowest average review score (3.80) and lowest customer satisfaction (0.71)  
- Health & Beauty and Watches & Gifts generate the highest revenue  
- Bed Bath Table and Health & Beauty have the highest quantity demand  
- São Paulo and Rio de Janeiro contribute the highest revenue geographically  

## Recommendations
- Expand product offerings and marketing focus on Health & Beauty and Watches & Gifts categories  
- Optimize promotions or reassess low-performing categories such as Security & Devices and Fashion Children Clothing  
- Increase production capacity for high-demand categories like Bed Bath Table and Health & Beauty  
- Investigate operational issues causing lower customer satisfaction in March  
- Focus expansion strategies on high-revenue regions such as São Paulo (SP) and Rio de Janeiro (RJ)  

## Tools & Technologies
- SQL (MySQL) – Data cleaning, transformation, analysis  
- Python (Pandas, SQLAlchemy) – Data ingestion  
- Power BI – Data modeling, DAX, visualization  
- DAX – KPI creation  
- GitHub – Version control and documentation  

## Project Structure
/sql       → SQL scripts for cleaning and transformation  
/python    → Python scripts for data ingestion  
/screenshots → Dashboard images  
/docs      → Business notes and insights  

## Power BI Dashboard

### Executive Overview
![Executive Overview](Screenshots\powerbi_excutive_overview.png)

### Executive Overview
![Revenue and Growth](Screenshots\powerbi_revenue_and_growth.png)

### Customer Analysis
![Customer Analysis](Screenshots/powerbi_customer_analysis.png)

### Product Analysis
![Product Analysis](Screenshots/powerbi_product_analysis.png)

### Geographic Analysis
![Geographic Analysis](Screenshots/powerbi_geo_analysis.png)

### Data Model
![Power BI Data Model](Screenshots/powerbi_data_model.png)


**Vamsi Krishna Penke**  
Aspiring Data Analyst  
Skills: SQL | Power BI | Python  

LinkedIn:  [www.linkedin.com/in/penkevamsikrishna](www.linkedin.com/in/penkevamsikrishna)  
Power BI Dashboard: [Link](https://pragatiengg-my.sharepoint.com/:u:/g/personal/22a31a43g3_pragati_ac_in/IQBIXSItF5FfSbu4EwAJ1D3IAdD9CO2niIhezfVyI62wXm0?e=t8BmPs)