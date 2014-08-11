#!/usr/bin/env perl

use strict;
use v5.10;
use autodie;

die "usage: m8-graph-2.pl <m8-graph-1 output> <neo4j server address>\n" unless $#ARGV==1;

use REST::Neo4p;
use REST::Neo4p::Query;

REST::Neo4p->connect($ARGV[1]);

my %basetaxahash;

open INPUT, $ARGV[0];
while(<INPUT>) { 
if($. != 1) { #Skips header
    chomp;
    my ($read, $gi, $basetaxa, $bitscore)  = split /\t/;
    $basetaxahash{$basetaxa}++;
    }
}
say '#Basetaxa are all stored in hash ...';
say '#Now querying graphDB';

my $stmt='start basetaxa=node:ncbitaxid(taxid={taxids}) match basetaxa-[:childof*]->(genus:`genus`) return genus.taxid';

foreach my $basetaxa (keys %basetaxahash) {
	my $query = REST::Neo4p::Query->new($stmt,{ taxids => $basetaxa });
	$query->execute;
	while (my $result = $query->fetch) {
		$basetaxahash{$basetaxa} = $result->[0]; #i need to not push empty returns
	}
    }

say '#Assigned genus rank to basetaxa';

seek INPUT,0,0;

while(<INPUT>){
    chomp;
    my ($read, $gi, $basetaxa, $bitscore)  = split /\t/;
    if (/READ/){
    	say "$_\tDESIRED_RANKID";
    	
    }else{
    	say "$_\t$basetaxahash{$basetaxa}";
    }
}
close INPUT;
