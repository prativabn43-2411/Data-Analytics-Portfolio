Create database Join_pratice;
use Join_Pratice;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    phone VARCHAR(15) UNIQUE
);

INSERT INTO Customers VALUES
(1, 'Ravi Kumar', 'Bangalore', '9876543210'),
(2, 'Priya Sharma', 'Delhi', '9876543211'),
(3, 'Aman Gupta', 'Mumbai', '9876543212'),
(4, 'Sneha Iyer', 'Chennai', '9876543213'),
(5, 'Karan Mehta', 'Pune', '9876543214'),
(6, 'Divya Nair', 'Delhi', '9876543215'),
(7, 'Rohit Verma', 'Mumbai', '9876543216'),
(8, 'Anjali Singh', 'Bangalore', '9876543217');



CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20) NOT NULL,
    balance DECIMAL(10,2) DEFAULT 0.00 CHECK (balance >= 0),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Accounts VALUES
(201, 1, 'Savings', 25000.00),
(202, 2, 'Current', 150000.00),
(203, 3, 'Savings', 8000.00),
(204, 4, 'Savings', 42000.00),
(205, 5, 'Current', 90000.00),
(206, 6, 'Savings', 15000.00),
(207, NULL, 'Savings', 5000.00),
(208, NULL, 'Current', 12000.00);

select * from Customers;
select * from Accounts; 


#Inner Join (Only common data)
select c.*, a.*
from Customers c
inner join
Accounts a 
on c.customer_id = a.customer_id;

#Left Join (Left table + Common Data)
select c.*, a.*
from Customers c
left join
Accounts a 
on c.customer_id = a.customer_id;

#Right Join (Right table + Common data)
select c.*, a.*
from Customers c
Right join
Accounts a 
on c.customer_id = a.customer_id;

#Questions
# 1. Find the customers with no account?
select c.customer_id,c.customer_name
from Customers c
left join Accounts a
on c.customer_id = a.customer_id
where a.customer_id is null;

# 2. Find accounts details with no assigned customers
select a.*
from Customers c
right join Accounts a
on c.customer_id = a.customer_id
where c.customer_id is null;


CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL UNIQUE,
    city VARCHAR(50),
    founded_year INT CHECK (founded_year >= 1900)
);

INSERT INTO Teams VALUES
(1, 'Mumbai Strikers', 'Mumbai', 2005),
(2, 'Delhi Dynamos', 'Delhi', 2010),
(3, 'Chennai Chargers', 'Chennai', 2008),
(4, 'Bangalore Blasters', 'Bangalore', 2012),
(5, 'Kolkata Kings', 'Kolkata', 2003);

select * from teams;

CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50) NOT NULL,
    team_id INT,
    position VARCHAR(20) NOT NULL,
    jersey_number INT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

INSERT INTO Players VALUES
(101, 'Ravi Kumar', 1, 'Forward', 9),
(102, 'Aman Gupta', 1, 'Midfielder', 8),
(103, 'Priya Sharma', 2, 'Forward', 11),
(104, 'Karan Mehta', 2, 'Defender', 4),
(105, 'Sneha Iyer', 3, 'Forward', 7),
(106, 'Rohit Verma', 3, 'Midfielder', 10),
(107, 'Divya Nair', 4, 'Defender', 3),
(108, 'Anjali Singh', 4, 'Forward', 15),
(109, 'Vikram Rao', 5, 'Midfielder', 6),
(110, 'Neha Joshi', 5, 'Forward', 19);
select * from Players;

