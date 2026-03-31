FROM r-base

MAINTAINER lichuhao<yc27658@um.edu.mo>

# install dependency
RUN apt update && apt-get install -y libcurl4-openssl-dev libmagick++-dev libssl-dev libgdal-dev

# install giotto and its dependency. current version of Giotto suite: v3.0.1  
RUN Rscript -e "install.packages('remotes'); remotes::install_github('drieslab/Giotto@suite'); Giotto::installGiottoEnvironment()"

# scran is used for DEG analysis. 
RUN Rscript -e "install.packages('BiocManager'); BiocManager::install('scran')"

# 1. Make me get a user folder when login. 
# 2. Make normal user can access conda under /root directory. 
RUN usermod -u 1019 docker && groupmod -g 1019 docker && chmod 755 /root

# Use harmony to integrate data. 
# Use SPARK and trendsceek to identify spatial genes. 
RUN Rscript -e "remotes::install_github('immunogenomics/harmony'); remotes::install_github('xzhoulab/SPARK'); BiocManager::install(c('genefilter', 'DESeq2')); remotes::install_github('edsgard/trendsceek')"

# Some package rely on this package. 
RUN Rscript -e "install.packages('ggrepel'); install.packages('ggfortify')"
RUN /root/.local/share/r-miniconda/envs/r-reticulate/bin/python -m pip install spatialde
RUN /root/.local/share/r-miniconda/envs/r-reticulate/bin/python -m pip install patsy 

RUN Rscript -e "remotes::install_github('rpolicastro/scProportionTest')"
RUN Rscript -e "install.packages(c('Seurat', 'hdf5r', 'umap')); BiocManager::install('MAST'); "
RUN Rscript -e "remotes::install_bitbucket(repo = 'qzhudfci/smfishhmrf-r', ref='master')"
RUN Rscript -e "BiocManager::install('ComplexHeatmap')"
RUN apt update && apt install -y default-jre
RUN Rscript -e "BiocManager::install('glmGamPoi'); remotes::install_github('satijalab/sctransform', ref = 'develop')"
RUN Rscript -e "install.packages(c('fields', 'KernSmooth', 'ROCR')); remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')"
# single cell: To use findConservedMarker
RUN apt-get install -y libfftw3-dev # To use findConservedMarker
RUN Rscript -e "BiocManager::install('multtest'); install.packages('metap')" # To use findConservedMarker

# for single cell annotation. 
RUN Rscript -e "BiocManager::install(c('scmap', 'SingleR'))"
RUN Rscript -e "BiocManager::install(c('celldex', 'scRNAseq'))"
RUN Rscript -e "install.packages('hdf5r'); remotes::install_github(repo='mojaveazure/loomR', ref = 'develop')"

RUN Rscript -e "remotes::install_github('zji90/TSCAN');" # for trajectory analysis. 

# To run deconvolution
RUN Rscript -e "install.packages(c('quadprog', 'reshape', 'varhandle'))"
RUN apt install -y libgsl-dev
RUN Rscript -e "install.packages('Rfast')"

# also for trajectory analysis
RUN apt-get update && apt install -y libharfbuzz-dev libfribidi-dev cmake libudunits2-dev
# libharfbuzz-dev and libfribidi-dev is for ggrastr, libudunits2-dev is for monocle3
RUN Rscript -e "BiocManager::install(c('BiocGenerics', 'DelayedArray', 'DelayedMatrixStats','limma', 'lme4', 'S4Vectors', 'SingleCellExperiment','SummarizedExperiment', 'batchelor', 'HDF5Array','terra', 'ggrastr'));"

RUN Rscript -e "remotes::install_github('cran/speedglm'); remotes::install_github('cole-trapnell-lab/monocle3')"

RUN Rscript -e "install.packages('scatterpie')" # for spatDeconvPlot

RUN Rscript -e 'remotes::install_github("mojaveazure/seurat-disk"); remotes::install_github("satijalab/seurat-wrappers")'

# to use cellchat
RUN /home/docker/.local/share/r-miniconda/bin/python -m pip install umap-learn
RUN Rscript -e 'remotes::install_github("jokergoo/circlize"); install.packages("NMF"); remotes::install_github("sqjin/CellChat")'

# to use clustree
RUN Rscript -e "install.packages('clustree')"

# to use megena
RUN Rscript -e "install.packages('MEGENA')"

# to use EnhancedVolcano
RUN Rscript -e "BiocManager::install('EnhancedVolcano')"

# to use hgWGCNA
RUN Rscript -e "BiocManager::install(c('WGCNA', 'igraph', 'GeneOverlap', 'ggrepel', 'UCell'))"
RUN Rscript -e "install.packages('harmony')"
RUN Rscript -e 'remotes::install_github("NightingaleHealth/ggforestplot"; remotes::install_github("smorabit/hdWGCNA", ref="dev"))'
RUN Rscript -e "install.packages('tidyverse')"
RUN Rscript -e "install.packages('enrichR')"
