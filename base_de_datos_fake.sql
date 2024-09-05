-- -----------------------------------------------------
-- Table "users"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  gmail VARCHAR(100),
  password VARCHAR(100),
  type VARCHAR(10) CHECK (type IN ('public', 'admin')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- -----------------------------------------------------
-- Table "clients"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS clients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  lastname VARCHAR(100),
  dni VARCHAR(8),
  phone_number VARCHAR(15),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- -----------------------------------------------------
-- Table "user_clients"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS user_clients (
  users_id INT NOT NULL,
  client_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  CONSTRAINT fk_public_user_client_users FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_public_user_client_clients FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table "admins"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS admins (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  lastname VARCHAR(100),
  dni VARCHAR(8),
  phone_number VARCHAR(15),
  birthdate DATE,
  state VARCHAR(50),
  users_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  CONSTRAINT fk_admins_users FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table "roles"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS roles (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- -----------------------------------------------------
-- Table "permission"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS permission (
  id SERIAL PRIMARY KEY,
  view VARCHAR(100),
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- -----------------------------------------------------
-- Table "user_roles"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS user_roles (
  users_id INT NOT NULL,
  roles_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_user_roles_users FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_user_roles_roles FOREIGN KEY (roles_id) REFERENCES roles (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table "role_permission"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS role_permission (
  roles_id INT NOT NULL,
  permission_id INT NOT NULL,
  CONSTRAINT fk_role_permission_roles FOREIGN KEY (roles_id) REFERENCES roles (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_role_permission_permission FOREIGN KEY (permission_id) REFERENCES permission (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table "states"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS states (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- -----------------------------------------------------
-- Table "orders"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  users_id INT NOT NULL,
  client_id INT NOT NULL,
  states_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  CONSTRAINT fk_orders_users FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_orders_clients FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_orders_states FOREIGN KEY (states_id) REFERENCES states (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table "category"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS category (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- -----------------------------------------------------
-- Table "models"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS models (
  id SERIAL PRIMARY KEY,
  category_id INT NOT NULL,
  name VARCHAR(100),
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  CONSTRAINT fk_models_category FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table "size"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS size (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- -----------------------------------------------------
-- Table "model_size"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS model_size (
  id SERIAL PRIMARY KEY,
  models_id INT NOT NULL,
  size_id INT NOT NULL,
  description VARCHAR(255),
  price DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  CONSTRAINT fk_model_size_models FOREIGN KEY (models_id) REFERENCES models (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_model_size_size FOREIGN KEY (size_id) REFERENCES size (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table "colors"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS colors (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  hex VARCHAR(7),
  rgb VARCHAR(20),
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- -----------------------------------------------------
-- Table "unit_measure"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unit_measure (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- -----------------------------------------------------
-- Table "embroidery"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS embroidery (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  description VARCHAR(255),
  route VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- -----------------------------------------------------
-- Table "order_models"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS order_models (
  id SERIAL PRIMARY KEY,
  orders_id INT NOT NULL,
  models_id INT NOT NULL,
  size_id INT NOT NULL,
  quantity INT,
  unit_measure_id INT NOT NULL,
  embroidery_id INT NOT NULL,
  deadline TIMESTAMP,
  place_delivery VARCHAR(255),
  states_id INT NOT NULL,
  shipping_description VARCHAR(255),
  users_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  CONSTRAINT fk_order_models_orders FOREIGN KEY (orders_id) REFERENCES orders (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_order_models_models FOREIGN KEY (models_id) REFERENCES models (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_order_models_size FOREIGN KEY (size_id) REFERENCES size (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_order_models_unit_measure FOREIGN KEY (unit_measure_id) REFERENCES unit_measure (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_order_models_embroidery FOREIGN KEY (embroidery_id) REFERENCES embroidery (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_order_models_states FOREIGN KEY (states_id) REFERENCES states (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_order_models_users FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table "order_model_colors"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS order_model_colors (
  id SERIAL PRIMARY KEY,
  order_models_id INT NOT NULL,
  colors_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP,
  CONSTRAINT fk_model_order_color_model_order1 FOREIGN KEY (order_models_id) REFERENCES order_models (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_model_order_color_colors1 FOREIGN KEY (colors_id) REFERENCES colors (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table "model_color"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS model_color (
  models_id INT NOT NULL,
  colors_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_model_color_models1 FOREIGN KEY (models_id) REFERENCES models (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_model_color_colors1 FOREIGN KEY (colors_id) REFERENCES colors (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table products
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  models_id INT NOT NULL,
  colors_id INT NOT NULL,
  size_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_measure_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
  deleted_at TIMESTAMP,
  CONSTRAINT fk_products_models1 FOREIGN KEY (models_id) REFERENCES models (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_products_colors1 FOREIGN KEY (colors_id) REFERENCES colors (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_products_size1 FOREIGN KEY (size_id) REFERENCES size (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_products_unit_measure1 FOREIGN KEY (unit_measure_id) REFERENCES unit_measure (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table movement
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS movement (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP 
);

-- -----------------------------------------------------
-- Table reason
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS reason (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NULL,
  description VARCHAR(255),
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL 
);

-- -----------------------------------------------------
-- Table product_movement
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product_movement (
  id SERIAL PRIMARY KEY,
  movement_id INT NOT NULL,
  products_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_measure_id INT NOT NULL,
  users_id INT NOT NULL,
  reason_id INT NOT NULL,
  description VARCHAR(255),
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  CONSTRAINT fk_product_movement_movement1 FOREIGN KEY (movement_id) REFERENCES movement (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_product_movement_products1 FOREIGN KEY (products_id) REFERENCES products (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_product_movement_unit_measure1 FOREIGN KEY (unit_measure_id) REFERENCES unit_measure (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_product_movement_reason1 FOREIGN KEY (reason_id) REFERENCES reason (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_product_movement_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table product_division
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product_division (
  id SERIAL PRIMARY KEY,
  products_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_measure_id INT NOT NULL,
  users_id INT NOT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  CONSTRAINT fk_product_division_products1 FOREIGN KEY (products_id) REFERENCES products (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_product_division_unit_measure1 FOREIGN KEY (unit_measure_id) REFERENCES unit_measure (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_product_division_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table sales
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS sales (
  id SERIAL PRIMARY KEY,
  price DECIMAL(10, 2) NOT NULL,
  users_id INT NOT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  CONSTRAINT fk_sales_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table sales_details
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS sales_details (
  id SERIAL PRIMARY KEY,
  sales_id INT NOT NULL,
  models_id INT NOT NULL,
  colors_id INT NOT NULL,
  size_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_measure_id INT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  CONSTRAINT fk_sales_details_sales1 FOREIGN KEY (sales_id) REFERENCES sales (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_sales_details_models1 FOREIGN KEY (models_id) REFERENCES models (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_sales_details_colors1 FOREIGN KEY (colors_id) REFERENCES colors (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_sales_details_size1 FOREIGN KEY (size_id) REFERENCES size (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_sales_details_unit_measure1 FOREIGN KEY (unit_measure_id) REFERENCES unit_measure (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table places_times_sales
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS places_times_sales (
  id SERIAL PRIMARY KEY,
  place VARCHAR(100) NULL,
  day VARCHAR(10) NULL,
  time TIME NULL,
  users_id INT NOT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  CONSTRAINT fk_places_times_sales_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table financial_movements
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS financial_movements (
  id SERIAL PRIMARY KEY,
  amount DECIMAL(10, 2) NULL,
  movement_id INT NOT NULL,
  users_id INT NOT NULL,
  reason_id INT NOT NULL,
  description VARCHAR(255),
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  CONSTRAINT fk_financial_movement_reason1 FOREIGN KEY (reason_id) REFERENCES reason (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_financial_movements_movement1 FOREIGN KEY (movement_id) REFERENCES movement (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_financial_movements_users1 FOREIGN KEY (users_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
