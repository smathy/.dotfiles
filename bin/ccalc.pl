#!/usr/bin/perl
use warnings;
use strict;

my %multiplier = ( month => 12, year => 1, day => 365.24, week => 52.2 );

my $period = 'month';

my $p = 4000;	# initial deposit
my $c = 4000;	# periodic contribution
my $r = 50;	# annual interest rate
my $t = 1;	# term in years

use Getopt::Long;
GetOptions( "initial=f" => \$p, "contribution=f" => \$c, "rate=f" => \$r, "term=f" => \$t, "period=s" => \$period);

die unless exists $multiplier{$period};

my $rate = $r / $multiplier{$period};
my $term = $t * $multiplier{$period};

$rate /= 100;

my $z = $rate + 1;

my $final = $p * $z**$term + $c * (( $z**($term+1)  - $z) / $rate ) - $c*$rate;

printf "\$%0.2f" => $p;
if( $c > 0 ) {
	printf " (plus \$%0.2f per %s)" => $c, $period;
}
printf " at %d%% p.a. accrued %sly for %d year%s gives...\n" => $r, $period, $t, ( $t == 1 ? '' : 's' );
print '$'. commafy( sprintf( "%0.2f" => $final)). "\n";

sub commafy
{
	my $number = reverse shift;
	$number =~ s/([^.]{3})(?=.)/$1,/g;
	reverse $number;
}
