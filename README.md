# Microglial depletion during the mid-disease stage alleviates symptoms in Alzheimer’s mice by restoring energy metabolism and preserving GABAergic neurons

Code repository for the spatial transcriptomics and single-cell integration analysis in *Microglial depletion during the mid-disease stage alleviates symptoms in Alzheimer’s mice by restoring energy metabolism and preserving GABAergic neurons.*

## Quick Start (Recommended - Using Docker)

We provide a **Dockerfile** to ensure a fully reproducible computational environment with all required R and Python packages.

### 1. Install Docker
Please install Docker Desktop from: https://docs.docker.com/engine/install/

### 2. Build the Docker Image
```bash
# Run this command in the root directory of the repository
docker build -t plx5622:latest -f Dockerfile .
```

### Download necessary data

1. Create a working directory. 
2. Download the spatial transcriptome data in the article and put it into `[WORKING DIR]/001ST/000data/`. The GEO ID is available in the **Data Accessibility** part of the article. 
3. Download the single-nucleus data and put it into `[WORKING DIR]/002SC/000data/`. The GEO ID is available in the **Data Accessibility** part of the article. 

### 3. Run the Container

```bash
docker run -it -u 1019:1019 \
  -v [Path to your tmp directory]:/home/tmp \
  -v [WORKING DIR]:/home/mouse_ad \
  plx5622:latest /bin/bash
```

## Reproduce

1. Run scripts in order. 
2. Results of spatial transcriptome will be generated in `001ST/001Giotto_out/`
3. Results of single-nucleus transcriptome will be generated in `002SC/004Seurat_out`

Contact: [yc276589\@um.edu.mo](mailto:yc276589@um.edu.mo){.email}
