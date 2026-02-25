#!/bin/bash --login
#SBATCH -J Trimgalore
#SBATCH -c 4
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=ALL
#SBATCH --mail-user=octavio.salazarmoya@kaust.edu.sa
#SBATCH -o summary_%J_%N.out
#SBATCH -e error_log_%J_%N.out
#SBATCH --mem=60G
#SBATCH --time=02-00:00:00

module load trimgalore

trim_galore --paired AReads_R1.fastq AReads_R2.fastq --fastqc --cores 4 --length 75 --clip_R1 10 --clip_R2 10 --three_prime_clip_R1 5 --three_prime_clip_R2 5 -o Trimmed_readsClipped


echo 'Finished'
