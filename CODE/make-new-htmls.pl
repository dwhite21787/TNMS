#!/usr/bin/perl -w

use strict;
use Getopt::Std;
use vars qw( $fname $opt_f $opt_d );

getopts("d:f:") or die "Usage: $0 -f NMS_txtfile -d HTML_dir\n";
($opt_d)  or die "Usage: $0 -f NMS_txtfile -d HTML_dir\n";
($opt_f)  or die "Usage: $0 -f NMS_txtfile -d HTML_dir\n";
(-e "$opt_f") or die "$0 : no file $opt_f\n";
(-e "$opt_d") or die "$0 : no directory $opt_d\n";

my $outfile = "$opt_f";
$outfile =~ s/\.txt/\.html/ ;
$outfile = "$opt_d/$outfile";
if (-e "$outfile") { die "$0 : will not overwrite $outfile\n"; }

my $issNum = substr($opt_f, -8,4);
my $prev = sprintf("%04d", $issNum - 1);
my $x = $issNum - 1;
while (($x > 1) && (! -e "nms_$prev.txt")) {
	$x--;
        $prev = sprintf("%04d", $x);
}
my $next = sprintf("%04d", $issNum + 1);
$x = $issNum + 1;
while (($x < 2300) && (! -e "nms_$next.txt")) {
	$x++;
        $next = sprintf("%04d", $x);
}
my $linkNum = $issNum*1000;
my $addrNum = $issNum*1000 + 300;

open(FOUT,">$outfile") or die "$0 : cannot open $outfile for writing\n";
if (! open(FIN,"$opt_f") ) { close(FOUT); die "$0 : cannot open $opt_f for reading\n"; }

print FOUT "<HTML><HEAD><TITLE>National Midnight Star #$issNum</TITLE></HEAD>\n<BODY><P><A HREF=\"../index.htm\">Site indices</A><P><A HREF=\"nms_$prev.html\">Previous</A> Issue <->  <A HREF=\"nms_$next.html\">Next</A> Issue\n<P>\n<HR>\n<PRE>\n ";

while(<FIN>) {
    my $l = $_;
    chomp $l;
    $l =~ s/\r//g;
    $l =~ s/\&gt;/>/g;
    $l =~ s/\&lt;/</g;
    if ($l =~ /Subject\:/ ) {
	    $l = "<A NAME=\"$linkNum\">$l</A>";
	    $linkNum++;
    }
    if ($l =~ /From\:/ ) {
	    $l = "<A NAME=\"$addrNum\">$l</A>";
	    $addrNum++;
    }
    print FOUT "$l\n";
}
close(FIN);

print FOUT "</PRE>\n<P><HR>\n<P><A HREF=\"nms_$prev.html\">Previous</A> Issue <->  <A HREF=\"nms_$next.html\">Next</A> Issue <P>\n</HTML>";
close(FOUT);

exit; 

__END__

<HTML><HEAD><TITLE>National Midnight Star #212</TITLE></HEAD>
<BODY><P><A HREF="../index.htm">Site indices</A><P><A HREF="nms_211.htm">Previous</A> Issue <->  <A HREF="nms_213.htm">Next</A> Issue
<P>
<HR>
<PRE>
Errors-To: rush-request@syrinx.umd.edu
Reply-To: rush@syrinx.umd.edu
Sender: rush-request@syrinx.umd.edu
Precedence: bulk
From: rush@syrinx.umd.edu
To: rush_mailing_list@syrinx.umd.edu
<A NAME="04/12/91 - The National Midnight Star #212">Subject: 04/12/91 - The National Midnight Star #212</A>

**   ____     __           ___ ____   ___        ___       **
**    /  /_/ /_     /\  / /__/  /  / /  / /\  / /__/ /     **
**   /  / / /__    /  \/ /  /  /  / /__/ /  \/ /  / /___   **
**                                                         **
**                    __            ___       ____         **
**        /\  /\   / /  \  /\  / / /  _  /__/  /           **
**       /  \/  \ / /___/ /  \/ / /___/ /  /  /            **

********************************************
End of The National Midnight Star Number 212
********************************************


</PRE>
<P><HR>
<P><A HREF="nms_001.htm">Previous</A> Issue <->  <A HREF="nms_003.htm">Next</A> Issue <P>
</HTML>

