#!/usr/bin/perl -w

use strict;
use vars qw( %raw %norm $issue $name );

my $l=0;
while (<>) {
	my @n = split(/"/,$_);
	$name = $n[1];
	my @s = split(/:/,$_,3);
	$s[2] =~ s/<\/A>$//g; # strip closing tag
	$raw{$s[2]} .= "$name\t";
	$l = $.;
}

print STDERR "$0 : read $l lines, holding ", (scalar keys(%raw)), " subjects\n";

for my $k (keys %raw) {
	my $r = $k;
	$r =~ s/^\s+|\s+$//g ; #remove lead and trailing spaces
	$r =~ s/^re: //i ; # remove "Re: " from start
	$r =~ s/^\s+|\s+$//g ; #remove lead and trailing spaces
	$r =~ s/^re: //i ; # remove "Re: " from start
	$r =~ s/^re://i ; # remove "Re:" from start
	$r =~ s/\"//g;
	$r =~ s/\'//g;
	$r =~ s/^\s+|\s+$//g ; #remove lead and trailing spaces
	# $r = lc($r);
	$norm{$r} = $raw{$k};
	chop $norm{$r};
}

print STDERR "$0 : normalized ", (scalar keys(%raw)), " subjects down to ", (scalar keys(%norm)), "\n";

for my $k (sort {lc($a) cmp lc($b)} keys %norm) {
	my @r = split(/\t/,$norm{$k});
	if (
		($k !~ /national midnight star #/i ) 
	   ) {
	    print "<BR>\t\"$k\"\t - in issue(s) \t";
	    for my $ref (@r) {
		my $i = int($ref/1000);
		my $issue=sprintf("%04d",$i);
		print "<A HREF=\"tmp/nms_$issue.html#$ref\">\#$i</A> ";
	    }
	    print "\n";
	}
}

exit;

__END__
nms_0001.html:<A NAME="1018">Subject: Re:  RUSH Fans Digest of 6/27/90</A>
nms_0001.html:<A NAME="1019">Subject: Stuff from last week...</A>
nms_0001.html:<A NAME="1020">Subject: Stuff from last week part II...</A>
nms_0001.html:<A NAME="1021">Subject:  Subdivisions</A>
nms_0001.html:<A NAME="1022">Subject: order of composition</A>
nms_0001.html:<A NAME="1023">Subject: Tour Dates - Presto</A>
nms_0002.html:<A NAME="2000">Subject: RUSH Fans Digest #2</A>
nms_0002.html:<A NAME="2001">Subject: Re: RUSH Fans Digest #1</A>
nms_0002.html:<A NAME="2002">Subject: Opening acts</A>
nms_0002.html:<A NAME="2003">Subject: Cal Expo</A>
nms_0002.html:<A NAME="2004">Subject: Oops</A>
nms_0002.html:<A NAME="2005">Subject: I want my soapbox back!</A>
nms_0002.html:<A NAME="2006">Subject: Lemmie see, I thought there was soap box around here somewhere...</A>
nms_0002.html:<A NAME="2007">Subject: Re: RUSH Fans Digest of 6/27/90</A>
nms_0002.html:<A NAME="2008">Subject: RUSH on tour</A>

