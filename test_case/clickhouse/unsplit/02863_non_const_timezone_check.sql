DROP TABLE IF EXISTS Dates;
CREATE TABLE Dates (date DateTime('UTC')) ENGINE = MergeTree() ORDER BY date;
INSERT INTO Dates VALUES ('2023-08-25 15:30:00');
SELECT toString((SELECT date FROM Dates), number % 2 ? 'America/Los_Angeles' : 'Europe/Amsterdam') FROM numbers(5);
DROP TABLE Dates;
