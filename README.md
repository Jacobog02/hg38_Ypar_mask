# hg38_Ypar_mask
Recording how I make a Y chr PAR region masked fasta file for 10x cell ranger alignment


Background: 
Caleb is interested in LoY in single cell data. Our current definition of LoY for single cells is identifying 'real' cells with no Y gene RNA's detected although they have many autosomal and X chromosome RNAs detected. Our thresholding is designed in such a way that we want to remove correlation between cells with low UMIs and LoY (we cant distinguish between low data and real LoY). 


I was reading my sex chromosome genetics papers and I found this stanford study 
Zhang X, Hong D, Ma S, Ward T, Ho M, Pattni R, Duren Z, Stankov A, Bade Shrestha S, Hallmayer J, Wong WH, Reiss AL, Urban AE. Integrated functional genomic analyses of Klinefelter and Turner syndromes reveal global network effects of altered X chromosome dosage. Proc Natl Acad Sci U S A. 2020 Mar 3;117(9):4864-4873. doi: 10.1073/pnas.1910003117. Epub 2020 Feb 18. PMID: 32071206; PMCID: PMC7060706.
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7060706/

This study basically did RNA-seq on individuals with Sex chromsoome aneuploidies to observe sex gene expression patterns dependent on sex chromosome dosage. Sweet targeted scientific question love it. 

Looking at Figure2 C, there is are logFC plot across PAR1 and PAR2 comparing X0 vs XY, XX vs XY, XXXY vs XY. This gives us a clear comparision of the expected PAR expression across X monosomy, XX vs XY, and XXY vs XY such that we can assess if the PAR1 region is full 'X escape'. This means that genes in this region are not epigenetically silenced in order to maintain homeostatic X chromosome expression. Other genes on the X in TS (45,X0) have the SAME EXACT EXPRESSION AS XX AND XY, thus we can observe X compensation mechanisms for some genes but not others... (THIS WOULD MAKE A GREAT CRISPR SCREEN BTW I CAN LOOK FOR GENES THAT REGULATE NORMAL X EXPR) 

Anyway, the moral of this parable is that X monosomy has a distinguishable impact of PAR1 expression (comapring XX and XY honestly... I think I need to download their data and try this again to double check this phenomena occurs in X0 vs XX as well.. might be a highly generalizable approach. 


SO, back to LoY. We use the default cellranger pipeline and when you look at PAR1/2 gene expression we get TERRIBLE umi counts positively horrendious. My hypothesis is that we lost hella data across the PAR regions... WILL MAKE IGVF TRACKS TO SHOW THIS. I anecdoately see like ~10-30 umis for PAR genes compared to ~100's-500's of umis across the X/Y chromosomes non-PAR. Thus I think that taking on a sex chr aware alignment to recover PAR reads by mapping only to the X chromosome by hard masking the Y chr PAR regions to force alignment only to the X. This can be interpreted fairly since these regions are 100% the same sequence thus we can say we dont care about the 2 PARs (if we had long read data it would be worth to seperate in theory...) we only want to quantify the X PAR region giving one alignment contig to minimize multimapping loss. 

The data we plan to map will only be fastq's from XY individuals. This I will only make the YPAR

So the plan: 
copy the 10x default refernece and record the PAR regions to hardmask for the Y PARs


Use encode database it has the par regions in bed format on this page see `Regions`
https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.26/

Use bedtools maskfasta
https://bedtools.readthedocs.io/en/latest/content/tools/maskfasta.html

I will follow this format roughly??? 
https://github.com/SexChrLab/XY_RNAseq/blob/master/Make_references/ensembl/ReadMe_DownloadReferenceGenomes

BUT ill probably just mask while I copy the cellranger default whatever.... 

PAR#1 Y:10001-2781479
PAR#2 Y:56887903-57217415

imma manually make this here bed file sorry guys

The cellranger reference is made with on sherlock... 


```
sbatch 01_Yparmask.sh
```


