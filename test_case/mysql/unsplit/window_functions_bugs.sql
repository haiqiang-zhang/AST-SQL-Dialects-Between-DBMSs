CREATE TABLE H (
col_varchar_10_utf8 varchar(10)  CHARACTER SET utf8mb3,
col_varchar_255_latin1_key varchar(255)  CHARACTER SET latin1,
col_varchar_10_latin1_key varchar(10)  CHARACTER SET latin1,
col_varchar_10_latin1 varchar(10)  CHARACTER SET latin1,
col_varchar_10_utf8_key varchar(10)  CHARACTER SET utf8mb3,
col_varchar_255_utf8_key varchar(255)  CHARACTER SET utf8mb3,
col_int int,
col_int_key int,
col_varchar_255_utf8 varchar(255)  CHARACTER SET utf8mb3,
pk integer auto_increment,
col_varchar_255_latin1 varchar(255)  CHARACTER SET latin1,
/*Indices*/
key (col_varchar_255_latin1_key ),
key (col_varchar_10_latin1_key ),
key (col_varchar_10_utf8_key ),
key (col_varchar_255_utf8_key ),
key (col_int_key ),
primary key (pk)) ENGINE=innodb;
INSERT IGNORE INTO H VALUES
('about', 'z', 'they', 'm', 'x', 'could',
3, 155189248,
'xyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemclpylcufjtmzxbutyghfkezxvfwojgolicczdqpqtwnugrwwcxumxofffljfhpkpddctnalygeuaugnnwxylfjdpzwvybdgtfyagjeqniouizgdzbhwahrylqwmnqzcjrhoivxidqmuikodwulsugcmwtxsadjdztkpdwbdxtvckayxskunxtompmmcbgiyedwfbjafnpcbvmxnrzvubwpnxfuzndvkxkfhjnzdvvkowuizfymqqexdtppmiznrhwfsngzbcvrynormfrjlflywpsmcsifmjuvwislbtaivizpbisvasqpyscnanwlttnqpzpdbiphzuujfksinzkcbbarimkigwdxjhscyrlmiqglyrdrwvhyoltdmpqlyzgknqzmfptjcmzeyokthfkdktzcsohicugzwgevhnsublfvasvftxhgk', NULL, 't');
CREATE TABLE DD (
col_varchar_255_latin1_key varchar(255)  CHARACTER SET latin1,
col_varchar_255_utf8_key varchar(255)  CHARACTER SET utf8mb3,
col_varchar_255_latin1 varchar(255)  CHARACTER SET latin1,
col_varchar_10_latin1_key varchar(10)  CHARACTER SET latin1,
col_int_key int,
col_varchar_255_utf8 varchar(255)  CHARACTER SET utf8mb3,
pk integer auto_increment,
col_varchar_10_utf8 varchar(10)  CHARACTER SET utf8mb3,
col_int int,
col_varchar_10_latin1 varchar(10)  CHARACTER SET latin1,
col_varchar_10_utf8_key varchar(10)  CHARACTER SET utf8mb3,
/*Indices*/
key (col_varchar_255_latin1_key ),
key (col_varchar_255_utf8_key ),
key (col_varchar_10_latin1_key ),
key (col_int_key ),
primary key (pk),
key (col_varchar_10_utf8_key )) ENGINE=innodb;
INSERT IGNORE INTO DD VALUES  ('q',
'brmucbzjaeueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemclpylcufjtmzxbutyghfkezxvfwojgolicczdqpqtwnugrwwcxumxofffljfhpkpddctnalygeuaugnnwxylfjdpzwvybdgtfyagjeqniouizgdzbhwahrylqwmnqzcjrhoivxidqmuikodwulsugcmwtxsadjdztkpdwbdxtvckayxskunxtompmmcbgiyedwfbjafnpcbvmxnrzvubwpnxfuzndvkxkf', 'now',
'you\'re', 1811152896, 'or', NULL, 'this', 6, 'then', 'e') ,  ('did', 'j',
'they',
'rmucbzjaeueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemclpylcufjtmzxbutyghfkezxvfwojgolicczdqpqtwnugrwwcxumxofffljfhpkpddctnalygeuaugnnwxylfjdpzwvybdgtfyagjeqniouizgdzbhwahrylqwmnqzcjrhoivxidqmuikodwulsugcmwtxsadjdztkpdwbdxtvckayxskunxtompmmcbgiyedwfbjafnpcbvmxnrzvubwpnxfuzndvkxkfhjnzdvvkowu',
2087649280,
'mucbzjaeueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbm',
NULL, 'would', -64421888, 'I\'m', 'do') ,  ('l',
'ucbzjaeueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillur', 'yes', 'it', 8,
'cbzjaeueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgke', NULL,'bzjaeueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemclpylc', 5,
'zjaeueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbquk', 'i') ,
('d', 'l', 'u',
'jaeueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemclpylcufjtmzxbutyghfke', -772603904, 'yes', NULL, 'l', 1, 'p',
'aeueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemclpylcufjtmzxbutyghfkezxvfwojgolicczdqpqtwnugrwwcxumxofffljfhpkpddctnalygeuaugnnwxylfjdpzwvybdgtfyagjeqniouizgdzbhwahrylqwmnqzcjrhoivxidqmuikodwulsugcmwtxsadjdztkpdwbdxtvckayxskunxtompmmcbgiyedwfbjafnpcbvmxnrzvubwpnxfuz') ,  ('well',
'eueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkje
bunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwgg
kspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuz
jvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxy
odli', 'of', 'on', 0,
'ueffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjeb
unithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggk
spxpaoxldymllvikfrwhblzugcnlgmoz', NULL,'effwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkb',
-479461376,
'ffwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemcl','fwxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemclpylcufjtmzxbutyghfkezxvfwojgolicczdqpqtwnugrwwcxumxofff') ,
('wxeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcb', 'we', 'w', 'me', 0,
'xeyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmr', NULL, 'with', 6, 'for', 'b') ,  ('say', 'l', 't', 'b', 9,
'eyonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflm', NULL, 'she', 8, 'come',
'yonrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmf')
,  ('or', 'c', 'q', 'from', 559546368, 'as', NULL, 'q', -988545024, 'do',
'onrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnb') ,
('nrgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemclpylcufjtmzxbutyghfkezxvfwojgolicczdqpqtwnugrwwcxumxofffljfhpkpddctnalygeuaugnnwxylfjdpzwvybdgtfyagjeqniouizgdzbhwahrylqwmnqzcjrhoivxi', 'one', 'n',
'rgouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemclpylcufjtmzxbutyghfkezxvfwojgolicczdq', -681639936,'gouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiunassfsitgtnbbqukaeoubigzikncxyodlihgflmcbkqxdcvjpiqmnoorrutfxankapsmbdiicuytbwekanfyklnbjliaaebckybutdqwptyalaxaeuihzhclgqsmahtzogdxwslioxailzxafyztqpcakqukruoggiuemclpylcufjtmzxbutyghfkezxvfwojgolicczdqpqtwnugrwwcxumxofffljfhpkpddctnalygeuaugnnwxylfjdpzwvybdgtfyagjeqniouizgdzbhwahrylqwmnqzcjrhoivxidqmuikodwulsugcmwtxsadjdztkpdwbdxtvckayxskunxtompmmcbgiyedwfbjafnpcbvmxnrzvubwpnxfuzndvkxkf', NULL, 'n', 5, 'p','ouqbsvekyzrfizdybnlisnzpgplythqeyugzvhzjmxhmzqnbmldcuskteeyxqeesumyuohkhmoxtlpsumxsuahxrnybqsdvkiiiiatzeihtiwqjgxrspppoytvmuufhhkcgbnpemioxkjebunithymftmsroaqsxdrxhcozhqdagsxfxndeimavrxfdocfgafdxzxqoehcikppndcieybkyxmumqsbcwcmmrweiprthlrnphvebnfgjfhrkrxxorzzbedateyoomxdzgkevuyyvmusoduugukillurhwggkspxpaoxldymllvikfrwhblzugcnlgmozwbhvpytvyogbythupkkfgjqpqjgprksqcndkbsrzgiuvqgkqtqvucjdnyfqhigpgfeclnxyrkcxviqrwelsktxpoecytteiloxyzksesbdqhrcrfdzuxboyppuzjvssddkrsgvagetbssudtdsxcmpqpemiqbztutrkxougxqcpwlacgbyktskefotymojkkjnbkvkmqjgzrvmfpzwkixtxioqbzfvomgkicobwpsjeyfcaxwqxegkkiun');
SELECT
alias1 . col_int AS field1 ,
CUME_DIST() OVER (   ORDER BY alias1 . pk) AS field2 ,
alias1 . col_int_key AS field3 ,
PERCENT_RANK() OVER ( ORDER BY  alias2 .col_varchar_255_utf8_key,
alias1 . col_varchar_10_latin1_key,  alias1. col_varchar_255_utf8 )
AS field4 ,
alias1 . col_int_key AS field5 ,
PERCENT_RANK() OVER (
PARTITION BY  alias2 .col_varchar_10_utf8,  alias1 .col_int_key,
alias2 .col_varchar_255_utf8
ORDER BY alias1. col_varchar_10_latin1
ROWS CURRENT ROW  ) AS field6 ,
alias1 . col_int AS field7 ,
RANK() OVER ( ORDER BY  alias1 . col_int ) AS field8 ,
alias2 . pk AS field9 ,
NTILE ( 1 ) OVER (
PARTITION BY
alias1 .col_varchar_255_latin1,alias2 . col_varchar_255_latin1,
alias1. col_varchar_255_utf8_key,  alias1. col_varchar_10_latin1,
alias2 . col_int_key
ORDER BY alias1 . col_int,  alias1 . col_int_key)
AS field10 ,
alias1 . col_int AS field11 ,
NTILE ( 5 ) OVER ( ORDER BY  alias1. col_int ) AS field12
FROM DD AS alias1 LEFT  JOIN H AS alias2
ON alias1 . pk =  alias2 . col_int
WHERE alias1 . pk > 3
GROUP BY
field1, alias1.pk, field3,alias2.col_varchar_255_utf8_key,
alias1.col_varchar_10_latin1_key,alias1.col_varchar_255_utf8, field5,
alias2.col_varchar_10_utf8,alias1.col_int_key,
alias2.col_varchar_255_utf8,alias1.col_varchar_10_latin1, field7,
alias1.col_int, field9,alias1.col_varchar_255_latin1,
alias2.col_varchar_255_latin1,alias1.col_varchar_255_utf8_key,
alias1.col_varchar_10_latin1,alias2.col_int_key, alias1.col_int,
alias1.col_int_key, field11,alias1.col_int
HAVING field3 >= 7
ORDER BY field10  , field6  , field4;
DROP TABLE DD,H;
CREATE TABLE t (a INT NOT NULL, b BLOB NOT NULL) ENGINE=INNODB;
CREATE VIEW v AS SELECT * FROM t;
INSERT INTO t VALUES (1, ''), (1, '');
SELECT a, PERCENT_RANK() OVER w1 FROM t GROUP BY b,1 WITH ROLLUP WINDOW w1 AS();
SELECT a, PERCENT_RANK() OVER w1 FROM v GROUP BY b,1 WITH ROLLUP WINDOW w1 AS();
DROP VIEW v;
DROP TABLE t;
CREATE TABLE t1 (doc JSON);
INSERT INTO t1 VALUES
 ('{"txt": "abcd"}'), ('{"txt": "bcde"}'),
 ('{"txt": "cdef"}'), ('{"txt": "defg"}');
