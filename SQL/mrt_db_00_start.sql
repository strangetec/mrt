-- Starting scripts

---- Create MRT_INFO Schema ----
CREATE SCHEMA IF NOT EXISTS MRT_INFO;

---- Create MRT_ADMIN User ----
CREATE USER IF NOT EXISTS MRT_ADMIN PASSWORD '<password>' ADMIN;