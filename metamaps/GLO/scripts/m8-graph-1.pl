#!/usr/bin/env perl

use strict;
use v5.10;
use autodie;

die "Usage m8-graph.pl <rapsearch_output.m8> <gitaxid file>\n" unless $#ARGV == 1;

my ($meight, $gitaxid) = @ARGV;

#Initialise GI<->taxid hash----------------------------------------------------------------------------------------------------
my %gitaxidhash;
open GITAXID, $gitaxid; 
while(<GITAXID>) {
    chomp;
    my ($gi, $taxid) = split(/\t/);
    $gitaxidhash{$gi} = $taxid;
}
#-----------------------------------------------------------------------------------------------------------------------------

#Calls neo4j for 
my $current_query; 
my $threshold;

#open OUTPUT, join(".", $meight, "m8-graph-1.output");
say (join "\t", qw/QUERY GI BASETAXA BITSCORE/);	#HEADER

open INPUT, $meight;
while(<INPUT>){
    if(!/^\#/){	#Skips rapsearch headers
	chomp;	
	my ($qid, $sid, $identity, $alnLength, $mismatchCount, $gapOpenCount, $qStart, $qEnd, $sStart, $sEnd, $eVal, $bitScore) = split /\t/;
	
	my ($gi) = $sid =~ /^gi\|
	    (\d+)	#the GI index
	    \|/x;
	
	if($current_query eq $qid) {
	    if($bitScore >= $threshold){ 
	   	say (join "\t", $qid,$gi,$gitaxidhash{$gi},$bitScore);
	    }
	}else{
	    say (join "\t", $qid,$gi,$gitaxidhash{$gi},$bitScore);	#First entry 
	    $current_query = $qid;
	    $threshold = $bitScore * 0.8;
	}
    }
}
close INPUT;
