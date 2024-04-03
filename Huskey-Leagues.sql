DROP DATABASE IF EXISTS HuskyLeagues;

CREATE DATABASE HuskyLeagues;

USE HuskyLeagues;

CREATE TABLE IF NOT EXISTS team_members (
    memberID int,
    firstName varchar(50),
    lastName varchar(50),
    email varchar(50),
    PRIMARY KEY (memberID)
);

CREATE TABLE IF NOT EXISTS sports (
    sportID int,
    name varchar(50),
    rules text,
    PRIMARY KEY (sportID)
);

CREATE TABLE IF NOT EXISTS teams (
    sportID int,
    teamID int,
    name varchar(50),
    PRIMARY KEY (sportID, teamID),
    FOREIGN KEY (sportID) REFERENCES sports (sportID)
                                 ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS roles (
    roleID int,
    name varchar(50),
    description text,
    PRIMARY KEY (roleID)
);

CREATE TABLE IF NOT EXISTS part_of (
    memberID int,
    sportID int,
    teamID int,
    jerseyNum int,
    roleID int,
    PRIMARY KEY (memberID, sportID, teamID),
    FOREIGN KEY (memberID) REFERENCES team_members (memberID)
                                 ON UPDATE CASCADE,
    FOREIGN KEY (sportID, teamID) REFERENCES teams (sportID, teamID)
                                 ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS admins (
    adminID int,
    firstName varchar(50),
    lastName varchar(50),
    email varchar(50),
    sportID int,
    PRIMARY KEY (adminID),
    FOREIGN KEY (sportID) REFERENCES sports (sportID)
                                 ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS sponsors (
    sponsorID int,
    name varchar(50),
    email varchar(50),
    PRIMARY KEY (sponsorID)
);

CREATE TABLE IF NOT EXISTS events (
    eventID int,
    description text,
    dateTime datetime,
    location varchar(50),
    sponsorID int,
    PRIMARY KEY (eventID),
    FOREIGN KEY (sponsorID) REFERENCES sponsors (sponsorID)
                                 ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS sponsorships (
    sponsorID int,
    teamID int,
    sportID int,
    money FLOAT,
    PRIMARY KEY (sponsorID, teamID, sportID),
    FOREIGN KEY (sponsorID) REFERENCES sponsors (sponsorID)
                                 ON UPDATE CASCADE,
    FOREIGN KEY (sportID, teamID) REFERENCES teams (sportID, teamID)
                                 ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS games (
    gameID int,
    dateTime datetime,
    location varchar(50),
    PRIMARY KEY (gameID)
);

CREATE TABLE team_game (
    teamID int,
    sportID int,
    gameID int,
    score int,
    PRIMARY KEY (teamID, sportID, gameID),
    FOREIGN KEY (sportID, teamID) REFERENCES teams (sportID, teamID)
                       ON UPDATE CASCADE,
    FOREIGN KEY (gameID) REFERENCES games (gameID)
                       ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS referees (
    refID int,
    firstName varchar(50),
    lastName varchar(50),
    email varchar(50),
    PRIMARY KEY (refID)
);

CREATE TABLE IF NOT EXISTS officiates (
    refID int,
    gameID int,
    PRIMARY KEY (refID, gameID),
    FOREIGN KEY (refID) REFERENCES referees (refID)
                                      ON UPDATE CASCADE,
    FOREIGN KEY (gameID) REFERENCES games (gameID)
                                      ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS chooses (
    refID int,
    sportID int,
    PRIMARY KEY (refID, sportID),
    FOREIGN KEY (refID) REFERENCES referees (refID)
                                   ON UPDATE CASCADE,
    FOREIGN KEY (sportID) REFERENCES sports (sportID)
                                   ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS fans (
    fanID int,
    firstName varchar(50),
    lastName varchar(50),
    email varchar(50),
    PRIMARY KEY (fanID)
);

CREATE TABLE IF NOT EXISTS follows_team_members (
    fanID int,
    memberID int,
    PRIMARY KEY (fanID, memberID),
    FOREIGN KEY (fanID) REFERENCES fans (fanID)
                                                ON UPDATE CASCADE,
    FOREIGN KEY (memberID) REFERENCES team_members (memberID)
                                                ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS follows_teams (
    fanID int,
    teamID int,
    sportID int,
    PRIMARY KEY (fanID, teamID, sportID),
    FOREIGN KEY (fanID) REFERENCES fans (fanID)
                                            ON UPDATE CASCADE,
    FOREIGN KEY (sportID, teamID) REFERENCES teams (sportID, teamID)
                                            ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS follows_sports (
    fanID int,
    sportID int,
    PRIMARY KEY (fanID, sportID),
    FOREIGN KEY (fanID) REFERENCES fans (fanID)
                                            ON UPDATE CASCADE,
    FOREIGN KEY (sportID) REFERENCES sports (sportID)
                                            ON UPDATE CASCADE
);

# team_members data
insert into team_members (memberID, firstName, lastName, email) values (1, 'Antone', 'Springham', 'aspringham0@ycombinator.com');
insert into team_members (memberID, firstName, lastName, email) values (2, 'Bidget', 'Ackery', 'backery1@infoseek.co.jp');
insert into team_members (memberID, firstName, lastName, email) values (3, 'Gare', 'Sahnow', 'gsahnow2@canalblog.com');
insert into team_members (memberID, firstName, lastName, email) values (4, 'Ginevra', 'Tong', 'gtong3@studiopress.com');
insert into team_members (memberID, firstName, lastName, email) values (5, 'Masha', 'Priddy', 'mpriddy4@twitter.com');
insert into team_members (memberID, firstName, lastName, email) values (6, 'Arlen', 'Coggles', 'acoggles5@marketwatch.com');
insert into team_members (memberID, firstName, lastName, email) values (7, 'Staffard', 'Claque', 'sclaque6@nba.com');
insert into team_members (memberID, firstName, lastName, email) values (8, 'Faythe', 'Lambol', 'flambol7@wix.com');
insert into team_members (memberID, firstName, lastName, email) values (9, 'Donni', 'Bern', 'dbern8@icq.com');
insert into team_members (memberID, firstName, lastName, email) values (10, 'Malachi', 'Stuehmeyer', 'mstuehmeyer9@java.com');

# sports data
INSERT INTO sports (sportID, name, rules) VALUES (1, 'Basketball', 'Basketball rules');
INSERT INTO sports (sportID, name, rules) VALUES (2, 'Soccer', 'Soccer rules');
INSERT INTO sports (sportID, name, rules) VALUES (3, 'Baseball', 'Baseball rules');
INSERT INTO sports (sportID, name, rules) VALUES (4, 'Football', 'Football rules');
INSERT INTO sports (sportID, name, rules) VALUES (5, 'Hockey', 'Hockey rules');
INSERT INTO sports (sportID, name, rules) VALUES (6, 'Volleyball', 'Volleyball rules');
INSERT INTO sports (sportID, name, rules) VALUES (7, 'Tennis', 'Tennis rules');
INSERT INTO sports (sportID, name, rules) VALUES (8, 'Golf', 'Golf rules');
INSERT INTO sports (sportID, name, rules) VALUES (9, 'Swimming', 'Swimming rules');
INSERT INTO sports (sportID, name, rules) VALUES (10, 'Cricket', 'Cricket rules');


# teams data
insert into teams (sportID, teamID, name) values (1, 1, 'Huskies');
insert into teams (sportID, teamID, name) values (1, 2, 'Bulldogs');
insert into teams (sportID, teamID, name) values (2, 1, 'Tigers');
insert into teams (sportID, teamID, name) values (2, 2, 'Lions');
insert into teams (sportID, teamID, name) values (3, 1, 'Bears');
insert into teams (sportID, teamID, name) values (3, 2, 'Cubs');
insert into teams (sportID, teamID, name) values (4, 1, 'Eagles');
insert into teams (sportID, teamID, name) values (4, 2, 'Falcons');
insert into teams (sportID, teamID, name) values (5, 1, 'Penguins');
insert into teams (sportID, teamID, name) values (5, 2, 'Seals');

# roles data
insert into roles (roleID, name, description) values (1, 'Player', 'A player on the team');
insert into roles (roleID, name, description) values (2, 'Coach', 'A coach of the team');
insert into roles (roleID, name, description) values (3, 'Team Manager', 'A manager of the team');
insert into roles (roleID, name, description) values (4, 'Equipment Manager', 'The equipment manager of the team');
insert into roles (roleID, name, description) values (5, 'Social Media Manager', 'The social media manager of the team');

# part_of data
insert into part_of (memberID, sportID, teamID, jerseyNum, roleID) values (1, 1, 1, 1, 1);
insert into part_of (memberID, sportID, teamID, jerseyNum, roleID) values (2, 1, 1, 2, 1);
insert into part_of (memberID, sportID, teamID, jerseyNum, roleID) values (3, 1, 1, 3, 1);
insert into part_of (memberID, sportID, teamID, jerseyNum, roleID) values (4, 1, 1, 4, 1);
insert into part_of (memberID, sportID, teamID, jerseyNum, roleID) values (5, 1, 1, 5, 1);
insert into part_of (memberID, sportID, teamID, jerseyNum, roleID) values (6, 1, 2, 1, 1);
insert into part_of (memberID, sportID, teamID, jerseyNum, roleID) values (7, 1, 2, 2, 1);
insert into part_of (memberID, sportID, teamID, jerseyNum, roleID) values (8, 1, 2, 3, 1);
insert into part_of (memberID, sportID, teamID, jerseyNum, roleID) values (9, 1, 2, 4, 1);
insert into part_of (memberID, sportID, teamID, jerseyNum, roleID) values (10, 1, 2, 5, 1);

# admins data
insert into admins (adminID, firstName, lastName, email, sportID) values (1, 'Jamal', 'Sisley', 'jsisley0@sakura.ne.jp', 7);
insert into admins (adminID, firstName, lastName, email, sportID) values (2, 'Corliss', 'Bowering', 'cbowering1@chron.com', 4);
insert into admins (adminID, firstName, lastName, email, sportID) values (3, 'Justinn', 'Duckwith', 'jduckwith2@soundcloud.com', 10);
insert into admins (adminID, firstName, lastName, email, sportID) values (4, 'Bethena', 'Oleksiak', 'boleksiak3@de.vu', 7);
insert into admins (adminID, firstName, lastName, email, sportID) values (5, 'Belita', 'Belf', 'bbelf4@xinhuanet.com', 4);
insert into admins (adminID, firstName, lastName, email, sportID) values (6, 'Duffie', 'Zammett', 'dzammett5@zimbio.com', 6);
insert into admins (adminID, firstName, lastName, email, sportID) values (7, 'Jackqueline', 'Kemm', 'jkemm6@intel.com', 5);
insert into admins (adminID, firstName, lastName, email, sportID) values (8, 'Darrin', 'Kilpatrick', 'dkilpatrick7@wunderground.com', 3);
insert into admins (adminID, firstName, lastName, email, sportID) values (9, 'Ange', 'Rowler', 'arowler8@sbwire.com', 7);
insert into admins (adminID, firstName, lastName, email, sportID) values (10, 'Elita', 'Gowler', 'egowler9@vk.com', 3);

# sponsors data
insert into sponsors (sponsorID, name, email) values (1, 'Skipstorm', 'dtonry0@yellowbook.com');
insert into sponsors (sponsorID, name, email) values (2, 'Youtags', 'dgatesman1@pbs.org');
insert into sponsors (sponsorID, name, email) values (3, 'Devpoint', 'mhalt2@hatena.ne.jp');
insert into sponsors (sponsorID, name, email) values (4, 'Avaveo', 'dhimsworth3@spotify.com');
insert into sponsors (sponsorID, name, email) values (5, 'Yadel', 'nouldcott4@java.com');
insert into sponsors (sponsorID, name, email) values (6, 'Thoughtstorm', 'hnowill5@jiathis.com');
insert into sponsors (sponsorID, name, email) values (7, 'Buzzster', 'mharling6@t.co');
insert into sponsors (sponsorID, name, email) values (8, 'Zoozzy', 'sdesson7@woothemes.com');
insert into sponsors (sponsorID, name, email) values (9, 'Twitterwire', 'ctissington8@goodreads.com');
insert into sponsors (sponsorID, name, email) values (10, 'Geba', 'shasley9@creativecommons.org');

# events data
insert into events (eventID, description, dateTime, location, sponsorID) values (1, 'Charity basketball game', '2021-10-01 12:00:00', 'Husky Stadium', 1);
insert into events (eventID, description, dateTime, location, sponsorID) values (2, 'Free food and beverage', '2021-10-02 12:00:00', 'Husky Stadium', 2);
insert into events (eventID, description, dateTime, location, sponsorID) values (3, 'Raffle', '2021-10-03 12:00:00', 'Husky Stadium', 3);
insert into events (eventID, description, dateTime, location, sponsorID) values (4, 'Auction', '2021-10-04 12:00:00', 'Husky Stadium', 4);
insert into events (eventID, description, dateTime, location, sponsorID) values (5, 'Live music', '2021-10-05 12:00:00', 'Husky Stadium', 5);
insert into events (eventID, description, dateTime, location, sponsorID) values (6, 'Dance performance', '2021-10-06 12:00:00', 'Husky Stadium', 6);
insert into events (eventID, description, dateTime, location, sponsorID) values (7, 'Comedy show', '2021-10-07 12:00:00', 'Husky Stadium', 7);
insert into events (eventID, description, dateTime, location, sponsorID) values (8, 'Charity softball game', '2021-10-08 12:00:00', 'Husky Stadium', 8);
insert into events (eventID, description, dateTime, location, sponsorID) values (9, 'Circus performance', '2021-10-09 12:00:00', 'Husky Stadium', 9);
insert into events (eventID, description, dateTime, location, sponsorID) values (10, 'Merchandise', '2021-10-10 12:00:00', 'Husky Stadium', 10);

# sponsorships data
insert into sponsorships (sponsorID, teamID, sportID, money) values (1, 1, 1, 1000);
insert into sponsorships (sponsorID, teamID, sportID, money) values (2, 1, 1, 2000);
insert into sponsorships (sponsorID, teamID, sportID, money) values (3, 1, 1, 3000);
insert into sponsorships (sponsorID, teamID, sportID, money) values (4, 1, 1, 4000);
insert into sponsorships (sponsorID, teamID, sportID, money) values (5, 1, 1, 5000);
insert into sponsorships (sponsorID, teamID, sportID, money) values (6, 1, 1, 6000);
insert into sponsorships (sponsorID, teamID, sportID, money) values (7, 1, 1, 7000);
insert into sponsorships (sponsorID, teamID, sportID, money) values (8, 1, 1, 8000);
insert into sponsorships (sponsorID, teamID, sportID, money) values (9, 1, 1, 9000);
insert into sponsorships (sponsorID, teamID, sportID, money) values (10, 1, 1, 10000);

# games data
insert into games (gameID, dateTime, location) values (1, '2021-10-01 12:00:00', 'Marino Recreation Center');
insert into games (gameID, dateTime, location) values (2, '2021-10-02 12:00:00', 'Marino Recreation Center');
insert into games (gameID, dateTime, location) values (3, '2021-10-03 12:00:00', 'Marino Recreation Center');
insert into games (gameID, dateTime, location) values (4, '2021-10-04 12:00:00', 'Carter Field');
insert into games (gameID, dateTime, location) values (5, '2021-10-05 12:00:00', 'Carter Field');
insert into games (gameID, dateTime, location) values (6, '2021-10-06 12:00:00', 'Carter Field');
insert into games (gameID, dateTime, location) values (7, '2021-10-07 12:00:00', 'Cabot Physical Education Center');
insert into games (gameID, dateTime, location) values (8, '2021-10-08 12:00:00', 'Cabot Physical Education Center');
insert into games (gameID, dateTime, location) values (9, '2021-10-09 12:00:00', 'Cabot Physical Education Center');
insert into games (gameID, dateTime, location) values (10, '2021-10-10 12:00:00', 'Cabot Physical Education Center');

# team_game data
insert into team_game (teamID, sportID, gameID, score) values (1, 1, 1, 100);
insert into team_game (teamID, sportID, gameID, score) values (2, 1, 1, 130);
insert into team_game (teamID, sportID, gameID, score) values (1, 1, 3, 115);
insert into team_game (teamID, sportID, gameID, score) values (2, 1, 3, 120);
insert into team_game (teamID, sportID, gameID, score) values (1, 1, 5, 110);
insert into team_game (teamID, sportID, gameID, score) values (2, 1, 5, 125);
insert into team_game (teamID, sportID, gameID, score) values (1, 1, 7, 105);
insert into team_game (teamID, sportID, gameID, score) values (2, 1, 7, 135);
insert into team_game (teamID, sportID, gameID, score) values (1, 1, 9, 120);
insert into team_game (teamID, sportID, gameID, score) values (2, 1, 9, 130);
insert into team_game (teamID, sportID, gameID, score) values (1, 2, 2, 5);
insert into team_game (teamID, sportID, gameID, score) values (2, 2, 2, 3);
insert into team_game (teamID, sportID, gameID, score) values (1, 2, 4, 4);
insert into team_game (teamID, sportID, gameID, score) values (2, 2, 4, 2);
insert into team_game (teamID, sportID, gameID, score) values (1, 2, 6, 3);
insert into team_game (teamID, sportID, gameID, score) values (2, 2, 6, 1);
insert into team_game (teamID, sportID, gameID, score) values (1, 2, 8, 2);
insert into team_game (teamID, sportID, gameID, score) values (2, 2, 8, 4);
insert into team_game (teamID, sportID, gameID, score) values (1, 2, 10, 1);
insert into team_game (teamID, sportID, gameID, score) values (2, 2, 10, 5);

# referees data
INSERT INTO referees (refID, firstName, lastName, email) VALUES (1, 'Valencia', 'Towlson', 'valencia@example.com');
INSERT INTO referees (refID, firstName, lastName, email) VALUES (2, 'Natala', 'Crouse', 'natala@example.com');
INSERT INTO referees (refID, firstName, lastName, email) VALUES (3, 'Saunderson', 'Mylan', 'saunderson@example.com');
INSERT INTO referees (refID, firstName, lastName, email) VALUES (4, 'Brion', 'Fairham', 'brion@example.com');
INSERT INTO referees (refID, firstName, lastName, email) VALUES (5, 'Finlay', 'Hallatt', 'finlay@example.com');
INSERT INTO referees (refID, firstName, lastName, email) VALUES (6, 'Kaitlyn', 'Mattiazzi', 'kaitlyn@example.com');
INSERT INTO referees (refID, firstName, lastName, email) VALUES (7, 'Sebastien', 'Manderson', 'sebastien@example.com');
INSERT INTO referees (refID, firstName, lastName, email) VALUES (8, 'Delilah', 'Aronovich', 'delilah@example.com');
INSERT INTO referees (refID, firstName, lastName, email) VALUES (9, 'Humfrid', 'Toothill', 'humfrid@example.com');
INSERT INTO referees (refID, firstName, lastName, email) VALUES (10, 'Max', 'Andryszczak', 'max@example.com');

# officiates data
insert into officiates (refID, gameID) values (1, 1);
insert into officiates (refID, gameID) values (2, 2);
insert into officiates (refID, gameID) values (3, 3);
insert into officiates (refID, gameID) values (4, 4);
insert into officiates (refID, gameID) values (5, 5);
insert into officiates (refID, gameID) values (6, 6);
insert into officiates (refID, gameID) values (7, 7);
insert into officiates (refID, gameID) values (8, 8);
insert into officiates (refID, gameID) values (9, 9);
insert into officiates (refID, gameID) values (10, 10);

# chooses data
insert into chooses (refID, sportID) values (1, 1);
insert into chooses (refID, sportID) values (2, 2);
insert into chooses (refID, sportID) values (3, 1);
insert into chooses (refID, sportID) values (4, 2);
insert into chooses (refID, sportID) values (5, 1);
insert into chooses (refID, sportID) values (6, 2);
insert into chooses (refID, sportID) values (7, 1);
insert into chooses (refID, sportID) values (8, 2);
insert into chooses (refID, sportID) values (9, 1);
insert into chooses (refID, sportID) values (10, 2);

# fans data
insert into fans (fanID, firstName, lastName, email) values (1, 'Addie', 'Kemster', 'akemster0@free.fr');
insert into fans (fanID, firstName, lastName, email) values (2, 'Cad', 'Matyushenko', 'cmatyushenko1@ftc.gov');
insert into fans (fanID, firstName, lastName, email) values (3, 'Janelle', 'Le Barr', 'jlebarr2@dyndns.org');
insert into fans (fanID, firstName, lastName, email) values (4, 'Ad', 'Gunby', 'agunby3@google.ca');
insert into fans (fanID, firstName, lastName, email) values (5, 'Joelle', 'Glanville', 'jglanville4@purevolume.com');
insert into fans (fanID, firstName, lastName, email) values (6, 'Whit', 'Vlies', 'wvlies5@amazon.de');
insert into fans (fanID, firstName, lastName, email) values (7, 'Parke', 'Syvret', 'psyvret6@cpanel.net');
insert into fans (fanID, firstName, lastName, email) values (8, 'Roddie', 'Lavies', 'rlavies7@cargocollective.com');
insert into fans (fanID, firstName, lastName, email) values (9, 'Karlotta', 'Redrup', 'kredrup8@reddit.com');
insert into fans (fanID, firstName, lastName, email) values (10, 'Constantine', 'Arrol', 'carrol9@theguardian.com');

# follows_team_members data
insert into follows_team_members (fanID, memberID) values (1, 1);
insert into follows_team_members (fanID, memberID) values (2, 2);
insert into follows_team_members (fanID, memberID) values (3, 3);
insert into follows_team_members (fanID, memberID) values (4, 4);
insert into follows_team_members (fanID, memberID) values (5, 5);
insert into follows_team_members (fanID, memberID) values (6, 6);
insert into follows_team_members (fanID, memberID) values (7, 7);
insert into follows_team_members (fanID, memberID) values (8, 8);
insert into follows_team_members (fanID, memberID) values (9, 9);
insert into follows_team_members (fanID, memberID) values (10, 10);

# follows_teams data
insert into follows_teams (fanID, teamID, sportID) values (1, 1, 1);
insert into follows_teams (fanID, teamID, sportID) values (2, 1, 2);
insert into follows_teams (fanID, teamID, sportID) values (3, 1, 3);
insert into follows_teams (fanID, teamID, sportID) values (4, 1, 4);
insert into follows_teams (fanID, teamID, sportID) values (5, 1, 5);
insert into follows_teams (fanID, teamID, sportID) values (6, 2, 1);
insert into follows_teams (fanID, teamID, sportID) values (7, 2, 2);
insert into follows_teams (fanID, teamID, sportID) values (8, 2, 3);
insert into follows_teams (fanID, teamID, sportID) values (9, 2, 4);
insert into follows_teams (fanID, teamID, sportID) values (10, 2, 5);

# follows_sports data
insert into follows_sports (fanID, sportID) values (1, 1);
insert into follows_sports (fanID, sportID) values (2, 2);
insert into follows_sports (fanID, sportID) values (3, 3);
insert into follows_sports (fanID, sportID) values (4, 4);
insert into follows_sports (fanID, sportID) values (5, 5);
insert into follows_sports (fanID, sportID) values (6, 6);
insert into follows_sports (fanID, sportID) values (7, 7);
insert into follows_sports (fanID, sportID) values (8, 8);
insert into follows_sports (fanID, sportID) values (9, 9);
insert into follows_sports (fanID, sportID) values (10, 10);
