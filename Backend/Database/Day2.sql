-- Day 2 Implementation

/************************************************************
ASSIGNMENT 2 — IPL SEASONS & CHAMPIONSHIP HISTORY
************************************************************/


/************************************************************
1. SETUP & SEASON TEAM DATA MODEL
************************************************************/

SELECT TOP (1000)
    [season_team_id],
    [season_id],
    [team_id],
    [matches_played],
    [points],
    [position],
    [qualified_for_playoffs],
    [created_at]
FROM [league].[dbo].[season_teams];


/************************************************************
SEASON TEAM STANDINGS DATA (2018 STYLE SAMPLE)
************************************************************/

INSERT INTO season_teams
(
    season_id,
    team_id,
    matches_played,
    points,
    position,
    qualified_for_playoffs
)
VALUES
-- 2018 season standings
(11, 1, 14, 18, 1, 1), -- CSK
(11, 4, 14, 16, 2, 1), -- MI
(11, 6, 14, 14, 3, 1), -- KKR
(11, 5, 14, 12, 4, 1), -- RCB
(11, 7, 14, 10, 5, 0); -- SRH


/************************************************************
SEASON TEAM STANDINGS DATA (2020–2022)
************************************************************/

INSERT INTO season_teams
(
    season_id,
    team_id,
    matches_played,
    points,
    position,
    qualified_for_playoffs
)
VALUES

-- 2020 Season
(13, 4, 14, 20, 1, 1), -- MI
(13, 7, 14, 16, 2, 1), -- SRH
(13, 1, 14, 14, 3, 1), -- CSK
(13, 5, 14, 14, 4, 1), -- RCB
(13, 6, 14, 12, 5, 0), -- KKR

-- 2021 Season
(14, 1, 14, 20, 1, 1), -- CSK
(14, 6, 14, 18, 2, 1), -- KKR
(14, 4, 14, 16, 3, 1), -- MI
(14, 5, 14, 14, 4, 1), -- RCB
(14, 7, 14, 12, 5, 0), -- SRH

-- 2022 Season
(15, 4, 14, 18, 1, 1), -- MI
(15, 5, 14, 16, 2, 1), -- RCB
(15, 1, 14, 14, 3, 1), -- CSK
(15, 7, 14, 12, 4, 1), -- SRH
(15, 6, 14, 10, 5, 0); -- KKR


/************************************************************
2. SEASON LISTING QUERY
************************************************************/

SELECT
    season_id,
    season_year
FROM seasons
ORDER BY season_year;


/************************************************************
3. RELATIONSHIP ANALYSIS
************************************************************/

/*
1 season : 1 winner
1 team : many seasons can be won by the same team

Therefore:
Season → Team is Many-to-One relationship
*/


/************************************************************
4. FOREIGN KEY DISCUSSION
************************************************************/

/*
winner_team_id should NOT be NULL because:
- A completed season must always have a champion
- NULL would represent incomplete/invalid historical data
*/


/************************************************************
5. TOP 3 TEAMS BY IPL TITLES
************************************************************/

SELECT TOP 3
    t.official_name AS team_name,
    COUNT(*) AS total_titles
FROM seasons s
INNER JOIN teams t
    ON s.winner_team_id = t.team_id
GROUP BY t.official_name
ORDER BY total_titles DESC;


/************************************************************
6. TEAMS THAT NEVER WON IPL
************************************************************/

SELECT
    t.official_name AS team_name
FROM teams t
WHERE NOT EXISTS
(
    SELECT 1
    FROM seasons s
    WHERE s.winner_team_id = t.team_id
)
ORDER BY t.official_name;


/************************************************************
7. EF CORE ONE-TO-ONE LOADING
************************************************************/

/*
One-to-one relationships in EF Core are not loaded automatically.
They require explicit loading using Include or explicit loading.

Impact:
- Better performance control
- Avoids unnecessary data loading
- Prevents N+1 query issues if misused
*/


/************************************************************
8. DELETION & REFERENTIAL INTEGRITY
************************************************************/

/*
In production systems, teams should NOT be hard deleted.

Best approach:
- Use soft delete (status = DISCONTINUED or IS_DELETED)

Reason:
- Preserves historical IPL data
- Maintains referential integrity
- Ensures analytics and reports remain valid
- Prevents breaking past season records
*/