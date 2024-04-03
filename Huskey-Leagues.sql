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
    rules longtext,
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
    description TEXT,
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
    description TEXT,
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