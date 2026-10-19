-- Query A: Leaderboard Ranking
SELECT project.Project_ID, project.Team_ID, project.Project_Title, score.Score_Value
FROM project
LEFT JOIN score ON project.Project_ID = score.Project_ID
ORDER BY score.Score_Value DESC;

-- Query B: Category Grouping
-- As a Hackaton organizer, we need to be able to group up the project to its team responsible for it and the category it falls under.
-- This helps us to coordinating category-specific mentors or judges to the projects.
SELECT project.Project_ID, team.Team_Name, category.Category_Name
FROM project
INNER JOIN team ON project.Team_ID = team.Team_ID
INNER JOIN category ON project.Category_ID = category.Category_ID;

-- Query C: Workshop Filtering
-- With the list of workshops we have made available we need to find a way to filter and find specific workshops that center around a certain topic and displaying
-- them with a user-friendly date format.
-- In this case we have to find the specific workshops that centers around the topic of technology, they way to find it is through the workshops title.
-- With the display of the scheduled_time.
SELECT Workshop_Name, Description, TO_CHAR(Date_Time, 'DD-MM-YYYY HH24:MI') AS Scheduled_Time
FROM workshop
WHERE (LOWER(Workshop_Name) LIKE '%tech%' OR LOWER(Description) LIKE '%tech%')
  AND Date_Time >= TO_DATE('2025-07-06', 'YYYY-MM-DD')
ORDER BY Date_Time;

-- Query D: Participant Search
SELECT Participant_Name, Email, University, Education_Level
FROM participant
WHERE (University = 'Sunway University' AND Education_Level = 'Postgraduate')
   OR LOWER(Participant_Name) LIKE '%tan%';

-- Query E: Popular Workshops
-- Find popular workshops that have at least 3 participants and showing the exact registration count to the specific workshop.
-- This helps us as the Hackaton organizers to monitor which workshops are popular or at capacity, identify sessions that might need bigger rooms, more mentors, or materials
-- and filter out low-engagement workshops from further promotion
SELECT
    w.Workshop_ID,
    w.Workshop_Name,
    (SELECT COUNT(*)
     FROM workshop_registration wr
     WHERE wr.Workshop_ID = w.Workshop_ID) AS Registration_Count
FROM
    workshop w
WHERE
    w.Workshop_ID IN (
        SELECT Workshop_ID
        FROM workshop_registration
        GROUP BY Workshop_ID
        HAVING COUNT(Participant_ID) >= 3
    );

-- Query F: Co-Registration Analysis
-- This finds pairs of workshops that have been registered together by the same participants, and counts how many participants registered for both.
-- As event organizers this is important for us as we need to find a way to optimize scheduling to avoid clashes between high-demand pairs
-- Further more this could help us discover popular combinations of workshops (e.g., "Intro to AI" + "AI Ethics Panel") and plan future events based on participant interests
SELECT
    wr1.Workshop_ID AS Workshop1,
    wr2.Workshop_ID AS Workshop2,
    COUNT(*) AS Co_Registrations
FROM
    workshop_registration wr1
JOIN
    workshop_registration wr2
    ON wr1.Participant_ID = wr2.Participant_ID
    AND wr1.Workshop_ID < wr2.Workshop_ID
GROUP BY
    wr1.Workshop_ID, wr2.Workshop_ID
HAVING
    COUNT(*) >= 2 -- Minimum number of co-registrations
ORDER BY
    Co_Registrations DESC;