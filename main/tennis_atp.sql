-- 1. What has been the ranking of each player over time?

SELECT
    player,
    Date,
    ranking
FROM (
    SELECT
        Player_1 AS player,
        Date,
        Rank_1 AS ranking
    FROM
        tennis.atp_tennis

    UNION ALL

    SELECT
        Player_2 AS player,
        Date,
        Rank_2 AS ranking
    FROM
        tennis.atp_tennis
) AS combined_players
WHERE
    player IN ('Nadal R.')  
ORDER BY
    player,
    Date;

-- 2.

-- 2. What is the average win percentage of each player per surface?

SELECT
    player,
    Surface,
    AVG(CASE WHEN player = Winner THEN 1 ELSE 0 END) AS average_win_percentage
FROM (
    SELECT
        Player_1 AS player,
        Surface,
        Winner
    FROM
        tennis.atp_tennis

    UNION ALL

    SELECT
        Player_2 AS player,
        Surface,
        Winner
    FROM
        tennis.atp_tennis
) AS combined_players
GROUP BY
    player,
    Surface;

-- 3. How many wins has each player achieved per tournament?
SELECT
    player,
    Tournament,
    Series,
    COUNT(*) AS total_wins
FROM (
    SELECT
        Player_1 AS player,
        Tournament,
        Series
    FROM
        tennis.atp_tennis
    WHERE
        Player_1 = Winner

    UNION ALL

    SELECT
        Player_2 AS player,
        Tournament,
        Series
    FROM
        tennis.atp_tennis
    WHERE
        Player_2 = Winner
) AS combined_players
GROUP BY
    player,
    Tournament,
    Series
ORDER BY total_wins DESC;

-- 4. What is the average win percentage of each player in every stage of the tournament?

SELECT
    player,
    Round AS tournament_round,
    AVG(CASE WHEN player = Winner THEN 1 ELSE 0 END) AS average_win_percentage
FROM (
    SELECT
        Player_1 AS player,
        Round,
        Winner
    FROM
        tennis.atp_tennis

    UNION ALL

    SELECT
        Player_2 AS player,
        Round,
        Winner
    FROM
        tennis.atp_tennis
) AS combined_players
GROUP BY
    player,
    Round;

-- 5. How does a player perform against a higher ranked player?
SELECT
    player,
    COUNT(*) AS num_matches,
    AVG(CASE WHEN player = Winner AND Rank_1 > Rank_2 THEN 1 ELSE 0 END) AS win_percentage_against_higher_ranked
FROM (
    SELECT
        Player_1 AS player,
        Rank_1,
        Rank_2,
        Winner
    FROM
        tennis.atp_tennis

    UNION ALL

    SELECT
        Player_2 AS player,
        Rank_2,
        Rank_1,
        Winner
    FROM
        tennis.atp_tennis
) AS combined_players
GROUP BY
    player
ORDER BY
	win_percentage_against_higher_ranked DESC;

-- 6. How does a player perform against a lower ranked player?
SELECT
    player,
    COUNT(*) AS num_matches,
    AVG(CASE WHEN player = Winner AND Rank_1 < Rank_2 THEN 1 ELSE 0 END) AS win_percentage_against_lower_ranked
FROM (
    SELECT
        Player_1 AS player,
        Rank_1,
        Rank_2,
        Winner
    FROM
        tennis.atp_tennis

    UNION ALL

    SELECT
        Player_2 AS player,
        Rank_2,
        Rank_1,
        Winner
    FROM
        tennis.atp_tennis
) AS combined_players
GROUP BY
    player
ORDER BY
	win_percentage_against_lower_ranked DESC;
    
-- 7. What is the correlation between ATP Points and total matches won of each player?

SELECT
    player,
    AVG(Pts_1) AS average_points,
    COUNT(*) AS total_matches,
    AVG(CASE WHEN player = Winner THEN 1 ELSE 0 END) AS average_win_percentage
FROM (
    SELECT
        Player_1 AS player,
        Pts_1,
        Winner
    FROM
        tennis.atp_tennis

    UNION ALL

    SELECT
        Player_2 AS player,
        Pts_2,
        Winner
    FROM
        tennis.atp_tennis
) AS combined_players
GROUP BY
    player;
    
-- 8. What is the record of each matchup?

SELECT
    player,
    rival,
    COUNT(*) AS total_matches,
    AVG(CASE WHEN player = Winner THEN 1 ELSE 0 END) AS average_win_percentage
FROM (
    SELECT
        Player_1 AS player,
        Player_2 AS rival,
        Winner
    FROM
        tennis.atp_tennis

    UNION ALL

    SELECT
        Player_2 AS player,
        Player_1 AS rival,
        Winner
    FROM
        tennis.atp_tennis
) AS player_rival_matches
WHERE
    player IS NOT NULL AND player != '' AND rival IS NOT NULL AND rival != ''
GROUP BY
    player,
    rival
ORDER BY
    total_matches DESC;
    
 -- 9. What are the odds of each player to win a specific round?   

SELECT
    Player,
    Round,
    AVG(CASE WHEN Player = Winner THEN 1 ELSE 0 END) AS Win_Probability
FROM (
    SELECT
        Player_1 AS Player,
        Round,
        Winner
    FROM
        tennis.atp_tennis

    UNION ALL

    SELECT
        Player_2 AS Player,
        Round,
        Winner
    FROM
        tennis.atp_tennis
) AS combined_players
WHERE
    Player IS NOT NULL AND Player != '' AND Round IS NOT NULL AND Winner IS NOT NULL
GROUP BY
    Player,
    Round;

    
-- 10. List of players that have reached the ATP TOP 10

SELECT
    Player
FROM (
    SELECT
        Player_1 AS Player,
        Rank_1 AS Top_10
    FROM
        tennis.atp_tennis

    UNION ALL

    SELECT
        Player_2 AS Player,
        Rank_2 AS Top_10
    FROM
        tennis.atp_tennis
) AS combined_players
WHERE
    Player IS NOT NULL AND Player != '' AND Top_10 <= 10
GROUP BY
    Player;