CREATE TABLE MatchStats (
    stat_id INT PRIMARY KEY,
    player_id INT,
    match_date DATE,
    goals_scored INT DEFAULT 0 CHECK (goals_scored >= 0),
    assists INT DEFAULT 0 CHECK (assists >= 0),
    minutes_played INT CHECK (minutes_played BETWEEN 0 AND 90),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

INSERT INTO MatchStats VALUES
(1, 101, '2026-06-01', 2, 1, 90),
(2, 101, '2026-06-08', 1, 0, 85),
(3, 102, '2026-06-01', 0, 2, 90),
(4, 102, '2026-06-08', 1, 1, 78),
(5, 103, '2026-06-02', 3, 0, 90),
(6, 103, '2026-06-09', 0, 1, 60),
(7, 104, '2026-06-02', 0, 0, 90),
(8, 105, '2026-06-03', 2, 1, 88),
(9, 105, '2026-06-10', 1, 0, 70),
(10, 106, '2026-06-03', 0, 3, 90),
(11, 107, '2026-06-04', 0, 0, 90),
(12, 108, '2026-06-04', 2, 0, 65),
(13, 108, '2026-06-11', 2, 1, 90),
(14, 109, '2026-06-05', 0, 2, 90),
(15, 110, '2026-06-05', 3, 0, 75),
(16, 110, '2026-06-12', 1, 1, 90);

select * from MatchStats;

#list Every player along with their team name
select p.player_id,p.player_name,t.team_name
from Players p 
inner join
Teams t 
on p.team_id =t.team_id;

#Find the total number of players in each team
select t.team_name,
count(p.player_id) as Total_players
from Teams t 
inner join
players p 
on t.team_id = p.team_id
group by t.team_name;

#Find teams that have more than 2 players
select t.team_name,
count(p.player_id) as Total_players
from Teams t 
inner join
players p 
on t.team_id = p.team_id
group by t.team_name
having Total_players>2;

#Find the total goals scored by each player
select p.player_name,
sum(m.goals_scored) as Total_goals
from Players p 
inner join
MatchStats m 
on p.player_id = m.player_id
group by p.player_name
order by Total_goals desc;

#Find the total goals scored by each team
select t.team_name,
sum(m.goals_scored) as Total_goals
from Teams t 
inner join Players p 
on t.team_id = P.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name
order by Total_goals desc;

# 1. Find players who have scored more than 2 goals in total.
select p.player_name,
sum(m.goals_scored) as Total_goals
from Players p 
inner join
MatchStats m 
on p.player_id = m.player_id
group by p.player_name
having Total_goals >2;

# 2. Find teams whose total goals scored is more than 4.
select t.team_name,
sum(m.goals_scored) as Total_goals
from Teams t 
inner join Players p 
on t.team_id = p.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name
having Total_goals >4; 

# 3. Find the average goals scored per match for each player.
select p.player_name,
round(avg(m.goals_scored),2) as Total_goals
from Players p 
inner join
MatchStats m 
on p.player_id = m.player_id
group by p.player_name
order by Total_goals desc;

# 4. Find players whose average assists per match is  greater than 1.
select p.player_name,
round(avg(m.goals_scored),2) as Total_goals
from Players p 
inner join
MatchStats m 
on p.player_id = m.player_id
group by p.player_name
having Total_goals >1;

# 5. Find the number of matches played by each player.
select p.player_id, p.player_name,
count(m.stat_id) as Total_matches
from Players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_id,p.player_name
order by Total_matches desc;

# 6. Find the total minutes played by each team.
select t.team_name,
sum(m.minutes_played) as Total_Minutes
from Teams t 
inner join Players p 
on t.team_id = p.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name
order by Total_Minutes desc;

# 7. Find the total goals scored by players in each position (Forward, Midfielder, Defender).
select p.position,
sum(m.goals_scored) as Total_goals
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.position
order by Total_goals desc;

# 8. Find positions where the average goals scored per match is more than 1.
select p.position,
round(avg(m.goals_scored),2) as Average_goals_score
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.position
having Average_goals_score>1;

# 9. Find players who have not scored a single goal in any match.
select p.player_id,p.player_name,
sum(m.goals_scored) as Total_goals
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_id,p.player_name
having Total_goals = 0;

# 10. Find the team with the highest total goals scored.
select t.team_name,
sum(m.goals_scored) as Total_goals
from teams t 
inner join players p 
on t.team_id = p.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name
order by Total_goals desc
limit 1;

# 11. Find the total assists given by each team.
select t.team_name,
sum(m.assists) as Total_assists
from teams t 
inner join players p 
on t.team_id = p.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name
order by Total_assists desc;

# 12. Find teams whose total assists are less than 3.
select t.team_name,
sum(m.assists) as Total_assists
from teams t 
inner join players p 
on t.team_id = p.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name
having Total_assists< 3;

# 13. Find the number of players per position across the whole league.
select p.position,
count(p.player_id) as Total_players
from players p 
inner join teams t 
on t.team_id = p.team_id
group by p.position
order by Total_players;

# 14.Find the average minutes played by players in each team.
select t.team_name,
round(avg(m.minutes_played),2) as Average_minutes_played
from teams t 
inner join players p 
on t.team_id = p.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name
order by Average_minutes_played;

# 15. Find teams where the average minutes played is more than 80.
select t.team_name,
round(avg(m.minutes_played),0) as Average_minutes_played
from teams t 
inner join players p 
on t.team_id = p.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name
having  Average_minutes_played> 80;

# 16.Find the highest single-match goal count recorded by each player.
select p.player_name,
max(m.goals_scored) as single_match_goals_score
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_name
order by single_match_goals_score desc; 

# 17. Find players whose best single-match goal count is 3 or more.
select p.player_name,
max(m.goals_scored) as single_match_goals_score
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_name
having single_match_goals_score>=3;

#18. Find the total number of matches recorded for each team.
select t.team_name,
count(m.stat_id) as Total_matches
from teams t 
inner join players p 
on t.team_id = p.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name
order by Total_matches desc;

#19. Find the combined goals + assists (total contributions) for each player.
select p.player_name,
sum(m.goals_scored)+sum(m.assists) as Total_contribution
from players p
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_name
order by Total_contribution desc;

#20.Find players whose combined goals + assists is greater than 4.
select p.player_name,
sum(m.goals_scored+m.assists) as Total_contribution
from players p
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_name
having Total_contribution>4;

#21. Find the minimum minutes played in a single match for each player.
select p.player_name,
min(m.minutes_played) as Minimum_minutes_played
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_name
order by Minimum_minutes_played desc;

#22. Find the number of goals scored by each team, only counting teams founded after 2005.
select t.team_id,team_name,
count(m.goals_scored) as Total_Number_of_goals
from teams t 
inner join Players p 
on t.team_id = p.team_id
inner join MatchStats m 
on p.player_id = m.player_id
where t.founded_year>2005
group by t.team_id,team_name
order by Total_Number_of_goals desc;

#23. Find positions where more than 3 matches have been recorded in total.
select p.position,
count(m.stat_id) as Total_matches
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.position
having Total_matches >3;

#24. Find teams whose players have collectively played more than 300 total minutes.
select t.team_name,
sum(m.minutes_played) as Total_minutes_played
from teams t 
inner join players p 
on t.team_id = p.team_id 
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name
having Total_minutes_played>300;

#25. Find each team's average goals scored per player (total team goals divided by number of distinct players who scored), 
#showing only teams averaging more than 1 goal per player.
 select t.team_name,
 round(sum(m.goals_scored) / count(distinct m.player_id),0) as Average_goals_per_player
 from teams t 
 inner join players p 
 on t.team_id = p.team_id
 inner join MatchStats m 
 on p.player_id = m.player_id
 group by t.team_name
 having Average_goals_per_player>1;
 
select p.player_id,p.player_name,
round(sum(m.goals_scored) / count(m.player_id),0) as Average_goals_per_player
from players p
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_id,p.player_name
having Average_goals_per_player>1;


# 13/08/2026
#----View 
#A view is a virtual table based on the result of a SELECT query . It doesn't store data itself . It store the query ,and runs it fresh every time you access the view. 
#This is especially useful with joins, since you can save a complex multi-table join once and reuse it like a simple table.

create view PlayerTeamView as 
select p.player_id,p.player_name,p.position,
t.team_name,t.city
from players p 
inner join Teams t 
on p.team_id = t.team_id;

-- calling the view itself now
select * from PlayerTeamView;

-- condition based view
select * from PlayerTeamView
where city = 'Delhi';

-- updating the existing view with different Query
Create or Replace view PlayerTeamView as
select p.player_name,t.team_name,t.city
from Players p 
inner join Teams t 
on p.team_id = t.team_id;

#Drop view PlayerTeamView---delete the view

-- create a view HighScoringplayer (totalgoals>2),
-- Table (Player_name,Goals_scored by them as Totalgoals)
create view HighScoringPlayers as
select p.player_name,
sum(m.goals_scored) as Total_goals
from Players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_name
order by Total_goals desc;

select * from HighScoringPlayers
where Total_goals >2;

/*
# Create a view named PlayerAssistsView that shows each player's 
name, their team name, and the total number of assists they 
have made across all matches. Then write a query to select all 
players from this view who have more than 1 total assist.

Create a view named TeamMatchSummaryView that shows each team's 
name along with the total number of matches played and the total 
minutes played by all its players combined (joining Teams, 
Players, and MatchStats). Then write a query to select only the 
teams from this view where total minutes played is greater 
than 250.

Create a view named ForwardScorersView that shows the player name,
 team name, and total goals scored, but only for players whose 
 position is 'Forward'. Then write a query to select from this 
 view the player with the highest total goals.

*/
create view PlayerAssistsView as
select p.player_name,t.team_name,
sum(m.assists) as Total_Assists
from Players p
inner join teams t 
on p.team_id = t.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_name,t.team_name
order by Total_Assists desc;

select * from PlayerAssistsView
where Total_Assists>1;
drop view PlayerAssistsView;


create view TeamMatchSummaryView as
select t.team_name,
count(distinct m.stat_id) as Total_matches,
sum(minutes_played) as Total_minutes_played 
from teams t 
inner join players p 
on t.team_id = p.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by t.team_name;

select * from TeamMatchSummaryView
where Total_minutes_played >250;

create view PlayerMatchStatsView as
select p.*,t.*
from Players p
inner join teams t 
on p.team_id = t.team_id
inner join MatchStats m 
on p.player_id = m.player_id;

create view ForwardScorersView as
select p.player_name,t.team_name,p.position,
sum(m.goals_scored) as Total_Goals
from Players p 
inner join Teams t 
on p.team_id = t.team_id
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_name,t.team_name,p.position
having p.position ='Forward'
order by Total_goals desc;

select * from ForwardScorersView;
drop view ForwardScorersView;



#14/08/2026
#Subqueries
-- Subquery in WHERE clause
-- Find players who play for 'Mumbai Strikers'
select player_name,position 
from players 
where team_id = 
(select team_id 
from Teams 
where team_name = 'Mumbai Strikers');

-- Subquery with (multiple values)
-- find players who belong to teams from Delhi or Mumbai
select player_name, team_id
from players 
where team_id in
(select team_id 
from Teams 
where city in ('Delhi','Mumbai'));

/*CTEs (Common Table Expressions)
A CTE is a named temporary result set, 
defined using WITH, that you can reference 
later in the same query. It's like a subquery
but more readable, especially when reused or chained.*/

# -- Basic CTE
# Find each teams total goals >2.
with TeamGoals as 
(select p.team_id,
sum(m.goals_scored) as total_goals
from Players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.team_id)

select t.team_name, tg.total_goals
from TeamGoals tg
inner join Teams t 
on tg.team_id = t.team_id
where tg.total_goals >2;

-- CTE with joins to explain each player's contribution 
#Find the combined goals + assists (total contributions)>3 for each player.
with PlayerContribution as 
(select p.player_id, p.player_name, p.team_id,
sum((m.goals_scored)+(m.assists)) as goals_assists
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_id, p.player_name, p.team_id)
select pc.player_name, t.team_name, pc.goals_assists
from PlayerContribution pc 
inner join Teams t 
on pc.team_id = t.team_id
where goals_assists>3;

-- Questions on Subqueries and CTEs for data table players,matches and teams.
# Find all players who belong to the team 'Chennai Chargers'.
 select player_id,player_name
 from players
 where team_id = 
 (select team_id 
 from Teams 
 where team_name = 'Chennai Chargers');

# Find the details of the team where player 'Ravi Kumar' plays.
select *
from players
where player_name = 'Ravi Kumar';

# Find all match records of the player who wears jersey number 9.
select *
from players
where jersey_number = '9';

# Find the team founded in the year 2003.
select team_id,team_name
from Teams
where founded_year = '2003';

# Find all players who belong to teams based in 'Delhi' or 'Mumbai'.
select player_name,team_id
from players 
where team_id in 
(select team_id 
from Teams 
where city in ('Delhi','Mumbai'));

# Find all match records of players whose position is 'Forward'.
select *
from players
where position = 'Forward';

# Find all teams that have at least one player with jersey number greater than 10.
select team_id,team_name
from teams
where team_id in 
(select team_id
from players 
where jersey_number > 10);

# Find all players who have played a match with more than 85 minutes.
select player_id,minutes_played
from MatchStats
where minutes_played>85;

-- Questions for CTE

# Using a CTE, find the total goals scored by each player.
with PlayerGoals as
(select p.player_name,
sum(m.goals_scored) as Total_goals 
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_name)
select p.player_name,pg.Total_goals
from PlayerGoals pg
inner join players p 
on pg.player_name = p.player_name
order by Total_goals desc;

# Using a CTE, find players whose total assists are greater than 1.
with PlayerAssists as
(select p.player_id,p.player_name,
sum(m.assists) as Total_assists
from Players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_id,p.player_name)
select p.player_name,pa.total_assists
from PlayerAssists pa 
inner join Players p 
on pa.player_name = p.player_name
where total_assists>1;

# Using a CTE, find the total number of matches played by each player.
with PlayerMatches as
(select player_name,
sum(m.stat_id) as Total_matches
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by player_name)
select p.player_name,pm.total_matches
from PlayerMatches pm 
inner join players p 
on pm.player_name = p.player_name
order by Total_matches desc;

# Using a CTE, find the average minutes played by each player.
with PlayerAvgminuteplayed as
(select p.player_name,
round(avg(m.minutes_played),0) as Avg_minute_played
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by P.player_name)
select p.player_name,pa.Avg_minute_played
from PlayerAvgminuteplayed pa 
inner join players p 
on pa.player_name = p.player_name
order by Avg_minute_played desc;

# Using a CTE, find each player's name, team name, and total goals scored.
with TotalGoals as
(select p.player_name,
sum(m.goals_scored) as Total_goals
from players p
inner join MatchStats m 
on p.player_id = m.player_id 
group by p.player_name)
select p.player_name,t.team_name,tg.total_goals
from players p 
inner join teams t 
on p.team_id = t.team_id
inner join TotalGoals tg 
on p.player_name = tg.player_name
order by Total_goals desc;

# Using a CTE, find each team's name along with its total assists, joining Teams and Players.
with PlayerAssists as 
(select p.player_id,
sum(m.assists) as Total_assists
from players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_id)
select t.team_name,
sum(pa.total_assists) as Team_total_assists
from Teams t 
inner join Players p 
on t.team_id = p.team_id
inner join PlayerAssists pa 
on p.player_id = pa.player_id
group by t.team_name;

# Using a CTE, find each player's name, position, and total contribution (goals + assists), joined with their team name.
with PlayerContribution as 
(select p.player_id,
sum((m.goals_scored) + (m.assists)) as Total_Contribution
from Players p 
inner join MatchStats m 
on p.player_id = m.player_id
group by p.player_id)
select p.player_name,p.position,pc.total_contribution,t.team_name
from Players p 
inner join PlayerContribution pc 
on p.player_id = pc.player_id
inner join teams t 
on p.team_id = t.team_id
order by Total_Contribution desc;