SELECT doc->'$.txt', LAG(doc->'$.txt') OVER (ORDER BY doc->'$.txt') FROM t1;
DROP TABLE t1;
CREATE TABLE t(a INT);
INSERT INTO t VALUES (1), (2), (3);
SELECT FIRST_VALUE(-2605.952148) OVER
         (PARTITION BY a ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM t WINDOW w1 AS (PARTITION BY a);
SELECT LAST_VALUE(-2605.952148) OVER
         (PARTITION BY a ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM t WINDOW w1 AS (PARTITION BY a);
SELECT NTH_VALUE(-2605.952148, 1) OVER
         (PARTITION BY a ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM t WINDOW w1 AS (PARTITION BY a);
SELECT LEAD(-2605.952148, 1) OVER
         (PARTITION BY a ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM t WINDOW w1 AS (PARTITION BY a);
SELECT MAX(-2605.952148) OVER
         (PARTITION BY a ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM t WINDOW w1 AS (PARTITION BY a);
DROP TABLE t;
CREATE TABLE t1 ( i INTEGER);
INSERT INTO t1 VALUES (392),(392),(1027),(1027),(1027),(1034),(1039);
SELECT i, LAST_VALUE(i) OVER w FROM t1
WINDOW w AS (ORDER BY i RANGE BETWEEN 7 PRECEDING AND 1 PRECEDING);
DROP TABLE t1;
CREATE TABLE t(a INT);
INSERT INTO t values (1),(2),(3),(6),(0);
SELECT 1 FROM t WINDOW w AS(PARTITION BY NULL,NULL ORDER BY NULL ASC);
SELECT 1 FROM t WINDOW w AS(PARTITION BY 1+2,3+4,5+6 ORDER BY 1+2,3+4);
SELECT RANK() OVER w1 FROM t WINDOW w1 AS (ORDER BY a), w2 AS (w1);
SELECT RANK() OVER w2 FROM t WINDOW w1 AS (ORDER BY a), w2 AS (w1);
SELECT RANK() OVER w2 FROM t WINDOW w1 AS (ORDER BY a), w2 AS (w1), w3 AS (w1);
SELECT RANK() OVER w3 FROM t WINDOW w1 AS (w2), w3 AS (w2), w2 AS ();
SELECT RANK() OVER w1 FROM t WINDOW w2 AS (w1), w1 AS (ORDER BY a);
SELECT RANK() OVER w1 FROM t WINDOW w1 AS (ROWS UNBOUNDED PRECEDING);
DROP TABLE t;
CREATE TABLE t(c LONGTEXT NOT NULL);
INSERT INTO t VALUES ('1'), ('1'), ('1'), ('1');
SELECT FIRST_VALUE(c) OVER w fv, LAST_VALUE(c) OVER w lv
       FROM t WINDOW w AS (ORDER BY c
                           ROWS BETWEEN 3 FOLLOWING AND 5 FOLLOWING);
DROP TABLE t;
CREATE TABLE t(a BIT(52) NOT NULL, KEY(a));
INSERT INTO t VALUES (1), (1), (1);
SELECT EXISTS
    (SELECT a, LAST_VALUE(INET_ATON(1)) OVER() FROM t WHERE BIT_OR(1));
DROP TABLE t;
CREATE TABLE t (
f1 LONGTEXT GENERATED ALWAYS AS (_utf8mb4'1') VIRTUAL NOT NULL
);
INSERT INTO t VALUES();
SELECT LEAD(f1,1,1) OVER (ORDER BY f1) FROM t GROUP BY f1 WITH ROLLUP;
SELECT LAG(f1,1,1) OVER (ORDER BY f1) FROM t GROUP BY f1 WITH ROLLUP;
SELECT LAG((f1+3/2-1+5),1,1) OVER (ORDER BY f1) FROM t GROUP BY f1 WITH ROLLUP;
SELECT COALESCE(LAG(f1,1,1) OVER (ORDER BY f1)) FROM t GROUP BY f1 WITH ROLLUP;
DROP TABLE t;
CREATE TABLE t1(b INT);
INSERT INTO t1 VALUES (2);
INSERT INTO t1 VALUES (3);
SELECT VARIANCE(b) over w `var`,
       AVG(b) OVER w `avg`,
       SUM(b) OVER w `sum`,
       b,
       COUNT(b) OVER w count FROM t1
       WINDOW w as (ORDER BY b ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING);
SELECT VARIANCE(b) over w `var`,
       AVG(b) OVER w `avg`,
       SUM(b) OVER w `sum`,
       b,
       count(b) OVER w count FROM t1
       WINDOW w as (ORDER BY b ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING);
SELECT VARIANCE(b) over w `var`,
       AVG(b) OVER w `avg`,
       SUM(b) OVER w `sum`,
       b,
       count(b) OVER w count,
       LAST_VALUE(b) OVER w lastval FROM t1
       WINDOW w as (ORDER BY b ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING);
INSERT INTO t1 VALUES (2);
INSERT INTO t1 VALUES (3);
SELECT VARIANCE(b) over w `var`,
       FIRST_VALUE(b) over w fv,
       AVG(b) OVER w `avg`,
       SUM(b) OVER w `sum`,
       b,
       count(b) OVER w count FROM t1
       WINDOW w as (ORDER BY b ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT VARIANCE(b) over w `var`,
       FIRST_VALUE(b) over w fv,
       AVG(b) OVER w `avg`,
       SUM(b) OVER w `sum`,
       b,
       count(b) OVER w count FROM t1
       WINDOW w as (ORDER BY b ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
DROP TABLE t1;
CREATE TABLE t (a BIGINT,b INT);
INSERT INTO t VALUES (9223372036854775807,1);
INSERT INTO t VALUES (1,2);
DROP TABLE t;
CREATE TABLE t(f1 INTEGER);
INSERT INTO t VALUES(0),(1),(2),(3);
SELECT * FROM (SELECT IF(1, WEEKDAY('1'), ROW_NUMBER() OVER (PARTITION BY f1))
               FROM t) AS a;
DROP TABLE t;
CREATE TABLE t(a SMALLINT);
INSERT INTO t(a) VALUES (-32768), (-1), (32767), (32767), (1);
SELECT a, COUNT(a) OVER w, LAG(1,13) RESPECT NULLS OVER w
  FROM t
  WINDOW w AS (ORDER BY a RANGE BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING);
DROP TABLE t;
SELECT bit_count(sum(cos(-66365726))over());
SELECT bit_count(avg(cos(-66365726))over());
CREATE TABLE t(a DATETIME(6) NOT NULL)ENGINE=INNODB;
INSERT INTO t(a) VALUES('2008-01-01 00:22:33');
DROP TABLE t;
CREATE TABLE t(a INTEGER);
INSERT INTO t VALUES (1),(2),(3),(4);
SELECT NTILE(74) OVER(ORDER BY a ROWS BETWEEN CURRENT ROW AND
                      9223372036854775807 FOLLOWING) FROM t;
SELECT SUM(a) OVER(ORDER BY a ROWS BETWEEN 9223372036854775807 FOLLOWING AND
                   9223372036854775807 FOLLOWING) as `sum` FROM t;
SELECT SUM(a) OVER(ORDER BY a ROWS BETWEEN 9223372036854775806 FOLLOWING AND
                   9223372036854775807 FOLLOWING) as `sum` FROM t;
SELECT SUM(a) OVER(ORDER BY a ROWS BETWEEN 9223372036854775805 FOLLOWING AND
                   9223372036854775807 FOLLOWING) as `sum` FROM t;
SELECT SUM(a) OVER(ORDER BY a ROWS BETWEEN 9223372036854775807 FOLLOWING AND
                   9223372036854775805 FOLLOWING) as `sum` FROM t;
SELECT SUM(a) OVER(ORDER BY a ROWS BETWEEN 9223372036854775807 PRECEDING AND
                   9223372036854775805 PRECEDING) as `sum` FROM t;
DROP TABLE t;
CREATE TABLE t1 (i INTEGER);
SELECT 3 AS i, ROW_NUMBER() OVER (ORDER BY i) FROM t1;
DROP TABLE t1;
CREATE TABLE t ( a INT, b DATETIME(3));
INSERT t VALUES(1986,'9344-11-05 13:39:24.686');
INSERT t VALUES(1995,'7213-04-25 08:35:10.618');
INSERT t VALUES(1971,'9352-01-31 07:55:58.233');
SELECT SUM(a) OVER w FROM t
WINDOW w AS(ORDER BY a,b RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
DROP TABLE t;
CREATE TABLE t(
  a TEXT CHARACTER SET CP1251
  GENERATED ALWAYS AS (LPAD(1,10621933,10)) VIRTUAL,
  b BLOB
  GENERATED ALWAYS AS (LPAD(1,10622,10)) VIRTUAL
  ) ENGINE=INNODB;
PREPARE stmt FROM 'SELECT NTILE(39) OVER w1 FROM t
WINDOW w1 AS(ORDER BY a)';
PREPARE stmt FROM 'SELECT NTILE(39) OVER w1 FROM t
WINDOW w1 AS(ORDER BY b)';
DROP TABLE t;
CREATE TABLE t(i INT);
INSERT INTO t VALUES (0), (0), (0), (0), (1), (0), (0), (0);
SELECT DISTINCT i, 1 + SUM(i) OVER (ORDER BY i ROWS UNBOUNDED PRECEDING) FROM t;
SELECT DISTINCT 1 + SUM(i) OVER (ORDER BY i ROWS UNBOUNDED PRECEDING) FROM t;
DROP TABLE t;
CREATE TABLE t(a INT, b INT);
INSERT INTO t VALUES (1,1), (2,1), (3,2), (4,2), (5,3), (6,3);
INSERT INTO t VALUES (1,1), (4,2), (NULL, 2), (NULL, NULL), (2, NULL);
SELECT a,b, FIRST_VALUE(b) OVER w AS first, LAST_VALUE (a) OVER w AS last
    FROM t WINDOW w AS (ORDER BY a  desc RANGE 3 PRECEDING);
DROP TABLE t;
CREATE TABLE t1 (a TIMESTAMP NOT NULL);
INSERT INTO t1 VALUES ('2000-01-01 00:00:00');
SELECT a + INTERVAL(LAST_VALUE(1) OVER ()) SECOND FROM (SELECT a FROM t1) q;
DROP TABLE t1;
CREATE TABLE t1 (
  f1 INTEGER,
  t1_partkey INTEGER
);
CREATE TABLE t2 (
  t2_partkey INTEGER PRIMARY KEY
);
INSERT INTO t1 VALUES (34, 1), (10, 1), (4, 1), (6, 1),
                      (9, 2), (64, 2), (31,2);
INSERT INTO t2 VALUES (1), (2), (3), (4), (5), (6), (7);
SELECT 0.2 * AVG(f1) OVER w AS avg, f1
 FROM t1 JOIN t2 ON t1_partkey = t2_partkey
 WINDOW w AS (PARTITION BY t1_partkey);
DROP TABLE t1, t2;
CREATE TABLE t(f1 SET('a','b'), f2 INTEGER);
INSERT INTO t VALUES ('b',1), ('a',2), ('a,b',3), ('b',0), ('a',1);
SELECT FIRST_VALUE(f2) OVER(ORDER BY f1 RANGE CURRENT ROW) FROM t;
DROP TABLE t;
CREATE TABLE t1 ( a INTEGER NOT NULL );
INSERT INTO t1 VALUES (4);
SELECT a, SUM(a) OVER () AS s
FROM t1
GROUP BY a
ORDER BY a, s;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER, b INTEGER );
SELECT ROW_NUMBER() OVER (ORDER BY a), COUNT(*) AS m
FROM t1
GROUP BY a, b
ORDER BY a, b, m;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER );
PREPARE stmt FROM "SELECT RANK() OVER (ORDER BY a) FROM t1 GROUP BY a";
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER );
INSERT INTO t1 VALUES (0), (1);
SELECT a
  FROM t1 AS outer_t1
  WHERE (a,a) IN (
    SELECT MAX(a) OVER (), a FROM t1
  );
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER, b INTEGER, c INTEGER, d INTEGER, e INTEGER, f INTEGER, g INTEGER, h INTEGER, i INTEGER, j INTEGER, k INTEGER );
SELECT
  CUME_DIST() OVER (ORDER BY t1.a)
FROM
  t1
  NATURAL JOIN t1 AS t2
  NATURAL JOIN t1 AS t3
  NATURAL JOIN t1 AS t4
GROUP BY t1.a
WITH ROLLUP;
DROP TABLE t1;
CREATE TABLE t1 ( pk INTEGER );
INSERT INTO t1 VALUES (2);
SELECT SUM(pk) OVER (ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) FROM t1 GROUP BY pk WITH ROLLUP;
DROP TABLE t1;
CREATE TABLE t1 ( a LONGTEXT, b INTEGER );
INSERT INTO t1 VALUES ('1', 0);
SELECT
  a,
  SUM(1) OVER (ORDER BY b),
  SUM(1) OVER (ORDER BY b DESC)
FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER, b VARCHAR(255));
INSERT INTO t1 VALUES (1,'x');
INSERT INTO t1 VALUES (-3,'y');
CREATE TABLE t2 ( a INTEGER );
DROP TABLE t1, t2;
CREATE TABLE t1 ( a INTEGER );
SELECT DISTINCT
  0 AS field1,
  RANK() OVER (ORDER BY a) AS field2,
  LAST_VALUE(a) OVER (ORDER BY a + 1) AS field3
FROM t1
GROUP BY a, field1 WITH ROLLUP
ORDER BY field1, field2, field3;
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (1);
SELECT LAST_VALUE(0) OVER (ORDER BY (@f:='x')) FROM t1;
DROP TABLE t1;
CREATE TABLE t(a INT, b DOUBLE);
INSERT INTO t VALUES(1, 2.1);
INSERT INTO t VALUES(2, 1.4);
INSERT INTO t VALUES(1, 2.56);
INSERT INTO t VALUES(2, 2.23);
SELECT a, SUM(b)+1 AS cnt,
       ROW_NUMBER() OVER (ORDER BY SUM(b) DESC) AS rn
FROM t GROUP BY a ORDER BY rn;
SELECT a, ROUND(SUM(b), 2) AS cnt,
       ROW_NUMBER() OVER (ORDER BY SUM(b) DESC) AS rn
FROM t GROUP BY a ORDER BY rn DESC;
DROP TABLE t;
CREATE TABLE v0 (v1 INTEGER);
INSERT INTO v0 VALUES (1);
SELECT v1, (SELECT v1 FROM (SELECT AVG(0) OVER (), v1) AS v2) FROM v0;
DROP TABLE v0;
CREATE TABLE t(
  col1 INT, col2 INT,
  col3 INT, col4 INT, col5 INT,
  col6 INT, col7 INT, col8 INT, col9 INT, col10 INT,
  col11 INT, col12 INT, col13 INT, col14 INT, col15 INT,
  col16 INT, col17 INT, col18 INT, col19 INT, col20 INT,
  col21 INT, col22 INT, col23 INT, col24 INT, col25 INT,
  col26 INT, col27 INT, col28 INT, col29 INT, col30 INT,
  col31 INT, col32 INT, col33 INT, col34 INT, col35 INT,
  col36 INT, col37 INT, col38 INT, col39 INT, col40 INT,
  col41 INT, col42 INT, col43 INT, col44 INT, col45 INT,
  col46 INT, col47 INT, col48 INT, col49 INT, col50 INT,
  col51 INT, col52 INT, col53 INT, col54 INT, col55 INT,
  col56 INT, col57 INT, col58 INT, col59 INT, col60 INT,
  col61 INT, col62 INT, col63 INT, col64 INT, col65 INT,
  col66 INT, col67 INT, col68 INT, col69 INT, col70 INT);
SELECT
  FIRST_VALUE(col1) OVER (ORDER BY col1) AS wf1,
  FIRST_VALUE(col1) OVER (ORDER BY col2) AS wf2,
  FIRST_VALUE(col1) OVER (ORDER BY col3) AS wf3,
  FIRST_VALUE(col1) OVER (ORDER BY col4) AS wf4,
  FIRST_VALUE(col1) OVER (ORDER BY col5) AS wf5,
  FIRST_VALUE(col1) OVER (ORDER BY col6) AS wf6,
  FIRST_VALUE(col1) OVER (ORDER BY col7) AS wf7,
  FIRST_VALUE(col1) OVER (ORDER BY col8) AS wf8,
  FIRST_VALUE(col1) OVER (ORDER BY col9) AS wf9,
  FIRST_VALUE(col1) OVER (ORDER BY col10) AS wf10,
  FIRST_VALUE(col1) OVER (ORDER BY col11) AS wf11,
  FIRST_VALUE(col1) OVER (ORDER BY col12) AS wf12,
  FIRST_VALUE(col1) OVER (ORDER BY col13) AS wf13,
  FIRST_VALUE(col1) OVER (ORDER BY col14) AS wf14,
  FIRST_VALUE(col1) OVER (ORDER BY col15) AS wf15,
  FIRST_VALUE(col1) OVER (ORDER BY col16) AS wf16,
  FIRST_VALUE(col1) OVER (ORDER BY col17) AS wf17,
  FIRST_VALUE(col1) OVER (ORDER BY col18) AS wf18,
  FIRST_VALUE(col1) OVER (ORDER BY col19) AS wf19,
  FIRST_VALUE(col1) OVER (ORDER BY col20) AS wf20,
  FIRST_VALUE(col1) OVER (ORDER BY col21) AS wf21,
  FIRST_VALUE(col1) OVER (ORDER BY col22) AS wf22,
  FIRST_VALUE(col1) OVER (ORDER BY col23) AS wf23,
  FIRST_VALUE(col1) OVER (ORDER BY col24) AS wf24,
  FIRST_VALUE(col1) OVER (ORDER BY col25) AS wf25,
  FIRST_VALUE(col1) OVER (ORDER BY col26) AS wf26,
  FIRST_VALUE(col1) OVER (ORDER BY col27) AS wf27,
  FIRST_VALUE(col1) OVER (ORDER BY col28) AS wf28,
  FIRST_VALUE(col1) OVER (ORDER BY col29) AS wf29,
  FIRST_VALUE(col1) OVER (ORDER BY col30) AS wf30,
  FIRST_VALUE(col1) OVER (ORDER BY col31) AS wf31,
  FIRST_VALUE(col1) OVER (ORDER BY col32) AS wf32,
  FIRST_VALUE(col1) OVER (ORDER BY col33) AS wf33,
  FIRST_VALUE(col1) OVER (ORDER BY col34) AS wf34,
  FIRST_VALUE(col1) OVER (ORDER BY col35) AS wf35,
  FIRST_VALUE(col1) OVER (ORDER BY col36) AS wf36,
  FIRST_VALUE(col1) OVER (ORDER BY col37) AS wf37,
  FIRST_VALUE(col1) OVER (ORDER BY col38) AS wf38,
  FIRST_VALUE(col1) OVER (ORDER BY col39) AS wf39,
  FIRST_VALUE(col1) OVER (ORDER BY col40) AS wf40,
  FIRST_VALUE(col1) OVER (ORDER BY col41) AS wf41,
  FIRST_VALUE(col1) OVER (ORDER BY col42) AS wf42,
  FIRST_VALUE(col1) OVER (ORDER BY col43) AS wf43,
  FIRST_VALUE(col1) OVER (ORDER BY col44) AS wf44,
  FIRST_VALUE(col1) OVER (ORDER BY col45) AS wf45,
  FIRST_VALUE(col1) OVER (ORDER BY col46) AS wf46,
  FIRST_VALUE(col1) OVER (ORDER BY col47) AS wf47,
  FIRST_VALUE(col1) OVER (ORDER BY col48) AS wf48,
  FIRST_VALUE(col1) OVER (ORDER BY col49) AS wf49,
  FIRST_VALUE(col1) OVER (ORDER BY col50) AS wf50,
  FIRST_VALUE(col1) OVER (ORDER BY col51) AS wf51,
  FIRST_VALUE(col1) OVER (ORDER BY col52) AS wf52,
  FIRST_VALUE(col1) OVER (ORDER BY col53) AS wf53,
  FIRST_VALUE(col1) OVER (ORDER BY col54) AS wf54,
  FIRST_VALUE(col1) OVER (ORDER BY col55) AS wf55,
  FIRST_VALUE(col1) OVER (ORDER BY col56) AS wf56,
  FIRST_VALUE(col1) OVER (ORDER BY col57) AS wf57,
  FIRST_VALUE(col1) OVER (ORDER BY col58) AS wf58,
  FIRST_VALUE(col1) OVER (ORDER BY col59) AS wf59,
  FIRST_VALUE(col1) OVER (ORDER BY col60) AS wf60,
  FIRST_VALUE(col1) OVER (ORDER BY col61) AS wf61,
  FIRST_VALUE(col1) OVER (ORDER BY col62) AS wf62,
  FIRST_VALUE(col1) OVER (ORDER BY col63) AS wf63,
  FIRST_VALUE(col1) OVER (ORDER BY col64) AS wf64,
  FIRST_VALUE(col1) OVER (ORDER BY col65) AS wf65,
  FIRST_VALUE(col1) OVER (ORDER BY col66) AS wf66,
  FIRST_VALUE(col1) OVER (ORDER BY col67) AS wf67,
  FIRST_VALUE(col1) OVER (ORDER BY col68) AS wf68,
  FIRST_VALUE(col1) OVER (ORDER BY col69) AS wf69,
  FIRST_VALUE(col1) OVER (ORDER BY col70) AS wf70
FROM t;
SELECT DISTINCT
  FIRST_VALUE(col1) OVER (ORDER BY col1) AS wf1,
  FIRST_VALUE(col1) OVER (ORDER BY col2) AS wf2,
  FIRST_VALUE(col1) OVER (ORDER BY col3) AS wf3,
  FIRST_VALUE(col1) OVER (ORDER BY col4) AS wf4,
  FIRST_VALUE(col1) OVER (ORDER BY col5) AS wf5,
  FIRST_VALUE(col1) OVER (ORDER BY col6) AS wf6,
  FIRST_VALUE(col1) OVER (ORDER BY col7) AS wf7,
  FIRST_VALUE(col1) OVER (ORDER BY col8) AS wf8,
  FIRST_VALUE(col1) OVER (ORDER BY col9) AS wf9,
  FIRST_VALUE(col1) OVER (ORDER BY col10) AS wf10,
  FIRST_VALUE(col1) OVER (ORDER BY col11) AS wf11,
  FIRST_VALUE(col1) OVER (ORDER BY col12) AS wf12,
  FIRST_VALUE(col1) OVER (ORDER BY col13) AS wf13,
  FIRST_VALUE(col1) OVER (ORDER BY col14) AS wf14,
  FIRST_VALUE(col1) OVER (ORDER BY col15) AS wf15,
  FIRST_VALUE(col1) OVER (ORDER BY col16) AS wf16,
  FIRST_VALUE(col1) OVER (ORDER BY col17) AS wf17,
  FIRST_VALUE(col1) OVER (ORDER BY col18) AS wf18,
  FIRST_VALUE(col1) OVER (ORDER BY col19) AS wf19,
  FIRST_VALUE(col1) OVER (ORDER BY col20) AS wf20,
  FIRST_VALUE(col1) OVER (ORDER BY col21) AS wf21,
  FIRST_VALUE(col1) OVER (ORDER BY col22) AS wf22,
  FIRST_VALUE(col1) OVER (ORDER BY col23) AS wf23,
  FIRST_VALUE(col1) OVER (ORDER BY col24) AS wf24,
  FIRST_VALUE(col1) OVER (ORDER BY col25) AS wf25,
  FIRST_VALUE(col1) OVER (ORDER BY col26) AS wf26,
  FIRST_VALUE(col1) OVER (ORDER BY col27) AS wf27,
  FIRST_VALUE(col1) OVER (ORDER BY col28) AS wf28,
  FIRST_VALUE(col1) OVER (ORDER BY col29) AS wf29,
  FIRST_VALUE(col1) OVER (ORDER BY col30) AS wf30,
  FIRST_VALUE(col1) OVER (ORDER BY col31) AS wf31,
  FIRST_VALUE(col1) OVER (ORDER BY col32) AS wf32,
  FIRST_VALUE(col1) OVER (ORDER BY col33) AS wf33,
  FIRST_VALUE(col1) OVER (ORDER BY col34) AS wf34,
  FIRST_VALUE(col1) OVER (ORDER BY col35) AS wf35,
  FIRST_VALUE(col1) OVER (ORDER BY col36) AS wf36,
  FIRST_VALUE(col1) OVER (ORDER BY col37) AS wf37,
  FIRST_VALUE(col1) OVER (ORDER BY col38) AS wf38,
  FIRST_VALUE(col1) OVER (ORDER BY col39) AS wf39,
  FIRST_VALUE(col1) OVER (ORDER BY col40) AS wf40,
  FIRST_VALUE(col1) OVER (ORDER BY col41) AS wf41,
  FIRST_VALUE(col1) OVER (ORDER BY col42) AS wf42,
  FIRST_VALUE(col1) OVER (ORDER BY col43) AS wf43,
  FIRST_VALUE(col1) OVER (ORDER BY col44) AS wf44,
  FIRST_VALUE(col1) OVER (ORDER BY col45) AS wf45,
  FIRST_VALUE(col1) OVER (ORDER BY col46) AS wf46,
  FIRST_VALUE(col1) OVER (ORDER BY col47) AS wf47,
  FIRST_VALUE(col1) OVER (ORDER BY col48) AS wf48,
  FIRST_VALUE(col1) OVER (ORDER BY col49) AS wf49,
  FIRST_VALUE(col1) OVER (ORDER BY col50) AS wf50,
  FIRST_VALUE(col1) OVER (ORDER BY col51) AS wf51,
  FIRST_VALUE(col1) OVER (ORDER BY col52) AS wf52,
  FIRST_VALUE(col1) OVER (ORDER BY col53) AS wf53,
  FIRST_VALUE(col1) OVER (ORDER BY col54) AS wf54,
  FIRST_VALUE(col1) OVER (ORDER BY col55) AS wf55,
  FIRST_VALUE(col1) OVER (ORDER BY col56) AS wf56,
  FIRST_VALUE(col1) OVER (ORDER BY col57) AS wf57,
  FIRST_VALUE(col1) OVER (ORDER BY col58) AS wf58,
  FIRST_VALUE(col1) OVER (ORDER BY col59) AS wf59,
  FIRST_VALUE(col1) OVER (ORDER BY col60) AS wf60,
  FIRST_VALUE(col1) OVER (ORDER BY col61) AS wf61,
  FIRST_VALUE(col1) OVER (ORDER BY col62) AS wf62,
  FIRST_VALUE(col1) OVER (ORDER BY col63) AS wf63,
  FIRST_VALUE(col1) OVER (ORDER BY col64) AS wf64,
  FIRST_VALUE(col1) OVER (ORDER BY col65) AS wf65,
  FIRST_VALUE(col1) OVER (ORDER BY col66) AS wf66,
  FIRST_VALUE(col1) OVER (ORDER BY col67) AS wf67,
  FIRST_VALUE(col1) OVER (ORDER BY col68) AS wf68,
  FIRST_VALUE(col1) OVER (ORDER BY col69) AS wf69,
  FIRST_VALUE(col1) OVER (ORDER BY col70) AS wf70
FROM t;
DROP TABLE t;
CREATE TABLE t1 (f1 INTEGER, f2 INTEGER, f3 INTEGER);
INSERT INTO t1 VALUES (1,1,1),
                      (2,1,20),
                      (3,1,300),
                      (4,1,4000);
SELECT f1,f2,f3,
       FIRST_VALUE(f3) OVER w  AS 'FIRST_VALUE',
       LAG(f3) OVER w          AS 'LAG',
       NTH_VALUE(f3, 4) OVER w AS 'NTH_VALUE'
FROM t1 WINDOW w AS (PARTITION BY f2 ORDER BY f3
                     ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING);
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);
INSERT INTO t1 VALUES (1,1),(1,2),(2,1),(2,2);
SELECT f1, f2, DENSE_RANK() OVER (ORDER BY f1), RANK() OVER (ORDER BY f1)
FROM t1 GROUP BY f1,f2 WITH ROLLUP;
SELECT f1, f2, DENSE_RANK() OVER (ORDER BY f1), RANK() OVER (ORDER BY f1)
FROM t1 GROUP BY f1,f2;
DROP TABLE t1;
CREATE TABLE t (n INTEGER, r FLOAT);
INSERT INTO t VALUES (1, 1.0), (2, 2.0), (3, 3.0), (4, 4.0);
SELECT n
     , SUM(n)   OVER w AS "sum(n)"
     , COUNT(*) OVER w AS "count(n)"
     , AVG(n)   OVER w AS "avg(n)"
     , SUM(n)   OVER w / COUNT(*) OVER w AS "sum(n)/count(n)",
     r
     , SUM(r)   OVER w AS "sum(r)"
     , COUNT(*) OVER w AS "count(r)"
     , AVG(r)   OVER w AS "avg(r)"
     , SUM(r)   OVER w / COUNT(*) OVER w AS "sum(r)/count(r)"
FROM t WINDOW w AS (ORDER BY n ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
ORDER BY n;
SELECT n
     , SUM(n)   OVER w AS "sum(n)"
     , COUNT(*) OVER w AS "count(n)"
     , AVG(n)   OVER w AS "avg(n)"
     , SUM(n)   OVER w / COUNT(*) OVER w AS "sum(n)/count(n)",
     r
     , SUM(r)   OVER w AS "sum(r)"
     , COUNT(*) OVER w AS "count(r)"
     , AVG(r)   OVER w AS "avg(r)"
     , SUM(r)   OVER w / COUNT(*) OVER w AS "sum(r)/count(r)"
FROM t WINDOW w AS (ORDER BY n ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
ORDER BY n;
DROP TABLE t;
CREATE TABLE t1 ( a TIME );
INSERT INTO t1 VALUES ('02:00:00');
INSERT INTO t1 VALUES (NULL);
SELECT a, PERCENT_RANK() OVER (ORDER BY a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER, b INTEGER );
INSERT INTO t1 VALUES (0,NULL);
INSERT INTO t1 VALUES (NULL,1);
SELECT 1 FROM t1
ORDER BY BIT_OR(a) OVER (ORDER BY b ROWS CURRENT ROW);
SELECT SUM(a) OVER w
FROM t1
WINDOW w AS (ORDER BY b ROWS CURRENT ROW)
ORDER BY SUM(b) OVER w;
SELECT a, b, SUM(a) OVER w, SUM(b) OVER w
FROM t1
WINDOW w AS (ORDER BY b ROWS CURRENT ROW)
ORDER BY SUM(b) OVER w;
DROP TABLE t1;
CREATE TABLE t1(pk INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                c1 VARCHAR(10) DEFAULT NULL,
                c2 VARCHAR(10) DEFAULT NULL,
                c3 INT, KEY(c1));
INSERT INTO t1(c1, c2, c3) VALUES('am', 'it', 1);
DROP TABLE t1;
CREATE TABLE t(i INT);
INSERT INTO t(i) VALUES (100), (101);
PREPARE stmt1 FROM "
  SELECT a.i, (LAST_VALUE(a.i) OVER outer_window) = a.i AS result
  FROM (SELECT LAG(i) OVER inner_window AS i_lag,
               i AS i
        FROM t
        WINDOW inner_window AS (ORDER BY i) ) AS a
  WINDOW outer_window AS (ORDER BY a.i)";
DROP PREPARE stmt1;
DROP TABLE t;
CREATE TABLE table1(id INT);
INSERT INTO table1 VALUES(1),(2),(3),(4),(5),(6);
DROP TABLE table1;
CREATE TABLE t1 (c1 INT);
INSERT INTO t1 VALUES (NULL), (NULL), (-2128216064);
SELECT AVG( @A := c1 ) OVER (ROWS 1 PRECEDING) FROM t1;
SELECT @A;
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (0);
SELECT DISTINCT
       POW( COUNT(*), @a:=(SELECT 1 FROM t1 LEFT JOIN
                                         t1 AS t2
                                         ON @a)
          ) AS b
FROM t1 GROUP BY a;
SELECT DISTINCT
       pow( COUNT(*), @a:=(SELECT 1 FROM t1 LEFT JOIN
                                         t1 t2
                                         ON @a)
          ) AS `pow`,
       AVG( @a:= a ) OVER (ROWS 1 PRECEDING) AS `avg`
FROM t1 GROUP BY a;
SELECT @a;
SELECT DISTINCT
       pow( COUNT(*), @a:=(SELECT MAX( @a := t1.a) OVER w
                           FROM t1
                                LEFT JOIN
                                t1 t2
                                ON @a
                           WINDOW w AS (ROWS 1 PRECEDING)
                          )
          ) AS `pow`
FROM t1 GROUP BY a;
SELECT @a;
DROP TABLE t1;
CREATE TABLE t1(f1 INTEGER);
SELECT @A := (CUME_DIST() OVER () + f1 + RANK() OVER ()) FROM t1 GROUP BY f1 WITH ROLLUP;
DROP TABLE t1;
CREATE TABLE t0(c1 TINYINT UNSIGNED, c5 BIT);
INSERT INTO t0 VALUES
       (0,NULL),
       (0,NULL),
       (0,NULL),
       (0,NULL),
       (0,NULL),
       (12,_binary '\0'),
       (135,_binary '\0'),
       (193,_binary '\0'),
       (206,_binary '\0'),
       (244,_binary '\0'),
       (255,NULL),
       (255,NULL),
       (255,NULL);
SELECT NTH_VALUE(t0.c1, 97) OVER (
       ORDER BY t0.c1
       RANGE BETWEEN 99 FOLLOWING AND 51 FOLLOWING)
FROM t0;
INSERT INTO t0(c1) VALUES (135), (206), (193), (244), (255), (255), (255);
SELECT NTH_VALUE(c1, 2) OVER (ORDER BY c1 RANGE BETWEEN 60 FOLLOWING AND 100 FOLLOWING) FROM t0;
DROP TABLE t0;
