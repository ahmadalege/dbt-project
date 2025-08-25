# 📊 TheLook eCommerce Data Transformation with dbt

This dbt (data build tool) project transforms raw data from the **thelook_ecommerce** dataset into a clean, reliable, and analytics-ready data model. It follows a layered approach (**Staging**, **Intermediate**, **Marts**) to ensure data quality, consistency, and ease of use for downstream reporting and analysis.

## 🚀 Project Purpose

The primary goal of this project is to provide a robust data foundation for analyzing eCommerce operations from the **thelook_ecommerce** dataset. This includes:

- **Standardizing Raw Data**: Cleaning and renaming source columns to ensure consistency.
- **Implementing Business Logic**: Creating reusable intermediate datasets for complex transformations and calculations.
- **Building Analytics-Ready Tables**: Delivering user-friendly dimension and fact tables optimized for BI and reporting tools.
- **Ensuring Data Quality**: Applying comprehensive tests to validate data integrity, uniqueness, and completeness at every layer.
- **Generating Documentation**: Providing clear, browsable documentation of the entire data model, including lineage and column definitions.

## 📦 Data Source

The project utilizes data from the **thelook_ecommerce** dataset, typically hosted on **Google BigQuery**. This dataset contains information on orders, products, users, events, inventory, and distribution centers related to an online retail store.

## 🏗️ Data Model Overview

The project adheres to a **three-layer data modeling architecture**:

### 1. Staging Layer (`stg_`)

- **Purpose**: Direct selections from raw source tables. Focuses on light cleaning, standardization (e.g., aliasing `id` to `product_id` or `user_id`), and basic data type casting. This layer mirrors the source system's schema with minor enhancements for consistency.
- **Materialization**: _Views_ (fast to build, always fresh data).
- **Key Models**:
  - `stg_ecommerce__orders`
  - `stg_ecommerce__products`
  - `stg_ecommerce__users`
  - `stg_ecommerce__order_items`
  - `stg_ecommerce__events`
  - `stg_ecommerce__inventory_items`
  - `stg_ecommerce__distribution_centers`

### 2. Intermediate Layer (`int_`)

- **Purpose**: Implements complex business logic, joins multiple staging tables, and performs aggregations that are reusable across various mart models. These models are not typically for direct consumption but serve as building blocks.
- **Materialization**: _Tables_ (better query performance for complex, frequently accessed data).
- **Key Models**:
  - `int_order_product_details` → combines order and product info
  - `int_user_order_summary` → aggregates user order data
  - `int_product_inventory_details` → links products to inventory
  - `int_user_event_stream` → enriches user events
  - `int_daily_product_sales` → summarizes daily product sales

### 3. Marts Layer (Final / Presentation Layer)

- **Purpose**: Provides highly denormalized, business-centric tables (dimension and fact tables) optimized for direct consumption by BI tools, dashboards, and analytics teams. This layer is designed for business-friendly exploration.
- **Materialization**: _Tables_ (optimizing for reporting performance).
- **Key Models**:
  - `dim_users`: A comprehensive view of all users with their demographics and aggregated order summary.
  - `dim_products`: Detailed information about each product, including cost and retail price.
  - `fct_orders`: Key metrics and attributes for each individual order, including revenue, profit, and discount.

## 🔗 Data Lineage and Dependencies

dbt automatically builds a **Directed Acyclic Graph (DAG)**, visualizing the lineage and dependencies between all models, sources, and tests in this project. This allows for transparent understanding of how data flows from its raw state through each transformation layer to the final analytical tables. You can explore this using:

```bash
dbt docs serve
```

## ✅ Data Quality & Testing

This project emphasizes robust data quality through extensive, automated testing at every layer, utilizing:

- **dbt's Built-in Tests**:  
  Fundamental checks like `not_null` (ensuring no missing values), `unique` (ensuring primary key integrity), `accepted_values` (validating categorical data), and `relationships` (enforcing referential integrity between tables).

- **dbt_utils Package**:  
  Provides advanced generic tests such as `expression_is_true` (validating custom SQL conditions like `amount >= 0`) and `at_least_one` (ensuring a column has at least one non-null value).

- **dbt-expectations Package**:  
  Offers a richer suite of data quality checks, including `expect_column_values_to_be_between` (for numeric ranges), `expect_column_values_to_match_regex` (for pattern validation like email formats), `expect_column_values_to_be_of_type` (for data type validation), and `expect_fk_column_values_to_be_in_sk_column` (for comprehensive foreign key checks).

## ⚙️ Setup and Installation

1. **Clone the Repository**:

```bash
git clone https://github.com/ahmadalege/dbt-project.git
cd dbt_project
```

2. **Install dbt**:

```bash
pip install dbt-bigquery
```

3. **Configure profiles.yml**
   Set up your connection to your data warehouse in your ~/.dbt/profiles.yml file. Ensure the profile name matches profile: "dbt_project" defined in dbt_project.yml.

4. **Install dbt Packages**

```bash
dbt deps
```

(This command reads packages.yml and installs dbt_utils and dbt_expectations into your dbt_packages folder).

## ▶️ Running the Project

Navigate to the root of your dbt project in your terminal.

**Compile SQL** (generates executable SQL):

```bash
dbt compile
```

**Build all models** (runs transformations and materializes tables/views):

```bash
dbt run
```

**Run all tests** (executes data quality checks):

```bash
dbt test
```

**Build and test everything** (combines `dbt run` and `dbt test`):

```bash
dbt build
```

**Select specific models or layers**:

```bash
# Run a specific model and its downstream dependencies
dbt run --select stg_ecommerce__orders+

# Run tests only on the intermediate layer
dbt test --select intermediate
```

## 📖 Documentation

Generate and explore interactive documentation for your project locally:

1. **Generate Docs**:

```bash
dbt docs generate
```

2. **Serve Docs Locally**:

```bash
dbt docs serve
```

## 🤝 Contribution and Support

Contributions, feedback, and suggestions are welcome! Please feel free to open issues or pull requests to improve this project.

You can also read a related article on **Modern Data Transformation with dbt** [here](https://medium.com/@alegeahmadolaitan/modern-data-transformation-with-dbt-a-guide-for-analysts-and-engineers-47d0fb007201).

For any questions or support, please refer to the [dbt documentation](https://docs.getdbt.com/) or reach out to the project maintainers.
