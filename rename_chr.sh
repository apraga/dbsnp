# Rename chromsomes from Refseq to "chr" notation
# Assume the genome is in ../genome-human
# Source : https://www.biostars.org/p/410789/ 
table=../genome-human/GCF_000001405.26_GRCh38_assembly_report.txt

grep -e '^[^#]' $table | awk  -F $'\t' '{print $7, $10}' > mapping_from_refseq.txt

bcftools annotate \
  --rename-chrs mapping_from_refseq.txt \
  --threads 10 -Oz \
  -o "GCF_000001405.40_chr.gz" \
  "GCF_000001405.40.gz"

# Create index
bcftools index \
  --tbi \
  --threads 10 \
  "GCF_000001405.40_chr.gz"
k
