-- Parent Tables
CREATE TABLE tournament(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    latest_match_id INT
);

CREATE TABLE player(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

CREATE TABLE tournament_player (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tournament_id INTEGER NOT NULL,
    player_id INTEGER NOT NULL,
    FOREIGN KEY (tournament_id) REFERENCES tournament(id) ON DELETE CASCADE,
    FOREIGN KEY (player_id) REFERENCES player(id) ON DELETE CASCADE,
    UNIQUE (tournament_id, player_id)
);

CREATE TABLE tournament_player_statistic (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tournament_player_id INTEGER NOT NULL,
    wins INTEGER DEFAULT 0,
    losses INTEGER DEFAULT 0,
    point_differential INTEGER DEFAULT 0,
    FOREIGN KEY (tournament_player_id) REFERENCES tournament_player(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS team(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    player1_id INT,
    player2_id INT,
    FOREIGN KEY (player1_id) REFERENCES player(id) ON DELETE CASCADE,
    FOREIGN KEY (player2_id) REFERENCES player(id) ON DELETE CASCADE,
    UNIQUE (player1_id, player2_id)
);

CREATE TABLE match(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tournament_id INT,
    team1_id INT,
    team2_id INT,
    team1_score INT,
    team2_score INT,
    team_winner_id INT,
    match_status TEXT,
    FOREIGN KEY (tournament_id) REFERENCES tournament(id) ON DELETE CASCADE,
    FOREIGN KEY (team1_id) REFERENCES team(id) ON DELETE CASCADE,
    FOREIGN KEY (team2_id) REFERENCES team(id) ON DELETE CASCADE
);



