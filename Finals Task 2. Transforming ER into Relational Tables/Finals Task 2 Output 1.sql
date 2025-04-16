CREATE DATABASE assignment_tracker_db;

CREATE TABLE student_tbl(
username VARCHAR(50) PRIMARY KEY
);

CREATE TABLE assignment_tbl(
shortname VARCHAR(50) PRIMARY KEY,
due_date DATE NOT NULL,
url VARCHAR(255)
);

CREATE TABLE submission_tbl (
    username VARCHAR(50),
    shortname VARCHAR(50),
    sub_version INT,
    submit_date DATE NOT NULL,
    sub_data TEXT,
    PRIMARY KEY (username, shortname, sub_version),
    FOREIGN KEY (username) REFERENCES student_tbl(username),
    FOREIGN KEY (shortname) REFERENCES assignment_tbl(shortname)
);