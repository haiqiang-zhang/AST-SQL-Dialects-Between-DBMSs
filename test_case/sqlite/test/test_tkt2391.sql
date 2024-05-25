SELECT count(*) FROM folders WHERE foldername < 'FolderC';
SELECT count(*) FROM folders WHERE foldername < 'FolderC' COLLATE nocase;
CREATE INDEX f_i ON folders(foldername);
SELECT count(*) FROM folders WHERE foldername < 'FolderC' COLLATE nocase;
