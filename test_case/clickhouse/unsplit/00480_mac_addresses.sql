SELECT '01:02:03:04:05:06' AS mac_str, MACStringToNum(mac_str) AS mac_num, hex(mac_num), MACNumToString(mac_num) AS mac_str2, mac_str = mac_str2, MACStringToOUI(mac_str) AS oui_num, hex(oui_num), MACStringToOUI(substring(mac_str, 1, 8)) AS oui_num2, oui_num = oui_num2;
