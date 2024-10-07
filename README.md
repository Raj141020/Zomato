# Zomato-like Restaurant Data Analysis

This project involves analyzing restaurant data from a platform similar to **Zomato**, with a focus on extracting valuable insights using **SQL** and **database management** techniques. The goal is to perform various data operations such as creating, modifying, and deleting tables, while analyzing data to generate meaningful reports. The project demonstrates proficiency in SQL, database triggers, and advanced querying methods.

## Key Features

### 1. Database Setup
- The project includes setting up multiple tables, simulating a real-world restaurant data structure:
  - **Restaurants**
  - **Customers**
  - **Orders**
  - **Reviews**
  - And more...
  
### 2. Data Analysis Queries
- A variety of SQL queries are implemented to analyze:
  - **Restaurant performance** (e.g., revenue, orders, ratings).
  - **Customer behavior** (e.g., most frequent customers, favorite cuisines).
  - **Review trends** (e.g., average ratings, top-rated restaurants).

### 3. Data Deletion Logging
- A trigger is created to log deleted order data into a `DeletedOrders` table. This ensures that any deleted data can be recovered, simulating a "soft delete" mechanism where no information is permanently lost.

### 4. Efficient Data Management
- **Data insertion**, **updates**, and **deletion** are performed efficiently while maintaining referential integrity through **foreign keys** and **constraints**.

### 5. Performance Optimization
- Techniques such as **indexing** and **query optimization** are applied to ensure smooth performance, even with large datasets.

## Technologies Used

- **SQL Server**: Database management and querying.
- **SQL**: For data manipulation, data analysis, and query execution.

## How to Use

1. Set up the database:
   - Run the SQL scripts in the `/scripts` folder to create the required tables (Restaurants, Customers, Orders, Reviews, etc.) and insert the initial dataset.
   
2. Execute the SQL queries:
   - The SQL queries for data analysis are provided in the `/queries` folder.
   - You can modify or run these queries to analyze different aspects of the restaurant data.

3. Monitor Deleted Data:
   - The trigger for logging deleted orders is included in the `/triggers` folder. 
   - Any deleted orders will be logged into the `DeletedOrders` table.

## Getting Started

### Prerequisites
- **SQL Server** or a compatible SQL database management system.
- Basic knowledge of **SQL**.

### Installation
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/zomato-restaurant-data-analysis.git

