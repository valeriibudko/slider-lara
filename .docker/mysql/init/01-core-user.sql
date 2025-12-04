CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY 'dev';
CREATE USER IF NOT EXISTS 'root'@'%'        IDENTIFIED BY 'dev';
GRANT ALL PRIVILEGES ON slider_lara.* TO 'root'@'localhost';
GRANT ALL PRIVILEGES ON slider_lara.* TO 'root'@'%';
FLUSH PRIVILEGES;
