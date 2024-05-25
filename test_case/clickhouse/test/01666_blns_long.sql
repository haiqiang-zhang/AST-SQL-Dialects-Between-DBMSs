SELECT groupArray(name) FROM system.columns WHERE database = currentDatabase() AND table = 'test';
