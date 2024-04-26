drop table if exists t1;
drop table if exists t2;
drop table if exists t3;
drop table if exists t4;

set names eucjpms;
set character_set_database = eucjpms;
 
CREATE TABLE t1(c1 CHAR(1)) DEFAULT CHARACTER SET = eucjpms;
INSERT INTO t1 VALUES
(0x5C),(0x7E),(0xA1B1),(0xA1BD),(0xA1C0),(0xA1C1),(0xA1C2),(0xA1DD),(0xA1F1),(0xA1F2),(0xA1EF),(0xA2CC),(0x8FA2B7),(0x8FA2C3);
INSERT INTO t1 VALUES
(0xADA1),(0xADA2),(0xADA3),(0xADA4),(0xADA5),(0xADA6),(0xADA7),(0xADA8),
(0xADA9),(0xADAA),(0xADAB),(0xADAC),(0xADAD),(0xADAE),(0xADAF),(0xADB0),
(0xADB1),(0xADB2),(0xADB3),(0xADB4),(0xADB5),(0xADB6),(0xADB7),(0xADB8),
(0xADB9),(0xADBA),(0xADBB),(0xADBC),(0xADBD),(0xADBE),(0xADC0),(0xADC1),
(0xADC2),(0xADC3),(0xADC4),(0xADC5),(0xADC6),(0xADC7),(0xADC8),(0xADC9),
(0xADCA),(0xADCB),(0xADCC),(0xADCD),(0xADCE),(0xADCF),(0xADD0),(0xADD1),
(0xADD2),(0xADD3),(0xADD4),(0xADD5),(0xADD6),(0xADDF),(0xADE0),(0xADE1),
(0xADE2),(0xADE3),(0xADE4),(0xADE5),(0xADE6),(0xADE7),(0xADE8),(0xADE9),
(0xADEA),(0xADEB),(0xADEC),(0xADED),(0xADEE),(0xADEF),(0xADF0),(0xADF1),
(0xADF2),(0xADF3),(0xADF4),(0xADF5),(0xADF6),(0xADF7),(0xADF8),(0xADF9),
(0xADFA),(0xADFB),(0xADFC);
INSERT INTO t1 VALUES
(0x8FF3F3),(0x8FF3F4),(0x8FF3F5),(0x8FF3F6),(0x8FF3F7),(0x8FF3F8),(0x8FF3F9),(0x8FF3FA),
(0x8FF3FB),(0x8FF3FC),(0x8FF3FD),(0x8FF3FE),(0x8FF4A1),(0x8FF4A2),(0x8FF4A3),(0x8FF4A4),
(0x8FF4A5),(0x8FF4A6),(0x8FF4A7),(0x8FF4A8),(0xA2CC),(0x8FA2C3),(0x8FF4A9),(0x8FF4AA),
(0x8FF4AB),(0x8FF4AC),(0x8FF4AD),(0xA2E8),(0x8FD4E3),(0x8FDCDF),(0x8FE4E9),(0x8FE3F8),
(0x8FD9A1),(0x8FB1BB),(0x8FF4AE),(0x8FC2AD),(0x8FC3FC),(0x8FE4D0),(0x8FC2BF),(0x8FBCF4),
(0x8FB0A9),(0x8FB0C8),(0x8FF4AF),(0x8FB0D2),(0x8FB0D4),(0x8FB0E3),(0x8FB0EE),(0x8FB1A7),
(0x8FB1A3),(0x8FB1AC),(0x8FB1A9),(0x8FB1BE),(0x8FB1DF),(0x8FB1D8),(0x8FB1C8),(0x8FB1D7),
(0x8FB1E3),(0x8FB1F4),(0x8FB1E1),(0x8FB2A3),(0x8FF4B0),(0x8FB2BB),(0x8FB2E6),(0x8FB2ED),
(0x8FB2F5),(0x8FB2FC),(0x8FF4B1),(0x8FB3B5),(0x8FB3D8),(0x8FB3DB),(0x8FB3E5),(0x8FB3EE),
(0x8FB3FB),(0x8FF4B2),(0x8FF4B3),(0x8FB4C0),(0x8FB4C7),(0x8FB4D0),(0x8FB4DE),(0x8FF4B4),
(0x8FB5AA),(0x8FF4B5),(0x8FB5AF),(0x8FB5C4),(0x8FB5E8),(0x8FF4B6),(0x8FB7C2),(0x8FB7E4),
(0x8FB7E8),(0x8FB7E7),(0x8FF4B7),(0x8FF4B8),(0x8FF4B9),(0x8FB8CE),(0x8FB8E1),(0x8FB8F5),
(0x8FB8F7),(0x8FB8F8),(0x8FB8FC),(0x8FB9AF),(0x8FB9B7),(0x8FBABE),(0x8FBADB),(0x8FCDAA),
(0x8FBAE1),(0x8FF4BA),(0x8FBAEB),(0x8FBBB3),(0x8FBBB8),(0x8FF4BB),(0x8FBBCA),(0x8FF4BC),
(0x8FF4BD),(0x8FBBD0),(0x8FBBDE),(0x8FBBF4),(0x8FBBF5),(0x8FBBF9),(0x8FBCE4),(0x8FBCED),
(0x8FBCFE),(0x8FF4BE),(0x8FBDC2),(0x8FBDE7),(0x8FF4BF),(0x8FBDF0),(0x8FBEB0),(0x8FBEAC),
(0x8FF4C0),(0x8FBEB3),(0x8FBEBD),(0x8FBECD),(0x8FBEC9),(0x8FBEE4),(0x8FBFA8),(0x8FBFC9),
(0x8FC0C4),(0x8FC0E4),(0x8FC0F4),(0x8FC1A6),(0x8FF4C1),(0x8FC1F5),(0x8FC1FC),(0x8FF4C2),
(0x8FC1F8),(0x8FC2AB),(0x8FC2A1),(0x8FC2A5),(0x8FF4C3),(0x8FC2B8),(0x8FC2BA),(0x8FF4C4),
(0x8FC2C4),(0x8FC2D2),(0x8FC2D7),(0x8FC2DB),(0x8FC2DE),(0x8FC2ED),(0x8FC2F0),(0x8FF4C5),
(0x8FC3A1),(0x8FC3B5),(0x8FC3C9),(0x8FC3B9),(0x8FF4C6),(0x8FC3D8),(0x8FC3FE),(0x8FF4C7),
(0x8FC4CC),(0x8FF4C8),(0x8FC4D9),(0x8FC4EA),(0x8FC4FD),(0x8FF4C9),(0x8FC5A7),(0x8FC5B5),
(0x8FC5B6),(0x8FF4CA),(0x8FC5D5),(0x8FC6B8),(0x8FC6D7),(0x8FC6E0),(0x8FC6EA),(0x8FC6E3),
(0x8FC7A1),(0x8FC7AB),(0x8FC7C7),(0x8FC7C3),(0x8FC7CB),(0x8FC7CF),(0x8FC7D9),(0x8FF4CB),
(0x8FF4CC),(0x8FC7E6),(0x8FC7EE),(0x8FC7FC),(0x8FC7EB),(0x8FC7F0),(0x8FC8B1),(0x8FC8E5),
(0x8FC8F8),(0x8FC9A6),(0x8FC9AB),(0x8FC9AD),(0x8FF4CD),(0x8FC9CA),(0x8FC9D3),(0x8FC9E9),
(0x8FC9E3),(0x8FC9FC),(0x8FC9F4),(0x8FC9F5),(0x8FF4CE),(0x8FCAB3),(0x8FCABD),(0x8FCAEF),
(0x8FCAF1),(0x8FCBAE),(0x8FF4CF),(0x8FCBCA),(0x8FCBE6),(0x8FCBEA),(0x8FCBF0),(0x8FCBF4),
(0x8FCBEE),(0x8FCCA5),(0x8FCBF9),(0x8FCCAB),(0x8FCCAE),(0x8FCCAD),(0x8FCCB2),(0x8FCCC2),
(0x8FCCD0),(0x8FCCD9),(0x8FF4D0),(0x8FCDBB),(0x8FF4D1),(0x8FCEBB),(0x8FF4D2),(0x8FCEBA),
(0x8FCEC3),(0x8FF4D3),(0x8FCEF2),(0x8FB3DD),(0x8FCFD5),(0x8FCFE2),(0x8FCFE9),(0x8FCFED),
(0x8FF4D4),(0x8FF4D5),(0x8FF4D6),(0x8FF4D7),(0x8FD0E5),(0x8FF4D8),(0x8FD0E9),(0x8FD1E8),
(0x8FF4D9),(0x8FF4DA),(0x8FD1EC),(0x8FD2BB),(0x8FF4DB),(0x8FD3E1),(0x8FD3E8),(0x8FD4A7),
(0x8FF4DC),(0x8FF4DD),(0x8FD4D4),(0x8FD4F2),(0x8FD5AE),(0x8FF4DE),(0x8FD7DE),(0x8FF4DF),
(0x8FD8A2),(0x8FD8B7),(0x8FD8C1),(0x8FD8D1),(0x8FD8F4),(0x8FD9C6),(0x8FD9C8),(0x8FD9D1),
(0x8FF4E0),(0x8FF4E1),(0x8FF4E2),(0x8FF4E3),(0x8FF4E4),(0x8FDCD3),(0x8FDDC8),(0x8FDDD4),
(0x8FDDEA),(0x8FDDFA),(0x8FDEA4),(0x8FDEB0),(0x8FF4E5),(0x8FDEB5),(0x8FDECB),(0x8FF4E6),
(0x8FDFB9),(0x8FF4E7),(0x8FDFC3),(0x8FF4E8),(0x8FF4E9),(0x8FE0D9),(0x8FF4EA),(0x8FF4EB),
(0x8FE1E2),(0x8FF4EC),(0x8FF4ED),(0x8FF4EE),(0x8FE2C7),(0x8FE3A8),(0x8FE3A6),(0x8FE3A9),
(0x8FE3AF),(0x8FE3B0),(0x8FE3AA),(0x8FE3AB),(0x8FE3BC),(0x8FE3C1),(0x8FE3BF),(0x8FE3D5),
(0x8FE3D8),(0x8FE3D6),(0x8FE3DF),(0x8FE3E3),(0x8FE3E1),(0x8FE3D4),(0x8FE3E9),(0x8FE4A6),
(0x8FE3F1),(0x8FE3F2),(0x8FE4CB),(0x8FE4C1),(0x8FE4C3),(0x8FE4BE),(0x8FF4EF),(0x8FE4C0),
(0x8FE4C7),(0x8FE4BF),(0x8FE4E0),(0x8FE4DE),(0x8FE4D1),(0x8FF4F0),(0x8FE4DC),(0x8FE4D2),
(0x8FE4DB),(0x8FE4D4),(0x8FE4FA),(0x8FE4EF),(0x8FE5B3),(0x8FE5BF),(0x8FE5C9),(0x8FE5D0),
(0x8FE5E2),(0x8FE5EA),(0x8FE5EB),(0x8FF4F1),(0x8FF4F2),(0x8FF4F3),(0x8FE6E8),(0x8FE6EF),
(0x8FE7AC),(0x8FF4F4),(0x8FE7AE),(0x8FF4F5),(0x8FE7B1),(0x8FF4F6),(0x8FE7B2),(0x8FE8B1),
(0x8FE8B6),(0x8FF4F7),(0x8FF4F8),(0x8FE8DD),(0x8FF4F9),(0x8FF4FA),(0x8FE9D1),(0x8FF4FB),
(0x8FE9ED),(0x8FEACD),(0x8FF4FC),(0x8FEADB),(0x8FEAE6),(0x8FEAEA),(0x8FEBA5),(0x8FEBFB),
(0x8FEBFA),(0x8FF4FD),(0x8FECD6),(0x8FF4FE);
INSERT INTO t1 VALUES
(0xF5A1),(0xF5A2),(0xF5A3),(0xF5A4),(0xF5A5),(0xF5A6),(0xF5A7),(0xF5A8),
(0xF5A9),(0xF5AA),(0xF5AB),(0xF5AC),(0xF5AD),(0xF5AE),(0xF5AF),(0xF5B0),
(0xF5B1),(0xF5B2),(0xF5B3),(0xF5B4),(0xF5B5),(0xF5B6),(0xF5B7),(0xF5B8),
(0xF5B9),(0xF5BA),(0xF5BB),(0xF5BC),(0xF5BD),(0xF5BE),(0xF5BF),(0xF5C0),
(0xF5C1),(0xF5C2),(0xF5C3),(0xF5C4),(0xF5C5),(0xF5C6),(0xF5C7),(0xF5C8),
(0xF5C9),(0xF5CA),(0xF5CB),(0xF5CC),(0xF5CD),(0xF5CE),(0xF5CF),(0xF5D0),
(0xF5D1),(0xF5D2),(0xF5D3),(0xF5D4),(0xF5D5),(0xF5D6),(0xF5D7),(0xF5D8),
(0xF5D9),(0xF5DA),(0xF5DB),(0xF5DC),(0xF5DD),(0xF5DE),(0xF5DF),(0xF5E0),
(0xF5E1),(0xF5E2),(0xF5E3),(0xF5E4),(0xF5E5),(0xF5E6),(0xF5E7),(0xF5E8),
(0xF5E9),(0xF5EA),(0xF5EB),(0xF5EC),(0xF5ED),(0xF5EE),(0xF5EF),(0xF5F0),
(0xF5F1),(0xF5F2),(0xF5F3),(0xF5F4),(0xF5F5),(0xF5F6),(0xF5F7),(0xF5F8),
(0xF5F9),(0xF5FA),(0xF5FB),(0xF5FC),(0xF5FD),(0xF5FE),
(0xF6A1),(0xF6A2),(0xF6A3),(0xF6A4),(0xF6A5),(0xF6A6),(0xF6A7),(0xF6A8),
(0xF6A9),(0xF6AA),(0xF6AB),(0xF6AC),(0xF6AD),(0xF6AE),(0xF6AF),(0xF6B0),
(0xF6B1),(0xF6B2),(0xF6B3),(0xF6B4),(0xF6B5),(0xF6B6),(0xF6B7),(0xF6B8),
(0xF6B9),(0xF6BA),(0xF6BB),(0xF6BC),(0xF6BD),(0xF6BE),(0xF6BF),(0xF6C0),
(0xF6C1),(0xF6C2),(0xF6C3),(0xF6C4),(0xF6C5),(0xF6C6),(0xF6C7),(0xF6C8),
(0xF6C9),(0xF6CA),(0xF6CB),(0xF6CC),(0xF6CD),(0xF6CE),(0xF6CF),(0xF6D0),
(0xF6D1),(0xF6D2),(0xF6D3),(0xF6D4),(0xF6D5),(0xF6D6),(0xF6D7),(0xF6D8),
(0xF6D9),(0xF6DA),(0xF6DB),(0xF6DC),(0xF6DD),(0xF6DE),(0xF6DF),(0xF6E0),
(0xF6E1),(0xF6E2),(0xF6E3),(0xF6E4),(0xF6E5),(0xF6E6),(0xF6E7),(0xF6E8),
(0xF6E9),(0xF6EA),(0xF6EB),(0xF6EC),(0xF6ED),(0xF6EE),(0xF6EF),(0xF6F0),
(0xF6F1),(0xF6F2),(0xF6F3),(0xF6F4),(0xF6F5),(0xF6F6),(0xF6F7),(0xF6F8),
(0xF6F9),(0xF6FA),(0xF6FB),(0xF6FC),(0xF6FD),(0xF6FE),
(0xF7A1),(0xF7A2),(0xF7A3),(0xF7A4),(0xF7A5),(0xF7A6),(0xF7A7),(0xF7A8),
(0xF7A9),(0xF7AA),(0xF7AB),(0xF7AC),(0xF7AD),(0xF7AE),(0xF7AF),(0xF7B0),
(0xF7B1),(0xF7B2),(0xF7B3),(0xF7B4),(0xF7B5),(0xF7B6),(0xF7B7),(0xF7B8),
(0xF7B9),(0xF7BA),(0xF7BB),(0xF7BC),(0xF7BD),(0xF7BE),(0xF7BF),(0xF7C0),
(0xF7C1),(0xF7C2),(0xF7C3),(0xF7C4),(0xF7C5),(0xF7C6),(0xF7C7),(0xF7C8),
(0xF7C9),(0xF7CA),(0xF7CB),(0xF7CC),(0xF7CD),(0xF7CE),(0xF7CF),(0xF7D0),
(0xF7D1),(0xF7D2),(0xF7D3),(0xF7D4),(0xF7D5),(0xF7D6),(0xF7D7),(0xF7D8),
(0xF7D9),(0xF7DA),(0xF7DB),(0xF7DC),(0xF7DD),(0xF7DE),(0xF7DF),(0xF7E0),
(0xF7E1),(0xF7E2),(0xF7E3),(0xF7E4),(0xF7E5),(0xF7E6),(0xF7E7),(0xF7E8),
(0xF7E9),(0xF7EA),(0xF7EB),(0xF7EC),(0xF7ED),(0xF7EE),(0xF7EF),(0xF7F0),
(0xF7F1),(0xF7F2),(0xF7F3),(0xF7F4),(0xF7F5),(0xF7F6),(0xF7F7),(0xF7F8),
(0xF7F9),(0xF7FA),(0xF7FB),(0xF7FC),(0xF7FD),(0xF7FE),
(0xF8A1),(0xF8A2),(0xF8A3),(0xF8A4),(0xF8A5),(0xF8A6),(0xF8A7),(0xF8A8),
(0xF8A9),(0xF8AA),(0xF8AB),(0xF8AC),(0xF8AD),(0xF8AE),(0xF8AF),(0xF8B0),
(0xF8B1),(0xF8B2),(0xF8B3),(0xF8B4),(0xF8B5),(0xF8B6),(0xF8B7),(0xF8B8),
(0xF8B9),(0xF8BA),(0xF8BB),(0xF8BC),(0xF8BD),(0xF8BE),(0xF8BF),(0xF8C0),
(0xF8C1),(0xF8C2),(0xF8C3),(0xF8C4),(0xF8C5),(0xF8C6),(0xF8C7),(0xF8C8),
(0xF8C9),(0xF8CA),(0xF8CB),(0xF8CC),(0xF8CD),(0xF8CE),(0xF8CF),(0xF8D0),
(0xF8D1),(0xF8D2),(0xF8D3),(0xF8D4),(0xF8D5),(0xF8D6),(0xF8D7),(0xF8D8),
(0xF8D9),(0xF8DA),(0xF8DB),(0xF8DC),(0xF8DD),(0xF8DE),(0xF8DF),(0xF8E0),
(0xF8E1),(0xF8E2),(0xF8E3),(0xF8E4),(0xF8E5),(0xF8E6),(0xF8E7),(0xF8E8),
(0xF8E9),(0xF8EA),(0xF8EB),(0xF8EC),(0xF8ED),(0xF8EE),(0xF8EF),(0xF8F0),
(0xF8F1),(0xF8F2),(0xF8F3),(0xF8F4),(0xF8F5),(0xF8F6),(0xF8F7),(0xF8F8),
(0xF8F9),(0xF8FA),(0xF8FB),(0xF8FC),(0xF8FD),(0xF8FE),
(0xF9A1),(0xF9A2),(0xF9A3),(0xF9A4),(0xF9A5),(0xF9A6),(0xF9A7),(0xF9A8),
(0xF9A9),(0xF9AA),(0xF9AB),(0xF9AC),(0xF9AD),(0xF9AE),(0xF9AF),(0xF9B0),
(0xF9B1),(0xF9B2),(0xF9B3),(0xF9B4),(0xF9B5),(0xF9B6),(0xF9B7),(0xF9B8),
(0xF9B9),(0xF9BA),(0xF9BB),(0xF9BC),(0xF9BD),(0xF9BE),(0xF9BF),(0xF9C0),
(0xF9C1),(0xF9C2),(0xF9C3),(0xF9C4),(0xF9C5),(0xF9C6),(0xF9C7),(0xF9C8),
(0xF9C9),(0xF9CA),(0xF9CB),(0xF9CC),(0xF9CD),(0xF9CE),(0xF9CF),(0xF9D0),
(0xF9D1),(0xF9D2),(0xF9D3),(0xF9D4),(0xF9D5),(0xF9D6),(0xF9D7),(0xF9D8),
(0xF9D9),(0xF9DA),(0xF9DB),(0xF9DC),(0xF9DD),(0xF9DE),(0xF9DF),(0xF9E0),
(0xF9E1),(0xF9E2),(0xF9E3),(0xF9E4),(0xF9E5),(0xF9E6),(0xF9E7),(0xF9E8),
(0xF9E9),(0xF9EA),(0xF9EB),(0xF9EC),(0xF9ED),(0xF9EE),(0xF9EF),(0xF9F0),
(0xF9F1),(0xF9F2),(0xF9F3),(0xF9F4),(0xF9F5),(0xF9F6),(0xF9F7),(0xF9F8),
(0xF9F9),(0xF9FA),(0xF9FB),(0xF9FC),(0xF9FD),(0xF9FE),
(0xFAA1),(0xFAA2),(0xFAA3),(0xFAA4),(0xFAA5),(0xFAA6),(0xFAA7),(0xFAA8),
(0xFAA9),(0xFAAA),(0xFAAB),(0xFAAC),(0xFAAD),(0xFAAE),(0xFAAF),(0xFAB0),
(0xFAB1),(0xFAB2),(0xFAB3),(0xFAB4),(0xFAB5),(0xFAB6),(0xFAB7),(0xFAB8),
(0xFAB9),(0xFABA),(0xFABB),(0xFABC),(0xFABD),(0xFABE),(0xFABF),(0xFAC0),
(0xFAC1),(0xFAC2),(0xFAC3),(0xFAC4),(0xFAC5),(0xFAC6),(0xFAC7),(0xFAC8),
(0xFAC9),(0xFACA),(0xFACB),(0xFACC),(0xFACD),(0xFACE),(0xFACF),(0xFAD0),
(0xFAD1),(0xFAD2),(0xFAD3),(0xFAD4),(0xFAD5),(0xFAD6),(0xFAD7),(0xFAD8),
(0xFAD9),(0xFADA),(0xFADB),(0xFADC),(0xFADD),(0xFADE),(0xFADF),(0xFAE0),
(0xFAE1),(0xFAE2),(0xFAE3),(0xFAE4),(0xFAE5),(0xFAE6),(0xFAE7),(0xFAE8),
(0xFAE9),(0xFAEA),(0xFAEB),(0xFAEC),(0xFAED),(0xFAEE),(0xFAEF),(0xFAF0),
(0xFAF1),(0xFAF2),(0xFAF3),(0xFAF4),(0xFAF5),(0xFAF6),(0xFAF7),(0xFAF8),
(0xFAF9),(0xFAFA),(0xFAFB),(0xFAFC),(0xFAFD),(0xFAFE),
(0xFBA1),(0xFBA2),(0xFBA3),(0xFBA4),(0xFBA5),(0xFBA6),(0xFBA7),(0xFBA8),
(0xFBA9),(0xFBAA),(0xFBAB),(0xFBAC),(0xFBAD),(0xFBAE),(0xFBAF),(0xFBB0),
(0xFBB1),(0xFBB2),(0xFBB3),(0xFBB4),(0xFBB5),(0xFBB6),(0xFBB7),(0xFBB8),
(0xFBB9),(0xFBBA),(0xFBBB),(0xFBBC),(0xFBBD),(0xFBBE),(0xFBBF),(0xFBC0),
(0xFBC1),(0xFBC2),(0xFBC3),(0xFBC4),(0xFBC5),(0xFBC6),(0xFBC7),(0xFBC8),
(0xFBC9),(0xFBCA),(0xFBCB),(0xFBCC),(0xFBCD),(0xFBCE),(0xFBCF),(0xFBD0),
(0xFBD1),(0xFBD2),(0xFBD3),(0xFBD4),(0xFBD5),(0xFBD6),(0xFBD7),(0xFBD8),
(0xFBD9),(0xFBDA),(0xFBDB),(0xFBDC),(0xFBDD),(0xFBDE),(0xFBDF),(0xFBE0),
(0xFBE1),(0xFBE2),(0xFBE3),(0xFBE4),(0xFBE5),(0xFBE6),(0xFBE7),(0xFBE8),
(0xFBE9),(0xFBEA),(0xFBEB),(0xFBEC),(0xFBED),(0xFBEE),(0xFBEF),(0xFBF0),
(0xFBF1),(0xFBF2),(0xFBF3),(0xFBF4),(0xFBF5),(0xFBF6),(0xFBF7),(0xFBF8),
(0xFBF9),(0xFBFA),(0xFBFB),(0xFBFC),(0xFBFD),(0xFBFE),
(0xFCA1),(0xFCA2),(0xFCA3),(0xFCA4),(0xFCA5),(0xFCA6),(0xFCA7),(0xFCA8),
(0xFCA9),(0xFCAA),(0xFCAB),(0xFCAC),(0xFCAD),(0xFCAE),(0xFCAF),(0xFCB0),
(0xFCB1),(0xFCB2),(0xFCB3),(0xFCB4),(0xFCB5),(0xFCB6),(0xFCB7),(0xFCB8),
(0xFCB9),(0xFCBA),(0xFCBB),(0xFCBC),(0xFCBD),(0xFCBE),(0xFCBF),(0xFCC0),
(0xFCC1),(0xFCC2),(0xFCC3),(0xFCC4),(0xFCC5),(0xFCC6),(0xFCC7),(0xFCC8),
(0xFCC9),(0xFCCA),(0xFCCB),(0xFCCC),(0xFCCD),(0xFCCE),(0xFCCF),(0xFCD0),
(0xFCD1),(0xFCD2),(0xFCD3),(0xFCD4),(0xFCD5),(0xFCD6),(0xFCD7),(0xFCD8),
(0xFCD9),(0xFCDA),(0xFCDB),(0xFCDC),(0xFCDD),(0xFCDE),(0xFCDF),(0xFCE0),
(0xFCE1),(0xFCE2),(0xFCE3),(0xFCE4),(0xFCE5),(0xFCE6),(0xFCE7),(0xFCE8),
(0xFCE9),(0xFCEA),(0xFCEB),(0xFCEC),(0xFCED),(0xFCEE),(0xFCEF),(0xFCF0),
(0xFCF1),(0xFCF2),(0xFCF3),(0xFCF4),(0xFCF5),(0xFCF6),(0xFCF7),(0xFCF8),
(0xFCF9),(0xFCFA),(0xFCFB),(0xFCFC),(0xFCFD),(0xFCFE),
(0xFDA1),(0xFDA2),(0xFDA3),(0xFDA4),(0xFDA5),(0xFDA6),(0xFDA7),(0xFDA8),
(0xFDA9),(0xFDAA),(0xFDAB),(0xFDAC),(0xFDAD),(0xFDAE),(0xFDAF),(0xFDB0),
(0xFDB1),(0xFDB2),(0xFDB3),(0xFDB4),(0xFDB5),(0xFDB6),(0xFDB7),(0xFDB8),
(0xFDB9),(0xFDBA),(0xFDBB),(0xFDBC),(0xFDBD),(0xFDBE),(0xFDBF),(0xFDC0),
(0xFDC1),(0xFDC2),(0xFDC3),(0xFDC4),(0xFDC5),(0xFDC6),(0xFDC7),(0xFDC8),
(0xFDC9),(0xFDCA),(0xFDCB),(0xFDCC),(0xFDCD),(0xFDCE),(0xFDCF),(0xFDD0),
(0xFDD1),(0xFDD2),(0xFDD3),(0xFDD4),(0xFDD5),(0xFDD6),(0xFDD7),(0xFDD8),
(0xFDD9),(0xFDDA),(0xFDDB),(0xFDDC),(0xFDDD),(0xFDDE),(0xFDDF),(0xFDE0),
(0xFDE1),(0xFDE2),(0xFDE3),(0xFDE4),(0xFDE5),(0xFDE6),(0xFDE7),(0xFDE8),
(0xFDE9),(0xFDEA),(0xFDEB),(0xFDEC),(0xFDED),(0xFDEE),(0xFDEF),(0xFDF0),
(0xFDF1),(0xFDF2),(0xFDF3),(0xFDF4),(0xFDF5),(0xFDF6),(0xFDF7),(0xFDF8),
(0xFDF9),(0xFDFA),(0xFDFB),(0xFDFC),(0xFDFD),(0xFDFE),
(0xFEA1),(0xFEA2),(0xFEA3),(0xFEA4),(0xFEA5),(0xFEA6),(0xFEA7),(0xFEA8),
(0xFEA9),(0xFEAA),(0xFEAB),(0xFEAC),(0xFEAD),(0xFEAE),(0xFEAF),(0xFEB0),
(0xFEB1),(0xFEB2),(0xFEB3),(0xFEB4),(0xFEB5),(0xFEB6),(0xFEB7),(0xFEB8),
(0xFEB9),(0xFEBA),(0xFEBB),(0xFEBC),(0xFEBD),(0xFEBE),(0xFEBF),(0xFEC0),
(0xFEC1),(0xFEC2),(0xFEC3),(0xFEC4),(0xFEC5),(0xFEC6),(0xFEC7),(0xFEC8),
(0xFEC9),(0xFECA),(0xFECB),(0xFECC),(0xFECD),(0xFECE),(0xFECF),(0xFED0),
(0xFED1),(0xFED2),(0xFED3),(0xFED4),(0xFED5),(0xFED6),(0xFED7),(0xFED8),
(0xFED9),(0xFEDA),(0xFEDB),(0xFEDC),(0xFEDD),(0xFEDE),(0xFEDF),(0xFEE0),
(0xFEE1),(0xFEE2),(0xFEE3),(0xFEE4),(0xFEE5),(0xFEE6),(0xFEE7),(0xFEE8),
(0xFEE9),(0xFEEA),(0xFEEB),(0xFEEC),(0xFEED),(0xFEEE),(0xFEEF),(0xFEF0),
(0xFEF1),(0xFEF2),(0xFEF3),(0xFEF4),(0xFEF5),(0xFEF6),(0xFEF7),(0xFEF8),
(0xFEF9),(0xFEFA),(0xFEFB),(0xFEFC),(0xFEFD),(0xFEFE),
(0x8FF5A1),(0x8FF5A2),(0x8FF5A3),(0x8FF5A4),(0x8FF5A5),(0x8FF5A6),(0x8FF5A7),(0x8FF5A8),
(0x8FF5A9),(0x8FF5AA),(0x8FF5AB),(0x8FF5AC),(0x8FF5AD),(0x8FF5AE),(0x8FF5AF),(0x8FF5B0),
(0x8FF5B1),(0x8FF5B2),(0x8FF5B3),(0x8FF5B4),(0x8FF5B5),(0x8FF5B6),(0x8FF5B7),(0x8FF5B8),
(0x8FF5B9),(0x8FF5BA),(0x8FF5BB),(0x8FF5BC),(0x8FF5BD),(0x8FF5BE),(0x8FF5BF),(0x8FF5C0),
(0x8FF5C1),(0x8FF5C2),(0x8FF5C3),(0x8FF5C4),(0x8FF5C5),(0x8FF5C6),(0x8FF5C7),(0x8FF5C8),
(0x8FF5C9),(0x8FF5CA),(0x8FF5CB),(0x8FF5CC),(0x8FF5CD),(0x8FF5CE),(0x8FF5CF),(0x8FF5D0),
(0x8FF5D1),(0x8FF5D2),(0x8FF5D3),(0x8FF5D4),(0x8FF5D5),(0x8FF5D6),(0x8FF5D7),(0x8FF5D8),
(0x8FF5D9),(0x8FF5DA),(0x8FF5DB),(0x8FF5DC),(0x8FF5DD),(0x8FF5DE),(0x8FF5DF),(0x8FF5E0),
(0x8FF5E1),(0x8FF5E2),(0x8FF5E3),(0x8FF5E4),(0x8FF5E5),(0x8FF5E6),(0x8FF5E7),(0x8FF5E8),
(0x8FF5E9),(0x8FF5EA),(0x8FF5EB),(0x8FF5EC),(0x8FF5ED),(0x8FF5EE),(0x8FF5EF),(0x8FF5F0),
(0x8FF5F1),(0x8FF5F2),(0x8FF5F3),(0x8FF5F4),(0x8FF5F5),(0x8FF5F6),(0x8FF5F7),(0x8FF5F8),
(0x8FF5F9),(0x8FF5FA),(0x8FF5FB),(0x8FF5FC),(0x8FF5FD),(0x8FF5FE),
(0x8FF6A1),(0x8FF6A2),(0x8FF6A3),(0x8FF6A4),(0x8FF6A5),(0x8FF6A6),(0x8FF6A7),(0x8FF6A8),
(0x8FF6A9),(0x8FF6AA),(0x8FF6AB),(0x8FF6AC),(0x8FF6AD),(0x8FF6AE),(0x8FF6AF),(0x8FF6B0),
(0x8FF6B1),(0x8FF6B2),(0x8FF6B3),(0x8FF6B4),(0x8FF6B5),(0x8FF6B6),(0x8FF6B7),(0x8FF6B8),
(0x8FF6B9),(0x8FF6BA),(0x8FF6BB),(0x8FF6BC),(0x8FF6BD),(0x8FF6BE),(0x8FF6BF),(0x8FF6C0),
(0x8FF6C1),(0x8FF6C2),(0x8FF6C3),(0x8FF6C4),(0x8FF6C5),(0x8FF6C6),(0x8FF6C7),(0x8FF6C8),
(0x8FF6C9),(0x8FF6CA),(0x8FF6CB),(0x8FF6CC),(0x8FF6CD),(0x8FF6CE),(0x8FF6CF),(0x8FF6D0),
(0x8FF6D1),(0x8FF6D2),(0x8FF6D3),(0x8FF6D4),(0x8FF6D5),(0x8FF6D6),(0x8FF6D7),(0x8FF6D8),
(0x8FF6D9),(0x8FF6DA),(0x8FF6DB),(0x8FF6DC),(0x8FF6DD),(0x8FF6DE),(0x8FF6DF),(0x8FF6E0),
(0x8FF6E1),(0x8FF6E2),(0x8FF6E3),(0x8FF6E4),(0x8FF6E5),(0x8FF6E6),(0x8FF6E7),(0x8FF6E8),
(0x8FF6E9),(0x8FF6EA),(0x8FF6EB),(0x8FF6EC),(0x8FF6ED),(0x8FF6EE),(0x8FF6EF),(0x8FF6F0),
(0x8FF6F1),(0x8FF6F2),(0x8FF6F3),(0x8FF6F4),(0x8FF6F5),(0x8FF6F6),(0x8FF6F7),(0x8FF6F8),
(0x8FF6F9),(0x8FF6FA),(0x8FF6FB),(0x8FF6FC),(0x8FF6FD),(0x8FF6FE),
(0x8FF7A1),(0x8FF7A2),(0x8FF7A3),(0x8FF7A4),(0x8FF7A5),(0x8FF7A6),(0x8FF7A7),(0x8FF7A8),
(0x8FF7A9),(0x8FF7AA),(0x8FF7AB),(0x8FF7AC),(0x8FF7AD),(0x8FF7AE),(0x8FF7AF),(0x8FF7B0),
(0x8FF7B1),(0x8FF7B2),(0x8FF7B3),(0x8FF7B4),(0x8FF7B5),(0x8FF7B6),(0x8FF7B7),(0x8FF7B8),
(0x8FF7B9),(0x8FF7BA),(0x8FF7BB),(0x8FF7BC),(0x8FF7BD),(0x8FF7BE),(0x8FF7BF),(0x8FF7C0),
(0x8FF7C1),(0x8FF7C2),(0x8FF7C3),(0x8FF7C4),(0x8FF7C5),(0x8FF7C6),(0x8FF7C7),(0x8FF7C8),
(0x8FF7C9),(0x8FF7CA),(0x8FF7CB),(0x8FF7CC),(0x8FF7CD),(0x8FF7CE),(0x8FF7CF),(0x8FF7D0),
(0x8FF7D1),(0x8FF7D2),(0x8FF7D3),(0x8FF7D4),(0x8FF7D5),(0x8FF7D6),(0x8FF7D7),(0x8FF7D8),
(0x8FF7D9),(0x8FF7DA),(0x8FF7DB),(0x8FF7DC),(0x8FF7DD),(0x8FF7DE),(0x8FF7DF),(0x8FF7E0),
(0x8FF7E1),(0x8FF7E2),(0x8FF7E3),(0x8FF7E4),(0x8FF7E5),(0x8FF7E6),(0x8FF7E7),(0x8FF7E8),
(0x8FF7E9),(0x8FF7EA),(0x8FF7EB),(0x8FF7EC),(0x8FF7ED),(0x8FF7EE),(0x8FF7EF),(0x8FF7F0),
(0x8FF7F1),(0x8FF7F2),(0x8FF7F3),(0x8FF7F4),(0x8FF7F5),(0x8FF7F6),(0x8FF7F7),(0x8FF7F8),
(0x8FF7F9),(0x8FF7FA),(0x8FF7FB),(0x8FF7FC),(0x8FF7FD),(0x8FF7FE),
(0x8FF8A1),(0x8FF8A2),(0x8FF8A3),(0x8FF8A4),(0x8FF8A5),(0x8FF8A6),(0x8FF8A7),(0x8FF8A8),
(0x8FF8A9),(0x8FF8AA),(0x8FF8AB),(0x8FF8AC),(0x8FF8AD),(0x8FF8AE),(0x8FF8AF),(0x8FF8B0),
(0x8FF8B1),(0x8FF8B2),(0x8FF8B3),(0x8FF8B4),(0x8FF8B5),(0x8FF8B6),(0x8FF8B7),(0x8FF8B8),
(0x8FF8B9),(0x8FF8BA),(0x8FF8BB),(0x8FF8BC),(0x8FF8BD),(0x8FF8BE),(0x8FF8BF),(0x8FF8C0),
(0x8FF8C1),(0x8FF8C2),(0x8FF8C3),(0x8FF8C4),(0x8FF8C5),(0x8FF8C6),(0x8FF8C7),(0x8FF8C8),
(0x8FF8C9),(0x8FF8CA),(0x8FF8CB),(0x8FF8CC),(0x8FF8CD),(0x8FF8CE),(0x8FF8CF),(0x8FF8D0),
(0x8FF8D1),(0x8FF8D2),(0x8FF8D3),(0x8FF8D4),(0x8FF8D5),(0x8FF8D6),(0x8FF8D7),(0x8FF8D8),
(0x8FF8D9),(0x8FF8DA),(0x8FF8DB),(0x8FF8DC),(0x8FF8DD),(0x8FF8DE),(0x8FF8DF),(0x8FF8E0),
(0x8FF8E1),(0x8FF8E2),(0x8FF8E3),(0x8FF8E4),(0x8FF8E5),(0x8FF8E6),(0x8FF8E7),(0x8FF8E8),
(0x8FF8E9),(0x8FF8EA),(0x8FF8EB),(0x8FF8EC),(0x8FF8ED),(0x8FF8EE),(0x8FF8EF),(0x8FF8F0),
(0x8FF8F1),(0x8FF8F2),(0x8FF8F3),(0x8FF8F4),(0x8FF8F5),(0x8FF8F6),(0x8FF8F7),(0x8FF8F8),
(0x8FF8F9),(0x8FF8FA),(0x8FF8FB),(0x8FF8FC),(0x8FF8FD),(0x8FF8FE),
(0x8FF9A1),(0x8FF9A2),(0x8FF9A3),(0x8FF9A4),(0x8FF9A5),(0x8FF9A6),(0x8FF9A7),(0x8FF9A8),
(0x8FF9A9),(0x8FF9AA),(0x8FF9AB),(0x8FF9AC),(0x8FF9AD),(0x8FF9AE),(0x8FF9AF),(0x8FF9B0),
(0x8FF9B1),(0x8FF9B2),(0x8FF9B3),(0x8FF9B4),(0x8FF9B5),(0x8FF9B6),(0x8FF9B7),(0x8FF9B8),
(0x8FF9B9),(0x8FF9BA),(0x8FF9BB),(0x8FF9BC),(0x8FF9BD),(0x8FF9BE),(0x8FF9BF),(0x8FF9C0),
(0x8FF9C1),(0x8FF9C2),(0x8FF9C3),(0x8FF9C4),(0x8FF9C5),(0x8FF9C6),(0x8FF9C7),(0x8FF9C8),
(0x8FF9C9),(0x8FF9CA),(0x8FF9CB),(0x8FF9CC),(0x8FF9CD),(0x8FF9CE),(0x8FF9CF),(0x8FF9D0),
(0x8FF9D1),(0x8FF9D2),(0x8FF9D3),(0x8FF9D4),(0x8FF9D5),(0x8FF9D6),(0x8FF9D7),(0x8FF9D8),
(0x8FF9D9),(0x8FF9DA),(0x8FF9DB),(0x8FF9DC),(0x8FF9DD),(0x8FF9DE),(0x8FF9DF),(0x8FF9E0),
(0x8FF9E1),(0x8FF9E2),(0x8FF9E3),(0x8FF9E4),(0x8FF9E5),(0x8FF9E6),(0x8FF9E7),(0x8FF9E8),
(0x8FF9E9),(0x8FF9EA),(0x8FF9EB),(0x8FF9EC),(0x8FF9ED),(0x8FF9EE),(0x8FF9EF),(0x8FF9F0),
(0x8FF9F1),(0x8FF9F2),(0x8FF9F3),(0x8FF9F4),(0x8FF9F5),(0x8FF9F6),(0x8FF9F7),(0x8FF9F8),
(0x8FF9F9),(0x8FF9FA),(0x8FF9FB),(0x8FF9FC),(0x8FF9FD),(0x8FF9FE),
(0x8FFAA1),(0x8FFAA2),(0x8FFAA3),(0x8FFAA4),(0x8FFAA5),(0x8FFAA6),(0x8FFAA7),(0x8FFAA8),
(0x8FFAA9),(0x8FFAAA),(0x8FFAAB),(0x8FFAAC),(0x8FFAAD),(0x8FFAAE),(0x8FFAAF),(0x8FFAB0),
(0x8FFAB1),(0x8FFAB2),(0x8FFAB3),(0x8FFAB4),(0x8FFAB5),(0x8FFAB6),(0x8FFAB7),(0x8FFAB8),
(0x8FFAB9),(0x8FFABA),(0x8FFABB),(0x8FFABC),(0x8FFABD),(0x8FFABE),(0x8FFABF),(0x8FFAC0),
(0x8FFAC1),(0x8FFAC2),(0x8FFAC3),(0x8FFAC4),(0x8FFAC5),(0x8FFAC6),(0x8FFAC7),(0x8FFAC8),
(0x8FFAC9),(0x8FFACA),(0x8FFACB),(0x8FFACC),(0x8FFACD),(0x8FFACE),(0x8FFACF),(0x8FFAD0),
(0x8FFAD1),(0x8FFAD2),(0x8FFAD3),(0x8FFAD4),(0x8FFAD5),(0x8FFAD6),(0x8FFAD7),(0x8FFAD8),
(0x8FFAD9),(0x8FFADA),(0x8FFADB),(0x8FFADC),(0x8FFADD),(0x8FFADE),(0x8FFADF),(0x8FFAE0),
(0x8FFAE1),(0x8FFAE2),(0x8FFAE3),(0x8FFAE4),(0x8FFAE5),(0x8FFAE6),(0x8FFAE7),(0x8FFAE8),
(0x8FFAE9),(0x8FFAEA),(0x8FFAEB),(0x8FFAEC),(0x8FFAED),(0x8FFAEE),(0x8FFAEF),(0x8FFAF0),
(0x8FFAF1),(0x8FFAF2),(0x8FFAF3),(0x8FFAF4),(0x8FFAF5),(0x8FFAF6),(0x8FFAF7),(0x8FFAF8),
(0x8FFAF9),(0x8FFAFA),(0x8FFAFB),(0x8FFAFC),(0x8FFAFD),(0x8FFAFE),
(0x8FFBA1),(0x8FFBA2),(0x8FFBA3),(0x8FFBA4),(0x8FFBA5),(0x8FFBA6),(0x8FFBA7),(0x8FFBA8),
(0x8FFBA9),(0x8FFBAA),(0x8FFBAB),(0x8FFBAC),(0x8FFBAD),(0x8FFBAE),(0x8FFBAF),(0x8FFBB0),
(0x8FFBB1),(0x8FFBB2),(0x8FFBB3),(0x8FFBB4),(0x8FFBB5),(0x8FFBB6),(0x8FFBB7),(0x8FFBB8),
(0x8FFBB9),(0x8FFBBA),(0x8FFBBB),(0x8FFBBC),(0x8FFBBD),(0x8FFBBE),(0x8FFBBF),(0x8FFBC0),
(0x8FFBC1),(0x8FFBC2),(0x8FFBC3),(0x8FFBC4),(0x8FFBC5),(0x8FFBC6),(0x8FFBC7),(0x8FFBC8),
(0x8FFBC9),(0x8FFBCA),(0x8FFBCB),(0x8FFBCC),(0x8FFBCD),(0x8FFBCE),(0x8FFBCF),(0x8FFBD0),
(0x8FFBD1),(0x8FFBD2),(0x8FFBD3),(0x8FFBD4),(0x8FFBD5),(0x8FFBD6),(0x8FFBD7),(0x8FFBD8),
(0x8FFBD9),(0x8FFBDA),(0x8FFBDB),(0x8FFBDC),(0x8FFBDD),(0x8FFBDE),(0x8FFBDF),(0x8FFBE0),
(0x8FFBE1),(0x8FFBE2),(0x8FFBE3),(0x8FFBE4),(0x8FFBE5),(0x8FFBE6),(0x8FFBE7),(0x8FFBE8),
(0x8FFBE9),(0x8FFBEA),(0x8FFBEB),(0x8FFBEC),(0x8FFBED),(0x8FFBEE),(0x8FFBEF),(0x8FFBF0),
(0x8FFBF1),(0x8FFBF2),(0x8FFBF3),(0x8FFBF4),(0x8FFBF5),(0x8FFBF6),(0x8FFBF7),(0x8FFBF8),
(0x8FFBF9),(0x8FFBFA),(0x8FFBFB),(0x8FFBFC),(0x8FFBFD),(0x8FFBFE),
(0x8FFCA1),(0x8FFCA2),(0x8FFCA3),(0x8FFCA4),(0x8FFCA5),(0x8FFCA6),(0x8FFCA7),(0x8FFCA8),
(0x8FFCA9),(0x8FFCAA),(0x8FFCAB),(0x8FFCAC),(0x8FFCAD),(0x8FFCAE),(0x8FFCAF),(0x8FFCB0),
(0x8FFCB1),(0x8FFCB2),(0x8FFCB3),(0x8FFCB4),(0x8FFCB5),(0x8FFCB6),(0x8FFCB7),(0x8FFCB8),
(0x8FFCB9),(0x8FFCBA),(0x8FFCBB),(0x8FFCBC),(0x8FFCBD),(0x8FFCBE),(0x8FFCBF),(0x8FFCC0),
(0x8FFCC1),(0x8FFCC2),(0x8FFCC3),(0x8FFCC4),(0x8FFCC5),(0x8FFCC6),(0x8FFCC7),(0x8FFCC8),
(0x8FFCC9),(0x8FFCCA),(0x8FFCCB),(0x8FFCCC),(0x8FFCCD),(0x8FFCCE),(0x8FFCCF),(0x8FFCD0),
(0x8FFCD1),(0x8FFCD2),(0x8FFCD3),(0x8FFCD4),(0x8FFCD5),(0x8FFCD6),(0x8FFCD7),(0x8FFCD8),
(0x8FFCD9),(0x8FFCDA),(0x8FFCDB),(0x8FFCDC),(0x8FFCDD),(0x8FFCDE),(0x8FFCDF),(0x8FFCE0),
(0x8FFCE1),(0x8FFCE2),(0x8FFCE3),(0x8FFCE4),(0x8FFCE5),(0x8FFCE6),(0x8FFCE7),(0x8FFCE8),
(0x8FFCE9),(0x8FFCEA),(0x8FFCEB),(0x8FFCEC),(0x8FFCED),(0x8FFCEE),(0x8FFCEF),(0x8FFCF0),
(0x8FFCF1),(0x8FFCF2),(0x8FFCF3),(0x8FFCF4),(0x8FFCF5),(0x8FFCF6),(0x8FFCF7),(0x8FFCF8),
(0x8FFCF9),(0x8FFCFA),(0x8FFCFB),(0x8FFCFC),(0x8FFCFD),(0x8FFCFE),
(0x8FFDA1),(0x8FFDA2),(0x8FFDA3),(0x8FFDA4),(0x8FFDA5),(0x8FFDA6),(0x8FFDA7),(0x8FFDA8),
(0x8FFDA9),(0x8FFDAA),(0x8FFDAB),(0x8FFDAC),(0x8FFDAD),(0x8FFDAE),(0x8FFDAF),(0x8FFDB0),
(0x8FFDB1),(0x8FFDB2),(0x8FFDB3),(0x8FFDB4),(0x8FFDB5),(0x8FFDB6),(0x8FFDB7),(0x8FFDB8),
(0x8FFDB9),(0x8FFDBA),(0x8FFDBB),(0x8FFDBC),(0x8FFDBD),(0x8FFDBE),(0x8FFDBF),(0x8FFDC0),
(0x8FFDC1),(0x8FFDC2),(0x8FFDC3),(0x8FFDC4),(0x8FFDC5),(0x8FFDC6),(0x8FFDC7),(0x8FFDC8),
(0x8FFDC9),(0x8FFDCA),(0x8FFDCB),(0x8FFDCC),(0x8FFDCD),(0x8FFDCE),(0x8FFDCF),(0x8FFDD0),
(0x8FFDD1),(0x8FFDD2),(0x8FFDD3),(0x8FFDD4),(0x8FFDD5),(0x8FFDD6),(0x8FFDD7),(0x8FFDD8),
(0x8FFDD9),(0x8FFDDA),(0x8FFDDB),(0x8FFDDC),(0x8FFDDD),(0x8FFDDE),(0x8FFDDF),(0x8FFDE0),
(0x8FFDE1),(0x8FFDE2),(0x8FFDE3),(0x8FFDE4),(0x8FFDE5),(0x8FFDE6),(0x8FFDE7),(0x8FFDE8),
(0x8FFDE9),(0x8FFDEA),(0x8FFDEB),(0x8FFDEC),(0x8FFDED),(0x8FFDEE),(0x8FFDEF),(0x8FFDF0),
(0x8FFDF1),(0x8FFDF2),(0x8FFDF3),(0x8FFDF4),(0x8FFDF5),(0x8FFDF6),(0x8FFDF7),(0x8FFDF8),
(0x8FFDF9),(0x8FFDFA),(0x8FFDFB),(0x8FFDFC),(0x8FFDFD),(0x8FFDFE),
(0x8FFEA1),(0x8FFEA2),(0x8FFEA3),(0x8FFEA4),(0x8FFEA5),(0x8FFEA6),(0x8FFEA7),(0x8FFEA8),
(0x8FFEA9),(0x8FFEAA),(0x8FFEAB),(0x8FFEAC),(0x8FFEAD),(0x8FFEAE),(0x8FFEAF),(0x8FFEB0),
(0x8FFEB1),(0x8FFEB2),(0x8FFEB3),(0x8FFEB4),(0x8FFEB5),(0x8FFEB6),(0x8FFEB7),(0x8FFEB8),
(0x8FFEB9),(0x8FFEBA),(0x8FFEBB),(0x8FFEBC),(0x8FFEBD),(0x8FFEBE),(0x8FFEBF),(0x8FFEC0),
(0x8FFEC1),(0x8FFEC2),(0x8FFEC3),(0x8FFEC4),(0x8FFEC5),(0x8FFEC6),(0x8FFEC7),(0x8FFEC8),
(0x8FFEC9),(0x8FFECA),(0x8FFECB),(0x8FFECC),(0x8FFECD),(0x8FFECE),(0x8FFECF),(0x8FFED0),
(0x8FFED1),(0x8FFED2),(0x8FFED3),(0x8FFED4),(0x8FFED5),(0x8FFED6),(0x8FFED7),(0x8FFED8),
(0x8FFED9),(0x8FFEDA),(0x8FFEDB),(0x8FFEDC),(0x8FFEDD),(0x8FFEDE),(0x8FFEDF),(0x8FFEE0),
(0x8FFEE1),(0x8FFEE2),(0x8FFEE3),(0x8FFEE4),(0x8FFEE5),(0x8FFEE6),(0x8FFEE7),(0x8FFEE8),
(0x8FFEE9),(0x8FFEEA),(0x8FFEEB),(0x8FFEEC),(0x8FFEED),(0x8FFEEE),(0x8FFEEF),(0x8FFEF0),
(0x8FFEF1),(0x8FFEF2),(0x8FFEF3),(0x8FFEF4),(0x8FFEF5),(0x8FFEF6),(0x8FFEF7),(0x8FFEF8),
(0x8FFEF9),(0x8FFEFA),(0x8FFEFB),(0x8FFEFC),(0x8FFEFD),(0x8FFEFE);
SELECT HEX(c1) FROM t1;
CREATE TABLE t2 SELECT CONVERT(c1 USING ucs2) AS c1 FROM t1;
SELECT HEX(c1) FROM t2;
CREATE TABLE t3 SELECT CONVERT(c1 USING eucjpms) AS c1 FROM t2;
SELECT HEX(c1) FROM t3;
CREATE TABLE t4 SELECT CONVERT(c1 USING cp932) AS c1 FROM t1;
SELECT HEX(c1) FROM t4;

DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
CREATE TABLE t1(c1 varchar(10)) default character set = eucjpms;

insert into t1 values(_ucs2 0x00F7);
insert into t1 values(_eucjpms 0xA1E0);
insert into t1 values(_ujis 0xA1E0);
insert into t1 values(_sjis 0x8180);
insert into t1 values(_cp932 0x8180);

SELECT HEX(c1) FROM t1;

DROP TABLE t1;

SET collation_connection='eucjpms_japanese_ci';
SET collation_connection='eucjpms_bin';

--
-- Bugs#15375: Unassigned multibyte codes are broken
-- into parts when converting to Unicode.
-- This query should return 0x003F0041. I.e. it should
-- scan unassigned double-byte character 0xA5FE, convert
-- it as QUESTION MARK 0x003F and then scan the next
-- character, which is a single byte character 0x41.
--
select hex(convert(_eucjpms 0xA5FE41 using ucs2));
select hex(convert(_eucjpms 0x8FABF841 using ucs2));


--
-- Bug #48053 String::c_ptr has a race and/or does an invalid 
--            memory reference
--            (triggered by Valgrind tests)
--  (see also ctype_eucjpms.test, ctype_cp1250.test, ctype_cp1251.test)
--
--error 1649
set global LC_TIME_NAMES=convert((convert((0x63) using eucjpms)) using utf8mb3);
SET NAMES utf8mb3;
SET collation_connection=eucjpms_japanese_ci;
CREATE TABLE t1 (b VARCHAR(2));
INSERT INTO t1 VALUES ('0'),('1'),('2'),('3'),('4'),('5'),('6'),('7');
INSERT INTO t1 VALUES ('8'),('9'),('A'),('B'),('C'),('D'),('E'),('F');
CREATE TEMPORARY TABLE head AS SELECT concat(b1.b, b2.b) AS head FROM t1 b1, t1 b2;
CREATE TEMPORARY TABLE tail AS SELECT concat(b1.b, b2.b) AS tail FROM t1 b1, t1 b2;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT 'XXXXXX' AS code, ' ' AS a LIMIT 0;
INSERT INTO t1 (code) SELECT concat('8E', head) FROM head
WHERE (head BETWEEN 'A1' AND 'DF') ORDER BY head;
INSERT INTO t1 (code) SELECT concat(head, tail)
FROM head, tail
WHERE (head BETWEEN '80' AND 'FF') AND (head NOT BETWEEN '8E' AND '8F')
AND (tail BETWEEN '20' AND 'FF')
ORDER BY head, tail;
INSERT INTO t1 (code) SELECT concat('8F', head, tail)
FROM head, tail
WHERE (head BETWEEN '80' AND 'FF') AND (tail BETWEEN '20' AND 'FF')
ORDER BY head, tail;
DROP TEMPORARY TABLE head, tail;

