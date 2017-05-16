#!/usr/bin/perl

#Perl Homework 2 - Task B
#Carey Metheringham
#gtf_clm79.pl
#created 18.04.17
#last edited 23.04.17

#A Perl script which, after loading its corresponding package GTFclm79.pm and its relevant subroutines:
#Reports results as directed by flags. 
#If run with -g if reports the number of genes in the gtf file. 
#If run with –e it reports the number of exons. 
#If run with –a it reports the average exon length. 
#If run with –n it reports the gene with the highest number of exons
#If run with –h it prints out some helpful instructions.

use strict;
use warnings;
#Import module containing subroutines
use GTFclm79;
#Import the Getopt module for command line options and specify flags
use Getopt::Std;
use vars qw($opt_g $opt_e $opt_a $opt_n $opt_h); 
getopts ('geanhx:'); #without the additional 'x' flag the h command does not run

#Specify file to be opened
my $gtf = "genes.gtf";

#open the .gtf file and read line by line into array 
open(GTF_FILE,"$gtf") or die "Cannot open file $gtf\n\n";
my @gtf_file = <GTF_FILE>; #This is not an ideal step
close (GTF_FILE);

#Call relevent subroutines from module and print output to STDOUT
#Separating flags int subroutines means that the program will not
#have to count genes when asked for the number of exons.
#However if multiple flags are used then some calculations may need to be
#performed multiple times.

if ($opt_g){
	print "Number of genes: " . &count_genes (@gtf_file) . "\n";
}
if ($opt_e){
	print "Number of exons: " . &count_exons (@gtf_file) . "\n";
}
if ($opt_a){
	printf "Average exon length: %3.2f bp \n", &average_exon (@gtf_file);
}
if ($opt_n){
#This subroutine returns two values stored in an array, which are accessed by reference 
	my @most_exons = &most_exons (@gtf_file);
	print "The gene with the highest number of exons is " . $most_exons[0] . "\n"; #TO DO!!!
	print " with " . $most_exons[1] . " exons \n";
}
#Print information about the script
if ($opt_h){ 
	print "This script counts entries in a gtf file. \n"; 
	print "Run with -g to count genes, -e to count exons, \n"; 
	print "-a to report average exon length or -n to find \n";
	print "the gene with the highest number of exons \n";
}
