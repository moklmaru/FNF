luaDebugMode = true
luaDeprecatedWarnings = true
total = 18
stoping=false
local capsuleSpacing = 1  -- Ajusta el espacio entre cápsulas
local capsuleTexts = {
    "Random", "bopeebo-erect", "fresh-erect", "dadbattle-erect",
    "spookeez-erect", "south-erect", "pico-erect", "philly-nice-erect",
    "blammed-erect", "satin-panties-erect", "high-erect", "cocoa-erect",
    "eggnog-erect", "senpai-erect", "roses-erect", "thorns-erect",
    "ugh-erect", "Darnell-(BF-Mix)"
}

function onCreate()
    setPropertyFromClass('flixel.addons.transition.FlxTransitionableState', 'skipNextTransIn', true)
    setPropertyFromClass('flixel.addons.transition.FlxTransitionableState', 'skipNextTransOut', true)

    createInstance('camSkibidi', 'flixel.FlxCamera', {1120, 690,220,24, zoom})
    setProperty('camSkibidi.bgColor', 0x0)
    
    createInstance('camUlin', 'flixel.FlxCamera')
    setProperty('camUlin.bgColor', 0x0)

    createInstance('newCamOther', 'flixel.FlxCamera')
    setProperty('newCamOther.bgColor', 0x0)

    createInstance('camLua', 'flixel.FlxCamera')
    setProperty('camLua.bgColor', 0x0)
    
    createInstance('camUi', 'flixel.FlxCamera')
    setProperty('camUi.bgColor', 0x0)

    createInstance('camTop', 'flixel.FlxCamera')
    setProperty('camTop.bgColor', 0x0)

    createInstance('camStickers', 'flixel.FlxCamera')
    setProperty('camStickers.bgColor', 0x0)

    createInstance('bye', 'flixel.FlxCamera')
    setProperty('bye.bgColor', 0x0)

    callMethodFromClass('flixel.FlxG', 'cameras.remove', {instanceArg('camGame'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.remove', {instanceArg('camOther'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camOther'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('newCamOther'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camUlin'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camSkibidi'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camUi'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camTop'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camLua'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('camStickers'), false})
    callMethodFromClass('flixel.FlxG', 'cameras.add', {instanceArg('bye'), false})
    setProperty('luaDebugGroup.camera', instanceArg('camLua'), false, true)

    makeFlxAnimateSprite("freeplayStars1", 645, 355, "UpDaTe/freeplay/freeplayStars")
    loadAnimateAtlas("freeplayStars1", "UpDaTe/freeplay/freeplayStars")
    addAnimationBySymbolIndices('freeplayStars1', '1', 'diff stars', '1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '2', 'diff stars', '101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '3', 'diff stars', '200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '4', 'diff stars', '300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '5', 'diff stars', '400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '6', 'diff stars', '500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '7', 'diff stars', '600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '8', 'diff stars', '700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729, 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 740, 741, 742, 743, 744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 764, 765, 766, 767, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788, 789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '9', 'diff stars', '800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866, 867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '10', 'diff stars', '900, 901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914, 915, 916, 917, 918, 919, 920, 921, 922, 923, 924, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983, 984, 985, 986, 987, 988, 989, 990, 991, 992, 993, 994, 995, 996, 997, 998, 999', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '11', 'diff stars', '1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1096, 1097, 1098, 1099', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '12', 'diff stars', '1100, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159, 1160, 1161, 1162, 1163, 1164, 1165, 1166, 1167, 1168, 1169, 1170, 1171, 1172, 1173, 1174, 1175, 1176, 1177, 1178, 1179, 1180, 1181, 1182, 1183, 1184, 1185, 1186, 1187, 1188, 1189, 1190, 1191, 1192, 1193, 1194, 1195, 1196, 1197, 1198, 1199', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '13', 'diff stars', '1200, 1201, 1202, 1203, 1204, 1205, 1206, 1207, 1208, 1209, 1210, 1211, 1212, 1213, 1214, 1215, 1216, 1217, 1218, 1219, 1220, 1221, 1222, 1223, 1224, 1225, 1226, 1227, 1228, 1229, 1230, 1231, 1232, 1233, 1234, 1235, 1236, 1237, 1238, 1239, 1240, 1241, 1242, 1243, 1244, 1245, 1246, 1247, 1248, 1249, 1250, 1251, 1252, 1253, 1254, 1255, 1256, 1257, 1258, 1259, 1260, 1261, 1262, 1263, 1264, 1265, 1266, 1267, 1268, 1269, 1270, 1271, 1272, 1273, 1274, 1275, 1276, 1277, 1278, 1279, 1280, 1281, 1282, 1283, 1284, 1285, 1286, 1287, 1288, 1289, 1290, 1291, 1292, 1293, 1294, 1295, 1296, 1297, 1298, 1299', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '14', 'diff stars', '1300, 1301, 1302, 1303, 1304, 1305, 1306, 1307, 1308, 1309, 1310, 1311, 1312, 1313, 1314, 1315, 1316, 1317, 1318, 1319, 1320, 1321, 1322, 1323, 1324, 1325, 1326, 1327, 1328, 1329, 1330, 1331, 1332, 1333, 1334, 1335, 1336, 1337, 1338, 1339, 1340, 1341, 1342, 1343, 1344, 1345, 1346, 1347, 1348, 1349, 1350, 1351, 1352, 1353, 1354, 1355, 1356, 1357, 1358, 1359, 1360, 1361, 1362, 1363, 1364, 1365, 1366, 1367, 1368, 1369, 1370, 1371, 1372, 1373, 1374, 1375, 1376, 1377, 1378, 1379, 1380, 1381, 1382, 1383, 1384, 1385, 1386, 1387, 1388, 1389, 1390, 1391, 1392, 1393, 1394, 1395, 1396, 1397, 1398, 1399', 24, true);
    addAnimationBySymbolIndices('freeplayStars1', '15', 'diff stars', '1400, 1401, 1402, 1403, 1404, 1405, 1406, 1407, 1408, 1409, 1410, 1411, 1412, 1413, 1414, 1415, 1416, 1417, 1418, 1419, 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1428, 1429, 1430, 1431, 1432, 1433, 1434, 1435, 1436, 1437, 1438, 1439, 1440, 1441, 1442, 1443, 1444, 1445, 1446, 1447, 1448, 1449, 1450, 1451, 1452, 1453, 1454, 1455, 1456, 1457, 1458, 1459, 1460, 1461, 1462, 1463, 1464, 1465, 1466, 1467, 1468, 1469, 1470, 1471, 1472, 1473, 1474, 1475, 1476, 1477, 1478, 1479, 1480, 1481, 1482, 1483, 1484, 1485, 1486, 1487, 1488, 1489, 1490, 1491, 1492, 1493, 1494, 1495, 1496, 1497, 1498, 1499', 24, true);
    addLuaSprite("freeplayStars1",true)
    setProperty('freeplayStars1.camera', instanceArg('camTop'), false, true)

makeLuaSprite('byebye', '', 0, 0)
makeGraphic('byebye', 1280, 720, '000000')
addLuaSprite('byebye', true)
setProperty('byebye.alpha',0)
setProperty('byebye.camera', instanceArg('bye'), false, true)
    --
-- Definir los personajes y la cantidad de stickers
local characters = {'bf', 'dad', 'gf', 'mom', 'pico', 'monster'}
local numberOfStickers = 80  -- Cambia este número para agregar más o menos stickers
local minDistance = 100  -- Distancia mínima entre los stickers
local occupiedPositions = {}  -- Tabla para almacenar posiciones ocupadas

function createSticker(character, x, y, scaleX, scaleY, angle)
    local stickerNumber = math.random(1, 100)
    local stickerName = character .. 'Sticker' .. tostring(stickerNumber)
    makeLuaSprite(stickerName, 'transitionSwag/stickers-set-1/' .. character .. 'Sticker1', x, y)
    scaleObject(stickerName, scaleX, scaleY)
    setProperty(stickerName .. '.angle', angle) -- Establecer el ángulo
    setProperty(stickerName .. '.camera', instanceArg('camStickers'), false, true)
    addLuaSprite(stickerName, true)
end
-- Función para verificar si una posición está ocupada
function isPositionOccupied(x, y)
    for _, pos in ipairs(occupiedPositions) do
        local dist = math.sqrt((pos.x - x)^2 + (pos.y - y)^2)
        if dist < minDistance then
            return true
        end
    end
    return false
end

-- Crear muchos stickers en posiciones aleatorias
for i = 1, numberOfStickers do
    local character = characters[math.random(#characters)]  -- Elegir un personaje aleatorio
    local x, y

    -- Generar una nueva posición aleatoria que no esté ocupada
    repeat
        x = getRandomInt(-500, 1300) -- Cambiar los límites según la resolución de tu pantalla
        y = getRandomInt(-300, 600)  -- Cambiar los límites según la resolución de tu pantalla
    until not isPositionOccupied(x, y)  -- Repetir hasta encontrar una posición no ocupada

    local scaleX = 1   -- Escalas aleatorias entre 1 y 2
    local scaleY = scaleX               -- Usar la misma escala para mantener la proporción
    local angle = getRandomInt(0, 360)   -- Ángulo aleatorio entre 0 y 360 grados

    createSticker(character, x, y, scaleX, scaleY, angle)

    -- Almacenar la posición ocupada
    table.insert(occupiedPositions, {x = x, y = y})
end
runTimer('removeALLstickers',0.01,1000)
runTimer('removeALLstickers2',0.01,1000)
    --
end
function onStartCountdown()
    -- Fondo de Freeplay

    makeLuaSprite('pinkBack', 'UpDaTe/freeplay/pinkBack', -200, -50)
    addLuaSprite('pinkBack')
    scaleObject('pinkBack', 1.5, 1.5)
    setProperty('pinkBack.camera', instanceArg('camOther'), false, true)
    setProperty('pinkBack.color',getColorFromHex('DFB653'))

    makeLuaSprite('cardGlow', 'UpDaTe/freeplay/cardGlow', -200, -50)
    addLuaSprite('cardGlow')
    scaleObject('cardGlow', 1.5, 1.5)
    setProperty('cardGlow.alpha',0.15)
    setProperty('cardGlow.camera', instanceArg('camOther'), false, true)
    setBlendMode('cardGlow','add')

    makeLuaSprite('dady', 'UpDaTe/freeplay/freeplayBGdad', 0, 60)
    addLuaSprite('dady')
    scaleObject('dady', 1, 1)
    setProperty('dady.camera', instanceArg('camUlin'), false, true)

    makeLuaSprite('blk', '', 0, -650-200)
    makeGraphic('blk', 1280, 920, '000000')
    addLuaSprite('blk', true)
    setProperty('blk.camera', instanceArg('camTop'), false, true)

    makeLuaText('freeplayText', 'FREEPLAY', 300, -30, 10)
    setTextSize('freeplayText', 50)
    setProperty('freeplayText.camera', instanceArg('camTop'), false, true)
    addLuaText('freeplayText')

    makeLuaText('oficialOstText', 'OFFICIAL OST', 1200, 500, 10)
    setTextSize('oficialOstText', 50)
    setProperty('oficialOstText.camera', instanceArg('camTop'), false, true)
    addLuaText('oficialOstText')

    -- Personaje "freeplay-boyfriend"
    makeFlxAnimateSprite("freeplay-boyfriend", 630, 367, "UpDaTe/freeplay/freeplay-boyfriend")
    loadAnimateAtlas("freeplay-boyfriend", "UpDaTe/freeplay/freeplay-boyfriend")
    addAnimationBySymbol("freeplay-boyfriend", "dj-intro", "boyfriend dj intro", 24, false)
    addAnimationBySymbolIndices("freeplay-boyfriend", "idle", "boyfriend freeplay", {17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}, 24, true)
    addAnimationBySymbol("freeplay-boyfriend", "1", "Boyfriend DJ confirm", 24, true)
    addAnimationBySymbol("freeplay-boyfriend", "as2", "Boyfriend DJ fist pump", 24, true)
    addAnimationBySymbol("freeplay-boyfriend", "as3", "Boyfriend DJ loss reaction 1", 24, true)
    addAnimationBySymbol("freeplay-boyfriend", "as4", "bf dj afk", 24, false)
    addAnimationBySymbol("freeplay-boyfriend", "as5", "Boyfriend DJ watchin tv OG", 24, true)
    addAnimationBySymbol("freeplay-boyfriend", "as6", "Boyfriend DJ to CS", 24, false)
    addAnimationBySymbol("freeplay-boyfriend", "as7", "Boyfriend DJ new character ", 24, true)
    addAnimationBySymbol("freeplay-boyfriend", "as8", "boyfriend dj body shirt blowing slowly", 24, true)
    addAnimationBySymbol("freeplay-boyfriend", "body", "boyfriend dj body", 24, true)
    addLuaSprite("freeplay-boyfriend")
    playAnim('freeplay-boyfriend', 'dj-intro', true)
    runTimer('idle', 0.8)
    setProperty('freeplay-boyfriend.camera', instanceArg('camUlin'), false, true)


    makeAnimatedLuaSprite('freeplaySelector', 'UpDaTe/freeplay/freeplaySelector', 30, 80)
    addLuaSprite('freeplaySelector',true)
    addAnimationByPrefix('freeplaySelector', 'normal', 'arrow pointer loop0', 24, true)
    scaleObject('freeplaySelector', 1, 1)
    setProperty('freeplaySelector.camera', instanceArg('camUlin'), false, true)

    makeAnimatedLuaSprite('freeplaySelector2', 'UpDaTe/freeplay/freeplaySelector', 330, 80)
    addLuaSprite('freeplaySelector2',true)
    addAnimationByPrefix('freeplaySelector2', 'normal', 'arrow pointer loop0', 24, true)
    scaleObject('freeplaySelector2', 1, 1)
    setProperty('freeplaySelector2.camera', instanceArg('camUlin'), false, true)
    setProperty('freeplaySelector2.flipX', true)

    makeLuaSprite('freeplayerect', 'UpDaTe/freeplay/freeplayerect', 90, 90)
    addLuaSprite('freeplayerect')
    scaleObject('freeplayerect', 1, 1)
    setProperty('freeplayerect.camera', instanceArg('camUlin'), false, true)

    makeAnimatedLuaSprite('freeplaynightmare', 'UpDaTe/freeplay/freeplaynightmare', 100, 90)
    addLuaSprite('freeplaynightmare')
    addAnimationByPrefix('freeplaynightmare','f', 'idle', 24, true)
    scaleObject('freeplaynightmare', 1, 1)
    setProperty('freeplaynightmare.camera', instanceArg('camUlin'), false, true)

    setProperty('freeplaynightmare.alpha', 0)

    makeLuaSprite('freeplayhard', 'UpDaTe/freeplay/freeplayhard', 100, 90)
    addLuaSprite('freeplayhard')
    scaleObject('freeplayhard', 1, 1)
    setProperty('freeplayhard.camera', instanceArg('camUlin'), false, true)
    setProperty('freeplayhard.alpha', 0)
    
    makeAnimatedLuaSprite('highscore', 'UpDaTe/freeplay/highscore', 850, 80)
    addAnimationByPrefix('highscore','idle','highscore small instance 1',24,true)
    addLuaSprite('highscore',true)
    scaleObject('highscore', 1, 1)
    setProperty('highscore.camera', instanceArg('camUlin'), false, true)
    updateSpriteVisibility()
    selectedCapsule = 1  
    setSelectedCapsule()

    makeLuaSprite('credit', '',1120, 690)
    makeGraphic('credit', 220, 320, '000000')
    addLuaSprite('credit', true)
    setProperty('credit.camera', instanceArg('camUlin'), false, true)

    makeLuaSprite('bgBoyfriend', '',-30, 445)
    makeGraphic('bgBoyfriend', 620, 70, 'fed302')
    addLuaSprite('bgBoyfriend', true)
    setProperty('bgBoyfriend.camera', instanceArg('camOther'), false, true)

    makeLuaText('textb', 'Game Ported by Ulisegas   ')
    setTextSize('textb', 30)
    createInstance('text', 'flixel.addons.display.FlxBackdrop', {nil, axis})
    callMethod('text.set_pixels', {instanceArg('textb.pixels')})
    addInstance('text')
    setProperty('text.camera', instanceArg('camSkibidi'), false, true)
    setProperty('text.velocity.x',-90)




    local textAmount = 3
    local speed = 300
    local texts = {} 
    local texts2 = {} 
    local texts3 = {} 
    local textsA3 = {} 
    local textsB4 = {}  
    local textsC5 = {}  
    local textsD6 = {}  
    local textsE7 = {}  
    local textsF8 = {}  
    local textsG9 = {}  
    local separationTexts = 750 
    local separationTexts2 = 320
    local separationTexts3 = 3020
    local horizontalSpacing = 100 
    
    for i = 1, textAmount do
if i <3 then
        local textID3 = 'textb3' .. i

            local xPosition3 = 500 + (i - 1) * (horizontalSpacing + separationTexts)
            makeLuaText(textID3, 'Hot blooded in more ways than one', 500, xPosition3, 180) 
            setTextFont(textID3, 'FNF Freeplay.ttf')
            setTextSize(textID3, 20)
            addLuaText(textID3)
            setProperty(textID3 .. '.camera', instanceArg('camOther'), false, true)
            setProperty(textID3 .. '.scale.x', 2)
            setProperty(textID3 .. '.scale.y', 2)
            setProperty(textID3 .. '.alpha', 0.25)
            setTextColor(textID3, 'ffffff')
            setBlendMode(textID3, 'add')
            setTextBorder(textID3, 0.1, 'ffffff')
            table.insert(texts3, textID3)
end
if i <3 then
            local textIDA3 = 'textbA3' .. i

            local xPositionA3 = 500 + (i - 1) * (horizontalSpacing + separationTexts)
            makeLuaText(textIDA3, 'Hot blooded in more ways than one', 500, xPositionA3, 310 + 100) 
            setTextFont(textIDA3, 'FNF Freeplay.ttf')
            setTextSize(textIDA3, 20)
            addLuaText(textIDA3)
            setProperty(textIDA3 .. '.camera', instanceArg('camOther'), false, true)
            setProperty(textIDA3 .. '.scale.x', 2)
            setProperty(textIDA3 .. '.scale.y', 2)
            setProperty(textIDA3 .. '.alpha', 0.25)
            setTextColor(textIDA3, 'ffffff')
            setBlendMode(textIDA3, 'add')
            setTextBorder(textIDA3, 0.1, 'ffffff')
            table.insert(textsA3, textIDA3)
end
if i <2 then
    local textIDB4 = 'textbB4' .. i
    local xPositionB4 = 800 + (i - 1) * (horizontalSpacing + separationTexts3)
    makeLuaText(textIDB4, 'BOYFRIEND', 500, xPositionB4, 220) 
    setTextFont(textIDB4, 'FNF Freeplay.ttf')
    setTextSize(textIDB4, 64)
    addLuaText(textIDB4)
    setProperty(textIDB4 .. '.camera', instanceArg('camOther'), false, true)
    setProperty(textIDB4 .. '.alpha', 0.4)
    setTextColor(textIDB4, 'ff3399')
    setTextBorder(textIDB4, 0.1, 'ff3399')
    table.insert(textsB4, textIDB4)
end
if i <2 then
    local textIDC5 = 'textbC5' .. i
    makeLuaText(textIDC5, 'BOYFRIEND', 500, 0, 220) 
    setTextFont(textIDC5, 'FNF Freeplay.ttf')
    setTextSize(textIDC5, 64)
    addLuaText(textIDC5)
    setProperty(textIDC5 .. '.camera', instanceArg('camOther'), false, true)
    setProperty(textIDC5 .. '.alpha', 0.4)
    setTextColor(textIDC5, 'ff3399')
    setTextBorder(textIDC5, 0.1, 'ff3399')
    table.insert(textsC5, textIDC5)
end
--
if i <2 then
    local textIDD6 = 'textbD6' .. i
    local xPositionD6 = 800 + (i - 1) * (horizontalSpacing + separationTexts3)
    makeLuaText(textIDD6, 'BOYFRIEND', 500, xPositionD6, 340) 
    setTextFont(textIDD6, 'FNF Freeplay.ttf')
    setTextSize(textIDD6, 64)
    addLuaText(textIDD6)
    setProperty(textIDD6 .. '.camera', instanceArg('camOther'), false, true)
    setProperty(textIDD6 .. '.alpha', 0.4)
    setTextColor(textIDD6, 'ff3399')
    setTextBorder(textIDD6, 0.1, 'ff3399')
    table.insert(textsD6, textIDD6)
end
if i <2 then
    local textIDE7 = 'textbE7' .. i
    makeLuaText(textIDE7, 'BOYFRIEND', 500, 0, 340) 
    setTextFont(textIDE7, 'FNF Freeplay.ttf')
    setTextSize(textIDE7, 64)
    addLuaText(textIDE7)
    setProperty(textIDE7 .. '.camera', instanceArg('camOther'), false, true)
    setProperty(textIDE7 .. '.alpha', 0.4)
    setTextColor(textIDE7, 'ff3399')
    setTextBorder(textIDE7, 0.1, 'ff3399')
    table.insert(textsE7, textIDE7)
end
if i <2 then
    local textIDF8 = 'textbF8' .. i
    local xPositionF8 = 800 + (i - 1) * (horizontalSpacing + separationTexts3)
    makeLuaText(textIDF8, 'BOYFRIEND', 500, xPositionF8, 450) 
    setTextFont(textIDF8, 'FNF Freeplay.ttf')
    setTextSize(textIDF8, 64)
    addLuaText(textIDF8)
    setProperty(textIDF8 .. '.camera', instanceArg('camOther'), false, true)
    setProperty(textIDF8 .. '.alpha', 0.4)
    setTextColor(textIDF8, 'ff3399')
    setTextBorder(textIDF8, 0.1, 'ff3399')
    table.insert(textsF8, textIDF8)
end
if i <2 then
    local textIDG9 = 'textbG9' .. i
    makeLuaText(textIDG9, 'BOYFRIEND', 500, 0, 450) 
    setTextFont(textIDG9, 'FNF Freeplay.ttf')
    setTextSize(textIDG9, 64)
    addLuaText(textIDG9)
    setProperty(textIDG9 .. '.camera', instanceArg('camOther'), false, true)
    setProperty(textIDG9 .. '.alpha', 0.4)
    setTextColor(textIDG9, 'ff3399')
    setTextBorder(textIDG9, 0.1, 'ff3399')
    table.insert(textsG9, textIDG9)
end
--
        local textID2 = 'textb2' .. i
        local xPosition2 = 500 + (i - 1) * (horizontalSpacing + separationTexts2)
        makeLuaText(textID2, 'PROTECT YO NUTS', 500, xPosition2, 300) 
        setTextFont(textID2, 'FNF Freeplay.ttf')
        setTextSize(textID2, 20)
        addLuaText(textID2)
        setProperty(textID2 .. '.camera', instanceArg('camOther'), false, true)
        setProperty(textID2 .. '.scale.x', 2)
        setProperty(textID2 .. '.scale.y', 2)
        setProperty(textID2 .. '.alpha', 1)
        setTextColor(textID2, 'ffffff')
        setBlendMode(textID2, 'add')
        setTextBorder(textID2, 0.2, 'ffffff')
        table.insert(texts2, textID2)

    end
    
    -- Función para mover el texto hacia la derecha en bucle
    function onUpdatePost(elapsed)
        for i, textID3 in ipairs(texts3) do
            local newX3 = getProperty(textID3 .. '.x') - (speed+70) * elapsed
            if newX3 < -650 then
                newX3 = 1050
            end
            setProperty(textID3 .. '.x', newX3)
        end
        for i, textIDA3 in ipairs(textsA3) do
            local newXA3 = getProperty(textIDA3 .. '.x') - (speed+70) * elapsed
            if newXA3 < -650 then
                newXA3 = 1050
            end
            setProperty(textIDA3 .. '.x', newXA3)
        end

        for i, textIDB4 in ipairs(textsB4) do
            local newXB4 = getProperty(textIDB4 .. '.x') + (speed+70) * elapsed 
            if newXB4 > 450 then 
                newXB4 = -450  
            end
            setProperty(textIDB4 .. '.x', newXB4)
        end
        for i, textIDC5 in ipairs(textsC5) do
            local newXC5 = getProperty(textIDC5 .. '.x') + (speed+70) * elapsed 
            if newXC5 > 450 then 
                newXC5 = -450  
            end
            setProperty(textIDC5 .. '.x', newXC5)
        end

        for i, textIDD6 in ipairs(textsD6) do
            local newXD6 = getProperty(textIDD6 .. '.x') + (speed+70) * elapsed 
            if newXD6 > 450 then 
                newXD6 = -450  
            end
            setProperty(textIDD6 .. '.x', newXD6)
        end
        for i, textIDE7 in ipairs(textsE7) do
            local newXE7 = getProperty(textIDE7 .. '.x') + (speed+70) * elapsed 
            if newXE7 > 450 then 
                newXE7 = -450  
            end
            setProperty(textIDE7 .. '.x', newXE7)
        end

        for i, textIDF8 in ipairs(textsF8) do
            local newXF8 = getProperty(textIDF8 .. '.x') + (speed+70) * elapsed 
            if newXF8 > 450 then 
                newXF8 = -450  
            end
            setProperty(textIDF8 .. '.x', newXF8)
        end
        for i, textIDG9 in ipairs(textsG9) do
            local newXG9 = getProperty(textIDG9 .. '.x') + (speed+70) * elapsed 
            if newXG9 > 450 then 
                newXG9 = -450  
            end
            setProperty(textIDG9 .. '.x', newXG9)
        end

        for i, textID2 in ipairs(texts2) do
            local newX2 = getProperty(textID2 .. '.x') - (speed - 70) * elapsed
            if newX2 < -450 then
                newX2 = 800
            end
            setProperty(textID2 .. '.x', newX2)
        end


    end
    for i = 1, 4 do
        local xPos = 455 + (i - 1) * 100
        local spriteName = 'seperator' .. i
        local animationName = "seperator instance 1"
        makeAnimatedLuaSprite(spriteName, 'UpDaTe/freeplay/letterStuff', xPos, 115)
        addAnimationByPrefix(spriteName, 'idle', animationName, 24, true)  -- Cambié a animationName aquí
        addLuaSprite(spriteName, true)
        scaleObject(spriteName, 1, 1)
        if i ~= 3 then
            setProperty(spriteName .. '.color', getColorFromHex('888888'))
        end
        setProperty(spriteName .. '.camera', instanceArg('camUi'), false, true)
    end    
    setProperty('seperator1.x',483)
    setProperty('seperator3.x',getProperty('seperator3.x')-15)
    setProperty('seperator4.x',getProperty('seperator4.x')-40)

    makeLuaSprite('miniArrow', 'UpDaTe/freeplay/miniArrow', 800, 115)
    addLuaSprite('miniArrow', true)
    scaleObject('miniArrow', 1, 1)
    setProperty('miniArrow.camera', instanceArg('camUi'), false, true)

    makeLuaSprite('miniArrow2', 'UpDaTe/freeplay/miniArrow', 400, 115)
    addLuaSprite('miniArrow2', true)
    scaleObject('miniArrow2', 1, 1)
    setProperty('miniArrow2.camera', instanceArg('camUi'), false, true)
    setProperty('miniArrow2.flipX',true)

makeFlxAnimateSprite("letterStuff1", 630, 150, "UpDaTe/freeplay/sortedLetters")
loadAnimateAtlas("letterStuff1", "UpDaTe/freeplay/sortedLetters")
addAnimationBySymbol("letterStuff1", "ALL", "ALL move", 24, true)
addLuaSprite("letterStuff1",true)
playAnim('letterStuff1', 'ALL', true)
setProperty('letterStuff1.camera', instanceArg('camUi'), false, true)

-- Sprite a la izquierda con animación "#" (color gris claro)
makeFlxAnimateSprite("letterStuff2", 430, 100, "UpDaTe/freeplay/sortedLetters")
loadAnimateAtlas("letterStuff2", "UpDaTe/freeplay/sortedLetters")
addAnimationBySymbol("letterStuff2", "ALL", "#", 24, true)
addLuaSprite("letterStuff2",true)
playAnim('letterStuff2', 'ALL', true)
setProperty('letterStuff2.camera', instanceArg('camUi'), false, true)
setProperty('letterStuff2.color', getColorFromHex('888888')) -- Color gris claro

-- Sprite a la derecha con animación "movin fav" (color gris claro)
makeFlxAnimateSprite("letterStuff3", 500, 100, "UpDaTe/freeplay/sortedLetters")
loadAnimateAtlas("letterStuff3", "UpDaTe/freeplay/sortedLetters")
addAnimationBySymbol("letterStuff3", "ALL", "movin fav", 24, true)
addLuaSprite("letterStuff3",true)
playAnim('letterStuff3', 'ALL', true)
setProperty('letterStuff3.camera', instanceArg('camUi'), false, true)
setProperty('letterStuff3.color', getColorFromHex('888888')) -- Color gris claro

-- Sprite a la izquierda con animación "ab" (color gris claro)
makeFlxAnimateSprite("letterStuff4", 660, 100, "UpDaTe/freeplay/sortedLetters")
loadAnimateAtlas("letterStuff4", "UpDaTe/freeplay/sortedLetters")
addAnimationBySymbol("letterStuff4", "ALL", "AB", 24, true)
addLuaSprite("letterStuff4",true)
playAnim('letterStuff4', 'ALL', true)
setProperty('letterStuff4.camera', instanceArg('camUi'), false, true)
setProperty('letterStuff4.color', getColorFromHex('888888')) -- Color gris claro

-- Sprite a la derecha con animación "cd" (color gris claro)
makeFlxAnimateSprite("letterStuff5", 740, 100, "UpDaTe/freeplay/sortedLetters")
loadAnimateAtlas("letterStuff5", "UpDaTe/freeplay/sortedLetters")
addAnimationBySymbol("letterStuff5", "ALL", "CD", 24, true)
addLuaSprite("letterStuff5",true)
playAnim('letterStuff5', 'ALL', true)
setProperty('letterStuff5.camera', instanceArg('camUi'), false, true)
setProperty('letterStuff5.color', getColorFromHex('888888')) -- Color gris claro


    return Function_Stop
end
local spriteIndex = 1
function updateSpriteVisibility()
    if spriteIndex == 1 then
        -- Mostrar y mover freeplayerect desde arriba hacia su posición normal
        doTweenAlpha('showFreeplayerect', 'freeplayerect', 1, 0.05, 'linear')
        doTweenY('moveFreeplayerect', 'freeplayerect', 90, 0.05, 'linear')
        -- Ocultar y mover los otros sprites hacia arriba
        doTweenAlpha('hideFreeplaynightmare', 'freeplaynightmare', 0, 0.05, 'linear')
        doTweenY('moveFreeplaynightmareUp', 'freeplaynightmare', 60, 0.05, 'linear')
        doTweenAlpha('hideFreeplayhard', 'freeplayhard', 0, 0.05, 'linear')
        doTweenY('moveFreeplayhardUp', 'freeplayhard', 60, 0.05, 'linear')

    elseif spriteIndex == 2 then
        -- Mostrar y mover freeplaynightmare desde arriba hacia su posición normal
        doTweenAlpha('showFreeplaynightmare', 'freeplaynightmare', 1, 0.05, 'linear')
        doTweenY('moveFreeplaynightmare', 'freeplaynightmare', 90, 0.05, 'linear')
        
        -- Ocultar y mover los otros sprites hacia arriba
        doTweenAlpha('hideFreeplayerect', 'freeplayerect', 0, 0.05, 'linear')
        doTweenY('moveFreeplayerectUp', 'freeplayerect', 60, 0.05, 'linear')
        doTweenAlpha('hideFreeplayhard', 'freeplayhard', 0, 0.05, 'linear')
        doTweenY('moveFreeplayhardUp', 'freeplayhard', 60, 0.05, 'linear')

    elseif spriteIndex == 3 then
        -- Mostrar y mover freeplayhard desde arriba hacia su posición normal
        doTweenAlpha('showFreeplayhard', 'freeplayhard', 1, 0.05, 'linear')
        doTweenY('moveFreeplayhard', 'freeplayhard', 90, 0.05, 'linear')
        
        -- Ocultar y mover los otros sprites hacia arriba
        doTweenAlpha('hideFreeplayerect', 'freeplayerect', 0, 0.05, 'linear')
        doTweenY('moveFreeplayerectUp', 'freeplayerect', 60, 0.05, 'linear')
        doTweenAlpha('hideFreeplaynightmare', 'freeplaynightmare', 0, 0.05, 'linear')
        doTweenY('moveFreeplaynightmareUp', 'freeplaynightmare', 60, 0.05, 'linear')
    end
  -- Define una variable global para almacenar el índice anterior
if previousSpriteIndex == nil then
    previousSpriteIndex = 3 -- Inicializa con 3
end

-- Lógica para manejar el cambio de spriteIndex
if spriteIndex == 1 or spriteIndex == 2 then
    -- Verifica si el índice anterior era 
    if previousSpriteIndex == 3 then
        capsules = {}
        local startX, startY = 200, 150 
--
removeLuaSprite('darnellpixel', true)
for i = 1, 3 do
    makeAnimatedLuaSprite('dadpixel' .. i, 'UpDaTe/freeplay/icons/dadpixel', 300, 400)
    addLuaSprite('dadpixel' .. i, true)
    addAnimationByPrefix('dadpixel' .. i, 'idle', 'idle', 24, true)
    addAnimationByPrefix('dadpixel' .. i, 'confirm', 'confirm', 20,false)
    scaleObject('dadpixel' .. i, 2, 2)
    setProperty('dadpixel' .. i .. '.antialiasing', false)
    setProperty('dadpixel' .. i .. '.camera', instanceArg('camUlin'), false, true)
    setObjectOrder('dadpixel' .. i, getObjectOrder('blk') - 1)

    makeAnimatedLuaSprite('picopixel' .. i, 'UpDaTe/freeplay/icons/picopixel', 300, 400)
    addLuaSprite('picopixel' .. i, true)
    addAnimationByPrefix('picopixel' .. i, 'idle', 'idle', 24, true)
    addAnimationByPrefix('picopixel' .. i, 'confirm', 'confirm', 20, false)
    scaleObject('picopixel' .. i, 2, 2)
    setProperty('picopixel' .. i .. '.antialiasing', false)
    setProperty('picopixel' .. i .. '.camera', instanceArg('camUlin'), false, true)
    setObjectOrder('picopixel' .. i, getObjectOrder('blk') - 1)
end
for i = 1, 2 do
    makeAnimatedLuaSprite('spookypixel' .. i, 'UpDaTe/freeplay/icons/spookypixel', 300, 400)
    addLuaSprite('spookypixel' .. i, true)
    addAnimationByPrefix('spookypixel' .. i, 'idle', 'idle', 24, true)
    addAnimationByPrefix('spookypixel' .. i, 'confirm', 'confirm', 20, false)
    scaleObject('spookypixel' .. i, 2, 2)
    setProperty('spookypixel' .. i .. '.antialiasing', false)
    setProperty('spookypixel' .. i .. '.camera', instanceArg('camUlin'), false, true)
    setObjectOrder('spookypixel' .. i, getObjectOrder('blk') - 1)

    makeAnimatedLuaSprite('mommypixel' .. i, 'UpDaTe/freeplay/icons/mommypixel', 300, 400)
    addLuaSprite('mommypixel' .. i, true)
    addAnimationByPrefix('mommypixel' .. i, 'idle', 'idle', 24, true)
    addAnimationByPrefix('mommypixel' .. i, 'confirm', 'confirm', 20, false)
    scaleObject('mommypixel' .. i, 2, 2)
    setProperty('mommypixel' .. i .. '.antialiasing', false)
    setProperty('mommypixel' .. i .. '.camera', instanceArg('camUlin'), false, true)
    setObjectOrder('mommypixel' .. i, getObjectOrder('blk') - 1)

    makeAnimatedLuaSprite('parents-christmaspixel' .. i, 'UpDaTe/freeplay/icons/parents-christmaspixel', 300, 400)
    addLuaSprite('parents-christmaspixel' .. i, true)
    addAnimationByPrefix('parents-christmaspixel' .. i, 'idle', 'idle', 24, true)
    addAnimationByPrefix('parents-christmaspixel' .. i, 'confirm', 'confirm', 20,false)
    scaleObject('parents-christmaspixel' .. i, 2, 2)
    setProperty('parents-christmaspixel' .. i .. '.antialiasing', false)
    setProperty('parents-christmaspixel' .. i .. '.camera', instanceArg('camUlin'), false, true)
    setObjectOrder('parents-christmaspixel' .. i, getObjectOrder('blk') - 1)
    
    makeAnimatedLuaSprite('senpaipixel' .. i, 'UpDaTe/freeplay/icons/senpaipixel', 300, 400)
    addLuaSprite('senpaipixel' .. i, true)
    addAnimationByPrefix('senpaipixel' .. i, 'idle', 'idle', 24, true)
    addAnimationByPrefix('senpaipixel' .. i, 'confirm', 'confirm', 20, false)
    scaleObject('senpaipixel' .. i, 2, 2)
    setProperty('senpaipixel' .. i .. '.antialiasing', false)
    setProperty('senpaipixel' .. i .. '.camera', instanceArg('camUlin'), false, true)
    setObjectOrder('senpaipixel' .. i, getObjectOrder('blk') - 1)
end
        
makeAnimatedLuaSprite('spiritpixel', 'UpDaTe/freeplay/icons/spiritpixel', 300, 400)
addLuaSprite('spiritpixel', true)
addAnimationByPrefix('spiritpixel', 'idle', 'idle', 24, true)
addAnimationByPrefix('spiritpixel', 'confirm', 'confirm', 20, false)
scaleObject('spiritpixel', 2, 2)
setProperty('spiritpixel.antialiasing', false)
setProperty('spiritpixel.camera', instanceArg('camUlin'), false, true)
setObjectOrder('spiritpixel', getObjectOrder('blk') - 1)

makeAnimatedLuaSprite('tankmanpixel', 'UpDaTe/freeplay/icons/tankmanpixel', 300, 400)
addLuaSprite('tankmanpixel', true)
addAnimationByPrefix('tankmanpixel', 'idle', 'idle', 24, true)
addAnimationByPrefix('tankmanpixel', 'confirm', 'confirm', 20, false)
scaleObject('tankmanpixel', 2, 2)
setProperty('tankmanpixel.antialiasing', false)
setProperty('tankmanpixel.camera', instanceArg('camUlin'), false, true)
setObjectOrder('tankmanpixel', getObjectOrder('blk') - 1)
--
        for i = 1, total - 1 do
            local capsuleName = 'freeplayCapsule' .. i
            makeAnimatedLuaSprite(capsuleName, 'UpDaTe/freeplay/freeplayCapsule/capsule/freeplayCapsule', startX+200, startY + (i - 1) * capsuleSpacing)
            addAnimationByPrefix(capsuleName, 'normal', 'mp3 capsule w backing NOT SELECTED', 24, true)
            addAnimationByPrefix(capsuleName, 'select', 'mp3 capsule w backing0', 24, true)
            addOffset(capsuleName, 'normal', 0, 0)
            addOffset(capsuleName, 'select', 4, 0)
            addLuaSprite(capsuleName)
            scaleObject(capsuleName, 0.8, 0.8)
            setProperty(capsuleName .. '.camera', instanceArg('camUlin'), false, true)
            table.insert(capsules, capsuleName)
            removeLuaSprite('freeplayCapsule18')

            local textName = 'capsuleText' .. i
            makeLuaText(textName, capsuleTexts[i], 900, startX - 100, startY + (i - 1) * capsuleSpacing + 50)
            setTextSize(textName, 30)  
            setTextColor(textName, '00ccff')
            setProperty(textName .. '.alpha', 0.8)
            setTextFont(textName, 'FNF Freeplay.ttf')
            setObjectOrder(textName, getObjectOrder('blk') - 1)
            setProperty(textName .. '.camera', instanceArg('camUlin'), false, true)
            addLuaText(textName, false)
            setBlendMode(textName, 'add')
            setTextItalic(textName, false) -- Activa el estilo cursivo en un Lua Text.
            removeLuaSprite('capsuleText18')
            precacheMusic('../songs/' .. capsuleTexts[i] .. '/Inst', 0.6, true) 
            if i == 10 then
                setTextWidth(textName, 836)
                setTextSize(textName, 26)  
            end
            local bpmx = 'bpmx' .. i
            makeLuaSprite(bpmx, 'UpDaTe/freeplay/freeplayCapsule/bpmtext', startX+100, startY + (i - 1) * capsuleSpacing)
            addLuaSprite(bpmx)
            scaleObject(bpmx, 1, 1)
            setProperty(bpmx .. '.camera', instanceArg('camUlin'), false, true)
            setObjectOrder(bpmx, getObjectOrder('blk') - 1)
            removeLuaSprite('bpmx1')
        end
        
        selectedCapsule = 1  
        setSelectedCapsule()
    end
end

-- Actualiza el índice anterior al valor actual
previousSpriteIndex = spriteIndex

    if spriteIndex == 3 then
        -- Eliminar los sprites y textos existentes que no sean 1 o 2
        for i = 1, total do
            if i > 2 then
                local bpmx = 'bpmx' .. i
                removeLuaSprite(bpmx)
                -- Eliminar cápsulas
                local capsuleName = 'freeplayCapsule' .. i
                if getProperty(capsuleName .. '.active') then
                    --
--


for i = 1, 3 do
    removeLuaSprite('dadpixel' .. i, true)
    removeLuaSprite('picopixel' .. i, true)
end
for i = 1, 2 do
    removeLuaSprite('spookypixel' .. i, true)
    removeLuaSprite('mommypixel' .. i, true)
    removeLuaSprite('parents-christmaspixel' .. i, true)
    removeLuaSprite('senpaipixel' .. i, true)
end
removeLuaSprite('spiritpixel', true)
removeLuaSprite('tankmanpixel', true)

makeAnimatedLuaSprite('darnellpixel', 'UpDaTe/freeplay/icons/darnellpixel', 300, 400)
addLuaSprite('darnellpixel', true)
addAnimationByPrefix('darnellpixel', 'idle', 'idle', 24, true)
addAnimationByPrefix('darnellpixel', 'confirm', 'confirm', 20, false)
scaleObject('darnellpixel', 2, 2)
setProperty('darnellpixel.antialiasing', false)
setProperty('darnellpixel.camera', instanceArg('camUlin'), false, true)
setObjectOrder('darnellpixel', getObjectOrder('blk') - 1)
--
                    --
                    removeLuaSprite(capsuleName, true) -- Eliminar sprite
                end
    
                -- Eliminar textos
                local textName = 'capsuleText' .. i
                if getProperty(textName .. '.active') then
                    removeLuaText(textName, true) -- Eliminar texto
                end
            end
        end

        capsules = {}
        local startX, startY = 200, 150 
    
        for i = 1, total - 16 do
            local capsuleName = 'freeplayCapsule' .. i
            makeAnimatedLuaSprite(capsuleName, 'UpDaTe/freeplay/freeplayCapsule/capsule/freeplayCapsule', startX+200,startY + (i - 1) * capsuleSpacing)
            addAnimationByPrefix(capsuleName, 'normal', 'mp3 capsule w backing NOT SELECTED', 24, true)
            addAnimationByPrefix(capsuleName, 'select', 'mp3 capsule w backing0', 24, true)
            addOffset(capsuleName, 'normal', 0, 0)
            addOffset(capsuleName, 'select', 4, 0)
            addLuaSprite(capsuleName)
            scaleObject(capsuleName, 0.8, 0.8)
            setProperty(capsuleName .. '.camera', instanceArg('camUlin'), false, true)
            table.insert(capsules, capsuleName)
    
            local textName = 'capsuleText' .. i
            makeLuaText(textName, capsuleTexts[i], 900, startX - 100, startY + (i - 1) * capsuleSpacing + 30)  -- Ajusta la posición X y Y
            if i == 2 then
            setTextString(textName, capsuleTexts[18])
            end
            setTextSize(textName, 30)  
            setTextColor(textName, '00ccff')
            setProperty(textName .. '.alpha', 0.8)
            setTextFont(textName, 'FNF Freeplay.ttf')
            setObjectOrder(textName, getObjectOrder('blk') - 1)
            setProperty(textName .. '.camera', instanceArg('camUlin'), false, true)
            addLuaText(textName, false)
            setBlendMode(textName, 'add')
        end
    
        selectedCapsule = 1  
        setSelectedCapsule()
    end
    
end
local stickerCounter = 0
function onTimerCompleted(tag)
    if tag == 'change' then
        animateCameras()
        runTimer('negrosdemierda',0.5)
    end
    if tag == 'negrosdemierda' then
        runTimer('toCs',1)
        doTweenAlpha('byebye','byebye',1,1,'linear')
    end
    if tag == 'toCs' then
loadSong('cs')
    end
if tag == 'playRandomTheme' then
    if selectedCapsule == 1 and spriteIndex ~= 3 then
        playMusic('freeplayRandom', 0.3,true)
    end
end
    if tag == 'removeALLstickers' then
        if stickerCounter<96 then
                playSound('stickersounds/keys/keyClick'..getRandomInt(1,5))
        end
                stickerCounter = stickerCounter + 1
            
                -- Intenta eliminar el sticker correspondiente según el contador
                removeLuaSprite('dadSticker' .. stickerCounter, true)
                removeLuaSprite('gfSticker' .. stickerCounter, true)
                removeLuaSprite('picoSticker' .. stickerCounter, true)
                removeLuaSprite('bfSticker' .. stickerCounter, true)
                removeLuaSprite('monsterSticker' .. stickerCounter, true)
                removeLuaSprite('momSticker' .. stickerCounter, true)
        
            end
            if tag == 'removeALLstickers2' then
                if stickerCounter<96 then
                        playSound('stickersounds/keys/keyClick'..getRandomInt(1,5))
                end
                        stickerCounter = stickerCounter + 1
                    
                        -- Intenta eliminar el sticker correspondiente según el contador
                        removeLuaSprite('dadSticker' .. stickerCounter, true)
                        removeLuaSprite('gfSticker' .. stickerCounter, true)
                        removeLuaSprite('picoSticker' .. stickerCounter, true)
                        removeLuaSprite('bfSticker' .. stickerCounter, true)
                        removeLuaSprite('monsterSticker' .. stickerCounter, true)
                        removeLuaSprite('momSticker' .. stickerCounter, true)
                
                    end
    if tag == 'flamas' then
        playAnim('freeplayFlame','new',false)
        
    end
    if tag == 'flamas2' then
        playAnim('freeplayFlame2','new',false)
        
    end
    if tag == 'flamas3' then
        playAnim('freeplayFlame3','new',false)
        
    end
    if tag == 'flamas4' then
        playAnim('freeplayFlame4','new',false)
        
    end
    if tag == 'normally2' then
        setBlendMode('freeplaySelector2','nuh uh')
        scaleObject('freeplaySelector2',1,1)
        setProperty('freeplaySelector2.x',330-5+5)
        setProperty('freeplaySelector2.y',80-15+15)
    end
    if tag == 'normally' then
        setBlendMode('freeplaySelector','nuh uh')
        scaleObject('freeplaySelector',1,1)
        setProperty('freeplaySelector.x',30-5+5)
        setProperty('freeplaySelector.y',80-15+15)
    end
    if tag == 'idle2idklolol' then
        setProperty('freeplay-boyfriend.x',-13)
        setProperty('freeplay-boyfriend.y',311)
        runTimer('idle', 5.6)
        runTimer('djmoment',60)
        playAnim('freeplay-boyfriend', 'as4', true)
    end
    if tag == 'djmoment' then
        playAnim('freeplay-boyfriend', 'as5', true)
        runTimer('djmoment2',2)
        setProperty('freeplay-boyfriend.x',637)
        setProperty('freeplay-boyfriend.y',370)
    end
    if tag == 'djmoment2' then
        runTimer('idle', 7.2)
        playAnim('freeplay-boyfriend', 'as5', true,true)
    end
    if tag == 'idle' then
        setProperty('freeplay-boyfriend.x',630)
        setProperty('freeplay-boyfriend.y',367)
        runTimer('idle2idklolol',120)
        playAnim('freeplay-boyfriend', 'idle', true)
    end
    if tag == 'loadSong' then
        if selectedCapsule == 1 then
        local filteredSongs = {}
        for i = 1, #capsuleTexts do
            local songName = capsuleTexts[i]
            
            if not (spriteIndex == 1 or spriteIndex == 2) or songName ~= "Darnell-(BF-Mix)" then
                table.insert(filteredSongs, songName)
            end
        end

        local difficulty
        if spriteIndex == 1 then
            difficulty = 0
        elseif spriteIndex == 2 then
            difficulty = 1
        elseif spriteIndex == 3 then
            loadSong("Darnell-(BF-Mix)", 2) 
            return 
        end
        local randomSong = filteredSongs[getRandomInt(1, #filteredSongs)]
        loadSong(randomSong, difficulty)
    else
        local difficulty
if spriteIndex == 1 then
    difficulty = 0
elseif spriteIndex == 2 then
    difficulty = 1
elseif spriteIndex == 3 then
    loadSong("Darnell-(BF-Mix)", 2)
    return
end
local loadToSong = getTextString('capsuleText' .. selectedCapsule)
loadSong(loadToSong, difficulty)
        
    end
end
end
local cameras = {
    'camOther', 'newCamOther', 'camSkibidi', 'camUi', 
    'camTop', 'camLua', 'camStickers','camUlin'
}
function animateCameras()
    doTweenY("letterStuff1_up", "letterStuff1", 350, 1.5, "backIn")
    doTweenY("letterStuff2_up", "letterStuff2", 350, 1.5, "backIn")
    doTweenY("letterStuff3_up", "letterStuff3", 350, 1.5, "backIn")
    doTweenY("letterStuff4_up", "letterStuff4", 350, 1.5, "backIn")
    doTweenY("letterStuff5_up", "letterStuff5", 350, 1.5, "backIn")

    doTweenY("letterStuff5_up", "letterStuff5", 350, 1.5, "backIn")
    doTweenY("harrd", "freeplayhard", 350, 1.5, "backIn")
    doTweenY("harrdw", "freeplayerect", 350, 1.5, "backIn")
    doTweenY("harr3d", "freeplaynightmare", 350, 1.5, "backIn")

    local objects = {'freeplayText', 'oficialOstText', 'freeplaySelector', 'freeplaySelector2', 'highscore'}
    for i = 1, 4 do
        local spriteName = 'seperator' .. i
        doTweenY(spriteName .. '_up', spriteName, 350, 1.5, 'backIn')
    end

    for _, objectName in ipairs(objects) do
            doTweenY(objectName .. '_up', objectName, 350, 1.5, 'backIn') 
    end
    for _, cameraName in ipairs(cameras) do
        -- Corregir la condición para 'camSkibidi'
        if not (cameraName == 'camSkibidi') then
            if cameraName == 'camUlin' then
                -- Animación más lenta para 'camUlin'
                doTweenY(cameraName .. '_up', cameraName, 300, 1.5, 'backIn')
            else
                -- Animación más rápida para las demás cámaras
                doTweenY(cameraName .. '_up', cameraName, 350, 1.5, 'backIn')
            end
        end
    end
end

function onUpdate()
    updateClearScore()
    updateScore()  -- Actualiza la visualización del puntaje
    presionar()
    if not stoping then
        if keyboardJustPressed('TAB') then
            stoping=true
            runTimer('change',0.5)
            playSound('confirmMenu')
            playAnim('freeplay-boyfriend', 'as6', true)
        end
        if keyboardJustPressed('ESCAPE') then
                      exitSong()--lol
        end
    if keyboardJustPressed('ENTER') then
        stoping = true;
        if spriteIndex == 1 or spriteIndex == 2 then
        if selectedCapsule >= 2 and selectedCapsule <= 17 then
            local animations = {
                [2] = {name = 'dadpixel1', count = 1},  -- cápsula 2: 1 vez dad
                [3] = {name = 'dadpixel2', count = 1},  -- cápsula 3: 1 vez dad
                [4] = {name = 'dadpixel3', count = 1},  -- cápsula 4: 1 vez dad
                [5] = {name = 'spookypixel1', count = 1}, -- cápsula 5: 1 vez spooky
                [6] = {name = 'spookypixel2', count = 1}, -- cápsula 5: 1 vez spooky
                [7] = {name = 'picopixel1', count = 1}, -- cápsula 6: 1 vez pico
                [8] = {name = 'picopixel2', count = 1}, -- cápsula 7: 1 vez pico
                [9] = {name = 'picopixel3', count = 1}, -- cápsula 7: 1 vez pico
                [10] = {name = 'mommypixel1', count = 1}, -- cápsula 8: 1 vez mommy
                [11] = {name = 'mommypixel2', count = 1}, -- cápsula 8: 1 vez mommy
                [12] = {name = 'parents-christmaspixel1', count = 1}, -- cápsula 9: 1 vez parents
                [13] = {name = 'parents-christmaspixel2', count = 1}, -- cápsula 9: 1 vez parents
                [14] = {name = 'senpaipixel1', count = 1}, -- cápsula 10: 1 vez senpai
                [15] = {name = 'senpaipixel2', count = 1}, -- cápsula 10: 1 vez senpai
                [16] = {name = 'spiritpixel', count = 1}, -- cápsula 10: 1 vez senpai
                [17] = {name = 'tankmanpixel', count = 1} -- cápsula 10: 1 vez senpai
            }
        
            local animation = animations[selectedCapsule]
            if animation then
                for i = 1, animation.count do
                    playAnim(animation.name, 'confirm')
                end
            end
        end
    end
    if spriteIndex == 3 then
        if selectedCapsule >= 2 then
            local animations = {
                [2] = {name = 'darnellpixel', count = 1},  -- cápsula 2: 1 vez dad
            }
        
            local animation = animations[selectedCapsule]
            if animation then
                for i = 1, animation.count do
                    playAnim(animation.name, 'confirm')
                end
            end
        end
    end

        makeFlxAnimateSprite("backing-text-yeah", 640, 360, "UpDaTe/freeplay/backing-text-yeah")
        loadAnimateAtlas("backing-text-yeah", "UpDaTe/freeplay/backing-text-yeah")
        addAnimationBySymbol("backing-text-yeah", "ALL", "BF back card confirm raw", 24, true)
        addLuaSprite("backing-text-yeah")
        playAnim('backing-text-yeah', 'ALL', true)
        setProperty('backing-text-yeah.camera', instanceArg('newCamOther'), false, true)

        makeLuaSprite('confirmGlow', 'UpDaTe/freeplay/confirmGlow', -175, 200)
        addLuaSprite('confirmGlow')
        scaleObject('confirmGlow', 1.5, 1.5)
        setProperty('confirmGlow.camera', instanceArg('newCamOther'), false, true)
        
        makeLuaSprite('confirmGlow2', 'UpDaTe/freeplay/confirmGlow2', -175, 200)
        addLuaSprite('confirmGlow2')
        scaleObject('confirmGlow2', 1.5, 1.5)
        setProperty('confirmGlow2.camera', instanceArg('newCamOther'), false, true)
        
        setBlendMode('confirmGlow','add')
        setBlendMode('confirmGlow2','add')
        setProperty('confirmGlow.alpha', 0) 
        setProperty('confirmGlow2.alpha', 0)
        
        doTweenAlpha('confirmGlowFadeIn', 'confirmGlow', 0.25/2, 1, 'linear')   
        doTweenAlpha('confirmGlow2FadeIn', 'confirmGlow2', 0.5/2, 1.5, 'linear') 
        
        
        doTweenAlpha('camOtherAlpha', 'camOther', 0, 0.25, 'linear')   
    

        setProperty('pinkBack.color',getColorFromHex('181831'))
        setProperty('pinkBack.camera', instanceArg('newCamOther'), false, true)
        playAnim('freeplay-boyfriend', '1', true)
        playSound('confirmMenu')
        runTimer('loadSong',1)
end

    if keyboardJustPressed('ONE') then
        restartSong()
    end
    if keyboardJustPressed('RIGHT') then
        cambiarScoreAnightmare()
        runTimer('normally2',0.1)
        setBlendMode('freeplaySelector2','add')
        scaleObject('freeplaySelector2',0.75,0.75)
        setProperty('freeplaySelector2.x',330+5)
        setProperty('freeplaySelector2.y',80+15)
        spriteIndex = (spriteIndex % 3) + 1  -- Alterna entre 1, 2 y 3
        updateSpriteVisibility()
    elseif keyboardJustPressed('LEFT') then
        cambiarScoreAerect()
        runTimer('normally',0.1)
        setBlendMode('freeplaySelector','add')
        scaleObject('freeplaySelector',0.75,0.75)
        setProperty('freeplaySelector.x',30+5)
        setProperty('freeplaySelector.y',80+15)
        spriteIndex = (spriteIndex - 2) % 3 + 1  -- Alterna entre 1, 2 y 3 hacia la izquierda
        updateSpriteVisibility()
    end
    if keyboardJustPressed('DOWN') then
        playSound('scrollMenu')
        selectedCapsule = (selectedCapsule % #capsules) + 1  -- Si llega al final, vuelve al inicio
        setSelectedCapsule()
    elseif keyboardJustPressed('UP') then
        playSound('scrollMenu')
        selectedCapsule = (selectedCapsule - 2) % #capsules + 1  -- Si llega al inicio, vuelve al final
        setSelectedCapsule()
    end
end
end
function setSelectedCapsule()
    local centerY = 275       -- Posición central en Y
    local baseX = 250         -- Nueva posición base en X para mover todas las cápsulas a la derecha
    local maxOffsetX = 50     -- Desplazamiento máximo en X para la cápsula seleccionada
    local capsuleSpacing = 115  -- Aumentar el espacio entre las cápsulas en Y
    local selectedOffsetX = 30 -- Desplazamiento adicional para la cápsula seleccionada
    local sideOffsetX = 15     -- Desplazamiento adicional para las cápsulas a los lados

    -- Tabla con los ajustes de desplazamiento para cada texto
    local textOffsets = {
        [2] = 60,
        [3] = 40,
        [4] = 80,
        [5] = 40,
        [7] = -10,
        [8] = 50,
        [9] = 20,
        [10] = 80,
        [11] = -10,
        [13] = 10,
        [14] = 10,
        [16] = 10,
        [17] = -20,
        [18] = 40,
    }
    if spriteIndex == 3 then
        textOffsets[2] = 80
    else
        textOffsets[2] = 60
    end
    for i, capsuleName in ipairs(capsules) do
        local targetY, targetX
        local tweenType = 'linear'  -- Tipo de tween por defecto

        -- Determinar la posición en Y para cada cápsula
        if i < selectedCapsule then
            targetY = centerY - (selectedCapsule - i) * capsuleSpacing
        elseif i > selectedCapsule then
            targetY = centerY + (i - selectedCapsule) * capsuleSpacing
        else
            targetY = centerY
            playAnim(capsuleName, 'select', true)
            if selectedCapsule == 1  then
                if spriteIndex ~= 3 then
                runTimer('playRandomTheme',0.5)
                end
            else
                local selectedText = getTextString('capsuleText' .. selectedCapsule) -- Obtener el texto de la cápsula seleccionada
                playMusic('../songs/' .. selectedText .. '/Inst',0.6,true) -- Asume que el texto corresponde al nombre de la canción
            end
        end
        targetY = targetY - 20
        local distance = math.abs(selectedCapsule - i)  -- Distancia a la cápsula seleccionada
        targetX = baseX + maxOffsetX - (distance * 10)  -- Reducir el desplazamiento cuanto más lejos esté
        targetXBPM = baseX + maxOffsetX - (distance * 10)  -- Reducir el desplazamiento cuanto más lejos esté
        -- Mover más a la derecha solo la cápsula seleccionada y las cápsulas a sus lados
        if i == selectedCapsule then
            targetX = targetX + selectedOffsetX  -- Desplazamiento adicional para la cápsula seleccionada
        elseif i == selectedCapsule - 1 or i == selectedCapsule + 1 then
            targetX = targetX + sideOffsetX  -- Desplazamiento adicional para las cápsulas a los lados
        end
---------------------
local currentScore = 0
local targetScore = 0
local transitionTime = 1  -- Tiempo total para la transición en segundos
local updateInterval = 0.05  -- Intervalo de actualización en segundos
local timer = 0
local lastDisplayedScore = -1  -- Variable para rastrear el último puntaje mostrado

function createNumberSprite(name, animationPrefix, posX, posY)
    makeAnimatedLuaSprite(name, 'UpDaTe/freeplay/digital_numbers', posX, posY)
    addLuaSprite(name, true)
    addAnimationByPrefix(name, 'idk', animationPrefix, 24, false)
    scaleObject(name, 0.4, 0.4)
    setProperty(name .. '.camera', instanceArg('camTop'), false, true)
end

-- Función para actualizar y mostrar el score gradualmente
function updateScore()
    if timer < transitionTime then
        timer = timer + updateInterval

        -- Calcula el porcentaje completado de la transición
        local t = timer / transitionTime

        -- Interpola cada dígito
        local scoreStrCurrent = string.format("%07d", currentScore)
        local scoreStrTarget = string.format("%07d", targetScore)

        for i = 1, 7 do
            local digitCurrent = tonumber(string.sub(scoreStrCurrent, i, i))
            local digitTarget = tonumber(string.sub(scoreStrTarget, i, i))
            
            -- Interpolación simple entre el dígito actual y el objetivo
            local newDigit = math.floor(digitCurrent + (digitTarget - digitCurrent) * t)

            -- Solo actualiza si el nuevo dígito es diferente del último mostrado
            if newDigit ~= tonumber(string.sub(lastDisplayedScore, i, i)) then
                local animationPrefix = getAnimationPrefix(tostring(newDigit))
                
                -- Ajusta la posición para el dígito "1"
                local posX = 900 + (45 * (i - 1))
                if newDigit == 1 then
                    posX = posX + 10  -- Mueve "1" 10 unidades a la derecha
                end
                
                createNumberSprite('digit' .. i, animationPrefix, posX, 126)
            end
        end

        -- Actualiza el último puntaje mostrado
        lastDisplayedScore = scoreStrCurrent
    else
        -- Al finalizar la transición, actualiza el puntaje actual al objetivo
        currentScore = targetScore
        timer = 0  -- Reinicia el temporizador
    end
end

-- Función para crear el número a partir del score
function displayScore(score)
    targetScore = score  -- Establece el nuevo puntaje objetivo
    timer = 0  -- Reinicia el temporizador
end

-- Función auxiliar para obtener el prefijo de animación correspondiente al dígito
function getAnimationPrefix(digit)
    local prefixes = {
        ['0'] = 'ZERO DIGITAL',
        ['1'] = 'ONE DIGITAL',
        ['2'] = 'TWO DIGITAL',
        ['3'] = 'THREE DIGITAL',
        ['4'] = 'FOUR DIGITAL',
        ['5'] = 'FIVE DIGITAL',
        ['6'] = 'SIX DIGITAL',
        ['7'] = 'SEVEN DIGITAL',
        ['8'] = 'EIGHT DIGITAL',
        ['9'] = 'NINE DIGITAL'
    }
    return prefixes[digit]
end

-- Llamada inicial para mostrar el score
displayScore(callMethodFromClass('backend.Highscore', 'getScore', { getTextString('capsuleText' .. selectedCapsule), spriteIndex - 1 }))

-- Llamada periódica para actualizar el score


-- Función para forzar un nuevo puntaje y ver el resultado
function forceNewScore(newScore)
    displayScore(newScore)
end


------------clear












local currentClearScore = 0
local targetClearScore = 0
local clearTransitionTime = 1  -- Tiempo total para la transición en segundos
local clearUpdateInterval = 0.05  -- Intervalo de actualización en segundos
local clearTimer = 0
local lastDisplayedClearScore = ""  -- Variable para rastrear el último puntaje mostrado

function createClearNumberSprite(name, animationPrefix, posX, posY, scale)
    makeAnimatedLuaSprite(name, 'UpDaTe/freeplay/freeplay-clear', posX, posY)
    addLuaSprite(name, true)
    addAnimationByPrefix(name, 'idk', animationPrefix, 24, false)
    scaleObject(name, scale, scale)  -- Ajusta la escala
    setProperty(name .. '.camera', instanceArg('camLua'), false, true)
end

-- Función para actualizar y mostrar el clear score gradualmente
function updateClearScore()
    if clearTimer < clearTransitionTime then
        clearTimer = clearTimer + clearUpdateInterval

        -- Calcula el porcentaje completado de la transición
        local t = clearTimer / clearTransitionTime

        -- Interpola el puntaje sin ceros a la izquierda
        local clearScoreStrCurrent = tostring(currentClearScore)
        local clearScoreStrTarget = tostring(targetClearScore)

        -- Asegúrate de que ambos puntajes tengan la misma longitud
        local maxLength = math.max(#clearScoreStrCurrent, #clearScoreStrTarget)
        clearScoreStrCurrent = string.format("%0" .. maxLength .. "d", currentClearScore)
        clearScoreStrTarget = string.format("%0" .. maxLength .. "d", targetClearScore)

        for i = 1, maxLength do
            local digitCurrent = tonumber(string.sub(clearScoreStrCurrent, i, i)) or 0
            local digitTarget = tonumber(string.sub(clearScoreStrTarget, i, i)) or 0
            
            -- Interpolación simple entre el dígito actual y el objetivo
            local newDigit = math.floor(digitCurrent + (digitTarget - digitCurrent) * t)

            -- Solo actualiza si el nuevo dígito es diferente del último mostrado
            local lastDigit = tonumber(string.sub(lastDisplayedClearScore, i, i)) or -1
            if newDigit ~= lastDigit then
                local animationPrefix = tostring(newDigit)  -- Usa el número directamente como el nombre de la animación
                
                -- Ajusta la posición de cada dígito
                local posX = 1190 + (25 * (i - 1))  -- Disminuye el valor para acercar los dígitos
                if newDigit == 1 then
                    posX = posX + 10  -- Mueve "1" 10 unidades a la derecha
                end
                -- Ajusta la escala y posición para números de 3 dígitos
                local scale = 1  -- Escala por defecto
                if maxLength == 3 then
                    scale = 0.8  -- Escala más pequeña para números de 3 dígitos
                    posX = posX - 10  -- Mueve más a la izquierda
                end

                createClearNumberSprite('clearDigit' .. i, animationPrefix, posX, 93, scale)  -- Cambia posición en Y para diferenciarlos
            end
        end

        -- Actualiza el último puntaje mostrado
        lastDisplayedClearScore = clearScoreStrCurrent
    else
        -- Al finalizar la transición, actualiza el puntaje actual al objetivo
        currentClearScore = targetClearScore
        clearTimer = 0  -- Reinicia el temporizador
    end
end
removeLuaSprite('clearDigit2',true)
removeLuaSprite('clearDigit3',true)
-- Función para crear el número a partir del clear score
function displayClearScore(score)
    targetClearScore = score  -- Establece el nuevo puntaje objetivo
    clearTimer = 0  -- Reinicia el temporizador
end

local rating = math.floor(callMethodFromClass('backend.Highscore', 'getRating', { getTextString('capsuleText' .. selectedCapsule), spriteIndex - 1 }) * 100)

if rating > 0 then
    displayClearScore(rating)
end

function forceNewClearScore(newScore)
    displayClearScore(newScore)
end

---------clear
------------------album
if selectedCapsule == 1 then
    for i = 2,4 do
        setProperty('freeplayFlame.visible',false)
      setProperty('freeplayFlame'..i..'.visible',false)
        end
    makeFlxAnimateSprite("albumRoll", 640, 360, "UpDaTe/freeplay/albumRoll/freeplayAlbum")
    loadAnimateAtlas("albumRoll", "UpDaTe/freeplay/albumRoll/freeplayAlbum")
    addAnimationBySymbol("albumRoll", "ALL", "ALBUM ALL", 24, false)
    addLuaSprite("albumRoll", true)
    playAnim('albumRoll', 'ALL', true)
    setProperty('albumRoll.camera', instanceArg('camUi'), false, true)
    
    setProperty('albumTexts.visible', false)
    setProperty('freeplayStars1.visible', false)
    setProperty('volume3.visible', false)
    setProperty('expansion1.visible', false)
    setProperty('expansion2.visible', false)
else
    setProperty('freeplayStars1.visible', true)
    setProperty('albumRoll.visible', false)
end
if spriteIndex == 3 and selectedCapsule == 2 then
    playAnim('freeplayStars1', '4', true)
    makeLuaSprite('expansion2', 'UpDaTe/freeplay/albumRoll/expansion2', 955, 270)
    addLuaSprite('expansion2', true)
    setProperty('expansion2.camera', instanceArg('camUi'), false, true)
    setProperty('expansion2.angle', 10)
    setProperty('expansion2.visible', true)
    doTweenY('expansion2Tween', 'expansion2', 280, 0.25, 'elasticInOut')

    makeAnimatedLuaSprite('albumTexts', 'UpDaTe/freeplay/albumRoll/expansion2-text',930,490)
    addAnimationByPrefix('albumTexts','idle','',24,false)
    addLuaSprite('albumTexts', true)
    setProperty('albumTexts.camera', instanceArg('camUi'), false, true)
end
if spriteIndex == 1 or spriteIndex == 2 then
    -----------------------stars
    if selectedCapsule == 2 then
        for i = 2,4 do
        setProperty('freeplayFlame.visible',false)
      setProperty('freeplayFlame'..i..'.visible',false)
        end
        playAnim('freeplayStars1', '8', true)
    elseif selectedCapsule == 3 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '6', true)
    elseif selectedCapsule == 4 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '9', true)
    elseif selectedCapsule == 5 then
        makeAnimatedLuaSprite('freeplayFlame', 'UpDaTe/freeplay/freeplayFlame',930,100)
        addAnimationByPrefix('freeplayFlame','idle','fire loop full instance 1',24,true)
        addAnimationByIndices('freeplayFlame','new','fire loop full instance 1','2,3,4,5,6,7,8,9',24,true)
        addLuaSprite('freeplayFlame', true)
        setProperty('freeplayFlame.camera', instanceArg('camUi'), false, true)
        playAnim('freeplayFlame','idle',false)

        makeAnimatedLuaSprite('freeplayFlame2', 'UpDaTe/freeplay/freeplayFlame',960,110)
        addAnimationByPrefix('freeplayFlame2','idle','fire loop full instance 1',24,true)
        addAnimationByIndices('freeplayFlame2','new','fire loop full instance 1','2,3,4,5,6,7,8,9',24,true)
        addLuaSprite('freeplayFlame2', true)
        setProperty('freeplayFlame2.camera', instanceArg('camUi'), false, true)
        playAnim('freeplayFlame2','idle',false)

        runTimer('flamas',0.1)
        runTimer('flamas2',0.1)

        playAnim('freeplayStars1', '12', true)
    elseif selectedCapsule == 6 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '9', true)
    elseif selectedCapsule == 7 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '8', true)
    elseif selectedCapsule == 8 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '8', true)
    elseif selectedCapsule == 9 then
        makeAnimatedLuaSprite('freeplayFlame', 'UpDaTe/freeplay/freeplayFlame',930,100)
        addAnimationByPrefix('freeplayFlame','idle','fire loop full instance 1',24,true)
        addAnimationByIndices('freeplayFlame','new','fire loop full instance 1','2,3,4,5,6,7,8,9',24,true)
        addLuaSprite('freeplayFlame', true)
        setProperty('freeplayFlame.camera', instanceArg('camUi'), false, true)
        playAnim('freeplayFlame','idle',false)

        makeAnimatedLuaSprite('freeplayFlame2', 'UpDaTe/freeplay/freeplayFlame',960,110)
        addAnimationByPrefix('freeplayFlame2','idle','fire loop full instance 1',24,true)
        addAnimationByIndices('freeplayFlame2','new','fire loop full instance 1','2,3,4,5,6,7,8,9',24,true)
        addLuaSprite('freeplayFlame2', true)
        setProperty('freeplayFlame2.camera', instanceArg('camUi'), false, true)
        playAnim('freeplayFlame2','idle',false)
        playAnim('freeplayStars1', '12', true)
        runTimer('flamas',0.1)
        runTimer('flamas2',0.1)
        for i = 3,4 do
          setProperty('freeplayFlame'..i..'.visible',false)
            end
    elseif selectedCapsule == 10 then
        makeAnimatedLuaSprite('freeplayFlame', 'UpDaTe/freeplay/freeplayFlame',930,100)
        addAnimationByPrefix('freeplayFlame','idle','fire loop full instance 1',24,true)
        addAnimationByIndices('freeplayFlame','new','fire loop full instance 1','2,3,4,5,6,7,8,9',24,true)
        addLuaSprite('freeplayFlame', true)
        setProperty('freeplayFlame.camera', instanceArg('camUi'), false, true)
        playAnim('freeplayFlame','idle',false)

        makeAnimatedLuaSprite('freeplayFlame2', 'UpDaTe/freeplay/freeplayFlame',960,110)
        addAnimationByPrefix('freeplayFlame2','idle','fire loop full instance 1',24,true)
        addAnimationByIndices('freeplayFlame2','new','fire loop full instance 1','2,3,4,5,6,7,8,9',24,true)
        addLuaSprite('freeplayFlame2', true)
        setProperty('freeplayFlame2.camera', instanceArg('camUi'), false, true)
        playAnim('freeplayFlame2','idle',false)

        makeAnimatedLuaSprite('freeplayFlame3', 'UpDaTe/freeplay/freeplayFlame',990,120)
        addAnimationByPrefix('freeplayFlame3','idle','fire loop full instance 1',24,true)
        addAnimationByIndices('freeplayFlame3','new','fire loop full instance 1','2,3,4,5,6,7,8,9',24,true)
        addLuaSprite('freeplayFlame3', true)
        setProperty('freeplayFlame3.camera', instanceArg('camUi'), false, true)
        playAnim('freeplayFlame3','idle',false)

        makeAnimatedLuaSprite('freeplayFlame4', 'UpDaTe/freeplay/freeplayFlame',1020,130)
        addAnimationByPrefix('freeplayFlame4','idle','fire loop full instance 1',24,true)
        addAnimationByIndices('freeplayFlame4','new','fire loop full instance 1','2,3,4,5,6,7,8,9',24,true)
        addLuaSprite('freeplayFlame4', true)
        setProperty('freeplayFlame4.camera', instanceArg('camUi'), false, true)
        playAnim('freeplayFlame4','idle',false)
        playAnim('freeplayStars1', '14', true)

        runTimer('flamas',0.1)
        runTimer('flamas2',0.1)
        runTimer('flamas3',0.1)
        runTimer('flamas4',0.1)
    elseif selectedCapsule == 11 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '7', true)
    elseif selectedCapsule == 12 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '9', true)
    elseif selectedCapsule == 13 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '7', true)
    elseif selectedCapsule == 14 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '9', true)
    elseif selectedCapsule == 15 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '8', true)
    elseif selectedCapsule == 16 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '9', true)
    elseif selectedCapsule == 17 then
        for i = 2,4 do
            setProperty('freeplayFlame.visible',false)
          setProperty('freeplayFlame'..i..'.visible',false)
            end
        playAnim('freeplayStars1', '10', true)
    end
    -----------------------
    if (selectedCapsule >= 2 and selectedCapsule <= 9) or selectedCapsule == 11 or (selectedCapsule >= 14 and selectedCapsule <= 16) then
        -- Ocultar otros sprites
        setProperty('albumRoll.visible', false)
        setProperty('expansion1.visible', false)
        setProperty('expansion2.visible', false)

        makeLuaSprite('volume3', 'UpDaTe/freeplay/albumRoll/volume3', 955, 270)
        addLuaSprite('volume3', true)
        setProperty('volume3.camera', instanceArg('camUi'), false, true)
        setProperty('volume3.angle', 10)
        setProperty('volume3.visible', true)
        doTweenY('volume3Tween', 'volume3', 280, 0.25, 'elasticInOut')

        makeAnimatedLuaSprite('albumTexts', 'UpDaTe/freeplay/albumRoll/volume3-text',940,500)
        addAnimationByPrefix('albumTexts','idle','',24,false)
        addLuaSprite('albumTexts', true)
        setProperty('albumTexts.camera', instanceArg('camUi'), false, true)
    end

    if selectedCapsule == 10 or selectedCapsule == 13 then
        -- Ocultar otros sprites
        setProperty('albumRoll.visible', false)
        setProperty('volume3.visible', false)
        setProperty('expansion2.visible', false)

        makeLuaSprite('expansion1', 'UpDaTe/freeplay/albumRoll/expansion1', 955, 270)
        addLuaSprite('expansion1', true)
        setProperty('expansion1.camera', instanceArg('camUi'), false, true)
        setProperty('expansion1.angle', 10)
        setProperty('expansion1.visible', true)
        doTweenY('expansion1Tween', 'expansion1', 280, 0.25, 'elasticInOut')

        makeAnimatedLuaSprite('albumTexts', 'UpDaTe/freeplay/albumRoll/expansion1-text',930,490)
        addAnimationByPrefix('albumTexts','idle','',24,false)
        addLuaSprite('albumTexts', true)
        setProperty('albumTexts.camera', instanceArg('camUi'), false, true)
    end

    if selectedCapsule == 12 or selectedCapsule == 17 then
        -- Ocultar otros sprites
        setProperty('albumRoll.visible', false)
        setProperty('volume3.visible', false)
        setProperty('expansion1.visible', false)

        makeLuaSprite('expansion2', 'UpDaTe/freeplay/albumRoll/expansion2', 955, 270)
        addLuaSprite('expansion2', true)
        setProperty('expansion2.camera', instanceArg('camUi'), false, true)
        setProperty('expansion2.angle', 10)
        setProperty('expansion2.visible', true)
        doTweenY('expansion2Tween', 'expansion2', 280, 0.25, 'elasticInOut')

        makeAnimatedLuaSprite('albumTexts', 'UpDaTe/freeplay/albumRoll/expansion2-text',930,490)
        addAnimationByPrefix('albumTexts','idle','',24,false)
        addLuaSprite('albumTexts', true)
        setProperty('albumTexts.camera', instanceArg('camUi'), false, true)
    end
