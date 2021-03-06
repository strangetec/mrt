-- Starting scripts

---- Create MRT_INFO Schema ----
CREATE SCHEMA IF NOT EXISTS MRT_INFO;

---- Create MRT_ADMIN User ----
CREATE USER IF NOT EXISTS MRT_ADMIN PASSWORD '<password>' ADMIN;

---- Create MRT_ADMIN_ROLE, MRT_PERSONNEL_ROLE, MRT_VEHICLE_ROLE, MRT_MISSION_ROLE ----
CREATE ROLE IF NOT EXISTS MRT_ADMIN_ROLE;
CREATE ROLE IF NOT EXISTS MRT_PERSONNEL_ROLE;
CREATE ROLE IF NOT EXISTS MRT_VEHICLE_ROLE;
CREATE ROLE IF NOT EXISTS MRT_MISSION_ROLE;