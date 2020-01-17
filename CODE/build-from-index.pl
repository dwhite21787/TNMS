#!/usr/bin/perl -w

use strict;
use Email::Find ;
use vars qw( %raw %norm $issue $name );

my $l=0;
while (<>) {
	chomp;
	my @n = split(/"/,$_);
	if ($#n > 0) {
	    $name = $n[1];
	    my @s = split(/:/,$_,3);
	    $s[2] =~ s/<\/A>$//g; # strip closing tag
	    $raw{$s[2]} .= "$name\t";
        }
	$l = $.;
}

print STDERR "$0 : read $l lines, holding ", (scalar keys(%raw)), " subjects\n";

my %auths;
for my $k ( keys %raw) {
             my $email = $k;
	     my @r = split(/\t/,$raw{$k});
	     my @p= split(/\@/,$email,2);
	     my @b=split(/[< ]/,$p[0]);
	     my @a=split(/[> ]/,$p[1]);
	     chop $a[0]; chop $a[0]; chop $a[0]; $a[0] = "$a[0]***";
	     $email = "$b[$#b]\@$a[0]";
	     $email =~ s/\"//g;
	     $email =~ s/\'//g;
	     $email =~ s/^\s+|\s+$//g ; #remove lead and trailing spaces
	     $email = lc($email);
	     # print "<BR>\t\"$email\"\t - in issue(s) \t";
	     for my $ref (@r) {
		my $i = int($ref/1000);
		my $issue=sprintf("%04d",$i);
		$auths{$email} .= "<A HREF=\"html/nms_$issue.html#$ref\">\#$i</A> ";
	     }
}
print "<HTML><HEAD><TITLE>National Midnight Star authors, alpha</TITLE></HEAD>\n <BODY> <H1 ALIGN=CENTER>NMS Archive Authors<P>Alphabetical Order</H1>\n <P><A HREF=\"index.htm\">All Indices</A></P>\n <P><HR>\n";
for my $a (sort {lc($a) cmp lc($b)} keys %auths) {
	print "<P> \"$a\" - in issues $auths{$a} \n";
}
print " </BODY></HTML>\n";

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

