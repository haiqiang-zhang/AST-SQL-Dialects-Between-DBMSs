CREATE TABLE folders(folderid, parentid, foldername COLLATE binary);
INSERT INTO folders VALUES(1, 3, 'FolderA');
INSERT INTO folders VALUES(1, 3, 'folderB');
INSERT INTO folders VALUES(4, 0, 'FolderC');
SELECT count(*) FROM folders WHERE foldername < 'FolderC';
CREATE INDEX f_i ON folders(foldername);
