# 🛒 Zepto SQL Analysis Project

This project demonstrates SQL skills applied to a simulated Zepto product dataset using PostgreSQL. It covers data exploration, cleaning, revenue calculation, performance optimization, and role-based access control — ideal for showcasing skills relevant to **Database Administrator (DBA)** or **Data Analyst** roles.

---

## 📂 Project Structure


---

## ✅ Objectives

- Create and manage a structured product database
- Perform data validation and cleaning
- Write meaningful business queries
- Calculate revenue, stock analysis, and category insights
- Manage users and permissions with roles
- Optimize query performance using indexing

---

## 🧱 Schema Definition

**Table**: `zepto`

| Column                | Type         | Description                         |
|-----------------------|--------------|-------------------------------------|
| `sku_id`              | SERIAL       | Primary Key                         |
| `category`            | VARCHAR(120) | Product category                    |
| `name`                | VARCHAR(150) | Product name                        |
| `mrp`                 | NUMERIC(8,2) | Maximum Retail Price                |
| `discountPercent`     | NUMERIC(5,2) | Discount offered (%)                |
| `availableQuantity`   | INTEGER      | Units in inventory                  |
| `discountedSellingPrice` | NUMERIC(8,2) | Final selling price after discount |
| `weightInGms`         | INTEGER      | Weight in grams                     |
| `outofStock`          | BOOLEAN      | Stock status                        |
| `quantity`            | INTEGER      | Quantity sold                       |

---

## 📊 Key SQL Features Used

- **Data Exploration**
  - Row count, sample data, null checks
  - Unique categories, stock status
- **Data Cleaning**
  - Filtering zero MRP entries
  - Converting paise to rupees
- **Analytics**
  - Revenue by category
  - Top discounts, inventory by weight
  - Best-value products and pricing per gram
- **Permissions**
  - Created roles: `analyst`, `editor`
  - Granted selective access control
- **Performance Optimization**
  - Added indexes on `outofStock`, `category`, `name`
  - Table size monitoring

---

## 📈 Sample Business Questions Answered

- What are the top 10 discounted products?
- Which products are high MRP but out of stock?
- Which category has the highest estimated revenue?
- What’s the total inventory weight per category?

---

## 🔐 Roles & Permissions

```sql
CREATE ROLE analyst LOGIN PASSWORD 'analystpass';
GRANT SELECT ON zepto TO analyst;

CREATE ROLE editor LOGIN PASSWORD 'editorpass';
GRANT SELECT, UPDATE ON zepto TO editor;