-- Set max_error_count to contain number of warnings in result file.
SET @@session.max_error_count = 64;
UPDATE IGNORE t1 SET a=unhex(code) ORDER BY code;
SET @@session.max_error_count = default;
SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM t1 WHERE a<>'';
SELECT COUNT(*) FROM t1 WHERE a<>'' AND OCTET_LENGTH(a)=2;
SELECT * FROM t1 WHERE CHAR_LENGTH(a)=2;
SELECT COUNT(*) FROM t1 WHERE a<>'' AND OCTET_LENGTH(a)=3;


--
-- Display all characters that have upper or lower case mapping.
--
SELECT code, hex(upper(a)), hex(lower(a)),a, upper(a), lower(a) FROM t1 WHERE hex(a)<>hex(upper(a)) OR hex(a)<>hex(lower(a)) ORDER BY code;
SELECT * FROM t1
WHERE HEX(CAST(LOWER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(LOWER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
SELECT * FROM t1
WHERE HEX(CAST(UPPER(a) AS CHAR CHARACTER SET utf8mb3)) <>
      HEX(UPPER(CAST(a AS CHAR CHARACTER SET utf8mb3))) ORDER BY code;
SELECT HEX(a), HEX(CONVERT(a USING utf8mb3)) as b FROM t1
WHERE a<>'' HAVING b<>'3F' ORDER BY code;

DROP TABLE t1;
SELECT HEX(a), HEX(CONVERT(a using sjis)) as b FROM t1 HAVING b<>'3F' ORDER BY BINARY a;
DROP TABLE t1;

set names eucjpms;

set collation_connection=eucjpms_bin;

--
-- Bugs#12635232: VALGRIND WARNINGS: IS_IPV6, IS_IPV4, INET6_ATON,
-- INET6_NTOA + MULTIBYTE CHARSET.
--

SET NAMES eucjpms;
