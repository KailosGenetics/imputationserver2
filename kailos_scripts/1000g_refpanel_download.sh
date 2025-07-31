#!/bin/bash

# Script to download 1000 Genomes Project VCF files for chromosomes 1-22
# Phase 3 data from the 20130502 release

mkdir /home/ec2-user/imputationserver2/tests/data/refpanels/1000g
mkdir /home/ec2-user/imputationserver2/tests/data/refpanels/1000g/bcf
cd /home/ec2-user/imputationserver2/tests/data/refpanels/1000g/bcf

# Loop through chromosomes 1-22
for chr in {1..22}; do
    echo "Downloading chromosome ${chr}..."
    
    # Download the VCF file
    wget -q --show-progress http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi

    # Download the tabix index file
    wget -q --show-progress http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz    
 
    echo "Completed chromosome ${chr}"
    echo ""
done
