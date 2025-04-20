Visoko City Services Database Population
This repository contains a PostgreSQL script to populate a database for managing city services, citizens, and community activities in Visoko, Bosnia and Herzegovina. The script generates sample data for addresses, households, citizens, city services, service requests, feedback, clubs, memberships, venues, and community events.
Purpose

The script is designed to:

Create realistic test data for a city services management system.
Populate tables with interdependent data (e.g., citizens linked to households, events linked to venues).
Support testing and development of applications for municipal service tracking.

Database Schema
The database includes the following tables:

addresses: Stores street addresses in Visoko with coordinates.
households: Links households to addresses.
citizens: Stores citizen details (name, birth date, email, phone, household).
city_services: Lists municipal services (e.g., waste collection, street lighting).
service_requests: Tracks citizen requests for services.
citizen_feedback: Stores feedback on services.
citizen_clubs: Lists community clubs.
citizen_club_members: Tracks club memberships.
venues: Stores event locations.
community_events: Lists community events at venues.

Prerequisites

PostgreSQL: Version 10 or higher.
Database: A PostgreSQL database with the above tables created. Ensure tables have appropriate columns and data types (e.g., integer for IDs, text for names, date for dates).
Permissions: Write access to the database.

Sample Schema
Example table structure for service_requests:
CREATE TABLE service_requests (
    citizen_id integer,
    service_id integer,
    request_date date,
    description text,
    status text
);

Run \d table_name in psql to verify each table’s structure.


Set Up Database:

Create a PostgreSQL database:createdb visoko_services


Create tables using your schema definition (not included in this repo).


Copy the Script:

The main script is populate_visoko.sql in the repository root.



Usage

Connect to PostgreSQL:
psql -U your_username -d visoko_services


Run the Script:
\i populate_visoko.sql


Verify Data:After running, check row counts:
SELECT COUNT(*) FROM addresses;          -- ~100
SELECT COUNT(*) FROM households;        -- ~150
SELECT COUNT(*) FROM citizens;          -- ~200
SELECT COUNT(*) FROM city_services;     -- 10
SELECT COUNT(*) FROM service_requests;  -- ~200
SELECT COUNT(*) FROM citizen_feedback;  -- ~200
SELECT COUNT(*) FROM citizen_clubs;     -- 30
SELECT COUNT(*) FROM citizen_club_members; -- ~200
SELECT COUNT(*) FROM venues;            -- 30
SELECT COUNT(*) FROM community_events;  -- ~30



Script Details
The script (populate_visoko.sql) consists of 10 sections:

Addresses: Inserts 100 addresses with street names, city, state, zip code, and random coordinates.
Households: Inserts 150 households, each linked to an address.
Citizens: Inserts 200 citizens with random names, birth dates, emails, phones, and household assignments.
City Services: Inserts 10 municipal services (e.g., waste collection, public transport).
Service Requests: Inserts ~200 service requests, one per citizen, linked to random services.
Citizen Feedback: Inserts ~200 feedback entries for services.
Citizen Clubs: Inserts 30 community clubs.
Club Memberships: Assigns each citizen to a random club (~200 memberships).
Venues: Inserts 30 venues linked to addresses.
Community Events: Inserts 30 events, one per venue.

Notes

Random Data: Uses PostgreSQL’s random() function for dates, coordinates, and selections.
Dependencies: Sections must run in order due to foreign key relationships (e.g., citizens depends on households).
No ON CONFLICT: The script avoids ON CONFLICT to prevent errors from missing unique constraints. To use ON CONFLICT, add constraints like:ALTER TABLE service_requests ADD CONSTRAINT unique_citizen_service UNIQUE (citizen_id, service_id);


![image](https://github.com/user-attachments/assets/9eb75249-9093-4123-a9ea-7064e594c355)



Troubleshooting

Zero Rows Inserted:

Check table schemas (\d table_name) for correct columns and types.
Verify dependencies (e.g., citizens has ~200 rows before running service_requests).
Run debug queries:SELECT COUNT(*) FROM citizens WHERE citizen_id <= 200;
SELECT COUNT(*) FROM city_services;


Ensure you’re running the correct script version (no typos like 200e_id).


Syntax Errors:

If you see errors like column "200e_id" does not exist, ensure you’re using the provided populate_visoko.sql without modifications.
Clear your SQL client’s query buffer before running.


Constraint Errors:

If adding ON CONFLICT, ensure unique constraints exist. Check for duplicates:SELECT citizen_id, service_id, COUNT(*) FROM service_requests GROUP BY citizen_id, service_id HAVING COUNT(*) > 1;

