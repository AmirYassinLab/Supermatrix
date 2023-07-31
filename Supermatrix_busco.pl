#!/usr/bin/perl -w
#Create a supermatrix for single-copy conserved busco genes
#use strict;

#List of species and proteomes
@Species=('Ephydra_gracilis','Acletoxenus_sp','Braula_coeca','Cacoxenus_indagator','Chymomyza_costata','Drosophila_busckii','Drosophila_grimshawi','Drosophila_melanogaster','Drosophila_mojavensis','Drosophila_pseudoobscura','Drosophila_virilis','Drosophila_willistoni','Leucophenga_varia','Phortica_variegata','Rhinoleucophenga_sp','Scaptodrosophila_lebanonensis','Cryptochetum_sp','Curtonotum_sp','Diastata_repleta','Stegana_sp');
@Genomes=('Ephydra_gracilis_GCA_001014675.1_ASM101467v1_genomic.fna','Acletoxenus-busco','Braula','Cacoxenus_indagator_350_busco','Chymomyza_costata_GCA_018150985.1_ASM1815098v1_genomic.fna','Drosophila_busckii__GCA_011750605.1_ASM1175060v1_genomic.fna','Drosophila_grimshawi','Drosophila_melanogaster','Drosophila_mojavensis','Drosophila_pseudoobscura','Drosophila_virilis','Drosophila_willistoni','Leucophenga_varia_GCA_018903435.1_ASM1890343v1_genomic.fna','Phortica_variegata','Rhinoleucophenga350_busco','Scaptodrosophila_lebanonensis','busco_Cryptochetum_sp.fna','busco_Curtonotum_sp.fna','busco_Diastata_repleta.fna','busco_Stegana_sp.fna');

$cmd="mkdir Busco_seq";
system($cmd);
for($s=0;$s<@Species;$s++){
  print "$Species[$s]\n";
#The Braula_SCO_summary.txt file is a file with a single column containing the name of the single-copy busco genes in Braula coeca
  $input="Braula/run_diptera_odb10/busco_sequences/single_copy_busco_sequences/Braula_SCO_summary.txt";
  open(I,$input);
  while(<I>){
    chomp;
    $output=">>Busco_seq/$_";
    open(O,$output);
    print O ">$Species[$s]\n";
    $seq="$Genomes[$s]/run_diptera_odb10/busco_sequences/single_copy_busco_sequences/$_";
    open(S,$seq);
    while(<S>){
      chomp;
      @line=split('',$_);
      unless($line[0] eq '>'){
        print O "$_\n";
        }
      }
    close(S);
    }
  }

close(I);

$cmd="mkdir Busco_seq_aln";
system($cmd);
$input="Braula/run_diptera_odb10/busco_sequences/single_copy_busco_sequences/Braula_SCO_summary.txt";
open(I,$input);
while(<I>){
  chomp;
  print "$_\n";
  $cmd="mafft --auto Busco_seq/".$_." >Busco_seq_aln/".$_."_aln.fas";
  system($cmd);
  }
close(I);

$cmd="mkdir Busco_seq_aln_sp";
system($cmd);
$input="Braula/run_diptera_odb10/busco_sequences/single_copy_busco_sequences/Braula_SCO_summary.txt";
open(I,$input);
while(<I>){
  chomp;
  print "$_\n";
  $gene="Busco_seq_aln/".$_."_aln.fas";
  open(G,$gene);
  while(<G>){
    chomp;
    @line=split('',$_);
    if($line[0] eq '>'){
      @name=@line[1..@line-1];
      $name=join('',@name);
      $outfile=">>Busco_seq_aln_sp/$name.txt";
      open(O,$outfile);
      }
    else{
      print O "$_\n";
      }
    }
  close(G);
  }
close(G);

$output=">Ephydroidea.fas";
open(O,$output);
for($s=0;$s<@Species;$s++){
  print "$Species[$s]\n";
  print O ">$Species[$s]\n";
  $input="Busco_seq_aln_sp/$Species[$s].txt";
  open(I,$input);
  while(<I>){
    chomp;
    print O "$_";
    }
  print O "\n";
  close(I);
  }

exit;
