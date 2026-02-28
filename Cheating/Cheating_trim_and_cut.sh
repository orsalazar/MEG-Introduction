#!/bin/bash --login
#SBATCH -J Trimgalore
#SBATCH -c 12
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=ALL
#SBATCH --mail-user=octavio.salazarmoya@kaust.edu.sa
#SBATCH -o summary_%J_%N.out
#SBATCH -e error_log_%J_%N.out
#SBATCH --mem=60G
#SBATCH --time=02-00:00:00

module load trimgalore

# Create an output directory so files stay organized
mkdir -p trimmed_and_cut_output

# Loop through all files ending in _R1.fq.gz
for r1_file in *_R1.fq.gz
do
    # Determine the matching R2 filename by replacing _R1 with _R2
    r2_file="${r1_file/_R1/_R2}"

    # Check if the R2 file actually exists before running
    if [[ -f "$r2_file" ]]; then
        echo "Processing: $r1_file and $r2_file"

        trim_galore --paired \
                    --fastqc \
                    --cores 12 \
                    --output_dir trimmed_and_cut_output \
                    --clip_R1 10 \
                    --clip_R2 10 \
                    --three_prime_clip_R1 5 \
                    --three_prime_clip_R2 5 \
                    "$r1_file" "$r2_file"
    else
        echo "Warning: Could not find matching R2 for $r1_file"
    fi
done

echo "All samples processed!"

echo 'Finished'
