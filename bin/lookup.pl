#!/usr/bin/perl

use strict;
use warnings;

my $switch = 'dst';

use Net::Whois::IP 'whoisip_query';
my $ip = shift;

my %lookup = setup();

if( $ip !~ /^(?:\d{1,3}\.){3}\d{1,3}$/ )
{
   use Socket;
   $ip = join '.' => unpack(C4 => gethostbyname($ip));
}

my($hr) = whoisip_query($ip);

my($country,$state) = ('','');
for(keys %$hr)
{
   /country/i        and $country = $hr->{$_};
   /state|province/i and $state = $hr->{$_};
}

print "$state, $lookup{lc $country}\n";
if( lc $country eq 'us' )
{
   my %tz = timezones();
   print "Time = ". scalar gmtime(time + 3600 * $tz{uc $state}{$switch}). "\n";
}

sub setup
{
   ( ad => 'Andorra, Principality of'
   , ae => 'United Arab Emirates'
   , af => 'Afghanistan, Islamic State of'
   , ag => 'Antigua and Barbuda'
   , ai => 'Anguilla'
   , al => 'Albania'
   , am => 'Armenia'
   , an => 'Netherlands Antilles'
   , ao => 'Angola'
   , aq => 'Antarctica'
   , ar => 'Argentina'
   , arpa => 'Old style Arpanet'
   , as => 'American Samoa'
   , at => 'Austria'
   , au => 'Australia'
   , aw => 'Aruba'
   , az => 'Azerbaidjan'
   , ba => 'Bosnia-Herzegovina'
   , bb => 'Barbados'
   , bd => 'Bangladesh'
   , be => 'Belgium'
   , bf => 'Burkina Faso'
   , bg => 'Bulgaria'
   , bh => 'Bahrain'
   , bi => 'Burundi'
   , bj => 'Benin'
   , bm => 'Bermuda'
   , bn => 'Brunei Darussalam'
   , bo => 'Bolivia'
   , br => 'Brazil'
   , bs => 'Bahamas'
   , bt => 'Bhutan'
   , bv => 'Bouvet Island'
   , bw => 'Botswana'
   , by => 'Belarus'
   , bz => 'Belize'
   , ca => 'Canada'
   , cc => 'Cocos (Keeling) Islands'
   , cf => 'Central African Republic'
   , cd => 'Congo, The Democratic Republic of the'
   , cg => 'Congo'
   , ch => 'Switzerland'
   , ci => 'Ivory Coast'
   , ck => 'Cook Islands'
   , cl => 'Chile'
   , cm => 'Cameroon'
   , cn => 'China'
   , co => 'Colombia'
   , com => 'Commercial'
   , cr => 'Costa Rica'
   , cs => 'Former Czechoslovakia'
   , cu => 'Cuba'
   , cv => 'Cape Verde'
   , cx => 'Christmas Island'
   , cy => 'Cyprus'
   , cz => 'Czech Republic'
   , de => 'Germany'
   , dj => 'Djibouti'
   , dk => 'Denmark'
   , dm => 'Dominica'
   , do => 'Dominican Republic'
   , dz => 'Algeria'
   , ec => 'Ecuador'
   , edu => 'Educational'
   , ee => 'Estonia'
   , eg => 'Egypt'
   , eh => 'Western Sahara'
   , er => 'Eritrea'
   , es => 'Spain'
   , et => 'Ethiopia'
   , fi => 'Finland'
   , fj => 'Fiji'
   , fk => 'Falkland Islands'
   , fm => 'Micronesia'
   , fo => 'Faroe Islands'
   , fr => 'France'
   , fx => 'France (European Territory)'
   , ga => 'Gabon'
   , gb => 'Great Britain'
   , gd => 'Grenada'
   , ge => 'Georgia'
   , gf => 'French Guyana'
   , gh => 'Ghana'
   , gi => 'Gibraltar'
   , gl => 'Greenland'
   , gm => 'Gambia'
   , gn => 'Guinea'
   , gov => 'USA Government'
   , gp => 'Guadeloupe (French)'
   , gq => 'Equatorial Guinea'
   , gr => 'Greece'
   , gs => 'S. Georgia & S. Sandwich Isls.'
   , gt => 'Guatemala'
   , gu => 'Guam (USA)'
   , gw => 'Guinea Bissau'
   , gy => 'Guyana'
   , hk => 'Hong Kong'
   , hm => 'Heard and McDonald Islands'
   , hn => 'Honduras'
   , hr => 'Croatia'
   , ht => 'Haiti'
   , hu => 'Hungary'
   , id => 'Indonesia'
   , ie => 'Ireland'
   , il => 'Israel'
   , in => 'India'
   , int => 'International'
   , io => 'British Indian Ocean Territory'
   , iq => 'Iraq'
   , ir => 'Iran'
   , is => 'Iceland'
   , it => 'Italy'
   , jm => 'Jamaica'
   , jo => 'Jordan'
   , jp => 'Japan'
   , ke => 'Kenya'
   , kg => 'Kyrgyz Republic (Kyrgyzstan)'
   , kh => 'Cambodia, Kingdom of'
   , ki => 'Kiribati'
   , km => 'Comoros'
   , kn => 'Saint Kitts & Nevis Anguilla'
   , kp => 'North Korea'
   , kr => 'South Korea'
   , kw => 'Kuwait'
   , ky => 'Cayman Islands'
   , kz => 'Kazakhstan'
   , la => 'Laos'
   , lb => 'Lebanon'
   , lc => 'Saint Lucia'
   , li => 'Liechtenstein'
   , lk => 'Sri Lanka'
   , lr => 'Liberia'
   , ls => 'Lesotho'
   , lt => 'Lithuania'
   , lu => 'Luxembourg'
   , lv => 'Latvia'
   , ly => 'Libya'
   , ma => 'Morocco'
   , mc => 'Monaco'
   , md => 'Moldavia'
   , mg => 'Madagascar'
   , mh => 'Marshall Islands'
   , mil => 'USA Military'
   , mk => 'Macedonia'
   , ml => 'Mali'
   , mm => 'Myanmar'
   , mn => 'Mongolia'
   , mo => 'Macau'
   , mp => 'Northern Mariana Islands'
   , mq => 'Martinique (French)'
   , mr => 'Mauritania'
   , ms => 'Montserrat'
   , mt => 'Malta'
   , mu => 'Mauritius'
   , mv => 'Maldives'
   , mw => 'Malawi'
   , mx => 'Mexico'
   , my => 'Malaysia'
   , mz => 'Mozambique'
   , na => 'Namibia'
   , nato => 'NATO (this was purged in 1996 - see hq.nato.int)'
   , nc => 'New Caledonia (French)'
   , ne => 'Niger'
   , net => 'Network'
   , nf => 'Norfolk Island'
   , ng => 'Nigeria'
   , ni => 'Nicaragua'
   , nl => 'Netherlands'
   , no => 'Norway'
   , np => 'Nepal'
   , nr => 'Nauru'
   , nt => 'Neutral Zone'
   , nu => 'Niue'
   , nz => 'New Zealand'
   , om => 'Oman'
   , org => 'Non-Profit Making Organisations (sic)'
   , pa => 'Panama'
   , pe => 'Peru'
   , pf => 'Polynesia (French)'
   , pg => 'Papua New Guinea'
   , ph => 'Philippines'
   , pk => 'Pakistan'
   , pl => 'Poland'
   , pm => 'Saint Pierre and Miquelon'
   , pn => 'Pitcairn Island'
   , pr => 'Puerto Rico'
   , pt => 'Portugal'
   , pw => 'Palau'
   , py => 'Paraguay'
   , qa => 'Qatar'
   , re => 'Reunion (French)'
   , ro => 'Romania'
   , ru => 'Russian Federation'
   , rw => 'Rwanda'
   , sa => 'Saudi Arabia'
   , sb => 'Solomon Islands'
   , sc => 'Seychelles'
   , sd => 'Sudan'
   , se => 'Sweden'
   , sg => 'Singapore'
   , sh => 'Saint Helena'
   , si => 'Slovenia'
   , sj => 'Svalbard and Jan Mayen Islands'
   , sk => 'Slovak Republic'
   , sl => 'Sierra Leone'
   , sm => 'San Marino'
   , sn => 'Senegal'
   , so => 'Somalia'
   , sr => 'Suriname'
   , st => 'Saint Tome (Sao Tome) and Principe'
   , su => 'Former USSR'
   , sv => 'El Salvador'
   , sy => 'Syria'
   , sz => 'Swaziland'
   , tc => 'Turks and Caicos Islands'
   , td => 'Chad'
   , tf => 'French Southern Territories'
   , tg => 'Togo'
   , th => 'Thailand'
   , tj => 'Tadjikistan'
   , tk => 'Tokelau'
   , tm => 'Turkmenistan'
   , tn => 'Tunisia'
   , to => 'Tonga'
   , tp => 'East Timor'
   , tr => 'Turkey'
   , tt => 'Trinidad and Tobago'
   , tv => 'Tuvalu'
   , tw => 'Taiwan'
   , tz => 'Tanzania'
   , ua => 'Ukraine'
   , ug => 'Uganda'
   , uk => 'United Kingdom'
   , um => 'USA Minor Outlying Islands'
   , us => 'United States'
   , uy => 'Uruguay'
   , uz => 'Uzbekistan'
   , va => 'Holy See (Vatican City State)'
   , vc => 'Saint Vincent & Grenadines'
   , ve => 'Venezuela'
   , vg => 'Virgin Islands (British)'
   , vi => 'Virgin Islands (USA)'
   , vn => 'Vietnam'
   , vu => 'Vanuatu'
   , wf => 'Wallis and Futuna Islands'
   , ws => 'Samoa'
   , ye => 'Yemen'
   , yt => 'Mayotte'
   , yu => 'Yugoslavia'
   , za => 'South Africa'
   , zm => 'Zambia'
   , zr => 'Zaire'
   , zw => 'Zimbabwe'
   );
}

