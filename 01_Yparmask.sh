#!/bin/bash
#
#SBATCH --job-name=ypar_mask
#SBATCH --partition=satpathy
#SBATCH --time=72:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=8G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jacobog


ml biology
ml bedtools


## This scripts a cellranger reference directory and then spits out a new Ypar_masked cellranger reference
ranger_ref="/home/groups/satpathy/software/cellranger_arc_v2/refdata-cellranger-arc-GRCh38-2020-A-2.0.0"

par_bed="Y_PAR.bed"


mkdir -p masked_fa

out_fa="masked_fa/cellranger_hg38_YPAR_mask.fa"

## Make a quick mask 
bedtools maskfasta -fi ${ranger_ref}/fasta/genome.fa -bed $par_bed -fo ${out_fa}


## Dont think I need to update the gtf file??? The Y genes are still annotated but not gonna be mapped tis chill for XY donors... 

ranger_path=/home/groups/satpathy/software/cellranger-7.0.0/bin/cellranger

$ranger_path mkref --genome=hg38_ypar_masked --fasta=${out_fa} --genes=${ranger_ref}/genes/genes.gtf.gz \
--memgb=64 --nthreads=8



