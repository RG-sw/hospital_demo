CREATE TABLE some_table (
  id INT PRIMARY KEY NOT NULL,
  int_col INT NOT NULL,
  str_col TEXT NOT NULL,
  bool_col BOOL NOT NULL
);

INSERT INTO
    some_table(id, str_col, int_col, bool_col)
VALUES
    (1, 'foo bar', 42, TRUE),
    (2, 'ObjectRocket Tutorial', 1234, FALSE);