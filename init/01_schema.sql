CREATE SCHEMA IF NOT EXISTS lab;
SET search_path TO lab, public;

DROP TABLE IF EXISTS fact_sales CASCADE;
DROP TABLE IF EXISTS dim_date CASCADE;
DROP TABLE IF EXISTS dim_store CASCADE;
DROP TABLE IF EXISTS dim_supplier CASCADE;
DROP TABLE IF EXISTS dim_product CASCADE;
DROP TABLE IF EXISTS dim_seller CASCADE;
DROP TABLE IF EXISTS dim_customer CASCADE;
DROP TABLE IF EXISTS all_mock_data CASCADE;

CREATE TABLE all_mock_data (
  id TEXT,
  customer_first_name TEXT,
  customer_last_name TEXT,
  customer_age TEXT,
  customer_email TEXT,
  customer_country TEXT,
  customer_postal_code TEXT,
  customer_pet_type TEXT,
  customer_pet_name TEXT,
  customer_pet_breed TEXT,
  seller_first_name TEXT,
  seller_last_name TEXT,
  seller_email TEXT,
  seller_country TEXT,
  seller_postal_code TEXT,
  product_name TEXT,
  product_category TEXT,
  product_price TEXT,
  product_quantity TEXT,
  sale_date TEXT,
  sale_customer_id TEXT,
  sale_seller_id TEXT,
  sale_product_id TEXT,
  sale_quantity TEXT,
  sale_total_price TEXT,
  store_name TEXT,
  store_location TEXT,
  store_city TEXT,
  store_state TEXT,
  store_country TEXT,
  store_phone TEXT,
  store_email TEXT,
  pet_category TEXT,
  product_weight TEXT,
  product_color TEXT,
  product_size TEXT,
  product_brand TEXT,
  product_material TEXT,
  product_description TEXT,
  product_rating TEXT,
  product_reviews TEXT,
  product_release_date TEXT,
  product_expiry_date TEXT,
  supplier_name TEXT,
  supplier_contact TEXT,
  supplier_email TEXT,
  supplier_phone TEXT,
  supplier_address TEXT,
  supplier_city TEXT,
  supplier_country TEXT
);

CREATE TABLE dim_customer (
  customer_id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  age INT,
  email TEXT,
  country TEXT,
  postal_code TEXT,
  pet_type TEXT,
  pet_name TEXT,
  pet_breed TEXT
);

CREATE TABLE dim_seller (
  seller_id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  email TEXT,
  country TEXT,
  postal_code TEXT
);

CREATE TABLE dim_product (
  product_id SERIAL PRIMARY KEY,
  product_name TEXT,
  category TEXT,
  brand TEXT,
  material TEXT,
  color TEXT,
  size TEXT,
  pet_category TEXT,
  weight_kg NUMERIC(12,3),
  description TEXT,
  release_date DATE,
  expiry_date DATE
);

CREATE TABLE dim_store (
  store_id SERIAL PRIMARY KEY,
  store_name TEXT,
  location TEXT,
  city TEXT,
  state TEXT,
  country TEXT,
  phone TEXT,
  email TEXT
);

CREATE TABLE dim_supplier (
  supplier_id SERIAL PRIMARY KEY,
  supplier_name TEXT,
  contact TEXT,
  email TEXT,
  phone TEXT,
  address TEXT,
  city TEXT,
  country TEXT
);

CREATE TABLE dim_date (
  date_id SERIAL PRIMARY KEY,
  d DATE UNIQUE
);

CREATE TABLE fact_sales (
  sale_id BIGSERIAL PRIMARY KEY,
  date_id INT NOT NULL REFERENCES dim_date(date_id),
  customer_id INT NOT NULL REFERENCES dim_customer(customer_id),
  seller_id INT NOT NULL REFERENCES dim_seller(seller_id),
  product_id INT NOT NULL REFERENCES dim_product(product_id),
  store_id INT NOT NULL REFERENCES dim_store(store_id),
  supplier_id INT NOT NULL REFERENCES dim_supplier(supplier_id),
  unit_price NUMERIC(12,2) NOT NULL,
  quantity INT NOT NULL,
  total_price NUMERIC(14,2) NOT NULL,
  product_rating NUMERIC(4,2),
  product_reviews INT
);

CREATE UNIQUE INDEX ux_dim_customer_expr
  ON dim_customer (first_name, last_name, (COALESCE(email,'')));

CREATE UNIQUE INDEX ux_dim_seller_expr
  ON dim_seller (first_name, last_name, (COALESCE(email,'')));

CREATE UNIQUE INDEX ux_dim_product_expr
  ON dim_product (product_name, (COALESCE(brand,'')), (COALESCE(category,'')));

CREATE UNIQUE INDEX ux_dim_store_expr
  ON dim_store (store_name, (COALESCE(city,'')), (COALESCE(country,'')));

CREATE UNIQUE INDEX ux_dim_supplier_expr
  ON dim_supplier (supplier_name, (COALESCE(email,'')));

CREATE INDEX ix_fact_date     ON fact_sales(date_id);
CREATE INDEX ix_fact_customer ON fact_sales(customer_id);
CREATE INDEX ix_fact_seller   ON fact_sales(seller_id);
CREATE INDEX ix_fact_product  ON fact_sales(product_id);
CREATE INDEX ix_fact_store    ON fact_sales(store_id);
CREATE INDEX ix_fact_supplier ON fact_sales(supplier_id);