sub timezones
{
   ( AL => { std => -6, dst => -5 }
   , AK => { std => -9, dst => -8 }
   , AZ => { std => -7, dst => -7 }
   , AR => { std => -6, dst => -5 }
   , CA => { std => -8, dst => -7 }
   , CO => { std => -7, dst => -6 }
   , CT => { std => -5, dst => -4 }
   , DE => { std => -5, dst => -4 }
   , FL => { std => -5, dst => -4 }
   , GA => { std => -5, dst => -4 }
   , HI => { std => -10,dst => -10}
   , ID => { std => -7, dst => -6 }
   , IL => { std => -6, dst => -5 }
   , IN => { std => -5, dst => -4 }
   , IA => { std => -6, dst => -5 }
   , KS => { std => -6, dst => -5 }
   , KY => { std => -5, dst => -4 }
   , LA => { std => -6, dst => -5 }
   , ME => { std => -5, dst => -4 }
   , MD => { std => -5, dst => -4 }
   , MA => { std => -5, dst => -4 }
   , MI => { std => -5, dst => -4 }
   , MN => { std => -6, dst => -5 }
   , MS => { std => -6, dst => -5 }
   , MO => { std => -6, dst => -5 }
   , MT => { std => -7, dst => -6 }
   , NE => { std => -6, dst => -5 }
   , NV => { std => -8, dst => -7 }
   , NH => { std => -5, dst => -4 }
   , NJ => { std => -5, dst => -4 }
   , NM => { std => -7, dst => -6 }
   , NY => { std => -5, dst => -4 }
   , NC => { std => -5, dst => -4 }
   , ND => { std => -6, dst => -5 }
   , OH => { std => -5, dst => -4 }
   , OK => { std => -6, dst => -5 }
   , OR => { std => -8, dst => -7 }
   , PA => { std => -5, dst => -4 }
   , RI => { std => -5, dst => -4 }
   , SC => { std => -5, dst => -4 }
   , SD => { std => -6, dst => -5 }
   , TN => { std => -6, dst => -5 }
   , TX => { std => -6, dst => -5 }
   , UT => { std => -7, dst => -6 }
   , VT => { std => -5, dst => -4 }
   , VA => { std => -5, dst => -4 }
   , WA => { std => -8, dst => -7 }
   , WV => { std => -5, dst => -4 }
   , WI => { std => -6, dst => -5 }
   , WY => { std => -7, dst => -6 }
   );
}
