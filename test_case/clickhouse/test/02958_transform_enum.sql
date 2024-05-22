WITH arrayJoin(['Hello', 'world'])::Enum('Hello', 'world') AS x SELECT x, transform(x, ['Hello', 'world'], [123, 456], 0);