end

------------------------
if i == selectedCapsule - 2 then
    targetY = targetY -225  -- Ajuste extra para elevar la cápsula dos posiciones atrás
end
if selectedCapsule == 17 or selectedCapsule == 18 then
    targetY = targetY +20
end
        -- Determinar si estamos en un ciclo (de la última a la primera o viceversa)
        if (selectedCapsule == 1 and i == #capsules) or (selectedCapsule == #capsules and i == 1) then
            tweenType = 'quadInOut'  -- Cambiar el tipo de tween si es un ciclo
        end

        -- Reproducir la animación de las cápsulas no seleccionadas
        if i ~= selectedCapsule then
            playAnim(capsuleName, 'normal', true)
        end
        --------------------
--------------------------------------
        -- Transiciones en X e Y para la cápsula
        doTweenY(capsuleName .. 'MoveTweenY', capsuleName, targetY, 0.2, tweenType)
        doTweenX(capsuleName .. 'MoveTweenX', capsuleName, targetX, 0.2, tweenType)

        -- Mover el texto correspondiente a la cápsula
        local textName = 'capsuleText' .. i
        if i ~= selectedCapsule then
            setTextColor(textName, 'b3e0ff') 
        else
            setTextColor(textName, '66dfff')  -- Azul claro aún más suave
            setProperty(textName .. '.alpha', 1)
        end
        local textTargetX = targetX - 240 -- Ajusta la posición X del texto de forma predeterminada
        if i > 4 then
            textTargetX = textTargetX + 40 -- Ajusta este valor según sea necesario
        end
        -- Ajustar el desplazamiento del texto basado en la tabla
        textTargetX = textTargetX + (textOffsets[i] or 0) -- Aplica el ajuste correspondiente o 0 si no hay ajuste

        -- Transiciones en Y para el texto
        doTweenY(textName .. 'MoveTweenY', textName, targetY + 45, 0.2, tweenType) -- Ajusta la posición Y del texto
        if i == 10 then
            doTweenY(textName .. 'MoveTweenY', textName, targetY + 48, 0.2, tweenType) 
        end
        doTweenX(textName .. 'MoveTweenX', textName, textTargetX, 0.2, tweenType) -- Mover texto con la cápsula
        local sprites -- Declarar la variable fuera del bloque

        if spriteIndex == 3 then
            sprites = {
                {id = 'darnellpixel', index = 2, offsetY = 15, offsetX = 50}
            }
        else
            sprites = {
                {id = 'dadpixel1', index = 2, offsetY = 15, offsetX = 52},
                {id = 'dadpixel2', index = 3, offsetY = 15, offsetX = 52},
                {id = 'dadpixel3', index = 4, offsetY = 15, offsetX = 52},
                {id = 'spookypixel1', index = 5, offsetY = 15, offsetX = 52},
                {id = 'spookypixel2', index = 6, offsetY = 15, offsetX = 42},
                {id = 'picopixel1', index = 7, offsetY = 25, offsetX = 71},
                {id = 'picopixel2', index = 8, offsetY = 25, offsetX = 71},
                {id = 'picopixel3', index = 9, offsetY = 25, offsetX = 71},
                {id = 'mommypixel1', index = 10, offsetY = -5, offsetX = 32},
                {id = 'mommypixel2', index = 11, offsetY = -5, offsetX = 32},
                {id = 'parents-christmaspixel1', index = 12, offsetY = 0, offsetX = 22},
                {id = 'parents-christmaspixel2', index = 13, offsetY = 0, offsetX = 22},
                {id = 'senpaipixel1', index = 14, offsetY = 25, offsetX = 51},
                {id = 'senpaipixel2', index = 15, offsetY = 25, offsetX = 51},
                {id = 'spiritpixel', index = 16, offsetY = 20, offsetX = 50},
                {id = 'tankmanpixel', index = 17, offsetY = 30, offsetX = 60},
            }
        end
        
        -- Ahora puedes usar la variable 'sprites' después de este bloque.
        
        for _, sprite in ipairs(sprites) do
            if i == sprite.index then
                doTweenY(sprite.id .. 'MoveTweenY', sprite.id, targetY + sprite.offsetY, 0.2, tweenType)
                doTweenX(sprite.id .. 'MoveTweenX', sprite.id, targetX + sprite.offsetX, 0.2, tweenType)
        
                local bpmx = 'bpmx' .. i
                -- Ajustando offsets para bpmx
                doTweenY(sprite.id .. 'MoveTweenY2', bpmx, targetY + sprite.offsetY + 70, 0.2, tweenType) 
                doTweenX(sprite.id .. 'MoveTweenX2', bpmx, targetX + sprite.offsetX + 80, 0.2, tweenType) 
                if i>6 and i <10 then
                    doTweenY(sprite.id .. 'MoveTweenY2', bpmx, targetY -10 + sprite.offsetY + 70, 0.2, tweenType) 
                    doTweenX(sprite.id .. 'MoveTweenX2', bpmx, targetX -20 + sprite.offsetX + 80, 0.2, tweenType) 
                end
                if i>9 and i <14 then
                    doTweenY(sprite.id .. 'MoveTweenY2', bpmx, targetY +20 + sprite.offsetY + 70, 0.2, tweenType) 
                    doTweenX(sprite.id .. 'MoveTweenX2', bpmx, targetX +20 + sprite.offsetX + 80, 0.2, tweenType) 
                end
                if i>13 and i <16 then
                    doTweenY(sprite.id .. 'MoveTweenY2', bpmx, targetY -10 + sprite.offsetY + 70, 0.2, tweenType) 
                    doTweenX(sprite.id .. 'MoveTweenX2', bpmx, targetX +4 + sprite.offsetX + 80, 0.2, tweenType) 
                end
                if i==12 or i == 13 then

                    doTweenY(sprite.id .. 'MoveTweenY2', bpmx, targetY +18 + sprite.offsetY + 70, 0.2, tweenType) 
                    doTweenX(sprite.id .. 'MoveTweenX2', bpmx, targetX +23 + sprite.offsetX + 80, 0.2, tweenType)     end
                if i==16 then
                    doTweenY(sprite.id .. 'MoveTweenY2', bpmx, targetY -4 + sprite.offsetY + 70, 0.2, tweenType) 
                    doTweenX(sprite.id .. 'MoveTweenX2', bpmx, targetX +0 + sprite.offsetX + 80, 0.2, tweenType) 
                end
                if i>16 then
                    doTweenY(sprite.id .. 'MoveTweenY2', bpmx, targetY -10 + sprite.offsetY + 70, 0.2, tweenType) 
                    doTweenX(sprite.id .. 'MoveTweenX2', bpmx, targetX -5 + sprite.offsetX + 80, 0.2, tweenType) 
                end
            end
        end
        
        
        
    end
end





local allDigitSprites = {} -- Tabla para almacenar todos los sprites de dígitos creados

-- Tabla con los números que necesitas
local numeros = {
    "128", "125", "190", "166", "177",
    "162", "175", "170", "135", "125",
    "174", "140", "158", "128", "190", 
    "170", "155","1","1","1","2","2",
    "3","3","3","4","4","5","5","6",
    "6","6","7"
    --diff
}

function onCreatePost()
    makeLuaSprite('clear%', 'UpDaTe/freeplay/clearBox', 1178,70)
    addLuaSprite('clear%', true)
    scaleObject('clear%', 1,1)
    setProperty('clear%.camera', instanceArg('camTop'), false, true)
    local animations = {
        "ZERO",
        "ONE",
        "TWO",
        "THREE",
        "FOUR",
        "FIVE",
        "SIX",
        "SEVEN",
        "EIGHT",
        "NINE"
    }
    
    local initialY = 0  
    local spacingY = 50
    for i = 1, 16 do
        local formattedNumber = i
        makeAnimatedLuaSprite("zero_" .. formattedNumber, "UpDaTe/freeplay/freeplayCapsule/bignumbers", 500, initialY + (i * spacingY))
        addAnimationByPrefix("zero_" .. formattedNumber, '0', animations[1], 24, false)
        addAnimationByPrefix("zero_" .. formattedNumber, '1', animations[2], 24, false)
        addLuaSprite("zero_" .. formattedNumber, true)
        setProperty("zero_" .. formattedNumber .. ".camera", instanceArg('camLua'), false, true)
        scaleObject("zero_" .. formattedNumber, 0.8, 0.8)
        playAnim("zero_" .. formattedNumber,'0')
    end
    for i = 1, 16 do
        local formattedNumber = i
        makeAnimatedLuaSprite("number_" .. formattedNumber, "UpDaTe/freeplay/freeplayCapsule/bignumbers", 0, initialY + (i * spacingY))
        addAnimationByPrefix("number_" .. formattedNumber, '0', animations[0+1], 24, false)
        addAnimationByPrefix("number_" .. formattedNumber, '1', animations[1+1], 24, false)
        addAnimationByPrefix("number_" .. formattedNumber, '2', animations[2+1], 24, false)
        addAnimationByPrefix("number_" .. formattedNumber, '3', animations[3+1], 24, false)
        addAnimationByPrefix("number_" .. formattedNumber, '4', animations[4+1], 24, false)
        addAnimationByPrefix("number_" .. formattedNumber, '5', animations[5+1], 24, false)
        addAnimationByPrefix("number_" .. formattedNumber, '6', animations[6+1], 24, false)
        addAnimationByPrefix("number_" .. formattedNumber, '7', animations[7+1], 24, false)
        addAnimationByPrefix("number_" .. formattedNumber, '8', animations[8+1], 24, false)
        addAnimationByPrefix("number_" .. formattedNumber, '9', animations[9+1], 24, false)
        addLuaSprite("number_" .. formattedNumber, true)
        setProperty("number_" .. formattedNumber .. ".camera", instanceArg('camLua'), false, true)
        scaleObject("number_" .. formattedNumber,0.8,0.8)
    end

    --
    for i = 1, 16 do
        local spriteName = 'weektypes' .. i  -- Generate a unique sprite name
        makeAnimatedLuaSprite(spriteName, 'UpDaTe/freeplay/freeplayCapsule/weektypes', 800, 115)
        addAnimationByPrefix(spriteName,'weektypes', 'WEEK text instance 1',24,true)
        addAnimationByPrefix(spriteName,'weekend', 'WEEKEND text instance 1',24,true)
        addLuaSprite(spriteName, false)
        scaleObject(spriteName, 1, 1)
        setProperty(spriteName .. '.camera', instanceArg('camUi'), false, true)

        local diffLol = 'diff' .. i  -- Generate a unique sprite name
        makeLuaSprite(diffLol, 'UpDaTe/freeplay/freeplayCapsule/difficultytext', 800, 115)
        addLuaSprite(diffLol, false)
        scaleObject(diffLol, 1, 1)
        setProperty(diffLol .. '.camera', instanceArg('camUi'), false, true)
    end

    
    for index, numero in ipairs(numeros) do
        crearNumeros(numero, index)  -- Llama a crearNumeros para cada número en la tabla
    end
end

-- Función para crear y mostrar los números
function crearNumeros(numeroStr, instanceIndex)
    -- Crea una tabla para almacenar los sprites de esta instancia
    local digitSprites = {}

    -- Itera a través de cada dígito del número
    for i = 1, #numeroStr do
        local digit = numeroStr:sub(i, i) -- Extrae el dígito como texto
        local animName = getAnimName(digit) -- Obtén el nombre de la animación correspondiente
        
        -- Crea un sprite para cada dígito y añade la animación correcta
        local sprite = 'digit' .. instanceIndex .. '_' .. i -- Cambia el nombre del sprite para diferenciar instancias
        makeAnimatedLuaSprite(sprite, 'UpDaTe/freeplay/freeplayCapsule/smallnumbers', 400 + ((i - 1) * 14), -400 + (instanceIndex - 1) * 30) -- Ajusta la posición en Y para separar las instancias
        addAnimationByPrefix(sprite, animName, animName, 24, false)
        addLuaSprite(sprite, false)
        setProperty(sprite..'.camera', instanceArg('camUi'), false, true)
        playAnim(sprite, animName, true)

        table.insert(digitSprites, sprite) -- Guarda el sprite en la tabla local
    end

    -- Guarda los sprites de esta instancia en la tabla global
    table.insert(allDigitSprites, digitSprites)
end

-- Función para obtener el nombre de la animación según el dígito
function getAnimName(digit)
    local animations = {
        ["0"] = "ZERO",
        ["1"] = "ONE",
        ["2"] = "TWO",
        ["3"] = "THREE",
        ["4"] = "FOUR",
        ["5"] = "FIVE",
        ["6"] = "SIX",
        ["7"] = "SEVEN",
        ["8"] = "EIGHT",
        ["9"] = "NINE"
    }
    return animations[digit]
end

function presionar()
    if spriteIndex == 3 then 
        playAnim("number_2", '4', true)
    end
    if spriteIndex == 1 then 
    playAnim("zero_4", '1',true)
    playAnim("zero_8", '1',true)
    playAnim("zero_9", '1',true)
    playAnim("zero_16", '0',true)

    playAnim("number_1", '7', true)
    playAnim("number_2", '6', true)
    playAnim("number_3", '8', true)
    playAnim("number_4", '2', true)
    playAnim("number_5", '8', true)
    playAnim("number_6", '8', true)
    playAnim("number_7", '7', true)
    playAnim("number_8", '2', true)
    playAnim("number_9", '3', true)
    playAnim("number_10", '7', true)
    playAnim("number_11", '8', true)
    playAnim("number_12", '6', true)
    playAnim("number_13", '7', true)
    playAnim("number_14", '8', true)
    playAnim("number_15", '6', true)
    playAnim("number_16", '9', true)    
    end
    if spriteIndex == 2 then 
        playAnim("zero_4", '1',true)
        playAnim("zero_8", '1',true)
        playAnim("zero_9", '1',true)
        playAnim("zero_16", '1',true)

        playAnim("number_1", '8', true)
        playAnim("number_2", '7', true)
        playAnim("number_3", '9', true)
        playAnim("number_4", '3', true)
        playAnim("number_5", '9', true)
        playAnim("number_6", '9', true)
        playAnim("number_7", '8', true)
        playAnim("number_8", '3', true)
        playAnim("number_9", '4', true)
        playAnim("number_10", '8', true)
        playAnim("number_11", '9', true)
        playAnim("number_12", '7', true)
        playAnim("number_13", '8', true)
        playAnim("number_14", '9', true)
        playAnim("number_15", '8', true)
        playAnim("number_16", '0', true)
        
        end
    ------------DIFFFFFF
    if spriteIndex == 3 then     
        setProperty("zero_2.x", getProperty('freeplayCapsule2.x')+460)
        setProperty("zero_2.y", getProperty('freeplayCapsule2.y')+39)
        setProperty("number_2.x",getProperty('freeplayCapsule2.x')+490)
        setProperty("number_2.y",getProperty('freeplayCapsule2.y')+39)
        for n = 1, 16 do 
            if n ~= 2 then
                setProperty("zero_" .. n .. ".x", 9990)
                setProperty("zero_" .. n .. ".y", 9909)
            end    
        end    
        
        for n = 1, 16 do 
            if n ~= 2 then
                setProperty("number_" .. n .. ".x", 9999)
                setProperty("number_" .. n .. ".y", 9999)
            end    
        end    
        
local capsuleIndex = 2  
local groupSize = 1     
local xOffset = 350
local yOffset = 8700

for q = 18, 37 do
    local capsuleY = getProperty('freeplayCapsule' .. capsuleIndex .. '.y') or 0
    local capsuleX = getProperty('freeplayCapsule' .. capsuleIndex .. '.x') or 0

    if q == 18 then
        setProperty('digit' .. q .. '_1.y', capsuleY+87)
        setProperty('digit' .. q .. '_1.x', capsuleX+390)
    else
        setProperty('digit' .. q .. '_1.y', capsuleY + yOffset)
        setProperty('digit' .. q .. '_1.x', capsuleX + xOffset)
    end

    if (q - 17) % groupSize == 0 then
        capsuleIndex = capsuleIndex + 1
    end
end

        for b = 1, 2 do
            setProperty('weektypes' .. b .. '.x', getProperty('freeplayCapsule'..b..'.x')+280)
            setProperty('weektypes' .. b .. '.y', getProperty('freeplayCapsule'..b..'.y')+87)

            setProperty('diff' .. b .. '.x', getProperty('freeplayCapsule'..b..'.x')+410)
            setProperty('diff' .. b .. '.y', getProperty('freeplayCapsule'..b..'.y')+87)
        end
        
        playAnim('weektypes2','weekend',true)
        setProperty('weektypes1.x',9999)
        setProperty('weektypes3.x',9999)
        setProperty('weektypes4.x',9999)
        setProperty('weektypes5.x',9999)
        setProperty('weektypes6.x',9999)
        setProperty('weektypes7.x',9999)
        setProperty('weektypes8.x',9999)
        setProperty('weektypes9.x',9999)
        setProperty('weektypes10.x',9999)
        setProperty('weektypes12.x',9999)
        setProperty('weektypes13.x',9999)
        setProperty('weektypes14.x',9999)
        setProperty('weektypes15.x',9999)
        setProperty('weektypes16.x',9999)
        setProperty('weektypes11.x',9999)

        setProperty('diff1.x',9999)
        setProperty('diff3.x',9999)
        setProperty('diff4.x',9999)
        setProperty('diff5.x',9999)
        setProperty('diff6.x',9999)
        setProperty('diff7.x',9999)
        setProperty('diff8.x',9999)
        setProperty('diff9.x',9999)
        setProperty('diff10.x',9999)
        setProperty('diff12.x',9999)
        setProperty('diff13.x',9999)
        setProperty('diff14.x',9999)
        setProperty('diff15.x',9999)
        setProperty('diff16.x',9999)
        setProperty('diff11.x',9999)
        for i = 1, 16 do

            for h = 1 ,3 do
            setProperty('digit' .. i .. '_' .. h .. '.y', 99999)
        end
    end
            for skibidi = 1, 3 do
        setProperty('digit17_' .. skibidi .. '.x', getProperty('freeplayCapsule2.x')+180 + ((skibidi - 1) * 14))
        setProperty('digit17_' .. skibidi .. '.y', getProperty('freeplayCapsule2.y')+85)
    end
end
    if spriteIndex == 1 or spriteIndex == 2 then
        for n = 1, 16 do 
            setProperty("zero_" .. n .. ".x", getProperty('freeplayCapsule' .. n+1 .. '.x')+460)
            setProperty("zero_" .. n .. ".y", getProperty('freeplayCapsule' .. n+1 .. '.y')+39)
        end    
        for n = 1, 16 do 
            setProperty("number_" .. n .. ".x", getProperty('freeplayCapsule' .. n+1 .. '.x')+490)
            setProperty("number_" .. n .. ".y", getProperty('freeplayCapsule' .. n+1 .. '.y')+39)
        end    
        local capsuleIndex = 2  
        local groupSize = 1     
        local xOffset = 350
        local yOffset = 87
        
        for q = 18, 37 do
            local capsuleY = getProperty('freeplayCapsule' .. capsuleIndex .. '.y') or 0
            local capsuleX = getProperty('freeplayCapsule' .. capsuleIndex .. '.x') or 0
        
            setProperty('digit' .. q .. '_1.y', capsuleY + yOffset)
            setProperty('digit' .. q .. '_1.x', capsuleX + xOffset)
        
            if (q - 17) % groupSize == 0 then
                capsuleIndex = capsuleIndex + 1
            end
        end
        
                playAnim('weektypes2','weektypes',true)
        for i = 1, 16 do
            setProperty('weektypes' .. i .. '.x', getProperty('freeplayCapsule'..(i+1)..'.x')+280)
            setProperty('weektypes' .. i .. '.y', getProperty('freeplayCapsule'..(i+1)..'.y')+87)

            setProperty('diff' .. i .. '.x', getProperty('freeplayCapsule'..(i+1)..'.x')+400)
            setProperty('diff' .. i .. '.y', getProperty('freeplayCapsule'..(i+1)..'.y')+87)
        end
        
    for skibidi = 1, 3 do
        setProperty('digit1_' .. skibidi .. '.x', getProperty('freeplayCapsule2.x')+180 + ((skibidi - 1) * 14))
        setProperty('digit1_' .. skibidi .. '.y', getProperty('freeplayCapsule2.y')+85)
        setProperty('digit2_' .. skibidi .. '.x', getProperty('freeplayCapsule3.x')+180 + ((skibidi - 1) * 14))
        setProperty('digit2_' .. skibidi .. '.y', getProperty('freeplayCapsule3.y')+85)
        setProperty('digit3_' .. skibidi .. '.x', getProperty('freeplayCapsule4.x')+180 + ((skibidi - 1) * 14))
        setProperty('digit3_' .. skibidi .. '.y', getProperty('freeplayCapsule4.y')+85)
        setProperty('digit4_' .. skibidi .. '.x', getProperty('freeplayCapsule5.x')+180 + ((skibidi - 1) * 14))
        setProperty('digit4_' .. skibidi .. '.y', getProperty('freeplayCapsule5.y')+85)
        setProperty('digit5_' .. skibidi .. '.x', getProperty('freeplayCapsule6.x')+180 + ((skibidi - 1) * 14))
        setProperty('digit5_' .. skibidi .. '.y', getProperty('freeplayCapsule6.y')+85)
        setProperty('digit6_' .. skibidi .. '.x', getProperty('freeplayCapsule7.x')+180 + ((skibidi - 1) * 14))
        setProperty('digit6_' .. skibidi .. '.y', getProperty('freeplayCapsule7.y')+85)
        setProperty('digit7_' .. skibidi .. '.x', getProperty('freeplayCapsule8.x')+180 + ((skibidi - 1) * 14))
        setProperty('digit7_' .. skibidi .. '.y', getProperty('freeplayCapsule8.y')+85)
        setProperty('digit8_' .. skibidi .. '.x', getProperty('freeplayCapsule9.x')+180 + ((skibidi - 1) * 14))
        setProperty('digit8_' .. skibidi .. '.y', getProperty('freeplayCapsule9.y')+85)

        setProperty('digit9_' .. skibidi .. '.x', getProperty('freeplayCapsule10.x') + 180 + ((skibidi - 1) * 14))
        setProperty('digit9_' .. skibidi .. '.y', getProperty('freeplayCapsule10.y') + 85)

        -- Ajusta las propiedades de digit10
        setProperty('digit10_' .. skibidi .. '.x', getProperty('freeplayCapsule11.x') + 180 + ((skibidi - 1) * 14))
        setProperty('digit10_' .. skibidi .. '.y', getProperty('freeplayCapsule11.y') + 85)

        -- Ajusta las propiedades de digit11
        setProperty('digit11_' .. skibidi .. '.x', getProperty('freeplayCapsule12.x') + 180 + ((skibidi - 1) * 14))
        setProperty('digit11_' .. skibidi .. '.y', getProperty('freeplayCapsule12.y') + 88)

        -- Ajusta las propiedades de digit12
        setProperty('digit12_' .. skibidi .. '.x', getProperty('freeplayCapsule13.x') + 180 + ((skibidi - 1) * 14))
        setProperty('digit12_' .. skibidi .. '.y', getProperty('freeplayCapsule13.y') + 88)

        -- Ajusta las propiedades de digit13
        setProperty('digit13_' .. skibidi .. '.x', getProperty('freeplayCapsule14.x') + 180 + ((skibidi - 1) * 14))
        setProperty('digit13_' .. skibidi .. '.y', getProperty('freeplayCapsule14.y') + 85)

        -- Ajusta las propiedades de digit14
        setProperty('digit14_' .. skibidi .. '.x', getProperty('freeplayCapsule15.x') + 180 + ((skibidi - 1) * 14))
        setProperty('digit14_' .. skibidi .. '.y', getProperty('freeplayCapsule15.y') + 85)

        -- Ajusta las propiedades de digit15
        setProperty('digit15_' .. skibidi .. '.x', getProperty('freeplayCapsule16.x') + 180 + ((skibidi - 1) * 14))
        setProperty('digit15_' .. skibidi .. '.y', getProperty('freeplayCapsule16.y') + 85)

        -- Ajusta las propiedades de digit16
        setProperty('digit16_' .. skibidi .. '.x', getProperty('freeplayCapsule17.x') + 187 + ((skibidi - 1) * 13))
        setProperty('digit16_' .. skibidi .. '.y', getProperty('freeplayCapsule17.y') + 90)

        setProperty('digit17_' .. skibidi .. '.x', getProperty('freeplayCapsule2.x')+180 + ((skibidi - 1) * 14))
        setProperty('digit17_' .. skibidi .. '.y', getProperty('freeplayCapsule2.y')+80005)
    end
end 
end
function cambiarScoreAerect()
    if spriteIndex ~= 3 then

        local rating = math.floor(callMethodFromClass('backend.Highscore', 'getRating', { getTextString('capsuleText' .. selectedCapsule),0}) * 100)

            displayClearScore(rating)
        
        function forceNewClearScore(newScore)
            displayClearScore(newScore)
        end

    displayScore(callMethodFromClass('backend.Highscore', 'getScore', { getTextString('capsuleText' .. selectedCapsule), 0}))
end
end
function cambiarScoreAnightmare()
    if spriteIndex ~= 3 then
          
        local rating = math.floor(callMethodFromClass('backend.Highscore', 'getRating', { getTextString('capsuleText' .. selectedCapsule), 1}) * 100)

            displayClearScore(rating)   
        
        function forceNewClearScore(newScore)
            displayClearScore(newScore)
        end

    displayScore(callMethodFromClass('backend.Highscore', 'getScore', { getTextString('capsuleText' .. selectedCapsule), 1}))
end
end