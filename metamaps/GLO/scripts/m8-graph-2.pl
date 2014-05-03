#!/usr/bin/env perl

use strict;
use v5.10;
use autodie;
use REST::Neo4p;
use REST::Neo4p::Query;
REST::Neo4p->connect($server);

my %basetaxahash;


open INPUT, $ARGV[0];
while(<>) { 
if($. != 1) { 
    chomp;
    my ($read, $gi, $basetaxa, $bitscore)  = split /\t/;
    $basetaxahash{$basetaxa}++;
    }
}

my $stmt='start basetaxa=node:ncbitaxid(taxid={taxids}) match basetaxa-[:childof*]->(genus:`genus`) return genus.taxid';

foreach my $basetaxa (keys %basetaxahash) {
	my $query = REST::Neo4p::Query->new($stmt,{ taxids => $basetaxa });
	$query->execute;
	while (my $result = $query->fetch) {
		$basetaxahash{$basetaxa} = $result->[0]; #i need to not push empty returns
	}
    }

foreach (keys %basetaxahash) { 
   say "$basetaxahash{$_}\t
