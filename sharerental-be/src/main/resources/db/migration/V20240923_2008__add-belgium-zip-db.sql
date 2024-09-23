UPDATE postal_code_lat_long
SET province_name = 'Noord-Brabant',
    city_name     = 'Helvoirt'
WHERE postcode LIKE '5268';

UPDATE postal_code_lat_long
SET province_name = 'Groningen',
    city_name     = 'Uitwierde'
WHERE postcode LIKE '9931';

UPDATE postal_code_lat_long
SET province_name = 'Groningen',
    city_name     = 'Garsthuizen'
WHERE postcode LIKE '9923';

UPDATE postal_code_lat_long
SET province_name = 'Groningen',
    city_name     = 'Termunten'
WHERE postcode LIKE '9947';

UPDATE postal_code_lat_long
SET province_name = 'Groningen',
    city_name     = 'Uitwierde'
WHERE postcode LIKE '9931';

UPDATE postal_code_lat_long
SET province_name = 'Groningen',
    city_name     = 'Spijk'
WHERE postcode LIKE '9909';

UPDATE postal_code_lat_long
SET province_name = 'Noord-Brabant',
    city_name     = 'Haaren'
WHERE postcode LIKE '5076';

UPDATE postal_code_lat_long
SET province_name = 'Noord-Brabant',
    city_name     = 'Esch'
WHERE postcode LIKE '5296';

UPDATE postal_code_lat_long
    set city_name = postcode
WHERE city_name is null;

alter table postal_code_lat_long
    add column country_code text not null default 'NL';

alter table postal_code_lat_long
    rename column postcode to postal_code;

-- alter table primary key to include country code
alter table postal_code_lat_long
    drop constraint postal_code_lat_long_pkey;

alter table postal_code_lat_long
    add constraint postal_code_lat_long_pkey primary key (postal_code, city_name, country_code);


INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.853812373745676, 4.369278654960959, '1000', 'Brussel-Hoofdstad', 'Sint-Joost-ten-Node', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1000', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.822325604082295, 4.377065860435231, '1000', 'Brussel-Hoofdstad', 'Elsene', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1005', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1006', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1007', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1008', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1009', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1011', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1012', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1020', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.861805515601496, 4.38605713534583, '1030', 'Brussel-Hoofdstad', 'Schaarbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.861805515601496, 4.38605713534583, '1031', 'Brussel-Hoofdstad', 'Schaarbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.861805515601496, 4.38605713534583, '1033', 'Brussel-Hoofdstad', 'Schaarbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.861805515601496, 4.38605713534583, '1035', 'Brussel-Hoofdstad', 'Schaarbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1040', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.83298255184288, 4.394600605024559, '1040', 'Brussel-Hoofdstad', 'Etterbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1041', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.861805515601496, 4.38605713534583, '1043', 'Brussel-Hoofdstad', 'Schaarbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.861805515601496, 4.38605713534583, '1044', 'Brussel-Hoofdstad', 'Schaarbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87001921742844, 4.408236007087518, '1046', 'Brussel-Hoofdstad', 'Evere', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.822325604082295, 4.377065860435231, '1047', 'Brussel-Hoofdstad', 'Elsene', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1048', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87001921742844, 4.408236007087518, '1049', 'Brussel-Hoofdstad', 'Evere', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.822325604082295, 4.377065860435231, '1050', 'Brussel-Hoofdstad', 'Elsene', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.829476307319766, 4.344697581912635, '1050', 'Brussel-Hoofdstad', 'Sint-Gillis', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.829476307319766, 4.344697581912635, '1060', 'Brussel-Hoofdstad', 'Sint-Gillis', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.828980275263795, 4.292904442200332, '1070', 'Brussel-Hoofdstad', 'Anderlecht', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.85522961973389, 4.318418678989754, '1080', 'Brussel-Hoofdstad', 'Sint-Jans-Molenbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86301498471678, 4.324083268779553, '1081', 'Brussel-Hoofdstad', 'Koekelberg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86465279974552, 4.293920189965437, '1082', 'Brussel-Hoofdstad', 'Sint-Agatha-Berchem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87440457885052, 4.309447398997361, '1083', 'Brussel-Hoofdstad', 'Ganshoren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.881720021988286, 4.321383766329789, '1090', 'Brussel-Hoofdstad', 'Jette', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1099', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1105', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1110', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1120', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '1130', 'Brussel-Hoofdstad', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87001921742844, 4.408236007087518, '1140', 'Brussel-Hoofdstad', 'Evere', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.83109966996703, 4.443103143199102, '1150', 'Brussel-Hoofdstad', 'Sint-Pieters-Woluwe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.81019872509648, 4.43799132057269, '1160', 'Brussel-Hoofdstad', 'Oudergem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.79291924189043, 4.423479931708108, '1170', 'Brussel-Hoofdstad', 'Watermaal-Bosvoorde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.78987082854528, 4.361370487792108, '1180', 'Brussel-Hoofdstad', 'Ukkel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.814084975691195, 4.324177215886155, '1190', 'Brussel-Hoofdstad', 'Vorst', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84789153612173, 4.431541527426499, '1200', 'Brussel-Hoofdstad', 'Sint-Lambrechts-Woluwe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.853812373745676, 4.369278654960959, '1210', 'Brussel-Hoofdstad', 'Sint-Joost-ten-Node', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.853812373745676, 4.369278654960959, '1212', 'Brussel-Hoofdstad', 'Sint-Joost-ten-Node', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69801921281275, 4.5719102975057, '1300', 'Brabant wallon (le)', 'Limal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.72477661519289, 4.609958977641858, '1300', 'Brabant wallon (le)', 'Wavre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.7168861193855, 4.581594841842499, '1301', 'Brabant wallon (le)', 'Bierges', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73629996455743, 4.464834689100548, '1310', 'Brabant wallon (le)', 'La Hulpe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.6951830376784, 4.788379199533981, '1315', 'Brabant wallon (le)', 'Incourt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.78029938291994, 4.7850703687239395, '1320', 'Brabant wallon (le)', 'Beauvechain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67844529926434, 4.711227589915237, '1325', 'Brabant wallon (le)', 'Chaumont-Gistoux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.7122118597938, 4.528024961130181, '1330', 'Brabant wallon (le)', 'Rixensart', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73537497297937, 4.546587881040538, '1331', 'Brabant wallon (le)', 'Rosières', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.722532048805405, 4.500249260661122, '1332', 'Brabant wallon (le)', 'Genval', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67146356031946, 4.584311991418305, '1340', 'Brabant wallon (le)', 'Ottignies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.660622122467714, 4.5341919461924025, '1341', 'Brabant wallon (le)', 'Céroux-Mousty', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.68379979985528, 4.5584085198370445, '1342', 'Brabant wallon (le)', 'Limelette', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.64437790193214, 4.610583193636526, '1348', 'Brabant wallon (le)', 'Mont-Saint-Guibert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67146356031946, 4.584311991418305, '1348', 'Brabant wallon (le)', 'Ottignies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.682127504134996, 4.943561142913658, '1350', 'Brabant wallon (le)', 'Jauche', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.75655859247487, 4.98531372583491, '1357', 'Brabant wallon (le)', 'Neerheylissem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.619095318139706, 4.765632118823371, '1360', 'Brabant wallon (le)', 'Thorembais-Saint-Trond', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.6450470427425, 4.867898985361501, '1367', 'Brabant wallon (le)', 'Geest-Gérompont-Petit-Rosière', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.717769456989686, 4.877544510544012, '1370', 'Brabant wallon (le)', 'Jodoigne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.683720905648165, 4.487230128604433, '1380', 'Brabant wallon (le)', 'Lasne-Chapelle-Saint-Lambert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.75149334838617, 4.673104738692169, '1390', 'Brabant wallon (le)', 'Archennes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.591388384222846, 4.327273956190343, '1400', 'Brabant wallon (le)', 'Nivelles', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.617663557366754, 4.358076642200513, '1401', 'Brabant wallon (le)', 'Baulers', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.589972355763386, 4.378963304808165, '1402', 'Brabant wallon (le)', 'Thines', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.6042547788242, 4.2629198483323, '1404', 'Brabant wallon (le)', 'Bornival', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.70976366812478, 4.403520554166193, '1410', 'Brabant wallon (le)', 'Waterloo', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.692382997024126, 4.35823745489421, '1420', 'Brabant wallon (le)', 'Braine-l`Alleud', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65760296310933, 4.339701935206512, '1421', 'Brabant wallon (le)', 'Ophain-Bois-Seigneur-Isaac', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.64114510796939, 4.366142301894997, '1428', 'Brabant wallon (le)', 'Lillois-Witterzée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65387528143722, 4.124926940143261, '1430', 'Brabant wallon (le)', 'Rebecq-Rognon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.64437790193214, 4.610583193636526, '1435', 'Brabant wallon (le)', 'Mont-Saint-Guibert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67878793707231, 4.268277717247763, '1440', 'Brabant wallon (le)', 'Braine-le-Château', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.57826594178644, 4.618303657381869, '1450', 'Brabant wallon (le)', 'Saint-Géry', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61680143779535, 4.692532525665684, '1457', 'Brabant wallon (le)', 'Walhain-Saint-Paul', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.64085582622058, 4.259715332494394, '1460', 'Brabant wallon (le)', 'Ittre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.64968399763807, 4.300030197749638, '1461', 'Brabant wallon (le)', 'Haut-Ittre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60920472279855, 4.448927543402161, '1470', 'Brabant wallon (le)', 'Genappe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59623200805342, 4.481721401439023, '1470', 'Brabant wallon (le)', 'Baisy-Thy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.594766353469524, 4.4335308077062585, '1471', 'Brabant wallon (le)', 'Loupoigne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.62507941120234, 4.412997016590901, '1472', 'Brabant wallon (le)', 'Vieux-Genappe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.63516214371723, 4.44652131973248, '1473', 'Brabant wallon (le)', 'Glabais', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.62720733860356, 4.470868865304241, '1474', 'Brabant wallon (le)', 'Ways', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.575783513789226, 4.410456750172978, '1476', 'Brabant wallon (le)', 'Houtain-le-Val', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.68403302110266, 4.1943623736711, '1480', 'Brabant wallon (le)', 'Tubize', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.62644859932748, 4.562595910150405, '1490', 'Brabant wallon (le)', 'Court-Saint-Étienne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.549583794306336, 4.535360186118476, '1495', 'Brabant wallon (le)', 'Marbais', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73071382505011, 4.240277878728712, '1500', 'Vlaams-Brabant', 'Halle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73746200178331, 4.262453273944151, '1501', 'Vlaams-Brabant', 'Buizingen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.71036726580038, 4.217983586174801, '1502', 'Vlaams-Brabant', 'Lembeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.722404957481096, 4.03604040962386, '1540', 'Vlaams-Brabant', 'Herne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.70447653722278, 3.9925589861453323, '1541', 'Vlaams-Brabant', 'Sint-Pieters-Kapelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.71066390957348, 3.9321743559343343, '1547', 'Vlaams-Brabant', 'Bever', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.76103393358512, 4.450819430141942, '1560', 'Vlaams-Brabant', 'Hoeilaart', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.74105581245334, 3.9902980751472428, '1570', 'Vlaams-Brabant', 'Tollembeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.78100238757931, 4.2506966915186215, '1600', 'Vlaams-Brabant', 'Sint-Pieters-Leeuw', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.78483815859806, 4.296779977559773, '1601', 'Vlaams-Brabant', 'Ruisbroek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.80579534061165, 4.230714668607756, '1602', 'Vlaams-Brabant', 'Vlezenbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.79350285511121, 4.3090488169548555, '1620', 'Vlaams-Brabant', 'Drogenbos', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.76794587216992, 4.345414125035608, '1630', 'Vlaams-Brabant', 'Linkebeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.744496059136004, 4.373732794655721, '1640', 'Vlaams-Brabant', 'Sint-Genesius-Rode', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.76625120592787, 4.312619251793211, '1650', 'Vlaams-Brabant', 'Beersel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.76610927459038, 4.2794918593238735, '1651', 'Vlaams-Brabant', 'Lot', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.74752884006042, 4.328078247271569, '1652', 'Vlaams-Brabant', 'Alsemberg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.733773934276996, 4.298649637605856, '1653', 'Vlaams-Brabant', 'Dworp', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.748563374114006, 4.274053226347698, '1654', 'Vlaams-Brabant', 'Huizingen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.75588535895773, 4.162898746828571, '1670', 'Vlaams-Brabant', 'Pepingen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.78030661666723, 4.174912694965389, '1671', 'Vlaams-Brabant', 'Elingen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.733790299411545, 4.181339451829367, '1673', 'Vlaams-Brabant', 'Beert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.737711397804, 4.1587223583369575, '1674', 'Vlaams-Brabant', 'Bellingen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84856042288083, 4.2578958901376485, '1700', 'Vlaams-Brabant', 'Dilbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84856042288083, 4.2578958901376485, '1701', 'Vlaams-Brabant', 'Dilbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.83153616046334, 4.232494457999711, '1701', 'Vlaams-Brabant', 'Itterbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.8724565436475, 4.262800821923428, '1702', 'Vlaams-Brabant', 'Groot-Bijgaarden', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.83953171216256, 4.199980231053451, '1703', 'Vlaams-Brabant', 'Schepdaal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.909272565714325, 4.186788555395837, '1730', 'Vlaams-Brabant', 'Asse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.90119406509116, 4.279490957617121, '1731', 'Vlaams-Brabant', 'Relegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.909272565714325, 4.186788555395837, '1733', 'Vlaams-Brabant', 'Asse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.873253369539526, 4.180161626217875, '1740', 'Vlaams-Brabant', 'Ternat', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.855789286666194, 4.155622977848159, '1741', 'Vlaams-Brabant', 'Wambeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87573299371628, 4.1359676324531796, '1742', 'Vlaams-Brabant', 'Sint-Katherina-Lombeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.96521724874241, 4.1822995567601176, '1745', 'Vlaams-Brabant', 'Opwijk', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.820531678444624, 4.179767578395023, '1750', 'Vlaams-Brabant', 'Sint-Martens-Lennik', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.77856023753248, 4.125487211137745, '1755', 'Vlaams-Brabant', 'Leerbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.83785020011701, 4.077674510624705, '1760', 'Vlaams-Brabant', 'Pamel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84979781140373, 4.1277646012156515, '1761', 'Vlaams-Brabant', 'Borchtlombeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.866522312514626, 4.09303583540632, '1770', 'Vlaams-Brabant', 'Liedekerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.90957954247929, 4.30932217692078, '1780', 'Vlaams-Brabant', 'Wemmel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.96497401622396, 4.232932989110518, '1785', 'Vlaams-Brabant', 'Merchtem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.91260930190065, 4.106537553803077, '1790', 'Vlaams-Brabant', 'Hekelgem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.93012891009888, 4.428578360497885, '1800', 'Vlaams-Brabant', 'Vilvoorde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.93012891009888, 4.428578360497885, '1804', 'Vlaams-Brabant', 'Vilvoorde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.908686915761194, 4.512768329408151, '1820', 'Vlaams-Brabant', 'Steenokkerzeel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.91134865371077, 4.443147468386422, '1830', 'Vlaams-Brabant', 'Machelen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.892944354955446, 4.445229932624749, '1831', 'Vlaams-Brabant', 'Diegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.014505411782686, 4.296428516201441, '1840', 'Vlaams-Brabant', 'Londerzeel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.940765638040666, 4.3851759462201425, '1850', 'Vlaams-Brabant', 'Grimbergen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.97142231710905, 4.378726002200047, '1851', 'Vlaams-Brabant', 'Humbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.954721858824506, 4.363325827639951, '1852', 'Vlaams-Brabant', 'Beigem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.90929474624263, 4.342915597541709, '1853', 'Vlaams-Brabant', 'Strombeek-Bever', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.943740928977, 4.325099323868312, '1860', 'Vlaams-Brabant', 'Meise', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.97336092889476, 4.309022344671084, '1861', 'Vlaams-Brabant', 'Wolvertem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.01138982072448, 4.366670334804054, '1880', 'Vlaams-Brabant', 'Kapelle-op-den-Bos', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.94874989926418, 4.570642620178585, '1910', 'Vlaams-Brabant', 'Kampenhout', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88338465440317, 4.47820494125249, '1930', 'Vlaams-Brabant', 'Zaventem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.892944354955446, 4.445229932624749, '1931', 'Vlaams-Brabant', 'Diegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86860468071333, 4.444164020555327, '1932', 'Vlaams-Brabant', 'Sint-Stevens-Woluwe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.85654613816079, 4.510708348249879, '1933', 'Vlaams-Brabant', 'Sterrebeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.892944354955446, 4.445229932624749, '1934', 'Vlaams-Brabant', 'Diegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88338465440317, 4.47820494125249, '1935', 'Vlaams-Brabant', 'Zaventem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.845386982127444, 4.471344481505892, '1950', 'Vlaams-Brabant', 'Kraainem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84309057749016, 4.492424812620597, '1970', 'Vlaams-Brabant', 'Wezembeek-Oppem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.987652937553015, 4.42957064327596, '1980', 'Vlaams-Brabant', 'Zemst', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.96088753393642, 4.442577358408958, '1980', 'Vlaams-Brabant', 'Eppegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99295390689466, 4.502914696762615, '1981', 'Vlaams-Brabant', 'Hofstade', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.967822951963036, 4.503548665909508, '1982', 'Vlaams-Brabant', 'Elewijt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.248447820724365, 4.376134025032607, '2000', 'Antwerpen', 'Antwerpen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.248447820724365, 4.376134025032607, '2018', 'Antwerpen', 'Antwerpen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.248447820724365, 4.376134025032607, '2020', 'Antwerpen', 'Antwerpen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.248447820724365, 4.376134025032607, '2030', 'Antwerpen', 'Antwerpen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.34298198470965, 4.298111097530031, '2040', 'Antwerpen', 'Berendrecht-Zandvliet-Lillo', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.248447820724365, 4.376134025032607, '2050', 'Antwerpen', 'Antwerpen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.248447820724365, 4.376134025032607, '2060', 'Antwerpen', 'Antwerpen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.23137750205675, 4.319816188688978, '2070', 'Antwerpen', 'Zwijndrecht', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.248447820724365, 4.376134025032607, '2099', 'Antwerpen', 'Antwerpen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.215898155997046, 4.46823712928013, '2100', 'Antwerpen', 'Deurne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.229586673387296, 4.516867253463567, '2110', 'Antwerpen', 'Wijnegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.2119968157408, 4.444865773892291, '2140', 'Antwerpen', 'Borgerhout', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.19145932067747, 4.487687146271747, '2150', 'Antwerpen', 'Borsbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.20678750787161, 4.518952239348571, '2160', 'Antwerpen', 'Wommelgem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.25156639821808, 4.44450162313264, '2170', 'Antwerpen', 'Merksem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.28352081368884, 4.4304552890543425, '2180', 'Antwerpen', 'Ekeren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.183255497155216, 4.831562156337345, '2200', 'Antwerpen', 'Herentals', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.06268641706418, 4.72968659576947, '2220', 'Antwerpen', 'Heist-op-den-Berg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.04634221090044, 4.7673047365352055, '2221', 'Antwerpen', 'Booischot', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.103700353875695, 4.722370017948313, '2222', 'Antwerpen', 'Itegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.02869754911989, 4.697724012817591, '2223', 'Antwerpen', 'Schriek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.052403764130105, 4.899473338402746, '2230', 'Antwerpen', 'Herselt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.04722426784125, 4.802118046978261, '2235', 'Antwerpen', 'Houtvenne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.22069321522656, 4.665552049419401, '2240', 'Antwerpen', 'Zandhoven', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.22691252263992, 4.706119439268822, '2242', 'Antwerpen', 'Pulderbos', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.198617734043566, 4.695739820672819, '2243', 'Antwerpen', 'Pulle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.16347229635089, 4.885612822364903, '2250', 'Antwerpen', 'Olen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.118648677888004, 4.893322739960348, '2260', 'Antwerpen', 'Tongerlo', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.13916219772636, 4.759935300337723, '2270', 'Antwerpen', 'Herenthout', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.252365619447, 4.822425937160039, '2275', 'Antwerpen', 'Lille', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.18510499166731, 4.739906950288028, '2280', 'Antwerpen', 'Grobbendonk', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.16186795577687, 4.7365146054743645, '2288', 'Antwerpen', 'Bouwel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.21766611526779, 4.772892306400321, '2290', 'Antwerpen', 'Vorselaar', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.3289645417869, 4.940164879461028, '2300', 'Antwerpen', 'Turnhout', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.35514942435804, 4.7674942745236395, '2310', 'Antwerpen', 'Rijkevorsel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.399348468595555, 4.742741597146226, '2320', 'Antwerpen', 'Hoogstraten', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.452321282795396, 4.727615310693475, '2321', 'Antwerpen', 'Meer', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.43142807168572, 4.774254142673586, '2322', 'Antwerpen', 'Castelre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.39956728747595, 4.80967875034335, '2323', 'Antwerpen', 'Wortel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.47294429226783, 4.800455130217273, '2328', 'Antwerpen', 'Meerle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.370433742714766, 4.870213713566063, '2330', 'Antwerpen', 'Merksplas', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.32032913642496, 4.834400497031085, '2340', 'Antwerpen', 'Beerse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.30529427138714, 4.885090740973934, '2350', 'Antwerpen', 'Vosselaar', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.32073392547652, 5.004371318046827, '2360', 'Antwerpen', 'Oud-Turnhout', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.33462182308609, 5.085447550635012, '2370', 'Antwerpen', 'Arendonk', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.37817221543302, 5.022773863066916, '2380', 'Antwerpen', 'Ravels', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.41131354672353, 5.0060100753927514, '2381', 'Antwerpen', 'Weelde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.44976104267063, 5.052107033848186, '2382', 'Antwerpen', 'Poppel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.41641400189452, 4.903894210159396, '2387', 'Antwerpen', 'Baarle-Hertog', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.28881699322618, 4.743920598152036, '2390', 'Antwerpen', 'Oostmalle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.241515872832345, 5.1221318711285955, '2400', 'Antwerpen', 'Dessel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.08791988851712, 5.0461260886208406, '2430', 'Antwerpen', 'Vorst', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.06274475941587, 4.979785860950487, '2431', 'Antwerpen', 'Veerle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.16646686399132, 4.984736550693137, '2440', 'Antwerpen', 'Geel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.124534764529855, 5.073574387688352, '2450', 'Antwerpen', 'Meerhout', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.22543459542968, 4.912232894257663, '2460', 'Antwerpen', 'Lichtaart', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.267067940052925, 5.07679040926115, '2470', 'Antwerpen', 'Retie', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.241515872832345, 5.1221318711285955, '2480', 'Antwerpen', 'Dessel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.166344406480725, 5.189507620442092, '2490', 'Antwerpen', 'Balen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.133153313377505, 5.1613779824434545, '2491', 'Antwerpen', 'Olmen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.13160180554329, 4.561792200549251, '2500', 'Antwerpen', 'Lier', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.1851724480689, 4.599904016207306, '2520', 'Antwerpen', 'Broechem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.160670898875395, 4.507452123689277, '2530', 'Antwerpen', 'Boechout', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.175995125929624, 4.536292285020099, '2531', 'Antwerpen', 'Vremde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.147212966513656, 4.482310085349264, '2540', 'Antwerpen', 'Hove', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.12769847424817, 4.497806447410268, '2547', 'Antwerpen', 'Lint', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.128476784411255, 4.44113168462789, '2550', 'Antwerpen', 'Kontich', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.14377998437943, 4.634965861012082, '2560', 'Antwerpen', 'Kessel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.095719546804055, 4.514141623555746, '2570', 'Antwerpen', 'Duffel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.04727200735847, 4.627238962828943, '2580', 'Antwerpen', 'Putte', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.10495876136289, 4.654716228104271, '2590', 'Antwerpen', 'Berlaar', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.19213330584189, 4.431973220636266, '2600', 'Antwerpen', 'Berchem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.16429714238415, 4.387893089723031, '2610', 'Antwerpen', 'Wilrijk', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.14373586065193, 4.340183148796095, '2620', 'Antwerpen', 'Hemiksem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.12267361693446, 4.342687429249923, '2627', 'Antwerpen', 'Schelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.13183400239181, 4.382521989987779, '2630', 'Antwerpen', 'Aartselaar', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.17463975833746, 4.461040132890298, '2640', 'Antwerpen', 'Mortsel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.1562541917077, 4.432829593906586, '2650', 'Antwerpen', 'Edegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.17680075275425, 4.349449465701912, '2660', 'Antwerpen', 'Hoboken', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.03007676437425, 4.468101716569333, '2800', 'Antwerpen', 'Mechelen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.048896156279405, 4.409688494262013, '2801', 'Antwerpen', 'Heffen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.02601332098993, 4.400356854897055, '2811', 'Antwerpen', 'Leest', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00884825004317, 4.52176968070652, '2812', 'Antwerpen', 'Muizen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.027021221986644, 4.54466040398519, '2820', 'Antwerpen', 'Bonheiden', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.063785840068654, 4.360048181748833, '2830', 'Antwerpen', 'Willebroek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.10462897076046, 4.407466354353447, '2840', 'Antwerpen', 'Reet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.10729376871485, 4.33556593193733, '2845', 'Antwerpen', 'Niel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.09355764030045, 4.372901183292752, '2850', 'Antwerpen', 'Boom', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.064188891317116, 4.514746404462987, '2860', 'Antwerpen', 'Sint-Katelijne-Waver', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.059134417535546, 4.575467319838737, '2861', 'Antwerpen', 'Onze-Lieve-Vrouw-Waver', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.072368741393966, 4.291591868087934, '2870', 'Antwerpen', 'Puurs', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.09084846028838, 4.228201007273273, '2880', 'Antwerpen', 'Bornem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.062738850754315, 4.240558354848952, '2890', 'Antwerpen', 'Oppuurs', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.26417701511706, 4.508194509964705, '2900', 'Antwerpen', 'Schoten', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.44950433077206, 4.465890207947531, '2910', 'Antwerpen', 'Essen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.398862311960194, 4.468685734962266, '2920', 'Antwerpen', 'Kalmthout', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.309508592907214, 4.5004250280853695, '2930', 'Antwerpen', 'Brasschaat', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.337978875586835, 4.36993960452919, '2940', 'Antwerpen', 'Stabroek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.33395441181101, 4.443787769978329, '2950', 'Antwerpen', 'Kapellen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.334976678828546, 4.607172140109691, '2960', 'Antwerpen', 'Brecht', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.25282552271659, 4.594469949585567, '2970', 'Antwerpen', 'Schilde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.26355606407579, 4.682858296150449, '2980', 'Antwerpen', 'Zoersel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.391851170056874, 4.565707127709544, '2990', 'Antwerpen', 'Wuustwezel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.8810526792466, 4.69569641887135, '3000', 'Vlaams-Brabant', 'Leuven', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.85734711667344, 4.691098755030863, '3000', 'Vlaams-Brabant', 'Heverlee', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.85734711667344, 4.691098755030863, '3001', 'Vlaams-Brabant', 'Heverlee', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88954206447257, 4.736791897843723, '3010', 'Vlaams-Brabant', 'Kessel-Lo', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.92127141131543, 4.707202587569181, '3012', 'Vlaams-Brabant', 'Wilsele', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.92127141131543, 4.707202587569181, '3018', 'Vlaams-Brabant', 'Wilsele', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.90898399648882, 4.642821496825906, '3020', 'Vlaams-Brabant', 'Winksele', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.81565278621968, 4.619809577671658, '3040', 'Vlaams-Brabant', 'Neerijse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.82968856103344, 4.661175687748797, '3050', 'Vlaams-Brabant', 'Oud-Heverlee', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.80458708010642, 4.650360859796001, '3051', 'Vlaams-Brabant', 'Sint-Joris-Weert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.82559015169222, 4.710276094943632, '3052', 'Vlaams-Brabant', 'Blanden', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.81690502548463, 4.705482591274831, '3053', 'Vlaams-Brabant', 'Haasrode', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.82209967822467, 4.688803551561262, '3054', 'Vlaams-Brabant', 'Vaalbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87014269326936, 4.625598414804474, '3060', 'Vlaams-Brabant', 'Bertem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84555719400637, 4.590807805833395, '3061', 'Vlaams-Brabant', 'Leefdaal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.884684436386145, 4.538103844626135, '3070', 'Vlaams-Brabant', 'Kortenberg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.905095205098974, 4.572830760492655, '3071', 'Vlaams-Brabant', 'Erps-Kwerps', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87197687503428, 4.5607874765310115, '3078', 'Vlaams-Brabant', 'Everberg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.821168109569065, 4.504921690627695, '3080', 'Vlaams-Brabant', 'Tervuren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.77131194884989, 4.532882605153322, '3090', 'Vlaams-Brabant', 'Overijse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.95663014095065, 4.729643203754868, '3110', 'Vlaams-Brabant', 'Rotselaar', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.948083381242256, 4.767193984031677, '3111', 'Vlaams-Brabant', 'Wezemaal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.974437446459724, 4.707853684749772, '3118', 'Vlaams-Brabant', 'Werchter', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99429271970909, 4.709198894538122, '3120', 'Vlaams-Brabant', 'Tremelo', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00532033491213, 4.748688160616197, '3128', 'Vlaams-Brabant', 'Baal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99502244496066, 4.785669137790253, '3130', 'Vlaams-Brabant', 'Betekom', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00520268020055, 4.654303955797991, '3140', 'Vlaams-Brabant', 'Keerbergen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.97836723301938, 4.633056953501904, '3150', 'Vlaams-Brabant', 'Haacht', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.97551341323077, 4.578350830548796, '3190', 'Vlaams-Brabant', 'Boortmeerbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.9849690381292, 4.542268865741871, '3191', 'Vlaams-Brabant', 'Hever', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.98527054969427, 4.8343102291469755, '3200', 'Vlaams-Brabant', 'Aarschot', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.01109800941638, 4.891356263524847, '3201', 'Vlaams-Brabant', 'Langdorp', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.974451211610976, 4.895613288808407, '3202', 'Vlaams-Brabant', 'Rillaar', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88357963294684, 4.835081689733584, '3210', 'Vlaams-Brabant', 'Lubbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87243034807027, 4.8924806024977405, '3211', 'Vlaams-Brabant', 'Binkom', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.8747668407872, 4.7900296902561985, '3212', 'Vlaams-Brabant', 'Pellenberg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.921265751787175, 4.796491715207058, '3220', 'Vlaams-Brabant', 'Kortrijk-Dutsel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.947958829092094, 4.831013953272166, '3221', 'Vlaams-Brabant', 'Nieuwrode', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.97091251522217, 4.977675317891447, '3270', 'Vlaams-Brabant', 'Scherpenheuvel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99895330058122, 4.981617466438012, '3271', 'Vlaams-Brabant', 'Zichem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.01625602737977, 4.946307973458278, '3272', 'Vlaams-Brabant', 'Testelt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.01216806865579, 5.098913716877939, '3290', 'Vlaams-Brabant', 'Schaffen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.97915616259631, 5.028035926090064, '3293', 'Vlaams-Brabant', 'Kaggevinne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00579392278925, 5.029500582529524, '3294', 'Vlaams-Brabant', 'Molenstede', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.80922727420936, 4.941172558459968, '3300', 'Vlaams-Brabant', 'Tienen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.78225179814631, 4.877610300119027, '3320', 'Vlaams-Brabant', 'Hoegaarden', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.75921240989309, 4.926426805935803, '3321', 'Vlaams-Brabant', 'Outgaarden', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.811992920375054, 5.02121613805768, '3350', 'Vlaams-Brabant', 'Wommersom', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.82540076878983, 4.757466104552368, '3360', 'Vlaams-Brabant', 'Bierbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.83055983736094, 4.826380661577238, '3370', 'Vlaams-Brabant', 'Vertrijk', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87384458226342, 4.952022082423206, '3380', 'Vlaams-Brabant', 'Glabbeek-Zuurbemde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.887760594878145, 4.958995562242453, '3381', 'Vlaams-Brabant', 'Kapellen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86937462434681, 4.921409000971563, '3384', 'Vlaams-Brabant', 'Attenrode', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.93598845337997, 4.914815932945844, '3390', 'Vlaams-Brabant', 'Tielt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.89595675363268, 4.9151565863386395, '3391', 'Vlaams-Brabant', 'Meensel-Kiezegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.76667903877654, 5.039508072145607, '3400', 'Vlaams-Brabant', 'Neerwinden', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.718032360518414, 5.087728599429149, '3401', 'Vlaams-Brabant', 'Walshoutem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.765882457050026, 5.099306592202783, '3404', 'Vlaams-Brabant', 'Attenhoven', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.843150737095876, 5.118295088901426, '3440', 'Vlaams-Brabant', 'Zoutleeuw', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.89500693999195, 5.10532003006251, '3450', 'Vlaams-Brabant', 'Geetbets', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.89146669339573, 5.157115263174214, '3454', 'Vlaams-Brabant', 'Rummen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.93685110466318, 4.972034148406212, '3460', 'Vlaams-Brabant', 'Bekkevoort', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.91333849949685, 4.942971194176077, '3461', 'Vlaams-Brabant', 'Molenbeek-Wersbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.90570825664911, 5.056948979369892, '3470', 'Vlaams-Brabant', 'Kortenaken', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86659404146787, 5.00507158453757, '3471', 'Vlaams-Brabant', 'Hoeleden', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.89424346153927, 5.0063731488353715, '3472', 'Vlaams-Brabant', 'Kersbeek-Miskom', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.913796056286756, 5.001710686638424, '3473', 'Vlaams-Brabant', 'Waanrode', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.93340823156662, 5.3539234872135655, '3500', 'Limburg', 'Hasselt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87972176549938, 5.353051553893263, '3501', 'Limburg', 'Wimmertingen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.95107161633338, 5.25139545968784, '3510', 'Limburg', 'Kermt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.95185535242305, 5.301449126036597, '3511', 'Limburg', 'Kuringen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.91740580040002, 5.247989672177129, '3512', 'Limburg', 'Stevoort', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99193999281114, 5.376662200197104, '3520', 'Limburg', 'Zonhoven', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.030095988663966, 5.4215253160211265, '3530', 'Limburg', 'Houthalen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.923981647173676, 5.18221676878469, '3540', 'Limburg', 'Herk-de-Stad', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.93999683513806, 5.096551633664311, '3545', 'Limburg', 'Halen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00902295258934, 5.294774004254104, '3550', 'Limburg', 'Zolder', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99602445645074, 5.199884737277817, '3560', 'Limburg', 'Lummen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.878408298677975, 5.290565432675959, '3570', 'Limburg', 'Alken', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.045748329744264, 5.223021187980118, '3580', 'Limburg', 'Beringen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.090098965515864, 5.248218029108467, '3581', 'Limburg', 'Beverlo', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.07062776310164, 5.28067689900486, '3582', 'Limburg', 'Koersel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.047686051880795, 5.173248093354319, '3583', 'Limburg', 'Paal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.91148333449561, 5.417426449396492, '3590', 'Limburg', 'Diepenbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.967174345910735, 5.4949237804863404, '3600', 'Limburg', 'Genk', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.89998677041696, 5.645659516356118, '3620', 'Limburg', 'Lanaken', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.928556465051244, 5.661986840544107, '3621', 'Limburg', 'Rekem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.97378286902597, 5.652242272891972, '3630', 'Limburg', 'Mechelen-aan-de-Maas', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.9280577168514, 5.720700717969127, '3631', 'Limburg', 'Uikhoven', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.17115647372937, 5.72880856924644, '3640', 'Limburg', 'Molenbeersel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.03297006986552, 5.70023659884594, '3650', 'Limburg', 'Dilsen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.04035063845221, 5.57135925539233, '3660', 'Limburg', 'Opglabbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00403806391602, 5.570947431025026, '3665', 'Limburg', 'As', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.01795509171514, 5.6127408860109504, '3668', 'Limburg', 'Niel-bij-As', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.084279929614404, 5.598544655982336, '3670', 'Limburg', 'Gruitrode', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.09916661611053, 5.703826568360952, '3680', 'Limburg', 'Neeroeteren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.93287623158777, 5.5754019777598245, '3690', 'Limburg', 'Zutendaal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.781684646613506, 5.466938591585194, '3700', 'Limburg', 'Tongeren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.72596086466414, 5.425422103675053, '3717', 'Limburg', 'Herstappe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86601338435881, 5.3782910830164745, '3720', 'Limburg', 'Kortessem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.867733483119835, 5.4309721883501325, '3721', 'Limburg', 'Vliermaalroot', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.855692119449934, 5.409332424911175, '3722', 'Limburg', 'Wintershoven', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84294090670337, 5.399067226481186, '3723', 'Limburg', 'Guigoven', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.83027442474485, 5.422309843662548, '3724', 'Limburg', 'Vliermaal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84869483874838, 5.4825239806318296, '3730', 'Limburg', 'Hoeselt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84206063229594, 5.448819241617612, '3732', 'Limburg', 'Schalkhoven', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87949887317435, 5.509721523877871, '3740', 'Limburg', 'Bilzen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.85271278619866, 5.532850517898544, '3742', 'Limburg', 'Martenslinde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86640062480266, 5.5493058423195345, '3746', 'Limburg', 'Waltwilder', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.80891991474512, 5.598513740289083, '3770', 'Limburg', 'Riemst', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.74114642464831, 5.833251300589162, '3790', 'Limburg', 'Sint-Martens-Voeren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.75435482321066, 5.712420603108801, '3790', 'Limburg', 'Moelingen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.72970119687923, 5.883215704808167, '3791', 'Limburg', 'Remersdaal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.72648833858975, 5.825715333771312, '3792', 'Limburg', 'Sint-Pieters-Voeren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.752388289041704, 5.872385566958153, '3793', 'Limburg', 'Teuven', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.76051302436153, 5.77243333760869, '3798', 'Limburg', '`s-Gravenvoeren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.798878110258016, 5.2274980798927775, '3800', 'Limburg', 'Brustem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.83301023422726, 5.147664225873109, '3803', 'Limburg', 'Duras', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.77914883264713, 5.135227965158734, '3806', 'Limburg', 'Velm', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84595525055639, 5.336452655385173, '3830', 'Limburg', 'Wellen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.827012457782146, 5.332926888163778, '3831', 'Limburg', 'Herten', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84458399365827, 5.290647724109565, '3832', 'Limburg', 'Ulbeek', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.80126374028137, 5.347299861560884, '3840', 'Limburg', 'Borgloon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87456504009532, 5.193628950060383, '3850', 'Limburg', 'Nieuwerkerken', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.7480248373796, 5.306318367766914, '3870', 'Limburg', 'Heers', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73831294896235, 5.175805996786182, '3890', 'Limburg', 'Borlo', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.750593993217784, 5.1763269783803185, '3891', 'Limburg', 'Buvingen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.20029934000348, 5.393398832214905, '3900', 'Limburg', 'Overpelt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.230977155710605, 5.444661036360133, '3910', 'Limburg', 'Neerpelt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.225583998505414, 5.302058606362873, '3920', 'Limburg', 'Lommel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.26942532941101, 5.481430155210708, '3930', 'Limburg', 'Achel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.11791085898852, 5.341586539050862, '3940', 'Limburg', 'Hechtel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.156731809260286, 5.350842696730286, '3941', 'Limburg', 'Eksel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.09460290737297, 5.133385546739354, '3945', 'Limburg', 'Kwaadmechelen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.19088890327587, 5.587395210052495, '3950', 'Limburg', 'Bocholt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.14058541231272, 5.636412026020706, '3960', 'Limburg', 'Bree', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.12093887157154, 5.265840257968899, '3970', 'Limburg', 'Leopoldsburg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.112588547157614, 5.229498754954051, '3971', 'Limburg', 'Heppen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.054783189174685, 5.069536263946347, '3980', 'Limburg', 'Tessenderlo', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.11022210934622, 5.454253657474964, '3990', 'Limburg', 'Peer', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.64100863770039, 5.576746544206011, '4000', 'Liège', 'Liège', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59185028437595, 5.577531125648646, '4000', 'Liège', 'Angleur', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.639959100598105, 5.638561209383813, '4020', 'Liège', 'Jupille-sur-Meuse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.62614473189009, 5.611819695855508, '4030', 'Liège', 'Grivegnée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59185028437595, 5.577531125648646, '4031', 'Liège', 'Angleur', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.614135660989234, 5.623582074795952, '4032', 'Liège', 'Chênée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67921179186858, 5.624363334016105, '4040', 'Liège', 'Herstal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69093418992845, 5.594986028388135, '4041', 'Liège', 'Milmort', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69186805608346, 5.571167772120222, '4042', 'Liège', 'Liers', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.58522465817122, 5.6444051822288746, '4050', 'Liège', 'Chaudfontaine', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60192572212116, 5.6339567661787555, '4051', 'Liège', 'Vaux-sous-Chèvremont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.561812680638766, 5.63741733618252, '4052', 'Liège', 'Beaufays', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59057394130485, 5.607087043742467, '4053', 'Liège', 'Embourg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67575138439455, 5.469467996585815, '4099', 'Liège', 'Awans', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.58496196593964, 5.508048762890354, '4100', 'Liège', 'Seraing', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61819164237959, 5.497986977613582, '4101', 'Liège', 'Jemeppe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59505274799415, 5.5464915208551835, '4102', 'Liège', 'Ougrée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.53217303794813, 5.482227353192982, '4120', 'Liège', 'Rotheux-Rimière', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.55426996412121, 5.469915430146981, '4121', 'Liège', 'Neuville-en-Condroz', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.54389010297114, 5.527872583036606, '4122', 'Liège', 'Plainevaux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.529235561214904, 5.560415477383841, '4130', 'Liège', 'Esneux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.507415279953975, 5.6370035682496304, '4140', 'Liège', 'Sprimont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.52741912628162, 5.717120147431578, '4141', 'Liège', 'Louveigné', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.479093496502465, 5.5228972877804905, '4160', 'Liège', 'Anthisnes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.50232901763118, 5.512449688843039, '4161', 'Liège', 'Villers-aux-Tours', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.48680247711935, 5.4980820472359975, '4162', 'Liège', 'Hody', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.496045601679796, 5.473824801913659, '4163', 'Liège', 'Tavier', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.4756584092423, 5.581742754294782, '4170', 'Liège', 'Comblain-au-Pont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.50253136444044, 5.573724208598252, '4171', 'Liège', 'Poulseur', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.427710260460834, 5.5357258086749646, '4180', 'Liège', 'Hamoir', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.42561167704621, 5.57670059087153, '4181', 'Liège', 'Filot', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.39547917259399, 5.633411249954286, '4190', 'Liège', 'Ferrières', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.58456128801683, 5.092973955562719, '4210', 'Liège', 'Lamontzée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.549412522627364, 5.090143739876208, '4217', 'Liège', 'Héron', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.52630827143261, 5.127824996316248, '4218', 'Liège', 'Couthuin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60713361162862, 5.026554675484, '4219', 'Liège', 'Meeffe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67482564884707, 5.16843188030489, '4250', 'Liège', 'Geer', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.654053967275566, 5.1982663884154805, '4252', 'Liège', 'Omal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.66735930571338, 5.194486533626656, '4253', 'Liège', 'Darion', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65619859696325, 5.175652517689511, '4254', 'Liège', 'Ligney', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.712009582693646, 5.210981477843381, '4257', 'Liège', 'Corswarem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61047819822582, 5.115731505060568, '4260', 'Liège', 'Ville-en-Hesbaye', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60532373506875, 5.175956196264243, '4260', 'Liège', 'Fallais', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.622509599335125, 5.167136948633016, '4261', 'Liège', 'Latinne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.640256177451256, 5.181623526805403, '4263', 'Liège', 'Tourinne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67444666979321, 5.083404367538335, '4280', 'Liège', 'Hannut', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.712177041056314, 5.033101948635712, '4287', 'Liège', 'Lincent', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69000743206165, 5.253818432923701, '4300', 'Liège', 'Waremme', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65927815315745, 5.2435332996051995, '4317', 'Liège', 'Celles', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.70502524243452, 5.441028833197113, '4340', 'Liège', 'Villers-l`Évêque', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.68356624247208, 5.455776383600718, '4342', 'Liège', 'Hognoul', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.66666070231287, 5.405647284829985, '4347', 'Liège', 'Fexhe-le-Haut-Clocher', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.686005865390605, 5.331842860471897, '4350', 'Liège', 'Lamine', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.6969029287981, 5.341979782980764, '4351', 'Liège', 'Hodeige', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65092325546578, 5.309581732627891, '4357', 'Liège', 'Donceel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.718706886537056, 5.3547688508954465, '4360', 'Liège', 'Lens-sur-Geer', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.716831389555615, 5.402696581101545, '4367', 'Liège', 'Crisnée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.593410925357574, 5.430129978484226, '4400', 'Liège', 'Chokier', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.629837917805894, 5.535060559845203, '4420', 'Liège', 'Saint-Nicolas', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65833644138832, 5.528168774947655, '4430', 'Liège', 'Ans', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.666242681486686, 5.4966005840809276, '4431', 'Liège', 'Loncin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.6804582190948, 5.5072436753673655, '4432', 'Liège', 'Alleur', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.708868602680006, 5.547836209240529, '4450', 'Liège', 'Villers-Saint-Siméon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.68931739251802, 5.548125535686045, '4451', 'Liège', 'Voroux-lez-Liers', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.72529589978149, 5.501118983612095, '4452', 'Liège', 'Wihogne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.708868602680006, 5.547836209240529, '4453', 'Liège', 'Villers-Saint-Siméon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.71433424897992, 5.5784149471353315, '4458', 'Liège', 'Fexhe-Slins', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.64214218719312, 5.42914187160935, '4460', 'Liège', 'Velroux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59670713269878, 5.360581366085947, '4470', 'Liège', 'Saint-Georges-sur-Meuse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.54940848302819, 5.390638932115777, '4480', 'Liège', 'Clermont-sous-Huy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.49945695953772, 5.181064535082792, '4500', 'Liège', 'Ben-Ahin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.54868891995823, 5.181242811816953, '4520', 'Liège', 'Moha', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.593163322500004, 5.222214523554705, '4530', 'Liège', 'Warnant-Dreye', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60516633896076, 5.3154057083189175, '4537', 'Liège', 'Verlaine', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.55255963122397, 5.311435799134499, '4540', 'Liège', 'Amay', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.521984968720844, 5.385171379484152, '4550', 'Liège', 'Yernée-Fraineux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.47689493645064, 5.383587116690836, '4557', 'Liège', 'Soheit-Tinlot', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.420737448736794, 5.369765408196325, '4560', 'Liège', 'Clavier', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.473945293960455, 5.233448550941895, '4570', 'Liège', 'Marchin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.477535782778155, 5.2879021079343005, '4577', 'Liège', 'Vierset-Barse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.44011299060317, 5.478514951977716, '4590', 'Liège', 'Ouffet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73709797041671, 5.701782207365342, '4600', 'Liège', 'Visé', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.70207095830987, 5.688323937396018, '4601', 'Liège', 'Argenteau', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.68354687061111, 5.67580876014664, '4602', 'Liège', 'Cheratte', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69538651900576, 5.750496866721882, '4606', 'Liège', 'Saint-André', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.728569832193, 5.741479660950062, '4607', 'Liège', 'Bombaye', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.714506071689094, 5.777538738447603, '4608', 'Liège', 'Neufchâteau', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.63300984234396, 5.671567293582618, '4610', 'Liège', 'Queue-du-Bois', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61824452614199, 5.683137791030607, '4620', 'Liège', 'Fléron', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.62899679344338, 5.698379831248319, '4621', 'Liège', 'Retinne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60129962416622, 5.686458271555588, '4623', 'Liège', 'Magnée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60428331237354, 5.665233901405933, '4624', 'Liège', 'Romsée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.646425643526335, 5.7032087296498615, '4630', 'Liège', 'Évegnée-Tignée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61859649966731, 5.745533226378796, '4630', 'Liège', 'Soumagne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.646425643526335, 5.7032087296498615, '4631', 'Liège', 'Évegnée-Tignée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65314739422452, 5.722308262380486, '4632', 'Liège', 'Cerexhe-Heuseux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.64349886118655, 5.745352632484007, '4633', 'Liège', 'Melen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60668764857255, 5.806874439823573, '4650', 'Liège', 'Grand-Rechain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69098820020856, 5.771891439181935, '4650', 'Liège', 'Julémont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.63955879367363, 5.794266605981542, '4650', 'Liège', 'Herve', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.63257057410082, 5.838799006571904, '4650', 'Liège', 'Chaineux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.63955879367363, 5.794266605981542, '4651', 'Liège', 'Herve', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61078931878826, 5.771850776307537, '4652', 'Liège', 'Xhendelesse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65978684223363, 5.758240678205082, '4653', 'Liège', 'Bolland', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67624576270806, 5.807628310761868, '4654', 'Liège', 'Charneux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.680270695887955, 5.747660575405222, '4670', 'Liège', 'Mortier', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65534079444836, 5.674857738316832, '4671', 'Liège', 'Saive', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69333591033592, 5.707331819981653, '4672', 'Liège', 'Saint-Remy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.71149221666199, 5.611734922005852, '4680', 'Liège', 'Hermée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.71604706559913, 5.675361165537338, '4681', 'Liège', 'Hermalle-sous-Argenteau', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.72881647641451, 5.631443900586804, '4682', 'Liège', 'Heure-le-Romain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69624198676869, 5.654562602832895, '4683', 'Liège', 'Vivegnis', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73584797043918, 5.659160032334298, '4684', 'Liège', 'Haccourt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.76497607239577, 5.604165228217777, '4690', 'Liège', 'Bassenge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.603595114378116, 6.137609316512761, '4700', 'Liège', '4700', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65021570484307, 6.0495715672490125, '4701', 'Liège', '4701', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67881290433241, 5.991143312332854, '4710', 'Liège', '4710', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.676511019577944, 6.036174840569045, '4711', 'Liège', '4711', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.72570477776681, 6.012157629321648, '4720', 'Liège', '4720', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.72570477776681, 6.012157629321648, '4721', 'Liège', '4721', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.709171658711334, 6.030889633776085, '4728', 'Liège', '4728', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.707875064250665, 6.06781126323219, '4730', 'Liège', '4730', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69859390393582, 6.0960472439258755, '4731', 'Liège', '4731', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.479812184949694, 6.223987444186985, '4750', 'Liège', '4750', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.34551850347334, 6.333485173401631, '4760', 'Liège', '4760', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.45179830084449, 6.305604104635684, '4761', 'Liège', '4761', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.35694653199721, 6.13522075073925, '4770', 'Liège', '4770', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.363509214258855, 6.223039487389554, '4771', 'Liège', '4771', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.33201406836701, 6.036229494728144, '4780', 'Liège', '4780', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.28086655228511, 6.255547264540821, '4782', 'Liège', '4782', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.26463755987939, 6.180688245608367, '4783', 'Liège', '4783', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.285770240148786, 6.0682953719167765, '4784', 'Liège', '4784', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.18191676082769, 6.116242106180693, '4790', 'Liège', '4790', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.22469121615678, 6.070274992461632, '4791', 'Liège', '4791', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.56914523874434, 5.879655823611434, '4800', 'Liège', 'Heusy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59152456135572, 5.865875472582388, '4800', 'Liège', 'Verviers', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59238313745336, 5.902807377719397, '4801', 'Liège', 'Stembert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.56914523874434, 5.879655823611434, '4802', 'Liège', 'Heusy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.613315193492284, 5.854411888490793, '4820', 'Liège', 'Dison', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61429464831296, 5.884105409196777, '4821', 'Liège', 'Andrimont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60246696405553, 5.934281847498286, '4830', 'Liège', 'Limbourg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.63050028614452, 5.922065846350702, '4831', 'Liège', 'Bilstain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59872335953817, 5.957013126892896, '4834', 'Liège', 'Goé', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.57275372512368, 6.059851595107361, '4837', 'Liège', 'Membach', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65913417375105, 5.965981946628496, '4840', 'Liège', 'Welkenraedt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.66552462291628, 5.926423757666302, '4841', 'Liège', 'Henri-Chapelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.50986541186604, 5.950080404670834, '4845', 'Liège', 'Sart', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.710827133860704, 5.950799963358972, '4850', 'Liège', 'Montzen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.74698777915346, 5.97976403510126, '4851', 'Liège', 'Gemmenich', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.71799547940604, 5.9198675355966826, '4852', 'Liège', 'Hombourg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.55726408880471, 5.798373353668578, '4860', 'Liège', 'Pepinster', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.591685643353806, 5.785595501682936, '4861', 'Liège', 'Soiron', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.58736496113965, 5.731972613312919, '4870', 'Liège', 'Olne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.58736496113965, 5.731972613312919, '4877', 'Liège', 'Olne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.700486490576935, 5.8513589270259025, '4880', 'Liège', 'Aubel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.67156235459628, 5.878938014018685, '4890', 'Liège', 'Clermont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.472024262928485, 5.86707384966682, '4900', 'Liège', 'Spa', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.479293293663225, 5.792942482132827, '4910', 'Liège', 'La Reid', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.46110254469126, 5.670030537118238, '4920', 'Liège', 'Aywaille', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.50290789629794, 6.1314033893304325, '4950', 'Liège', 'Robertville', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.453739832613685, 6.043258899461595, '4960', 'Liège', 'Bevercé', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.39359722903743, 5.950319171761081, '4970', 'Liège', 'Stavelot', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.35343298613215, 5.937157500592078, '4980', 'Liège', 'Wanne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.35983789190931, 5.804821970618819, '4983', 'Liège', 'Basse-Bodeux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.42261730261762, 5.787930660775993, '4987', 'Liège', 'Stoumont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.29409301034046, 5.794561305962568, '4990', 'Liège', 'Lierneux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.457759547420494, 4.854539162275639, '5000', 'Namur', 'Namur', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.46995741568755, 4.821762784969388, '5001', 'Namur', 'Belgrade', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.47869396859471, 4.838488417206432, '5002', 'Namur', 'Saint-Servais', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.49450203349887, 4.846938613127187, '5003', 'Namur', 'Saint-Marc', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.478874984040665, 4.893869705686034, '5004', 'Namur', 'Bouge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.457759547420494, 4.854539162275639, '5010', 'Namur', 'Namur', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.457759547420494, 4.854539162275639, '5012', 'Namur', 'Namur', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.49563850900468, 4.873254627779406, '5020', 'Namur', 'Vedrin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.46106075009524, 4.8034428349936995, '5020', 'Namur', 'Flawinne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.493364500178885, 4.930964293946384, '5021', 'Namur', 'Boninne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.51703286547315, 4.9080968903714925, '5022', 'Namur', 'Cognelée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.49074420495649, 4.962847303886857, '5024', 'Namur', 'Marche-les-Dames', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.56226114863281, 4.697014729356807, '5030', 'Namur', 'Gembloux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.58043804844668, 4.76821828718657, '5031', 'Namur', 'Grand-Leez', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.522287433980544, 4.7057966491197565, '5032', 'Namur', 'Bossière', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.44623070905599, 4.632974955181051, '5060', 'Namur', 'Auvelais', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.3948193471962, 4.691483360689996, '5070', 'Namur', 'Fosses-la-Ville', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.51802156697481, 4.823040677097621, '5080', 'Namur', 'Émines', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.53704044788278, 4.775332482316229, '5081', 'Namur', 'Saint-Denis', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.41121198572444, 4.899775924422468, '5100', 'Namur', 'Dave', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.456610659386854, 4.946185429338447, '5101', 'Namur', 'Loyers', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.544450199823686, 4.604155625840349, '5140', 'Namur', 'Sombreffe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.42119091720402, 4.77748662433658, '5150', 'Namur', 'Floreffe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.38843943711718, 4.8264040094071285, '5170', 'Namur', 'Bois-de-Villers', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.45878087705008, 4.689321690925804, '5190', 'Namur', 'Moustier', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.470976974644394, 5.045737027703342, '5300', 'Namur', 'Bonneville', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.589589303738954, 4.9097344895319806, '5310', 'Namur', 'Éghezée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.36606853931639, 5.020871557528589, '5330', 'Namur', 'Assesse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.37122276200273, 4.942849651844251, '5330', 'Namur', 'Maillen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.351207136545604, 4.961712178534264, '5332', 'Namur', 'Crupet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.38965322349175, 5.024831035542033, '5333', 'Namur', 'Sorinne-la-Longue', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.37302188907322, 5.072746307457648, '5334', 'Namur', 'Florée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.39510851684177, 4.996020765701244, '5336', 'Namur', 'Courrière', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.4076707290065, 5.0704560512873025, '5340', 'Namur', 'Gesves', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.441864713360246, 5.147327658298041, '5350', 'Namur', 'Haillot', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.441864713360246, 5.147327658298041, '5351', 'Namur', 'Haillot', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.460277864723565, 5.175428601096177, '5352', 'Namur', 'Perwez', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.452469672410466, 5.208424610080438, '5353', 'Namur', 'Goesnes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.43725613016662, 5.186497398257584, '5354', 'Namur', 'Jallet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.34906234313159, 5.160500843183148, '5360', 'Namur', 'Hamois', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.34264635676491, 5.061870667976435, '5360', 'Namur', 'Natoye', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.30908081792327, 5.2131611317320825, '5361', 'Namur', 'Scy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.330503113983866, 5.172824713050145, '5362', 'Namur', 'Achet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.335160801619345, 5.113867500779082, '5363', 'Namur', 'Emptinne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.36563070490373, 5.124727454236162, '5364', 'Namur', 'Schaltin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.35324114383989, 5.234149664913023, '5370', 'Namur', 'Jeneffe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.36005581017268, 5.341122640429873, '5372', 'Namur', 'Méan', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.35341140252153, 5.315597145107968, '5374', 'Namur', 'Maffe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.36785139207581, 5.243183871046597, '5376', 'Namur', 'Miécret', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.296262885971046, 5.303213461804268, '5377', 'Namur', 'Heure', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.546491169184726, 4.982835996473257, '5380', 'Namur', 'Noville-les-Bois', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.228545842808934, 4.90622118525634, '5500', 'Namur', 'Anseremme', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.28922251728592, 4.9526064024415, '5501', 'Namur', 'Lisogne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.28599157049045, 4.992689154104473, '5502', 'Namur', 'Thynes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.26088806498371, 4.997261792195762, '5503', 'Namur', 'Sorinnes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.23963348274697, 4.987813904353079, '5504', 'Namur', 'Foy-Notre-Dame', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.24596761096666, 4.850650076002723, '5520', 'Namur', 'Onhaye', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.237701808655856, 4.764893238436779, '5520', 'Namur', 'Anthée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.25727471143225, 4.776379391331089, '5521', 'Namur', 'Serville', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.284685553110265, 4.797119069820602, '5522', 'Namur', 'Falaën', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.279590825418595, 4.857621564582526, '5523', 'Namur', 'Sommière', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.24089758548294, 4.811848147548683, '5524', 'Namur', 'Gerin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.335959831796735, 4.980740469908019, '5530', 'Namur', 'Durnal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.3335869684532, 4.796803952608396, '5537', 'Namur', 'Bioul', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.2078836754068, 4.832756422482895, '5540', 'Namur', 'Hastière-par-delà', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.2078836754068, 4.832756422482895, '5541', 'Namur', 'Hastière-par-delà', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.19203680336448, 4.8407337935185675, '5542', 'Namur', 'Blaimont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.16549170513231, 4.844595751539798, '5543', 'Namur', 'Heer', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.16335709112081, 4.792448026629197, '5544', 'Namur', 'Agimont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.81215041837728, 4.9131328842918345, '5550', 'Namur', 'Sugny', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.91362049811571, 4.998335027623808, '5555', 'Namur', 'Monceau-en-Ardenne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.172628492844844, 4.968684555520797, '5560', 'Namur', 'Mesnil-Église', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.182431503215504, 5.08287693404777, '5560', 'Namur', 'Ciergnon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.22314318428099, 5.007105967209664, '5561', 'Namur', 'Celles', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.21051152192043, 5.05952373423188, '5562', 'Namur', 'Custinne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.16232806783965, 5.030921755689385, '5563', 'Namur', 'Hour', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.149633736117195, 5.067139267601601, '5564', 'Namur', 'Wanlin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.08384330829393, 5.040325265896285, '5570', 'Namur', 'Honnay', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.08277879784013, 4.915324310356166, '5570', 'Namur', 'Javingue', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.145229203958436, 4.97830552524816, '5571', 'Namur', 'Wiesme', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.12749275678512, 5.044689986719531, '5572', 'Namur', 'Focant', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.126433277720075, 5.007125330137938, '5573', 'Namur', 'Martouzin-Neuville', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.08885978622481, 5.0034189402375535, '5574', 'Namur', 'Pondrôme', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.9929545134084, 4.885444604221798, '5575', 'Namur', 'Rienne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.05045280411518, 5.001612601787774, '5576', 'Namur', 'Froidfontaine', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.15164063847288, 5.170062938055328, '5580', 'Namur', 'Éprave', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.15317032593864, 5.254754400757525, '5589', 'Namur', 'Jemelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.25624897081881, 5.122824767561598, '5590', 'Namur', 'Leignon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.16289384914997, 4.571891599680242, '5600', 'Namur', 'Sautour', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.22859428096972, 4.682579832709662, '5620', 'Namur', 'Rosée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.29540777309948, 4.565329626632812, '5621', 'Namur', 'Hanzinelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.19005868117103, 4.433892293802589, '5630', 'Namur', 'Soumoy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.3263285233684, 4.650508996795713, '5640', 'Namur', 'Mettet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.3095092940113, 4.70307395011975, '5641', 'Namur', 'Furnaux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.288945096747675, 4.723851662787109, '5644', 'Namur', 'Ermeton-sur-Biert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.278681857417574, 4.661128895795521, '5646', 'Namur', 'Stave', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.24835129550285, 4.43827062667041, '5650', 'Namur', 'Walcourt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.29549130048675, 4.455249275038879, '5651', 'Namur', 'Gourdinne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.02591044841348, 4.521200178801961, '5660', 'Namur', 'Couvin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.06128545825886, 4.607604903151012, '5670', 'Namur', 'Olloy-sur-Viroin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.139022948304294, 4.6710549870624485, '5680', 'Namur', 'Romerée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.41632296870234, 4.448541194700186, '6000', 'Henegouwen', 'Charleroi', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.38225363133343, 4.440022349479033, '6001', 'Henegouwen', 'Marcinelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.38738594793574, 4.471682428951614, '6010', 'Henegouwen', 'Couillet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.41727752258545, 4.426930454280802, '6020', 'Henegouwen', 'Dampremy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.40979153641901, 4.4003850453821665, '6030', 'Henegouwen', 'Marchienne-au-Pont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.41515789568444, 4.361351528564767, '6030', 'Henegouwen', 'Goutroux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.41682879063639, 4.376855591954091, '6031', 'Henegouwen', 'Monceau-sur-Sambre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.382584915377535, 4.409596474775443, '6032', 'Henegouwen', 'Mont-sur-Marchienne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.444720779004314, 4.43508407116947, '6040', 'Henegouwen', 'Jumet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.469348178772314, 4.443036647141276, '6041', 'Henegouwen', 'Gosselies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.43082543509163, 4.445088267227546, '6042', 'Henegouwen', 'Lodelinsart', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.455291567001304, 4.482185655871988, '6043', 'Henegouwen', 'Ransart', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.439827627940524, 4.390184365559585, '6044', 'Henegouwen', 'Roux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.42801704334071, 4.485373214118113, '6060', 'Henegouwen', 'Gilly', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.40703507741261, 4.474362856677057, '6061', 'Henegouwen', 'Montignies-sur-Sambre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.47084791169866, 4.5358954856785685, '6075', 'Henegouwen', 'Fleurus', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.47084791169866, 4.5358954856785685, '6099', 'Henegouwen', 'Fleurus', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.37221819422906, 4.377794034073585, '6110', 'Henegouwen', 'Montignies-le-Tilleul', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.387888119787554, 4.352541315701001, '6111', 'Henegouwen', 'Landelies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87298266192055, 4.375234148039785, '612', '', 'Brussel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.32368641321891, 4.392363013422629, '6120', 'Henegouwen', 'Ham-sur-Heure', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.41166595335169, 4.322326932134048, '6140', 'Henegouwen', 'Fontaine-l`Évêque', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.431992527152396, 4.3214370817388215, '6141', 'Henegouwen', 'Forchies-la-Marche', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.38772819346952, 4.321438240901546, '6142', 'Henegouwen', 'Leernes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.403614438638385, 4.265665841285156, '6150', 'Henegouwen', 'Anderlues', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.46129976005874, 4.371924010502227, '6180', 'Henegouwen', 'Courcelles', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.49356069435289, 4.321858639805036, '6181', 'Henegouwen', 'Gouy-lez-Piéton', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.44647867483665, 4.342232335477467, '6182', 'Henegouwen', 'Souvret', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.46341661415244, 4.323267120555157, '6183', 'Henegouwen', 'Trazegnies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.38361148737189, 4.510607244620078, '6200', 'Henegouwen', 'Bouffioulx', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.53834844566403, 4.445996016740626, '6210', 'Henegouwen', 'Frasnes-lez-Gosselies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.48811219247635, 4.470914471459328, '6210', 'Henegouwen', 'Wayaux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.503548344357434, 4.482079376421948, '6211', 'Henegouwen', 'Mellet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.47084791169866, 4.5358954856785685, '6220', 'Henegouwen', 'Fleurus', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.51075215545845, 4.529097147609301, '6221', 'Henegouwen', 'Saint-Amand', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.53016995305675, 4.563277340296821, '6222', 'Henegouwen', 'Brye', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.52221118069762, 4.529837788789084, '6223', 'Henegouwen', 'Wagnelée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.47621722958689, 4.578579799842651, '6224', 'Henegouwen', 'Wanfercée-Baulet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.51181207915504, 4.390802624362681, '6230', 'Henegouwen', 'Luttre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.51380992517715, 4.425481448298368, '6238', 'Henegouwen', 'Liberchies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.43504749697217, 4.548899555935839, '6240', 'Henegouwen', 'Farciennes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.416649525281294, 4.591784707468043, '6250', 'Henegouwen', 'Aiseau', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.36017223758737, 4.523242741162944, '6280', 'Henegouwen', 'Acoz', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.133096318864645, 4.3494113497929074, '6440', 'Henegouwen', 'Froid-Chapelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.20256339867955, 4.3528760813818215, '6441', 'Henegouwen', 'Erpion', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.07867277426734, 4.274520828596977, '6460', 'Henegouwen', 'Robechies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.077727641354144, 4.334215751069693, '6461', 'Henegouwen', 'Virelles', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.06370274451575, 4.364589916088016, '6462', 'Henegouwen', 'Vaulx', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.0728761381687, 4.382626355226494, '6463', 'Henegouwen', 'Lompret', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.00089209592164, 4.357438686155878, '6464', 'Henegouwen', 'Bourlers', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.16398541429335, 4.22739285471852, '6470', 'Henegouwen', 'Sautin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.213805173417235, 4.24543910724317, '6500', 'Henegouwen', 'Solre-Saint-Géry', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.2760472993157, 4.279981984073648, '6511', 'Henegouwen', 'Strée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.3444427429975, 4.296923768430381, '6530', 'Henegouwen', 'Thuin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.30332639911263, 4.247028109916089, '6530', 'Henegouwen', 'Leers-et-Fosteau', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.31812045059716, 4.311671935515356, '6531', 'Henegouwen', 'Biesme-sous-Thuin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.311942516865784, 4.269962571572194, '6532', 'Henegouwen', 'Ragnies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.323462089031366, 4.261483400913289, '6533', 'Henegouwen', 'Biercée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.34868908709587, 4.346616190652407, '6534', 'Henegouwen', 'Gozée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.29902859457919, 4.338563216834223, '6536', 'Henegouwen', 'Thuillies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.358020372384544, 4.266199327463462, '6540', 'Henegouwen', 'Lobbes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.33861404174617, 4.21653934089934, '6542', 'Henegouwen', 'Sars-la-Buissière', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.35496568123008, 4.214267005222947, '6543', 'Henegouwen', 'Bienne-lez-Happart', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.30024640277612, 4.145436326314291, '6560', 'Henegouwen', 'Solre-sur-Sambre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.321764997657006, 4.190430142008371, '6567', 'Henegouwen', 'Labuissière', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.02162973923655, 4.176287709519636, '6590', 'Henegouwen', 'Momignies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.036243994263806, 4.206042073482571, '6591', 'Henegouwen', 'Macon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.031929456819185, 4.224103116240292, '6592', 'Henegouwen', 'Monceau-Imbrechies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.977320436172576, 4.1988746354359785, '6593', 'Henegouwen', 'Macquenoise', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.005375479855154, 4.162295575481096, '6594', 'Henegouwen', 'Beauwelz', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.97898648422563, 4.269644953625766, '6596', 'Henegouwen', 'Forge-Philippe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.99402420506634, 5.778188594148576, '6600', 'Luxembourg', 'Wardin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.81114180866708, 5.724790024237842, '6630', 'Luxembourg', 'Martelange', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.90302132947767, 5.698147410667557, '6637', 'Luxembourg', 'Hollange', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.911239171143, 5.6089347598933355, '6640', 'Luxembourg', 'Nives', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.12884928984165, 5.785168385349334, '6660', 'Luxembourg', 'Houffalize', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.1553599185884, 5.681868604193096, '6660', 'Luxembourg', 'Nadrin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.159261224130894, 5.785887742892076, '6661', 'Luxembourg', 'Mont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.104656740274564, 5.844017287644833, '6662', 'Luxembourg', 'Tavigny', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.113443275423265, 5.729307367811699, '6663', 'Luxembourg', 'Mabompré', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.167698427407615, 5.7210462844278105, '6666', 'Luxembourg', 'Wibrin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.1554258444236, 5.924095190498312, '6670', 'Luxembourg', 'Limerlé', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.22726344766786, 5.92961403178149, '6671', 'Luxembourg', 'Bovigny', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.203028455680766, 5.995047199568529, '6672', 'Luxembourg', 'Beho', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.1711127756483, 5.8712071071348895, '6673', 'Luxembourg', 'Cherain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.20775804616796, 5.839021360913197, '6674', 'Luxembourg', 'Montleban', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.00000388003773, 5.557721163814337, '6680', 'Luxembourg', 'Tillet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.05028143591854, 5.480509278699119, '6681', 'Luxembourg', 'Lavacherie', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.06338776348134, 5.606593809442786, '6686', 'Luxembourg', 'Flamierge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.08988048136106, 5.678127382385678, '6687', 'Luxembourg', 'Bertogne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.0426383250265, 5.670351880014501, '6688', 'Luxembourg', 'Longchamps', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.24765540036063, 5.811034974448453, '6690', 'Luxembourg', 'Bihain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.28124402586553, 5.988170180603465, '6690', 'Luxembourg', 'Petit-Thier', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.28124402586553, 5.988170180603465, '6692', 'Luxembourg', 'Petit-Thier', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.32371252905669, 5.907434542453936, '6698', 'Luxembourg', 'Grand-Halleux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.68523319258533, 5.7415202000238965, '6700', 'Luxembourg', 'Heinsch', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.71240298450457, 5.8586753191074585, '6704', 'Luxembourg', 'Guirsch', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.65434011124272, 5.8619859842148045, '6706', 'Luxembourg', 'Autelbas', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.75420777419082, 5.776093147961596, '6717', 'Luxembourg', 'Attert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.74650799227212, 5.659611775346301, '6720', 'Luxembourg', 'Habay-la-Neuve', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.76799730607734, 5.620096176696785, '6721', 'Luxembourg', 'Anlier', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.71862344579244, 5.6154254778907715, '6723', 'Luxembourg', 'Habay-la-Vieille', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.72469658214863, 5.584882988483655, '6724', 'Luxembourg', 'Houdemont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.686161342951024, 5.512110597659552, '6730', 'Luxembourg', 'Tintigny', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.66464260205263, 5.615989158827708, '6740', 'Luxembourg', 'Étalle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.66704544782038, 5.669204381387059, '6741', 'Luxembourg', 'Vance', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.64881693322211, 5.660868788927638, '6742', 'Luxembourg', 'Chantemelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.64012347764595, 5.598438096005902, '6743', 'Luxembourg', 'Buzenol', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.61238072490389, 5.653187325004047, '6747', 'Luxembourg', 'Saint-Léger', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.56614956268711, 5.700188781552907, '6750', 'Luxembourg', 'Musson', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.6024106010902, 5.586439661915086, '6760', 'Luxembourg', 'Èthe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.55987469152944, 5.566885790661556, '6761', 'Luxembourg', 'Latour', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.54165370769686, 5.530606033964006, '6762', 'Luxembourg', 'Saint-Mard', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.53508203015487, 5.499749051664374, '6767', 'Luxembourg', 'Harnoncourt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.61163093704924, 5.480048194278173, '6769', 'Luxembourg', 'Meix-devant-Virton', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.631621783058776, 5.839067589370517, '6780', 'Luxembourg', 'Hondelange', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.61176867222083, 5.855063999433785, '6781', 'Luxembourg', 'Sélange', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.61018109325086, 5.764544551734923, '6782', 'Luxembourg', 'Habergy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.56583399531406, 5.804527562249287, '6790', 'Luxembourg', 'Aubange', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.57086993737889, 5.844003703149036, '6791', 'Luxembourg', 'Athus', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.57175881836431, 5.75801069233419, '6792', 'Luxembourg', 'Halanzy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.966023829437134, 5.380064364430568, '6800', 'Luxembourg', 'Bras', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.68602194700267, 5.370379239265897, '6810', 'Luxembourg', 'Izel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.74608658491904, 5.415493330986141, '6811', 'Luxembourg', 'Suxy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.74608658491904, 5.415493330986141, '6812', 'Luxembourg', 'Suxy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.707492590823946, 5.458886356855338, '6813', 'Luxembourg', 'Termes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.730217343328725, 5.184128185589924, '6820', 'Luxembourg', 'Muno', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.688935334473356, 5.320695987212549, '6820', 'Luxembourg', 'Florenville', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.742933997928546, 5.298180861291905, '6821', 'Luxembourg', 'Lacuisine', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.63982835133382, 5.363443534552545, '6823', 'Luxembourg', 'Villers-devant-Orval', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.71025630475131, 5.2693492261193065, '6824', 'Luxembourg', 'Chassepierre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.7690492821049, 5.118811913985813, '6830', 'Luxembourg', 'Bouillon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.83770446341737, 5.0020138514899415, '6830', 'Luxembourg', 'Rochehaut', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.81335395137129, 5.107898361138987, '6831', 'Luxembourg', 'Noirefontaine', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.81947922854715, 5.072301176633269, '6832', 'Luxembourg', 'Sensenruth', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.83100514037023, 5.044393996035766, '6833', 'Luxembourg', 'Ucimont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.839895206995465, 5.119076371486765, '6834', 'Luxembourg', 'Bellevaux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.792793746138756, 5.1354266792414425, '6836', 'Luxembourg', 'Dohan', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.79527943567343, 5.017588453111326, '6838', 'Luxembourg', 'Corbion', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.8424024694399, 5.431672182519433, '6840', 'Luxembourg', 'Neufchâteau', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.89790501802281, 5.128141991092279, '6850', 'Luxembourg', 'Paliseul', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.865694466396626, 5.113734146114013, '6851', 'Luxembourg', 'Nollevaux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.94920516539996, 5.124980525130461, '6852', 'Luxembourg', 'Opont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.92614724730353, 5.161248013672438, '6853', 'Luxembourg', 'Framont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.854262365690154, 5.1582456030194805, '6856', 'Luxembourg', 'Fays-les-Veneurs', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.80698722514835, 5.6099619087915436, '6860', 'Luxembourg', 'Léglise', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.03690455420123, 5.313902123517168, '6870', 'Luxembourg', 'Arville', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.84977519876712, 5.240492986044481, '6880', 'Luxembourg', 'Bertrix', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.80995012801415, 5.315139327987978, '6887', 'Luxembourg', 'Saint-Médard', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (49.975033875368666, 5.235608802219327, '6890', 'Luxembourg', 'Villance', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.21249107184126, 5.3662325505714055, '6900', 'Luxembourg', 'Waha', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.065483546895, 5.111386048020265, '6920', 'Luxembourg', 'Wellin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.05849398713359, 5.056586197743311, '6920', 'Luxembourg', 'Sohier', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.06655938330617, 5.15517535823723, '6921', 'Luxembourg', 'Chanly', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.05960656940028, 5.131211208965811, '6922', 'Luxembourg', 'Halma', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.05230404659848, 5.085140043949813, '6924', 'Luxembourg', 'Lomprez', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.06697106261305, 5.219646829870623, '6927', 'Luxembourg', 'Tellin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.003839490814315, 5.06712904861771, '6929', 'Luxembourg', 'Gembes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.324817507035, 5.418311627470638, '6940', 'Luxembourg', 'Grandhan', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.37761023713464, 5.525863186340421, '6941', 'Luxembourg', 'Bomal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.1175874690849, 5.367278074686654, '6950', 'Luxembourg', 'Nassogne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.145729472352265, 5.430710856296992, '6951', 'Luxembourg', 'Bande', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.14607474972478, 5.3926796747107195, '6952', 'Luxembourg', 'Grune', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.130211961412996, 5.2831318208857105, '6953', 'Luxembourg', 'Forrières', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.30006951081897, 5.6511780487737715, '6960', 'Luxembourg', 'Grandmenil', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.08393238628601, 5.4602215163455154, '6970', 'Luxembourg', 'Tenneville', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.11753944587284, 5.483673473140941, '6971', 'Luxembourg', 'Champlon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.11217509808931, 5.554126217508594, '6972', 'Luxembourg', 'Erneuville', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.15622908507213, 5.522423987166039, '6980', 'Luxembourg', 'Beausaint', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.20224682438749, 5.670560135809374, '6982', 'Luxembourg', 'Samrée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.130140819937175, 5.628599161615838, '6983', 'Luxembourg', 'Ortho', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.14984404058582, 5.574347416754611, '6984', 'Luxembourg', 'Hives', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.173774460280164, 5.508984278009601, '6986', 'Luxembourg', 'Halleux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.225561542216425, 5.482531103545013, '6987', 'Luxembourg', 'Rendeux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.268167181605, 5.451885055651398, '6990', 'Luxembourg', 'Hotton', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.291261976609114, 5.580717761285836, '6997', 'Luxembourg', 'Érezée', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.456203480863934, 3.9685021666591336, '7000', 'Henegouwen', 'Mons', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.4951508161205, 3.972124117938859, '7010', 'Henegouwen', 'Maisières', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.481082162881385, 3.901016350641789, '7011', 'Henegouwen', 'Ghlin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.45206420035348, 3.8964343000960744, '7012', 'Henegouwen', 'Jemappes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.4951508161205, 3.972124117938859, '7020', 'Henegouwen', 'Maisières', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.45918696003368, 4.044682821851172, '7021', 'Henegouwen', 'Havré', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.40949604031477, 4.020935214580339, '7022', 'Henegouwen', 'Harmignies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.412633442688026, 3.9451466052179596, '7024', 'Henegouwen', 'Ciply', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.43872268944256, 4.013831231106731, '7030', 'Henegouwen', 'Saint-Symphorien', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.42864283297361, 4.046531623169427, '7031', 'Henegouwen', 'Villers-Saint-Ghislain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.42411866903341, 3.9905448121212914, '7032', 'Henegouwen', 'Spiennes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.43375629555613, 3.9235572335343907, '7033', 'Henegouwen', 'Cuesmes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.48200388760719, 4.00345440389874, '7034', 'Henegouwen', 'Obourg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.36752867405708, 3.9261335279719556, '7040', 'Henegouwen', 'Quévy-le-Petit', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.37493720462305, 4.024781199341022, '7041', 'Henegouwen', 'Givry', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.52814330556847, 3.918679117161573, '7050', 'Henegouwen', 'Jurbise', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61194257686289, 4.030440932890032, '7060', 'Henegouwen', 'Horrues', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.519242244798235, 4.04800871255348, '7061', 'Henegouwen', 'Thieusies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.548012339069835, 4.100931494300653, '7062', 'Henegouwen', 'Naast', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.55742575023612, 4.006437199983385, '7063', 'Henegouwen', 'Neufvilles', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.51427419126255, 4.120027302711064, '7070', 'Henegouwen', 'Le Roeulx', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.38578213408955, 3.8705385638083722, '7080', 'Henegouwen', 'Eugies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60371814071546, 4.131890628017427, '7090', 'Henegouwen', 'Braine-le-Comte', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.48132422290698, 4.19011154300274, '7100', 'Henegouwen', 'La Louvière', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.474815160866434, 4.12138559583128, '7110', 'Henegouwen', 'Strépy-Bracquegnies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.39629094528612, 4.095748578678034, '7120', 'Henegouwen', 'Estinnes-au-Mont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.41072051574393, 4.175446206829685, '7130', 'Henegouwen', 'Binche', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.43277241381592, 4.091806919824024, '7130', 'Henegouwen', 'Bray', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.404053619435395, 4.150309924021009, '7131', 'Henegouwen', 'Waudrez', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.37988564802503, 4.202423169562303, '7133', 'Henegouwen', 'Buvrinnes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.42207407680261, 4.193661361460719, '7134', 'Henegouwen', 'Ressaix', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.45668408944778, 4.236149898184558, '7140', 'Henegouwen', 'Morlanwelz-Mariemont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.442037889702995, 4.256948981157719, '7141', 'Henegouwen', 'Carnières', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.471307819925876, 4.282857249459756, '7160', 'Henegouwen', 'Chapelle-lez-Herlaimont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.50169979774876, 4.2454380952875646, '7170', 'Henegouwen', 'Manage', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.526342127372516, 4.267552901341413, '7180', 'Henegouwen', 'Seneffe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.56357491577711, 4.239812278948863, '7181', 'Henegouwen', 'Feluy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.56896913004575, 4.1634062777021885, '7190', 'Henegouwen', 'Écaussinnes-d`Enghien', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.56896913004575, 4.1634062777021885, '7191', 'Henegouwen', 'Écaussinnes-d`Enghien', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.428770523273045, 3.788860299004143, '7300', 'Henegouwen', 'Boussu', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.42392561275431, 3.8208323149960965, '7301', 'Henegouwen', 'Hornu', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.480332045342706, 3.647114170315043, '7320', 'Henegouwen', 'Bernissart', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.50207166780633, 3.656865761710339, '7321', 'Henegouwen', 'Blaton', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.4765234583893, 3.733485175395442, '7322', 'Henegouwen', 'Ville-Pommeroeul', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.4500706332298, 3.8172904337168116, '7330', 'Henegouwen', 'Saint-Ghislain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.48388325647103, 3.841110674109011, '7331', 'Henegouwen', 'Baudour', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.50994439203581, 3.779560383207146, '7332', 'Henegouwen', 'Sirault', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.46581770145303, 3.800762342554161, '7333', 'Henegouwen', 'Tertre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.47317124088612, 3.7620000645379954, '7334', 'Henegouwen', 'Hautrage', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.41357901065898, 3.837522601240584, '7340', 'Henegouwen', 'Wasmes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.43469662965351, 3.7083653814536435, '7350', 'Henegouwen', 'Montrœul-sur-Haine', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.39099245390335, 3.8001487818072714, '7370', 'Henegouwen', 'Dour', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.388765845550154, 3.692568855595319, '7380', 'Henegouwen', 'Baisieux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.38275401924759, 3.723392783820701, '7382', 'Henegouwen', 'Audregnies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.349281749956276, 3.7333268452111716, '7387', 'Henegouwen', 'Autreppe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.43631602049697, 3.86194835965052, '7390', 'Henegouwen', 'Quaregnon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.604136689758725, 3.389009268205489, '7500', 'Henegouwen', 'Tournai', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.602611637589625, 3.347229563836705, '7501', 'Henegouwen', 'Orcq', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.57622769425181, 3.2956711060824793, '7502', 'Henegouwen', 'Esplechin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.62489136694395, 3.346537083665326, '7503', 'Henegouwen', 'Froyennes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.58098203970654, 3.3303814103708587, '7504', 'Henegouwen', 'Froidmont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.57378705169133, 3.3513415277031946, '7506', 'Henegouwen', 'Willemeau', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.602611637589625, 3.347229563836705, '7510', 'Henegouwen', 'Orcq', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.602611637589625, 3.347229563836705, '7511', 'Henegouwen', 'Orcq', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.637541773166404, 3.3845370472413023, '7512', 'Henegouwen', 'Kain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.637541773166404, 3.3845370472413023, '7513', 'Henegouwen', 'Kain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.647346386472826, 3.2825253115172197, '7520', 'Henegouwen', 'Templeuve', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.5862481736304, 3.412335241590891, '7521', 'Henegouwen', 'Chercq', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61171026009968, 3.2915790330161814, '7522', 'Henegouwen', 'Hertain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59532756736342, 3.483051868633904, '7530', 'Henegouwen', 'Gaurain-Ramecroix', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.62156794125197, 3.4739562588474113, '7531', 'Henegouwen', 'Havinnes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.62386386404468, 3.5217009090513463, '7532', 'Henegouwen', 'Beclers', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.641652308740106, 3.5232791324371178, '7533', 'Henegouwen', 'Thimougies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61105853195004, 3.5520671325420774, '7534', 'Henegouwen', 'Maulde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59123450717168, 3.4415599804543526, '7536', 'Henegouwen', 'Vaulx', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.572528257787404, 3.508473443089577, '7538', 'Henegouwen', 'Vezon', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65395242995072, 3.438963243139209, '7540', 'Henegouwen', 'Mourcourt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.66555402764512, 3.410802212427557, '7542', 'Henegouwen', 'Mont-Saint-Aubert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.65395242995072, 3.438963243139209, '7543', 'Henegouwen', 'Mourcourt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61090861965755, 3.4324931541870596, '7548', 'Henegouwen', 'Warchin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.512024646835705, 3.59255320640889, '7600', 'Henegouwen', 'Péruwelz', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.52937405342307, 3.586478486826305, '7601', 'Henegouwen', 'Roucourt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.544858985703385, 3.597161038111336, '7602', 'Henegouwen', 'Bury', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.49830025259294, 3.613561374498213, '7603', 'Henegouwen', 'Bon-Secours', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.55086938268508, 3.536924130255559, '7604', 'Henegouwen', 'Wasmes-Audemez-Briffoeil', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.50753481051892, 3.5318351790340086, '7608', 'Henegouwen', 'Wiers', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.55274565455217, 3.3063522199192126, '7610', 'Henegouwen', 'Rumes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.52946413753035, 3.306893241964832, '7611', 'Henegouwen', 'La Glanerie', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.545235304503116, 3.3403978981578932, '7618', 'Henegouwen', 'Taintignies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.5449124056137, 3.3992738246942347, '7620', 'Henegouwen', 'Jollain-Merlin', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.52075635830985, 3.3875169749252834, '7621', 'Henegouwen', 'Lesdain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.52282341554432, 3.4445838928066204, '7622', 'Henegouwen', 'Laplaigne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.50608146948224, 3.38554306737723, '7623', 'Henegouwen', 'Rongy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.5162241204786, 3.349949848814559, '7624', 'Henegouwen', 'Howardries', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.54545345708928, 3.4944897055267035, '7640', 'Henegouwen', 'Maubray', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.55998570298441, 3.4260710273518886, '7641', 'Henegouwen', 'Bruyelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.575331826236805, 3.431836204544051, '7642', 'Henegouwen', 'Calonne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.56623815456898, 3.476615438431995, '7643', 'Henegouwen', 'Fontenoy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.745880794857555, 3.215028338180876, '7700', 'Henegouwen', 'Mouscron', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73438991075176, 3.2937990942292363, '7711', 'Henegouwen', 'Dottignies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.721852963883954, 3.240635140304602, '7712', 'Henegouwen', 'Herseaux', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.68201651214613, 3.3018410867010766, '7730', 'Henegouwen', 'Estaimbourg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.68821665184891, 3.328838749789718, '7740', 'Henegouwen', 'Pecq', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69337538023613, 3.3689264479109804, '7742', 'Henegouwen', 'Hérinnes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.66206016331977, 3.3713929733569294, '7743', 'Henegouwen', 'Obigies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.724482583521386, 3.5044545736781334, '7750', 'Henegouwen', 'Anseroeul', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.7071975803299, 3.456200534307307, '7760', 'Henegouwen', 'Celles', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.784876378600636, 2.99734556351623, '7780', 'Henegouwen', 'Comines', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.78946756486205, 2.966798613727431, '7781', 'Henegouwen', 'Houthem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.72755766166643, 2.8780756030848824, '7782', 'Henegouwen', 'Ploegsteert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.72755766166643, 2.8780756030848824, '7783', 'Henegouwen', 'Ploegsteert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73920926750211, 2.9191502380038523, '7784', 'Henegouwen', 'Warneton', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.63179570360427, 3.78049228040414, '7800', 'Henegouwen', 'Ath', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.621365169904074, 3.753921100362554, '7801', 'Henegouwen', 'Irchonwelz', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.58665419458767, 3.7293017141190106, '7802', 'Henegouwen', 'Ormeignies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.63179570360427, 3.78049228040414, '7803', 'Henegouwen', 'Ath', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.653011856041736, 3.755902905774185, '7803', 'Henegouwen', 'Bouvignies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.677701418566485, 3.7553209046098677, '7804', 'Henegouwen', 'Ostiches', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61786635385123, 3.8047203981833277, '7810', 'Henegouwen', 'Maffle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61902074525225, 3.821598681364686, '7811', 'Henegouwen', 'Arbre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.628632330168784, 3.725435693581204, '7812', 'Henegouwen', 'Villers-Saint-Amand', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.6471815598948, 3.8439814768590543, '7822', 'Henegouwen', 'Meslin-l`Évêque', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.635129295259155, 3.88836464420893, '7823', 'Henegouwen', 'Gibecq', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.6479669266252, 3.9393945696011543, '7830', 'Henegouwen', 'Silly', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.659001835660554, 4.036272078129364, '7850', 'Henegouwen', 'Hoves', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.70782135153303, 3.8276559593212687, '7860', 'Henegouwen', 'Lessines', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.69629991312962, 3.7873374933022106, '7861', 'Henegouwen', 'Wannebecq', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.7210042912353, 3.7749973625661926, '7862', 'Henegouwen', 'Ogy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73567380125361, 3.8052955450143426, '7863', 'Henegouwen', 'Ghoy', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73219062587638, 3.86465888313695, '7864', 'Henegouwen', 'Deux-Acren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.68396490547971, 3.8632562963582977, '7866', 'Henegouwen', 'Ollignies', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.56446331467332, 3.9475828957169266, '7870', 'Henegouwen', 'Montignies-lez-Lens', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.75357491255145, 3.731663175948145, '7880', 'Henegouwen', 'Flobecq', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.71588222284948, 3.727212389829618, '7890', 'Henegouwen', 'Wodecq', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59212889282027, 3.6154793651811903, '7900', 'Henegouwen', 'Leuze', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.62058136421661, 3.594621384457763, '7901', 'Henegouwen', 'Thieulain', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59531937409011, 3.6568557842774476, '7903', 'Henegouwen', 'Chapelle-à-Oie', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59212889282027, 3.6154793651811903, '7904', 'Henegouwen', 'Leuze', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.6037200753987, 3.5741670821583895, '7906', 'Henegouwen', 'Gallaix', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.68754560428395, 3.530466499652594, '7910', 'Henegouwen', 'Cordes', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.685314316780754, 3.628571814619295, '7911', 'Henegouwen', 'Frasnes-lez-Buissenal', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.71244851530913, 3.6069982531020446, '7912', 'Henegouwen', 'Saint-Sauveur', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59845750301012, 3.8617229296549187, '7940', 'Henegouwen', 'Brugelette', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.60955347523937, 3.8336833054901907, '7941', 'Henegouwen', 'Attre', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.61648174771696, 3.8531560201932367, '7942', 'Henegouwen', 'Mévergnies-lez-Lens', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.6083969205011, 3.89326844668147, '7943', 'Henegouwen', 'Gages', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.57418829736578, 3.8079366251543827, '7950', 'Henegouwen', 'Chièvres', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.59062474667933, 3.7684146960625102, '7951', 'Henegouwen', 'Tongre-Notre-Dame', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.53491288978105, 3.7328113686013142, '7970', 'Henegouwen', 'Belœil', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.54061455452053, 3.6564991592089098, '7971', 'Henegouwen', 'Wadelincourt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.55370748488333, 3.694148224086389, '7972', 'Henegouwen', 'Ellignies-Sainte-Anne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.506654719989385, 3.7278930133097457, '7973', 'Henegouwen', 'Stambruges', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.232646001171425, 3.2071828570336303, '8000', 'West-Vlaanderen', 'Brugge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.115614510612126, 3.20946687009095, '8020', 'West-Vlaanderen', 'Waardamme', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.19372229465939, 3.1708734667446055, '8200', 'West-Vlaanderen', 'Sint-Andries', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.13670159091553, 3.1364537581236362, '8210', 'West-Vlaanderen', 'Zedelgem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.117200223533914, 3.093794529125806, '8211', 'West-Vlaanderen', 'Aartrijke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.346651571344495, 3.331958012765075, '8300', 'West-Vlaanderen', 'Knokke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.31166474283851, 3.2588654806261412, '8301', 'West-Vlaanderen', 'Ramskapelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.21677335757064, 3.2724169340982785, '8310', 'West-Vlaanderen', 'Sint-Kruis', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.242984753181155, 3.3526971798341947, '8340', 'West-Vlaanderen', 'Moerkerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.29837935392511, 3.14160121764503, '8370', 'West-Vlaanderen', 'Uitkerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.24088195427637, 3.109097150981669, '8377', 'West-Vlaanderen', 'Houtave', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.319188488680844, 3.1984127435592233, '8380', 'West-Vlaanderen', 'Lissewege', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.204054302137884, 2.920364240174513, '8400', 'West-Vlaanderen', 'Stene', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.29866846302454, 3.0922383231618036, '8420', 'West-Vlaanderen', 'Wenduine', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.246343172418754, 3.0238645867311704, '8420', 'West-Vlaanderen', 'Klemskerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.26258540478536, 3.062663199459585, '8421', 'West-Vlaanderen', 'Vlissegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.17815500112932, 2.8368380598056255, '8430', 'West-Vlaanderen', 'Wilskerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.17815500112932, 2.8368380598056255, '8431', 'West-Vlaanderen', 'Wilskerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.16749162383475, 2.8811201736596774, '8432', 'West-Vlaanderen', 'Leffinge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.14935973377296, 2.8358811713798677, '8433', 'West-Vlaanderen', 'Slijpe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.15486680637328, 2.7761610348929397, '8434', 'West-Vlaanderen', 'Westende', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.23671218246712, 2.9773784952722453, '8450', 'West-Vlaanderen', 'Bredene', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.19721509326913, 2.998147048625271, '8460', 'West-Vlaanderen', 'Oudenburg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.1562401145374, 2.9597453837462373, '8470', 'West-Vlaanderen', 'Gistel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.130084962134525, 3.0248478443119233, '8480', 'West-Vlaanderen', 'Eernegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.18656071645014, 3.087844865344226, '8490', 'West-Vlaanderen', 'Jabbeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.81548648715903, 3.276541129725285, '8500', 'West-Vlaanderen', 'Kortrijk', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.85249379414545, 3.2340102684744165, '8501', 'West-Vlaanderen', 'Heule', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.773491427377515, 3.2969354667112425, '8510', 'West-Vlaanderen', 'Bellegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.77635920318213, 3.2240271003500363, '8511', 'West-Vlaanderen', 'Aalbeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86016289078808, 3.27159421386401, '8520', 'West-Vlaanderen', 'Kuurne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84348326097594, 3.317611496271605, '8530', 'West-Vlaanderen', 'Harelbeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.89094037278907, 3.2901107325128245, '8531', 'West-Vlaanderen', 'Hulste', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.842562692188935, 3.366165828303196, '8540', 'West-Vlaanderen', 'Deerlijk', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.80547297509661, 3.339351438011737, '8550', 'West-Vlaanderen', 'Zwevegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.793846078186775, 3.3992783979228665, '8551', 'West-Vlaanderen', 'Heestert', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.77320484048642, 3.3859126303006803, '8552', 'West-Vlaanderen', 'Moen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.80839107751576, 3.4215637822902787, '8553', 'West-Vlaanderen', 'Otegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.76269677519784, 3.3518778713429906, '8554', 'West-Vlaanderen', 'Sint-Denijs', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.83983510732439, 3.1507135657129837, '8560', 'West-Vlaanderen', 'Moorsele', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84340914962332, 3.464043077530356, '8570', 'West-Vlaanderen', 'Anzegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.814377568247124, 3.494571566290156, '8572', 'West-Vlaanderen', 'Kaster', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.812531400589315, 3.4653295400956363, '8573', 'West-Vlaanderen', 'Tiegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.77754918828237, 3.4483560009053003, '8580', 'West-Vlaanderen', 'Avelgem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.79966114606921, 3.503222554493061, '8581', 'West-Vlaanderen', 'Kerkhove', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.75878665269722, 3.426397560847429, '8582', 'West-Vlaanderen', 'Outrijve', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.74897050321547, 3.405276865798134, '8583', 'West-Vlaanderen', 'Bossuit', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.736639741135924, 3.3809640679863673, '8587', 'West-Vlaanderen', 'Helkijn', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.0547539517997, 2.8727490452451248, '8600', 'West-Vlaanderen', 'Beerst', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.0244017181459, 2.9995172539979014, '8610', 'West-Vlaanderen', 'Handzame', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.108205475195454, 2.7795516374437015, '8620', 'West-Vlaanderen', 'Ramskapelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.044271735015755, 2.6418910560283257, '8630', 'West-Vlaanderen', 'Bulskamp', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.92894644794197, 2.745174468977816, '8640', 'West-Vlaanderen', 'Oostvleteren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.97051264978583, 2.736133320548195, '8647', 'West-Vlaanderen', 'Pollinkhove', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.98454557706053, 2.9030974565617265, '8650', 'West-Vlaanderen', 'Klerken', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.0704142079429, 2.5945876048058936, '8660', 'West-Vlaanderen', 'Adinkerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.121346604412906, 2.700626980557324, '8670', 'West-Vlaanderen', 'Oostduinkerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.09021185685532, 2.9722168338691484, '8680', 'West-Vlaanderen', 'Koekelare', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.01476098287005, 2.72121062374652, '8690', 'West-Vlaanderen', 'Alveringem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.976301824160764, 2.63603213658728, '8691', 'West-Vlaanderen', 'Leisele', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99997764926436, 3.3374069061288845, '8700', 'West-Vlaanderen', 'Tielt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.91023075205403, 3.358850342103825, '8710', 'West-Vlaanderen', 'Wielsbeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.94966332294179, 3.3924510777041075, '8720', 'West-Vlaanderen', 'Markegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.12979244806573, 3.320853323796497, '8730', 'West-Vlaanderen', 'Beernem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99261140625523, 3.270450267559886, '8740', 'West-Vlaanderen', 'Pittem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.06781205827559, 3.28867923741712, '8750', 'West-Vlaanderen', 'Wingene', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.05512431930623, 3.382269724086246, '8755', 'West-Vlaanderen', 'Ruiselede', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.95105389378751, 3.295037936851297, '8760', 'West-Vlaanderen', 'Meulebeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.921458230622584, 3.260684729457544, '8770', 'West-Vlaanderen', 'Ingelmunster', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.93059447967373, 3.3372204211631344, '8780', 'West-Vlaanderen', 'Oostrozebeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.878530359819216, 3.426441012327737, '8790', 'West-Vlaanderen', 'Waregem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87235752687971, 3.345056110746947, '8791', 'West-Vlaanderen', 'Beveren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88478823206576, 3.3677549097404054, '8792', 'West-Vlaanderen', 'Desselgem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.89985376070436, 3.396984910260643, '8793', 'West-Vlaanderen', 'Sint-Eloois-Vijve', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.94625796358603, 3.1177834512642963, '8800', 'West-Vlaanderen', 'Roeselare', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.02776706343605, 3.1461225981811634, '8810', 'West-Vlaanderen', 'Lichtervelde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.062335838080806, 3.095483897636927, '8820', 'West-Vlaanderen', 'Torhout', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.98182637352017, 3.0640233035166684, '8830', 'West-Vlaanderen', 'Hooglede', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.96684101290582, 3.0048781500757906, '8840', 'West-Vlaanderen', 'Staden', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.9707202465605, 3.204586319277043, '8850', 'West-Vlaanderen', 'Ardooie', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.006944651303314, 3.1996567967432394, '8851', 'West-Vlaanderen', 'Koolskamp', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.885991292634145, 3.232021688120187, '8860', 'West-Vlaanderen', 'Lendelede', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.91131070183646, 3.2046318970732175, '8870', 'West-Vlaanderen', 'Izegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87492645636235, 3.1513772152801423, '8880', 'West-Vlaanderen', 'Rollegem-Kapelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88759693424778, 3.0741597685235034, '8890', 'West-Vlaanderen', 'Moorslede', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.81848404852776, 2.820689990115551, '8900', 'West-Vlaanderen', 'Dikkebus', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.855344107999336, 2.8957068009838367, '8900', 'West-Vlaanderen', 'Ieper', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.833226269872256, 2.9323899166643654, '8902', 'West-Vlaanderen', 'Zillebeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.89559226356297, 2.865255587209115, '8904', 'West-Vlaanderen', 'Boezinge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88168535177004, 2.8081336651108164, '8906', 'West-Vlaanderen', 'Elverdinge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.8470357900288, 2.8206986206233813, '8908', 'West-Vlaanderen', 'Vlamertinge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.908899940491104, 2.9247896783271297, '8920', 'West-Vlaanderen', 'Langemark', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.804089742749824, 3.1215173255091266, '8930', 'West-Vlaanderen', 'Menen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.82465133123318, 3.0713792802417728, '8940', 'West-Vlaanderen', 'Geluwe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.73761074793143, 2.824419784392634, '8950', 'West-Vlaanderen', 'Nieuwkerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.76103699521742, 2.794145665700685, '8951', 'West-Vlaanderen', 'Dranouter', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.76688542530164, 2.8421536091117092, '8952', 'West-Vlaanderen', 'Wulvergem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.782949599766326, 2.902678146003848, '8953', 'West-Vlaanderen', 'Wijtschate', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.79934939433776, 2.7437920011764887, '8954', 'West-Vlaanderen', 'Westouter', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.79001022171517, 2.835750526775866, '8956', 'West-Vlaanderen', 'Kemmel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.759777966611054, 2.8975460982504275, '8957', 'West-Vlaanderen', 'Mesen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.79093944397671, 2.7873658498693037, '8958', 'West-Vlaanderen', 'Loker', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.853593199911806, 2.71933380201441, '8970', 'West-Vlaanderen', 'Poperinge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88590312626407, 2.6565612254087987, '8972', 'West-Vlaanderen', 'Proven', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.847277895421854, 2.6407127152519636, '8978', 'West-Vlaanderen', 'Watou', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86573873980175, 2.979610977650222, '8980', 'West-Vlaanderen', 'Zonnebeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99895330058122, 4.981617466438012, '9', 'Vlaams-Brabant', 'Zichem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.053260703972086, 3.720262345300755, '9000', 'Oost-Vlaanderen', 'Gent', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.07386417979972, 3.6785357740312907, '9030', 'Oost-Vlaanderen', 'Mariakerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.051202535013374, 3.633046770040216, '9031', 'Oost-Vlaanderen', 'Drongen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.115287374583325, 3.738386889083249, '9032', 'Oost-Vlaanderen', 'Wondelgem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.06701435001319, 3.7694068345287524, '9040', 'Oost-Vlaanderen', 'Sint-Amandsberg', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.103064477304066, 3.772807392554319, '9041', 'Oost-Vlaanderen', 'Oostakker', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.161780043746816, 3.810343889705428, '9042', 'Oost-Vlaanderen', 'Sint-Kruis-Winkel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.03750198876654, 3.7710482317047225, '9050', 'Oost-Vlaanderen', 'Gentbrugge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.020835067310294, 3.6770404444377904, '9051', 'Oost-Vlaanderen', 'Sint-Denijs-Westrem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00344710907644, 3.7083253028608065, '9052', 'Oost-Vlaanderen', 'Zwijnaarde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.19915619493164, 3.8085967931803255, '9060', 'Oost-Vlaanderen', 'Zelzate', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.02810615197796, 3.812266535063497, '9070', 'Oost-Vlaanderen', 'Heusden', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.115287374583325, 3.738386889083249, '9075', 'Oost-Vlaanderen', 'Wondelgem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.0996990473999, 3.831947554237734, '9080', 'Oost-Vlaanderen', 'Lochristi', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00027811930153, 3.7964919983728342, '9090', 'Oost-Vlaanderen', 'Melle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.115287374583325, 3.738386889083249, '9099', 'Oost-Vlaanderen', 'Wondelgem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.16368187628335, 4.156645019474472, '9100', 'Oost-Vlaanderen', 'Sint-Niklaas', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.15731459867738, 4.089994967950732, '9111', 'Oost-Vlaanderen', 'Belsele', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.16014232146869, 4.029177437791314, '9112', 'Oost-Vlaanderen', 'Sinaai', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.21395164485779, 4.241424192342918, '9120', 'Oost-Vlaanderen', 'Beveren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.29334611618766, 4.203171492710529, '9130', 'Oost-Vlaanderen', 'Kieldrecht', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.140756480974794, 4.216570683439023, '9140', 'Oost-Vlaanderen', 'Temse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.1482626061719, 4.285333793866953, '9150', 'Oost-Vlaanderen', 'Bazel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.100245533430055, 3.968193939813087, '9160', 'Oost-Vlaanderen', 'Lokeren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.22764907167518, 4.119502014366569, '9170', 'Oost-Vlaanderen', 'Sint-Gillis-Waas', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.18224611521425, 3.9450631009265, '9180', 'Oost-Vlaanderen', 'Moerbeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.18040422959496, 3.8732661150898067, '9185', 'Oost-Vlaanderen', 'Wachtebeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.21058097517089, 4.018028609943872, '9190', 'Oost-Vlaanderen', 'Stekene', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.03696478515703, 4.084093700934431, '9200', 'Oost-Vlaanderen', 'Dendermonde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.089266350478, 4.120667785433801, '9220', 'Oost-Vlaanderen', 'Hamme', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00236028375542, 3.8707194000984635, '9230', 'Oost-Vlaanderen', 'Wetteren', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.06733279544228, 4.035908298040555, '9240', 'Oost-Vlaanderen', 'Zele', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.118651482590245, 4.0748651273348475, '9250', 'Oost-Vlaanderen', 'Waasmunster', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00801606329608, 4.192866346755479, '9255', 'Oost-Vlaanderen', 'Buggenhout', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.00798150472708, 3.936369060878192, '9260', 'Oost-Vlaanderen', 'Schellebelle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.03888355150804, 3.8572563876425936, '9270', 'Oost-Vlaanderen', 'Laarne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99414481507905, 4.137729814030584, '9280', 'Oost-Vlaanderen', 'Lebbeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.02452070785009, 3.9594524507697386, '9290', 'Oost-Vlaanderen', 'Uitbergen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.941780843882924, 4.047007532896995, '9300', 'Oost-Vlaanderen', 'Aalst', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.9673651621167, 4.029669760417315, '9308', 'Oost-Vlaanderen', 'Hofstade', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.95430084590078, 4.101311151466272, '9310', 'Oost-Vlaanderen', 'Moorsel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.91524229667714, 4.063243126487138, '9320', 'Oost-Vlaanderen', 'Erembodegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.957953814619216, 3.942331671334093, '9340', 'Oost-Vlaanderen', 'Impe', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.795727309381256, 4.014183549287835, '9400', 'Oost-Vlaanderen', 'Denderwindeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.85407606035612, 3.9665052522195245, '9400', 'Oost-Vlaanderen', 'Nederhasselt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84648981107948, 4.023746600967054, '9400', 'Oost-Vlaanderen', 'Ninove', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.81752760603058, 4.005803312914622, '9401', 'Oost-Vlaanderen', 'Pollare', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.819933611266514, 4.047828651322145, '9402', 'Oost-Vlaanderen', 'Meerbeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.80217727662278, 4.061660845254389, '9403', 'Oost-Vlaanderen', 'Neigem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.842928103900576, 3.946633269793813, '9404', 'Oost-Vlaanderen', 'Aspelare', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.84455637967905, 3.9904657170479583, '9406', 'Oost-Vlaanderen', 'Outer', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.916766900692416, 3.965005574250437, '9420', 'Oost-Vlaanderen', 'Mere', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.8756806472586, 4.0096342861603995, '9450', 'Oost-Vlaanderen', 'Denderhoutem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88499243738454, 3.9811720709385954, '9451', 'Oost-Vlaanderen', 'Kerksken', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.884211048076374, 4.068749078554287, '9470', 'Oost-Vlaanderen', 'Denderleeuw', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87453739606754, 4.0447930829411956, '9472', 'Oost-Vlaanderen', 'Iddergem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.89809663996499, 4.050302142583166, '9473', 'Oost-Vlaanderen', 'Welle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.820983674896276, 3.8868636876065725, '9500', 'Oost-Vlaanderen', 'Ophasselt', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.75631465402039, 3.8691914611452813, '9500', 'Oost-Vlaanderen', 'Overboelare', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.787052491799976, 3.937779364233144, '9506', 'Oost-Vlaanderen', 'Grimminge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.9196479297709, 3.850486439705949, '9520', 'Oost-Vlaanderen', 'Sint-Lievens-Houtem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.9399317811508, 3.9054061642290923, '9520', 'Oost-Vlaanderen', 'Vlierzele', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.931386568796505, 3.8742597152450755, '9521', 'Oost-Vlaanderen', 'Letterhoutem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.85766221605622, 3.8867416222453217, '9550', 'Oost-Vlaanderen', 'Sint-Lievens-Esse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.89338772451674, 3.9111979185866566, '9551', 'Oost-Vlaanderen', 'Ressegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.908600221464965, 3.889208165923369, '9552', 'Oost-Vlaanderen', 'Borsbeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.78878863358732, 3.8431823958137774, '9570', 'Oost-Vlaanderen', 'Deftinge', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.820759323517876, 3.837351919604356, '9570', 'Oost-Vlaanderen', 'Sint-Maria-Lierde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.80897937344392, 3.8629835042889376, '9571', 'Oost-Vlaanderen', 'Hemelveerdegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.80264947555913, 3.817041723218188, '9572', 'Oost-Vlaanderen', 'Sint-Martens-Lierde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.749709459509745, 3.6075931433164605, '9600', 'Oost-Vlaanderen', 'Ronse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86893462600802, 3.790568577398006, '9620', 'Oost-Vlaanderen', 'Strijpen', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.87804896694438, 3.7346053432296387, '9630', 'Oost-Vlaanderen', 'Munkzwalm', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88835687675334, 3.6894723695684046, '9636', 'Oost-Vlaanderen', 'Nederzwalm-Hermelgem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.804414751954994, 3.7639609001757734, '9660', 'Oost-Vlaanderen', 'Nederbrakel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.787756729438186, 3.8006573450507704, '9661', 'Oost-Vlaanderen', 'Parike', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.825598023975324, 3.6997802610882604, '9667', 'Oost-Vlaanderen', 'Sint-Kornelis-Horebeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.79985672096752, 3.6269285276748473, '9680', 'Oost-Vlaanderen', 'Etikhove', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.78349852701911, 3.6038124977970334, '9681', 'Oost-Vlaanderen', 'Nukerke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.78995440054331, 3.6830242329156384, '9688', 'Oost-Vlaanderen', 'Schorisse', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.77770082468756, 3.5422652943080513, '9690', 'Oost-Vlaanderen', 'Kwaremont', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.848018865686875, 3.611088262898648, '9700', 'Oost-Vlaanderen', 'Oudenaarde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.904546303248395, 3.602442710188111, '9750', 'Oost-Vlaanderen', 'Huise', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.916145054810755, 3.5299631913517944, '9770', 'Oost-Vlaanderen', 'Kruishoutem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.882928824884424, 3.5027556718941995, '9771', 'Oost-Vlaanderen', 'Nokere', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.88931137033742, 3.5577852555788283, '9772', 'Oost-Vlaanderen', 'Wannegem-Lede', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.86191054804526, 3.5005613467294294, '9790', 'Oost-Vlaanderen', 'Wortegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.98786919100002, 3.5164337686649905, '9800', 'Oost-Vlaanderen', 'Deinze', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.95655594080886, 3.595768004762264, '9810', 'Oost-Vlaanderen', 'Nazareth', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99390732762893, 3.746326283353625, '9820', 'Oost-Vlaanderen', 'Merelbeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.015740803574026, 3.6294698250650828, '9830', 'Oost-Vlaanderen', 'Sint-Martens-Latem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.99944078844335, 3.6103097552337835, '9831', 'Oost-Vlaanderen', 'Deurle', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.978265393100166, 3.6850030687203534, '9840', 'Oost-Vlaanderen', 'Zevergem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.044421243003534, 3.535967009652099, '9850', 'Oost-Vlaanderen', 'Nevele', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.933609936771354, 3.7703436593791997, '9860', 'Oost-Vlaanderen', 'Scheldewindeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.93514539477177, 3.4714136791105457, '9870', 'Oost-Vlaanderen', 'Olsene', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.09151927680345, 3.4195278281906196, '9880', 'Oost-Vlaanderen', 'Aalter', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.09168561675328, 3.4977257175846765, '9881', 'Oost-Vlaanderen', 'Bellem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (50.91707954807099, 3.7078450201871163, '9890', 'Oost-Vlaanderen', 'Dikkelvenne', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.19431839992802, 3.5623319136868963, '9900', 'Oost-Vlaanderen', 'Eeklo', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.13162078202465, 3.480613447575087, '9910', 'Oost-Vlaanderen', 'Ursel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.10476775744932, 3.622449773263771, '9920', 'Oost-Vlaanderen', 'Lovendegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.085020282418405, 3.639645638711476, '9921', 'Oost-Vlaanderen', 'Vinderhoute', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.11772486118317, 3.561101157171588, '9930', 'Oost-Vlaanderen', 'Zomergem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.15129887754736, 3.54260327297431, '9931', 'Oost-Vlaanderen', 'Oostwinkel', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.13340587981811, 3.5474694985779482, '9932', 'Oost-Vlaanderen', 'Ronsele', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.12040642924183, 3.7075201896052277, '9940', 'Oost-Vlaanderen', 'Evergem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.15208538001621, 3.6096560081033076, '9950', 'Oost-Vlaanderen', 'Waarschoot', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.228166383700824, 3.756207077499878, '9960', 'Oost-Vlaanderen', 'Assenede', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.25601063121515, 3.71047142445394, '9961', 'Oost-Vlaanderen', 'Boekhoute', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.23188747088605, 3.675027437464864, '9968', 'Oost-Vlaanderen', 'Bassevelde', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.22723496446966, 3.6164435324640904, '9970', 'Oost-Vlaanderen', 'Kaprijke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.19309612643193, 3.6356493131868612, '9971', 'Oost-Vlaanderen', 'Lembeke', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.232721096844344, 3.537156676449163, '9980', 'Oost-Vlaanderen', 'Sint-Laureins', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.270401617861964, 3.5397930596762, '9981', 'Oost-Vlaanderen', 'Sint-Margriete', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.25944310696155, 3.5766214003970918, '9982', 'Oost-Vlaanderen', 'Sint-Jan-in-Eremo', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.27265892988695, 3.642019715836148, '9988', 'Oost-Vlaanderen', 'Watervliet', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.19958507615239, 3.4327722449576346, '9990', 'Oost-Vlaanderen', 'Maldegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.18218511767298, 3.502766008215296, '9991', 'Oost-Vlaanderen', 'Adegem', 'BE');

INSERT INTO postal_code_lat_long (latitude, longitude, postal_code, province_name, city_name, country_code) VALUES (51.251803237430686, 3.4080986433831844, '9992', 'Oost-Vlaanderen', 'Middelburg', 'BE');

