# Tech Innovation Hackathon Management System 🏆

## Project Overview
This project features an 11-table normalized relational database schema designed to support "Into RoshanVerse 2025," a 3-day national collegiate tech hackathon. The database handles event operations, cross-university participant and team management, real-time workshop tracking, and secure project evaluations. 

**Key Achievements:**
- Designed an 11-table normalized relational database schema to support operations for a 3-day national hackathon, cross-university participant and team management, and secure project evaluations.
- Used SQL and entity-relationship modelling to define database relationships, implementing strict UNIQUE and CHECK constraints to enforce business rules and maintain referential and data integrity.

## Database Architecture & ERD
The relational database consists of 11 interconnected tables: `workshop`, `mentor`, `category`, `team`, `participant`, `project`, `judge`, `score`, `sponsor`, `award`, and `workshop_registration`.

## Business Rules & Constraints
To maintain strict data integrity, the following business logic was enforced via SQL constraints:
- **Team Structuring:** Teams are restricted to 3-5 members (`CHECK` constraint) and assigned exactly one unique mentor.
- **Participant Eligibility:** Only 'Undergraduate' or 'Postgraduate' students are permitted (`CHECK` constraint).
- **Evaluation Integrity:** Judge scores must fall between 0 and 100, and a judge can only submit one score per project (`UNIQUE` composite key) to prevent duplicate evaluation.

## Analytical Queries
The repository includes SQL queries designed to assist event organizers with logistics and decision-making:
- **Query A - Leaderboard:** Ranks projects based on judge scores in descending order.
- **Query B - Category Grouping:** Joins projects, teams, and categories to help coordinate category-specific mentors and judges.
- **Query C - Workshop Filtering:** Identifies specific technology-centric workshops and formats the schedule for user-friendly display.
- **Query D - Participant Search:** Filters specific participants based on university, education level, or name.
- **Query E - Popular Workshops:** Identifies high-demand workshops (3+ participants) using nested queries to help organizers allocate larger rooms or more materials.
- **Query F - Co-Registration Analysis:** Finds pairs of workshops registered together by the same participants to optimize scheduling and avoid clashes between high-demand sessions.

## Technologies Used
- **Database Engine:** Oracle Database / Oracle APEX
- **Language:** SQL
- **Design:** Entity-Relationship (ER) Modeling
