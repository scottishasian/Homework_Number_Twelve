DROP TABLE IF EXISTS bounty_info;

CREATE TABLE bounty_info (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  homeworld VARCHAR(255),
  bounty_value INT8
);
