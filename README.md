# RaceDay - Part 1: System Planning and Database

Overview

RaceDay is a full-stack event management system built for the South African road running, walking, and cycling community. It replaces the paper-based registration and spreadsheet tracking that many local running clubs and race organisers currently rely on.

This repository covers Part 1 of the project: planning the system before any application code is written. It contains the Entity Relationship Diagram (ERD), the API endpoint plan, and the SQL script that creates and seeds the RaceDay database.

Roles

RaceDay supports two user roles, enforced consistently across all three parts of the project:

- Organiser - creates, edits, and deletes events; manages event categories (e.g. 5km, 10km); captures participant results; and views all enrolments for their events.
- Participant - registers for an account, browses upcoming events, enters an event by selecting a category, views their own enrolments, and tracks their personal result history.

Repository Structure

/docs
  RaceDay_ERD.png          - Entity Relationship Diagram
  RaceDay_Endpoint_Plan.md - API endpoint plan (Section B)
  RaceDay_Schema.sql       - Database creation and seed script (Section C)
.github/workflows/         - CI/CD workflow validating repo structure
README.md


Database Setup (SSMS)

1. Open SQL Server Management Studio and connect to a local or clean SQL Server instance.
2. Open docs/RaceDay_Schema.sql.
3. Execute the script. It will:
   - Create the RaceDayDB database (if it doesn't already exist).
   - Drop and recreate all six tables (Users, UserProfiles, Events, Categories, Enrolments, Results) with primary keys, foreign keys, and constraints.
   - Seed the database with sample data: 2 Organisers, 2 Participants, 3 Events, 5 Categories, and sample Enrolments and Results.
4. Verify the tables were created successfully by expanding `RaceDayDB > Tables in Object Explorer.

Green build screenshot:

![Users](<Screenshot 2026-09-05 112411.png>)
![Enrolments](<Screenshot 2026-09-05 112747.png>)
![Events](<Screenshot 2026-09-05 112839.png>)

Video Walkthrough

https://youtu.be/KPVqGUT6VDw

 AI Disclosure

AI was use to get the idae of how to constract the API and errors in SQL script that i couldnt figure out what the problem was

