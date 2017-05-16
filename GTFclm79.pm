#!/usr/bin/perl

#Perl Homework 2 - Task B
#Carey Metheringham
#GTFclm79.pm
#created 18.04.17
#last edited 23.04.17

#Module for use with gtf_clm79.pl
#Takes a gtf file passed as an array and counts elements

package GTFclm79;
#include subroutines in exporter
use Exporter;
our @ISA = ("Exporter");
our @EXPORT = qw(&count_genes &count_exons &average_exon &most_exons);


#Find all genes in the file and count their exons, return as hash
sub genes {
	my %genes;
#For each line in the file find the gene id in coloumn 9
	foreach (@_){
		my @column = split("\t", $_);
		$column[8] =~ /gene_id\s"(\w+)";/;
		my $gene_name = $1;
#If the gene is in the hash and the line is an exon
#Add 1 to the gene's exon count
		if (exists $genes{$gene_name}){
			if ($column[2] eq "exon"){
			$genes{$gene_name} ++
			} 
		}
#If the gene is not allready in the hash:
#Add it and add 1 to the gene count 
		else {$genes{$gene_name} = 1; $gene_count ++;}
	}
	return %genes;
}

#Count the number of genes (keys) in the hash 
sub count_genes {
	my %genes = & genes(@_);
	my $gene_count = keys %genes;
	return $gene_count;
}

#Counts the number of exons in the file 
sub count_exons {
	my $exon_count = 0;
#For each line in the file check if the third column says 'exon'
#If so add 1 to the exon count 
	foreach (@_){
		my @column = split("\t", $_);
		if ($column[2] eq "exon"){
			$exon_count ++;
		}
	}
	return $exon_count;
}

#Calculates average exon length 
sub average_exon {
	my $exon_count;
	my $total_exon_length;
	foreach (@_){
		my @column = split("\t", $_);
		if ($column[2] eq "exon"){
			$exon_count ++;
#Use the end and start positions to calculate exon length
#and add this to the total exon length 
			my $exon_length = $column[4]-$column[3] +1;
			$total_exon_length += $exon_length;
		}

	}
#calculate the average exon length by dividing total exon length by number of exons
	return $total_exon_length/$exon_count;
}

#Find the gene with the most exons
sub most_exons {
	my $most_exons = 0;
	my $long_gene_name;
	my %genes = & genes(@_);
        while (my ($key, $value) = each %genes) {
        	if ($value > $most_exons){
			$most_exons = $value;
			$long_gene_name = $key;
		}
        }
	return ($long_gene_name, $most_exons);
}

1;
