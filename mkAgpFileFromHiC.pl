#!/usr/bin/perl 

use strict;
use warnings;
use Bio::SeqIO;

## we must use 2 command line arguments, or else exit program

unless(@ARGV==2){
    die "usage: $0 <assembly.FINAL.fasta> <assembly.FINAL.assembly> \n"; 
}

## import assembly fasta file, store data in arrays

my $seqio = Bio::SeqIO->new(-file=>"$ARGV[0]",-format=>"fasta"); 

my @dna_array;
my @names_array;
my @seq_array; 
while ( my $seq = $seqio->next_seq() ) {
    push @dna_array, $seq->seq();
    push @names_array, $seq->id();
    push @seq_array, $seq;
}

## parse .assembly file in order to build an AGP file

my %partsHash;
my $lineNum = 0;

my $input = "$ARGV[1]";
open(my $in, '<', $input) or die "Could not open file '$input' $!";
while(my $line = <$in>){
    chomp $line;
    my @row = split ' ', $line; 
    my $firstChar = substr($line, 0, 1);
    if($firstChar eq '>'){
        my $partName = $row[0];
	$partName =~ s/^.//s;
        my $partNum = $row[1];
        my $partLen = $row[2];
	$partsHash{$partNum} = "$partName $partLen";		
    }else{
        my $contigName = $names_array[$lineNum];
	my $contigLen = length($dna_array[$lineNum]);
	my $pos = 1;
	my $ind = 1;
	for(my $i=0; $i<scalar @row; $i++){
	    my $partNum = $row[$i];	
	    my $partNameLen = $partsHash{$partNum};
	    my @vals = split ' ' , $partNameLen;
	    my $partName = $vals[0];
	    my $partLen = $vals[1];
	    my $compT;
	    my $field6;
	    my $field7; 
	    my $field8;
	    my $field9;
	    if($partName =~ /hic_gap/){
	        $compT = 'N';	
		$field6 = $partLen;
		$field7 = "scaffold";
		$field8 = "yes";
		$field9 = "paired-ends";
	    }else{
                $compT = 'W';	
		$field6 = $partName;
		$field7 = 1;
		$field8 = $partLen;
		$field9 = "+";
            }
	    my $p_end = $pos + $partLen - 1 ;			
            print "$contigName\t$pos\t$p_end\t$ind\t$compT\t$field6\t$field7\t$field8\t$field9\n";
            $pos = $pos + $partLen ;
	    $ind++;
        }		
	$pos = $pos - 1;
	die "$pos  $contigLen"  if($pos != $contigLen); # defensive programming					
	$lineNum++;		
    }	
}	

close $in;


