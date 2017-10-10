DROP TABLE IF EXISTS bounty_info;

CREATE TABLE bounty_info (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  bouty_value INT8,
  homeworld VARCHAR(255)
);
