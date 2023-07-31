#!/usr/bin/perl -w
#Create a supermatrix from single copy orthologs identified by OrthoFinder
#use strict;

#List of sing-copy-orthologs orthogroups in fasta format present in the Single_Copy_Orthologue_Sequences folder
$cmd="mkdir Single_Copy_Orthologue_Sequences_mafft";
system($cmd);
@Gene=('OG0006856','OG0006865','OG0006867','OG0006869','OG0006871','OG0006874','OG0006877','OG0006878','OG0006883','OG0006885','OG0006895','OG0006896','OG0006903','OG0006907','OG0006908','OG0006910','OG0006914','OG0006916','OG0006917','OG0006918','OG0006921','OG0006926','OG0006928','OG0006937','OG0006938','OG0006940','OG0006942','OG0006949','OG0006953','OG0006954','OG0006955','OG0006957','OG0006960','OG0006961','OG0006962','OG0006965','OG0006971','OG0006974','OG0006975','OG0006979','OG0006985','OG0006988','OG0006990','OG0006999','OG0007000','OG0007001','OG0007008','OG0007009','OG0007010','OG0007013','OG0007021','OG0007025','OG0007026','OG0007032','OG0007036','OG0007039','OG0007045','OG0007047','OG0007048','OG0007049','OG0007051','OG0007053','OG0007055','OG0007060','OG0007064','OG0007067','OG0007070','OG0007073','OG0007074','OG0007076','OG0007078','OG0007079','OG0007085','OG0007087','OG0007090','OG0007098','OG0007099','OG0007106','OG0007108');
for($g=0;$g<@Gene;$g++){
  print "$Gene[$g]\n";
  $cmd="mafft --auto Single_Copy_Orthologue_Sequences/$Gene[$g].fa >Single_Copy_Orthologue_Sequences_mafft/$Gene[$g].fa";
  system ($cmd);
  }

#List of species
@Sp=('Apis_cerana','Apis_dorsata','Apis_florea','Apis_laboriosa','Apis_mellifera','Bacterocera_dorsalis','Bombus_affinis','Bombus_impatiens','Bombus_pyrosoma','Braula_coeca','Ceratitis_capitata','Ceratina_calcarata','Colletes_gigas','Drosophila_busckii','Drosophila_grimshawi','Drosophila_melanogaster','Drosophila_mojavensis','Drosophila_pseudoobscura','Drosophila_virilis','Drosophila_willistoni','Diachasma_alloeum','Dufourea_novaeangliae','Ephydra_gracilis','Eufriesea_mexicana','Fopius_arisanus','Frieseomelitta_varia','Habropoda_laboriosa','Hylaeus_anthracinus','Lucilia_cuprina','Leptopilina_boulardi','Leucophenga_varia','Megachile_rotundata','Megalopta_genalis','Monomorium_pharaonis','Nasonia_vitripennis','Nomia_melanderi','Osmia_bicornis','Phortica_variegata','Rhagleotis_pomonella','Stomoxys_calcitrans','Scaptodrosophila_lebanonensis','Vespula_vulgaris');
#Supermatrix file
$outfile= ">Supermatrix_SCOS_May10.fa";
open(O,$outfile);

for($g=0;$g<@Gene;$g++){
  $l=0;
  $infile = "Single_Copy_Orthologue_Sequences_mafft/".$Gene[$g].".fa";
  open(F,$infile);
  while(<F>){
    chomp;
    @line=split('',$_);
    if($line[0] eq '>'){
      $outfile1= ">>$Sp[$l].fa";
      open(O1,$outfile1);
      $l++;
      }
    else{
      print O1 "$_";
      }
    }
  }

close(O1);

for($j=0;$j<@Sp;$j++){
  $infile1 = "$Sp[$j].fa";
  open(F1,$infile1);
  while(<F1>){
    chomp;
    print O ">$Sp[$j]\n$_\n";
    }
  }

close(O);

exit;