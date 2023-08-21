# Downsample VCF by Lat/Long

## Overview
The python script `sample-by-coordinate.py` cross-references a multi-sample VCF with a metadata .xlsx file to 1) Make sure the VCF sample names match the metadata sample names, 2) Use a kilometer distance matrix to cluster samples by their collection sites, and 3) Downsample the VCF across geographic clusters. The script will produce three downsampled VCFs: one that is downsampled randomly, irrespective of geographic location, one that is downsampled evenly across all locations, and one that is downsampled more in some locations than in others. The intent of this script is to assess the robustness of results against smaller and less even sampling.

## Usage
```
usage: sample-by-coordinate.py [-h] --metadata METADATA
[--distance_threshold DISTANCE_THRESHOLD] [--proportion PROPORTION] 
--vcf VCF [--cores CORES] [--seed SEED]

options:
  -h, --help            show this help message and exit
  --metadata METADATA, -m METADATA
                        Metadata file with sample IDs and decimal latitudes and longitudes.
  --distance_threshold DISTANCE_THRESHOLD, -d DISTANCE_THRESHOLD
                        The maximum kilometer distance at which a new cluster should be assigned.
  --proportion PROPORTION, -p PROPORTION
                        Proportion of samples to retain in downsampling.
  --vcf VCF, -v VCF     Multisample VCF to subset.
  --cores CORES, -c CORES
                        Number of cores to use in multiprocessing.
  --seed SEED, -s SEED  Seed for random number generation.
```

## Dependencies
`sample-by-coordinate.py` uses `polars` to create DataFrames, `geopy` to compute the distances between samples, `scipy` to cluster samples by goegraphic location, `numpy` for numerical computations, and both `bcftools` and `vcftools` to process the VCF.
