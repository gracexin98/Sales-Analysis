# High-Value Customer Targeting – RFM Analysis

## Project Goal
The RFM analysis is an effective marketing segmentation method to gain insight into customer behavior. In the exploratory data analysis, I calculated three indexes for the RFM model, which are recency, frequency, and monetary value. Combining those three indexes, I generate important customer insights and improve our segmentation strategy using Tableau visualization.

## Data
The dataset tracks 2,823 customer orders over 3 years, 19 countries, recording their purchase date, expenditure, and quantity bought.

## Step One : Data wrangling
In this step , I clean the raw data by the following steps. </br>
1. Load in the data </br>
2. Detect missing data </br>
3. Manage Date Columns </br>
4. Generate New Columns  (Trips) 

## Step Two : Generate key indexes
I calculate three key indexes for the RFM analysis </br>
Recency : When was a customer’s last purchase? </br>
Frequency : How often does a customer make a purchase? </br>
Monetary Value : How much money does a customer spend on purchases?

## Step Three : Generate Ranking Index
I calculate rank from 1 to 4 for each index, by dividing four equal ranges of percentile.

## Final Data
I finalize the data for the RFM analysis.

## Dashboard Key Findings
From the plots I can discover : </br>
1. Distribution of Rankings </br>
2. Number of orders for each customer </br>
3. Relationship between Recency & Frequency </br>

![alt text](https://github.com/gracexin98/Sales-RFM-Analysis/blob/main/Sales_Dash1.png)


<b>Tableau Dashboard 2</b>
![alt text](https://github.com/gracexin98/Sales-RFM-Analysis/blob/main/Sales_Dash2.png)
