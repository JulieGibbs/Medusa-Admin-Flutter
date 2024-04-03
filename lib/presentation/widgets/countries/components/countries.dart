import 'package:medusa_admin_dart_client/medusa_admin.dart';

const List<Country> countries = [
  Country(id: 001, iso2: 'af', numCode: 4, name: 'AFGHANISTAN', iso3: 'afg', displayName: 'Afghanistan'),
  Country(id: 002, iso2: 'al', numCode: 8, name: 'ALBANIA', iso3: 'alb', displayName: 'Albania'),
  Country(id: 003, iso2: 'dz', numCode: 12, name: 'ALGERIA', iso3: 'dza', displayName: 'Algeria'),
  Country(id: 004, iso2: 'as', numCode: 16, name: 'AMERICAN SAMOA', iso3: 'asm', displayName: 'American Samoa'),
  Country(id: 005, iso2: 'ad', numCode: 20, name: 'ANDORRA', iso3: 'and', displayName: 'Andorra'),
  Country(id: 006, iso2: 'ao', numCode: 24, name: 'ANGOLA', iso3: 'ago', displayName: 'Angola'),
  Country(id: 007, iso2: 'ai', numCode: 660, name: 'ANGUILLA', iso3: 'aia', displayName: 'Anguilla'),
  Country(id: 008, iso2: 'aq', numCode: 10, name: 'ANTARCTICA', iso3: 'ata', displayName: 'Antarctica'),
  Country(
      id: 009, iso2: 'ag', numCode: 28, name: 'ANTIGUA AND BARBUDA', iso3: 'atg', displayName: 'Antigua and Barbuda'),
  Country(id: 010, iso2: 'ar', numCode: 32, name: 'ARGENTINA', iso3: 'arg', displayName: 'Argentina'),
  Country(id: 011, iso2: 'am', numCode: 51, name: 'ARMENIA', iso3: 'arm', displayName: 'Armenia'),
  Country(id: 012, iso2: 'aw', numCode: 533, name: 'ARUBA', iso3: 'abw', displayName: 'Aruba'),
  Country(id: 013, iso2: 'au', numCode: 36, name: "AUSTRALIA", iso3: 'aus', displayName: "Australia"),
  Country(id: 014, iso2: 'at', numCode: 40, name: "AUSTRIA", iso3: 'aut', displayName: "Austria"),
  Country(id: 015, iso2: 'az', numCode: 31, name: "AZERBAIJAN", iso3: 'aze', displayName: "Azerbaijan"),
  Country(id: 016, iso2: 'bs', numCode: 44, name: "BAHAMAS", iso3: 'bhs', displayName: "Bahamas"),
  Country(id: 017, iso2: 'bh', numCode: 48, name: "BAHRAIN", iso3: 'bhr', displayName: "Bahrain"),
  Country(id: 018, iso2: 'bd', numCode: 50, name: "BANGLADESH", iso3: 'bgd', displayName: "Bangladesh"),
  Country(id: 019, iso2: 'bb', numCode: 52, name: "BARBADOS", iso3: 'brb', displayName: "Barbados"),
  Country(id: 020, iso2: 'by', numCode: 112, name: "BELARUS", iso3: 'blr', displayName: "Belarus"),
  Country(id: 021, iso2: 'be', numCode: 56, name: "BELGIUM", iso3: 'bel', displayName: "Belgium"),
  Country(id: 022, iso2: 'bz', numCode: 84, name: "BELIZE", iso3: 'blz', displayName: "Belize"),
  Country(id: 023, iso2: 'bj', numCode: 204, name: "BENIN", iso3: 'ben', displayName: "Benin"),
  Country(id: 024, iso2: 'bm', numCode: 60, name: "BERMUDA", iso3: 'bmu', displayName: "Bermuda"),
  Country(id: 025, iso2: 'bt', numCode: 64, name: "BHUTAN", iso3: 'btn', displayName: "Bhutan"),
  Country(id: 026, iso2: 'bo', numCode: 68, name: "BOLIVIA", iso3: 'bol', displayName: "Bolivia"),
  Country(
      id: 027,
      iso2: 'bq',
      numCode: 535,
      name: "BONAIRE, SINT EUSTATIUS AND SABA",
      iso3: 'bes',
      displayName: "Bonaire, Sint Eustatius and Saba"),
  Country(
      id: 028,
      iso2: 'ba',
      numCode: 70,
      name: "BOSNIA AND HERZEGOVINA",
      iso3: 'bih',
      displayName: "Bosnia and Herzegovina"),
  Country(id: 029, iso2: 'bw', numCode: 72, name: "BOTSWANA", iso3: 'bwa', displayName: "Botswana"),
  Country(id: 030, iso2: 'bv', numCode: 74, name: "BOUVET ISLAND", iso3: 'bvd', displayName: "Bouvet Island"),
  Country(id: 031, iso2: 'br', numCode: 76, name: "BRAZIL", iso3: 'bra', displayName: "Brazil"),
  Country(
      id: 032,
      iso2: 'io',
      numCode: 86,
      name: "BRITISH INDIAN OCEAN TERRITORY",
      iso3: 'iot',
      displayName: "British Indian Ocean Territory"),
  Country(id: 033, iso2: 'bn', numCode: 96, name: "BRUNEI DARUSSALAM", iso3: 'brn', displayName: "Brunei Darussalam"),
  Country(id: 034, iso2: 'bg', numCode: 100, name: "BULGARIA", iso3: 'bgr', displayName: "Bulgaria"),
  Country(id: 035, iso2: 'bf', numCode: 854, name: "BURKINA FASO", iso3: 'bfa', displayName: "Burkina Faso"),
  Country(id: 036, iso2: 'bi', numCode: 108, name: "BURUNDI", iso3: 'bdi', displayName: "Burundi"),
  Country(id: 037, iso2: 'kh', numCode: 116, name: "CAMBODIA", iso3: 'khm', displayName: "Cambodia"),
  Country(id: 038, iso2: 'cm', numCode: 120, name: "CAMEROON", iso3: 'cmr', displayName: "Cameroon"),
  Country(id: 039, iso2: 'ca', numCode: 124, name: "CANADA", iso3: 'can', displayName: "Canada"),
  Country(id: 040, iso2: 'cv', numCode: 132, name: "CAPE VERDE", iso3: 'cpv', displayName: "Cape Verde"),
  Country(id: 041, iso2: 'ky', numCode: 136, name: "CAYMAN ISLANDS", iso3: 'cym', displayName: "Cayman Islands"),
  Country(
      id: 042,
      iso2: 'cf',
      numCode: 140,
      name: "CENTRAL AFRICAN REPUBLIC",
      iso3: 'caf',
      displayName: "Central African Republic"),
  Country(id: 043, iso2: 'td', numCode: 148, name: "CHAD", iso3: 'tcd', displayName: "Chad"),
  Country(id: 044, iso2: 'cl', numCode: 152, name: "CHILE", iso3: 'chl', displayName: "Chile"),
  Country(id: 045, iso2: 'cn', numCode: 156, name: "CHINA", iso3: 'chn', displayName: "China"),
  Country(id: 046, iso2: 'cx', numCode: 162, name: "CHRISTMAS ISLAND", iso3: 'cxr', displayName: "Christmas Island"),
  Country(
      id: 047,
      iso2: 'cc',
      numCode: 166,
      name: "COCOS (KEELING) ISLANDS",
      iso3: 'cck',
      displayName: "Cocos (Keeling) Islands"),
  Country(id: 048, iso2: 'co', numCode: 170, name: "COLOMBIA", iso3: 'col', displayName: "Colombia"),
  Country(id: 049, iso2: 'km', numCode: 174, name: "COMOROS", iso3: 'com', displayName: "Comoros"),
  Country(id: 050, iso2: 'cg', numCode: 178, name: "CONGO", iso3: 'cog', displayName: "Congo"),
  Country(
      id: 051,
      iso2: 'cd',
      numCode: 180,
      name: "CONGO, THE DEMOCRATIC REPUBLIC OF THE",
      iso3: 'cod',
      displayName: "Congo, the Democratic Republic of the"),
  Country(id: 052, iso2: 'ck', numCode: 184, name: "COOK ISLANDS", iso3: 'cok', displayName: "Cook Islands"),
  Country(id: 053, iso2: 'cr', numCode: 188, name: "COSTA RICA", iso3: 'cri', displayName: "Costa Rica"),
  Country(id: 054, iso2: 'ci', numCode: 384, name: "COTE D'IVOIRE", iso3: 'civ', displayName: "Cote D'Ivoire"),
  Country(id: 055, iso2: 'hr', numCode: 191, name: "CROATIA", iso3: 'hrv', displayName: "Croatia"),
  Country(id: 056, iso2: 'cu', numCode: 192, name: "CUBA", iso3: 'cub', displayName: "Cuba"),
  Country(id: 057, iso2: 'cw', numCode: 531, name: "CURAÇAO", iso3: 'cuw', displayName: "Curaçao"),
  Country(id: 058, iso2: 'cy', numCode: 196, name: "CYPRUS", iso3: 'cyp', displayName: "Cyprus"),
  Country(id: 059, iso2: 'cz', numCode: 203, name: "CZECH REPUBLIC", iso3: 'cze', displayName: "Czech Republic"),
  Country(id: 060, iso2: 'dk', numCode: 208, name: "DENMARK", iso3: 'dnk', displayName: "Denmark"),
  Country(id: 061, iso2: 'dj', numCode: 262, name: "DJIBOUTI", iso3: 'dji', displayName: "Djibouti"),
  Country(id: 062, iso2: 'dm', numCode: 212, name: "DOMINICA", iso3: 'dma', displayName: "Dominica"),
  Country(
      id: 063, iso2: 'do', numCode: 214, name: "DOMINICAN REPUBLIC", iso3: 'dom', displayName: "Dominican Republic"),
  Country(id: 064, iso2: 'ec', numCode: 218, name: "ECUADOR", iso3: 'ecu', displayName: "Ecuador"),
  Country(id: 065, iso2: 'eg', numCode: 818, name: "EGYPT", iso3: 'egy', displayName: "Egypt"),
  Country(id: 066, iso2: 'sv', numCode: 222, name: "EL SALVADOR", iso3: 'slv', displayName: "El Salvador"),
  Country(id: 067, iso2: 'gq', numCode: 226, name: "EQUATORIAL GUINEA", iso3: 'gnq', displayName: "Equatorial Guinea"),
  Country(id: 068, iso2: 'er', numCode: 232, name: "ERITREA", iso3: 'eri', displayName: "Eritrea"),
  Country(id: 069, iso2: 'ee', numCode: 233, name: "ESTONIA", iso3: 'est', displayName: "Estonia"),
  Country(id: 070, iso2: 'et', numCode: 231, name: "ETHIOPIA", iso3: 'eth', displayName: "Ethiopia"),
  Country(
      id: 071,
      iso2: 'fk',
      numCode: 238,
      name: "FALKLAND ISLANDS (MALVINAS)",
      iso3: 'flk',
      displayName: "Falkland Islands (Malvinas)"),
  Country(id: 072, iso2: 'fo', numCode: 234, name: "FAROE ISLANDS", iso3: 'fro', displayName: "Faroe Islands"),
  Country(id: 073, iso2: 'fj', numCode: 242, name: "FIJI", iso3: 'fji', displayName: "Fiji"),
  Country(id: 074, iso2: 'fi', numCode: 246, name: "FINLAND", iso3: 'fin', displayName: "Finland"),
  Country(id: 075, iso2: 'fr', numCode: 250, name: "FRANCE", iso3: 'fra', displayName: "France"),
  Country(id: 076, iso2: 'gf', numCode: 254, name: "FRENCH GUIANA", iso3: 'guf', displayName: "French Guiana"),
  Country(id: 077, iso2: 'pf', numCode: 258, name: "FRENCH POLYNESIA", iso3: 'pyf', displayName: "French Polynesia"),
  Country(
      id: 078,
      iso2: 'tf',
      numCode: 260,
      name: "FRENCH SOUTHERN TERRITORIES",
      iso3: 'atf',
      displayName: "French Southern Territories"),
  Country(id: 079, iso2: 'ga', numCode: 266, name: "GABON", iso3: 'gab', displayName: "Gabon"),
  Country(id: 080, iso2: 'gm', numCode: 270, name: "GAMBIA", iso3: 'gmb', displayName: "Gambia"),
  Country(id: 081, iso2: 'ge', numCode: 268, name: "GEORGIA", iso3: 'geo', displayName: "Georgia"),
  Country(id: 082, iso2: 'de', numCode: 276, name: "GERMANY", iso3: 'deu', displayName: "Germany"),
  Country(id: 083, iso2: 'gh', numCode: 288, name: "GHANA", iso3: 'gha', displayName: "Ghana"),
  Country(id: 084, iso2: 'gi', numCode: 292, name: "GIBRALTAR", iso3: 'gib', displayName: "Gibraltar"),
  Country(id: 085, iso2: 'gr', numCode: 300, name: "GREECE", iso3: 'grc', displayName: "Greece"),
  Country(id: 086, iso2: 'gl', numCode: 304, name: "GREENLAND", iso3: 'grl', displayName: "Greenland"),
  Country(id: 087, iso2: 'gd', numCode: 308, name: "GRENADA", iso3: 'grd', displayName: "Grenada"),
  Country(id: 088, iso2: 'gp', numCode: 312, name: "GUADELOUPE", iso3: 'glp', displayName: "Guadeloupe"),
  Country(id: 089, iso2: 'gu', numCode: 316, name: "GUAM", iso3: 'gum', displayName: "Guam"),
  Country(id: 090, iso2: 'gt', numCode: 320, name: "GUATEMALA", iso3: 'gtm', displayName: "Guatemala"),
  Country(id: 091, iso2: 'gg', numCode: 831, name: "GUERNSEY", iso3: 'ggy', displayName: "Guernsey"),
  Country(id: 092, iso2: 'gn', numCode: 324, name: "GUINEA", iso3: 'gin', displayName: "Guinea"),
  Country(id: 093, iso2: 'gw', numCode: 624, name: "GUINEA-BISSAU", iso3: 'gnb', displayName: "Guinea-Bissau"),
  Country(id: 094, iso2: 'gy', numCode: 328, name: "GUYANA", iso3: 'guy', displayName: "Guyana"),
  Country(id: 095, iso2: 'ht', numCode: 332, name: "HAITI", iso3: 'hti', displayName: "Haiti"),
  Country(id: 098, iso2: 'hn', numCode: 340, name: "HONDURAS", iso3: 'hnd', displayName: "Honduras"),
  Country(id: 099, iso2: 'hk', numCode: 344, name: "HONG KONG", iso3: 'hkg', displayName: "Hong Kong"),
  Country(id: 100, iso2: 'hu', numCode: 348, name: "HUNGARY", iso3: 'hun', displayName: "Hungary"),
  Country(id: 101, iso2: 'is', numCode: 352, name: "ICELAND", iso3: 'isl', displayName: "Iceland"),
  Country(id: 102, iso2: 'in', numCode: 356, name: "INDIA", iso3: 'ind', displayName: "India"),
  Country(id: 103, iso2: 'id', numCode: 360, name: "INDONESIA", iso3: 'idn', displayName: "Indonesia"),
  Country(
      id: 104,
      iso2: 'ir',
      numCode: 364,
      name: "ISLAMIC REPUBLIC OF IRAN",
      iso3: 'irn',
      displayName: "Islamic Republic of Iran"),
  Country(id: 105, iso2: 'iq', numCode: 368, name: "IRAQ", iso3: 'irq', displayName: "Iraq"),
  Country(id: 106, iso2: 'ie', numCode: 372, name: "IRELAND", iso3: 'irl', displayName: "Ireland"),
  Country(id: 107, iso2: 'im', numCode: 833, name: "ISLE OF MAN", iso3: 'imn', displayName: "Isle Of Man"),
  Country(id: 108, iso2: 'il', numCode: 376, name: "ISRAEL", iso3: 'isr', displayName: "Israel"),
  Country(id: 109, iso2: 'it', numCode: 380, name: "ITALY", iso3: 'ita', displayName: "Italy"),
  Country(id: 110, iso2: 'jm', numCode: 388, name: "JAMAICA", iso3: 'jam', displayName: "Jamaica"),
  Country(id: 111, iso2: 'jp', numCode: 392, name: "JAPAN", iso3: 'jpn', displayName: "Japan"),
  Country(id: 112, iso2: 'je', numCode: 832, name: "JERSEY", iso3: 'jey', displayName: "Jersey"),
  Country(id: 113, iso2: 'jo', numCode: 400, name: "JORDAN", iso3: 'jor', displayName: "Jordan"),
  Country(id: 114, iso2: 'kz', numCode: 398, name: "KAZAKHSTAN", iso3: 'kaz', displayName: "Kazakhstan"),
  Country(id: 115, iso2: 'ke', numCode: 404, name: "KENYA", iso3: 'ken', displayName: "Kenya"),
  Country(id: 116, iso2: 'ki', numCode: 296, name: "KIRIBATI", iso3: 'kir', displayName: "Kiribati"),
  Country(
      id: 118, iso2: 'kr', numCode: 410, name: "KOREA, REPUBLIC OF", iso3: 'kor', displayName: "Korea, Republic of"),
  Country(id: 119, iso2: 'xk', numCode: 900, name: "KOSOVO", iso3: 'xkx', displayName: "Kosovo"),
  Country(id: 120, iso2: 'kw', numCode: 414, name: "KUWAIT", iso3: 'kwt', displayName: "Kuwait"),
  Country(id: 121, iso2: 'kg', numCode: 417, name: "KYRGYZSTAN", iso3: 'kgz', displayName: "Kyrgyzstan"),
  Country(id: 123, iso2: 'lv', numCode: 428, name: "LATVIA", iso3: 'lva', displayName: "Latvia"),
  Country(id: 124, iso2: 'lb', numCode: 422, name: "LEBANON", iso3: 'lbn', displayName: "Lebanon"),
  Country(id: 125, iso2: 'ls', numCode: 426, name: "LESOTHO", iso3: 'lso', displayName: "Lesotho"),
  Country(id: 126, iso2: 'lr', numCode: 430, name: "LIBERIA", iso3: 'lbr', displayName: "Liberia"),
  Country(id: 128, iso2: 'li', numCode: 438, name: "LIECHTENSTEIN", iso3: 'lie', displayName: "Liechtenstein"),
  Country(id: 129, iso2: 'lt', numCode: 440, name: "LITHUANIA", iso3: 'ltu', displayName: "Lithuania"),
  Country(id: 130, iso2: 'lu', numCode: 442, name: "LUXEMBOURG", iso3: 'lux', displayName: "Luxembourg"),
  Country(id: 131, iso2: 'mo', numCode: 446, name: "MACAO", iso3: 'mac', displayName: "Macao"),
  Country(
      id: 132,
      iso2: 'mk',
      numCode: 807,
      name: "THE FORMER YUGOSLAV REPUBLIC OF MACEDONIA",
      iso3: 'mkd',
      displayName: "the Former Yugoslav Republic of Macedonia"),
  Country(id: 133, iso2: 'mg', numCode: 450, name: "MADAGASCAR", iso3: 'mdg', displayName: "Madagascar"),
  Country(id: 134, iso2: 'mw', numCode: 454, name: "MALAWI", iso3: 'mwi', displayName: "Malawi"),
  Country(id: 135, iso2: 'my', numCode: 458, name: "MALAYSIA", iso3: 'mys', displayName: "Malaysia"),
  Country(id: 136, iso2: 'mv', numCode: 462, name: "MALDIVES", iso3: 'mdv', displayName: "Maldives"),
  Country(id: 137, iso2: 'ml', numCode: 466, name: "MALI", iso3: 'mli', displayName: "Mali"),
  Country(id: 138, iso2: 'mt', numCode: 470, name: "MALTA", iso3: 'mlt', displayName: "Malta"),
  Country(id: 139, iso2: 'mh', numCode: 584, name: "MARSHALL ISLANDS", iso3: 'mhl', displayName: "Marshall Islands"),
  Country(id: 140, iso2: 'mq', numCode: 474, name: "MARTINIQUE", iso3: 'mtq', displayName: "Martinique"),
  Country(id: 141, iso2: 'mr', numCode: 478, name: "MAURITANIA", iso3: 'mrt', displayName: "Mauritania"),
  Country(id: 142, iso2: 'mu', numCode: 480, name: "MAURITIUS", iso3: 'mus', displayName: "Mauritius"),
  Country(id: 143, iso2: 'yt', numCode: 175, name: "MAYOTTE", iso3: 'myt', displayName: "Mayotte"),
  Country(id: 144, iso2: 'mx', numCode: 484, name: "MEXICO", iso3: 'mex', displayName: "Mexico"),
  Country(
      id: 145,
      iso2: 'fm',
      numCode: 583,
      name: "FEDERATED STATES OF MICRONESIA",
      iso3: 'fsm',
      displayName: "Federated States of Micronesia"),
  Country(
      id: 146,
      iso2: 'md',
      numCode: 498,
      name: "MOLDOVA, REPUBLIC OF",
      iso3: 'mda',
      displayName: "Moldova, Republic of"),
  Country(id: 147, iso2: 'mc', numCode: 492, name: "MONACO", iso3: 'mco', displayName: "Monaco"),
  Country(id: 148, iso2: 'mn', numCode: 496, name: "MONGOLIA", iso3: 'mng', displayName: "Mongolia"),
  Country(id: 149, iso2: 'me', numCode: 499, name: "MONTENEGRO", iso3: 'mne', displayName: "Montenegro"),
  Country(id: 150, iso2: 'ms', numCode: 500, name: "MONTSERRAT", iso3: 'msr', displayName: "Montserrat"),
  Country(id: 151, iso2: 'ma', numCode: 504, name: "MOROCCO", iso3: 'mar', displayName: "Morocco"),
  Country(id: 152, iso2: 'mz', numCode: 508, name: "MOZAMBIQUE", iso3: 'moz', displayName: "Mozambique"),
  Country(id: 153, iso2: 'mm', numCode: 104, name: "MYANMAR", iso3: 'mmr', displayName: "Myanmar"),
  Country(id: 154, iso2: 'na', numCode: 516, name: "NAMIBIA", iso3: 'nam', displayName: "Namibia"),
  Country(id: 155, iso2: 'nr', numCode: 520, name: "NAURU", iso3: 'nru', displayName: "Nauru"),
  Country(id: 156, iso2: 'np', numCode: 524, name: "NEPAL", iso3: 'npl', displayName: "Nepal"),
  Country(id: 157, iso2: 'nl', numCode: 528, name: "NETHERLANDS", iso3: 'nld', displayName: "Netherlands"),
  Country(id: 158, iso2: 'nc', numCode: 540, name: "NEW CALEDONIA", iso3: 'ncl', displayName: "New Caledonia"),
  Country(id: 159, iso2: 'nz', numCode: 554, name: "NEW ZEALAND", iso3: 'nzl', displayName: "New Zealand"),
  Country(id: 160, iso2: 'ni', numCode: 558, name: "NICARAGUA", iso3: 'nic', displayName: "Nicaragua"),
  Country(id: 161, iso2: 'ne', numCode: 562, name: "NIGER", iso3: 'ner', displayName: "Niger"),
  Country(id: 162, iso2: 'ng', numCode: 566, name: "NIGERIA", iso3: 'nga', displayName: "Nigeria"),
  Country(id: 163, iso2: 'nu', numCode: 570, name: "NIUE", iso3: 'niu', displayName: "Niue"),
  Country(id: 164, iso2: 'nf', numCode: 574, name: "NORFOLK ISLAND", iso3: 'nfk', displayName: "Norfolk Island"),
  Country(
      id: 165,
      iso2: 'mp',
      numCode: 580,
      name: "NORTHERN MARIANA ISLANDS",
      iso3: 'mnp',
      displayName: "Northern Mariana Islands"),
  Country(id: 166, iso2: 'no', numCode: 578, name: "NORWAY", iso3: 'nor', displayName: "Norway"),
  Country(id: 167, iso2: 'om', numCode: 512, name: "OMAN", iso3: 'omn', displayName: "Oman"),
  Country(id: 168, iso2: 'pk', numCode: 586, name: "PAKISTAN", iso3: 'pak', displayName: "Pakistan"),
  Country(id: 169, iso2: 'pw', numCode: 585, name: "PALAU", iso3: 'plw', displayName: "Palau"),
  Country(
      id: 170,
      iso2: 'ps',
      numCode: 275,
      name: "PALESTINIAN TERRITORY, OCCUPIED",
      iso3: 'pse',
      displayName: "Palestinian Territory, Occupied"),
  Country(id: 171, iso2: 'pa', numCode: 591, name: "PANAMA", iso3: 'pan', displayName: "Panama"),
  Country(id: 172, iso2: 'pg', numCode: 598, name: "PAPUA NEW GUINEA", iso3: 'png', displayName: "Papua New Guinea"),
  Country(id: 173, iso2: 'py', numCode: 600, name: "PARAGUAY", iso3: 'pry', displayName: "Paraguay"),
  Country(id: 174, iso2: 'pe', numCode: 604, name: "PERU", iso3: 'per', displayName: "Peru"),
  Country(id: 175, iso2: 'ph', numCode: 608, name: "PHILIPPINES", iso3: 'phl', displayName: "Philippines"),
  Country(id: 176, iso2: 'pn', numCode: 612, name: "PITCAIRN", iso3: 'pcn', displayName: "Pitcairn"),
  Country(id: 177, iso2: 'pl', numCode: 616, name: "POLAND", iso3: 'pol', displayName: "Poland"),
  Country(id: 178, iso2: 'pt', numCode: 620, name: "PORTUGAL", iso3: 'prt', displayName: "Portugal"),
  Country(id: 179, iso2: 'pr', numCode: 630, name: "PUERTO RICO", iso3: 'pri', displayName: "Puerto Rico"),
  Country(id: 180, iso2: 'qa', numCode: 634, name: "QATAR", iso3: 'qat', displayName: "Qatar"),
  Country(id: 181, iso2: 're', numCode: 638, name: "REUNION", iso3: 'reu', displayName: "Reunion"),
  Country(id: 182, iso2: 'ro', numCode: 642, name: "ROMANIA", iso3: 'rom', displayName: "Romania"),
  Country(
      id: 183, iso2: 'ru', numCode: 643, name: "RUSSIAN FEDERATION", iso3: 'rus', displayName: "Russian Federation"),
  Country(id: 184, iso2: 'rw', numCode: 646, name: "RWANDA", iso3: 'rwa', displayName: "Rwanda"),
  Country(id: 185, iso2: 'bl', numCode: 652, name: "SAINT BARTHÉLEMY", iso3: 'blm', displayName: "Saint Barthélemy"),
  Country(id: 186, iso2: 'sh', numCode: 654, name: "SAINT HELENA", iso3: 'shn', displayName: "Saint Helena"),
  Country(
      id: 187,
      iso2: 'kn',
      numCode: 659,
      name: "SAINT KITTS AND NEVIS",
      iso3: 'kna',
      displayName: "Saint Kitts and Nevis"),
  Country(id: 188, iso2: 'lc', numCode: 662, name: "SAINT LUCIA", iso3: 'lca', displayName: "Saint Lucia"),
  Country(
      id: 189,
      iso2: 'mf',
      numCode: 663,
      name: "SAINT MARTIN (FRENCH PART)",
      iso3: 'maf',
      displayName: "Saint Martin (French part)"),
  Country(
      id: 190,
      iso2: 'pm',
      numCode: 666,
      name: "SAINT PIERRE AND MIQUELON",
      iso3: 'spm',
      displayName: "Saint Pierre and Miquelon"),
  Country(
      id: 191,
      iso2: 'vc',
      numCode: 670,
      name: "SAINT VINCENT AND THE GRENADINES",
      iso3: 'vct',
      displayName: "Saint Vincent and the Grenadines"),
  Country(id: 192, iso2: 'ws', numCode: 882, name: "SAMOA", iso3: 'wsm', displayName: "Samoa"),
  Country(id: 193, iso2: 'sm', numCode: 674, name: "SAN MARINO", iso3: 'smr', displayName: "San Marino"),
  Country(
      id: 194,
      iso2: 'st',
      numCode: 678,
      name: "SAO TOME AND PRINCIPE",
      iso3: 'stp',
      displayName: "Sao Tome and Principe"),
  Country(id: 195, iso2: 'sa', numCode: 682, name: "SAUDI ARABIA", iso3: 'sau', displayName: "Saudi Arabia"),
  Country(id: 196, iso2: 'sn', numCode: 686, name: "SENEGAL", iso3: 'sen', displayName: "Senegal"),
  Country(id: 197, iso2: 'rs', numCode: 688, name: "SERBIA", iso3: 'srb', displayName: "Serbia"),
  Country(id: 198, iso2: 'sc', numCode: 690, name: "SEYCHELLES", iso3: 'syc', displayName: "Seychelles"),
  Country(id: 199, iso2: 'sl', numCode: 694, name: "SIERRA LEONE", iso3: 'sle', displayName: "Sierra Leone"),
  Country(id: 200, iso2: 'sg', numCode: 702, name: "SINGAPORE", iso3: 'sgp', displayName: "Singapore"),
  Country(id: 201, iso2: 'sx', numCode: 534, name: "SINT MAARTEN", iso3: 'sxm', displayName: "Sint Maarten"),
  Country(id: 202, iso2: 'sk', numCode: 703, name: "SLOVAKIA", iso3: 'svk', displayName: "Slovakia"),
  Country(id: 203, iso2: 'si', numCode: 705, name: "SLOVENIA", iso3: 'svn', displayName: "Slovenia"),
  Country(id: 204, iso2: 'sb', numCode: 90, name: "SOLOMON ISLANDS", iso3: 'slb', displayName: "Solomon Islands"),
  Country(id: 205, iso2: 'so', numCode: 706, name: "SOMALIA", iso3: 'som', displayName: "Somalia"),
  Country(id: 206, iso2: 'za', numCode: 710, name: "SOUTH AFRICA", iso3: 'zaf', displayName: "South Africa"),
  Country(id: 208, iso2: 'ss', numCode: 728, name: "SOUTH SUDAN", iso3: 'ssd', displayName: "South Sudan"),
  Country(id: 209, iso2: 'es', numCode: 724, name: "SPAIN", iso3: 'esp', displayName: "Spain"),
  Country(id: 210, iso2: 'lk', numCode: 144, name: "SRI LANKA", iso3: 'lka', displayName: "Sri Lanka"),
  Country(id: 211, iso2: 'sd', numCode: 729, name: "SUDAN", iso3: 'sdn', displayName: "Sudan"),
  Country(id: 212, iso2: 'sr', numCode: 740, name: "SURINAME", iso3: 'sur', displayName: "Suriname"),
  Country(
      id: 213,
      iso2: 'sj',
      numCode: 744,
      name: "SVALBARD AND JAN MAYEN",
      iso3: 'sjm',
      displayName: "Svalbard and Jan Mayen"),
  Country(id: 214, iso2: 'sz', numCode: 748, name: "SWAZILAND", iso3: 'swz', displayName: "Swaziland"),
  Country(id: 215, iso2: 'se', numCode: 752, name: "SWEDEN", iso3: 'swe', displayName: "Sweden"),
  Country(id: 216, iso2: 'ch', numCode: 756, name: "SWITZERLAND", iso3: 'che', displayName: "Switzerland"),
  Country(
      id: 217,
      iso2: 'sy',
      numCode: 760,
      name: "SYRIAN ARAB REPUBLIC",
      iso3: 'syr',
      displayName: "Syrian Arab Republic"),
  Country(
      id: 218,
      iso2: 'tw',
      numCode: 158,
      name: "TAIWAN, PROVINCE OF CHINA",
      iso3: 'twn',
      displayName: "Taiwan, Province of China"),
  Country(id: 219, iso2: 'tj', numCode: 762, name: "TAJIKISTAN", iso3: 'tjk', displayName: "Tajikistan"),
  Country(
      id: 220,
      iso2: 'tz',
      numCode: 834,
      name: "UNITED REPUBLIC OF TANZANIA",
      iso3: 'tza',
      displayName: "United Republic of Tanzania"),
  Country(id: 221, iso2: 'th', numCode: 764, name: "THAILAND", iso3: 'tha', displayName: "Thailand"),
  Country(id: 222, iso2: 'tl', numCode: 626, name: "TIMOR LESTE", iso3: 'tls', displayName: "Timor Leste"),
  Country(id: 223, iso2: 'tg', numCode: 768, name: "TOGO", iso3: 'tgo', displayName: "Togo"),
  Country(id: 224, iso2: 'tk', numCode: 772, name: "TOKELAU", iso3: 'tkl', displayName: "Tokelau"),
  Country(id: 225, iso2: 'to', numCode: 776, name: "TONGA", iso3: 'ton', displayName: "Tonga"),
  Country(
      id: 226, iso2: 'tt', numCode: 780, name: "TRINIDAD AND TOBAGO", iso3: 'tto', displayName: "Trinidad and Tobago"),
  Country(id: 227, iso2: 'tn', numCode: 788, name: "TUNISIA", iso3: 'tun', displayName: "Tunisia"),
  Country(id: 228, iso2: 'tr', numCode: 792, name: "TURKEY", iso3: 'tur', displayName: "Turkey"),
  Country(id: 229, iso2: 'tm', numCode: 795, name: "TURKMENISTAN", iso3: 'tkm', displayName: "Turkmenistan"),
  Country(
      id: 230,
      iso2: 'tc',
      numCode: 796,
      name: "TURKS AND CAICOS ISLANDS",
      iso3: 'tca',
      displayName: "Turks and Caicos Islands"),
  Country(id: 231, iso2: 'tv', numCode: 798, name: "TUVALU", iso3: 'tuv', displayName: "Tuvalu"),
  Country(id: 232, iso2: 'ug', numCode: 800, name: "UGANDA", iso3: 'uga', displayName: "Uganda"),
  Country(id: 233, iso2: 'ua', numCode: 804, name: "UKRAINE", iso3: 'ukr', displayName: "Ukraine"),
  Country(
      id: 234,
      iso2: 'ae',
      numCode: 784,
      name: "UNITED ARAB EMIRATES",
      iso3: 'are',
      displayName: "United Arab Emirates"),
  Country(id: 235, iso2: 'gb', numCode: 826, name: "UNITED KINGDOM", iso3: 'gbr', displayName: "United Kingdom"),
  Country(id: 236, iso2: 'us', numCode: 840, name: "UNITED STATES", iso3: 'usa', displayName: "United States"),
  Country(
      id: 237,
      iso2: 'um',
      numCode: 581,
      name: "UNITED STATES MINOR OUTLYING ISLANDS",
      iso3: 'umi',
      displayName: "United States Minor Outlying Islands"),
  Country(id: 238, iso2: 'uy', numCode: 858, name: "URUGUAY", iso3: 'ury', displayName: "Uruguay"),
  Country(id: 239, iso2: 'uz', numCode: 860, name: "UZBEKISTAN", iso3: 'uzb', displayName: "Uzbekistan"),
  Country(id: 240, iso2: 'vu', numCode: 548, name: "VANUATU", iso3: 'vut', displayName: "Vanuatu"),
  Country(id: 241, iso2: 've', numCode: 862, name: "VENEZUELA", iso3: 'ven', displayName: "Venezuela"),
  Country(id: 242, iso2: 'vn', numCode: 704, name: "VIET NAM", iso3: 'vnm', displayName: "Viet Nam"),
  Country(
      id: 243,
      iso2: 'vg',
      numCode: 92,
      name: "VIRGIN ISLANDS, BRITISH",
      iso3: 'vgb',
      displayName: "Virgin Islands, British"),
  Country(
      id: 244,
      iso2: 'vi',
      numCode: 850,
      name: "VIRGIN ISLANDS, U.S.",
      iso3: 'vir',
      displayName: "Virgin Islands, U.S."),
  Country(id: 245, iso2: 'wf', numCode: 876, name: "WALLIS AND FUTUNA", iso3: 'wlf', displayName: "Wallis and Futuna"),
  Country(id: 246, iso2: 'eh', numCode: 732, name: "WESTERN SAHARA", iso3: 'esh', displayName: "Western Sahara"),
  Country(id: 247, iso2: 'ye', numCode: 887, name: "YEMEN", iso3: 'yem', displayName: "Yemen"),
  Country(id: 248, iso2: 'zm', numCode: 894, name: "ZAMBIA", iso3: 'zmb', displayName: "Zambia"),
  Country(id: 249, iso2: 'zw', numCode: 716, name: "ZIMBABWE", iso3: 'zwe', displayName: "Zimbabwe"),
  Country(id: 250, iso2: 'ax', numCode: 248, name: "ÅLAND ISLANDS", iso3: 'ala', displayName: "Åland Islands")
];
