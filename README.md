# Analyzing Factors Affecting Potato Prices in Canadian Grocery Markets

## Overview

This repository contains the code and data used to analyze the factors influencing potato prices in Canadian grocery markets. The analysis focuses on vendor type, historical pricing, and sales month, employing Bayesian regression modeling to determine the impact of these factors on the pricing trends of yellow and white potatoes. This study aims to enhance our understanding of the dynamics of potato pricing and provide valuable insights to consumers, retailers, and policymakers.


## File Structure

The repository is structured as follows:

- **data**: Includes simulated data and cleaned datasets that were used in the analysis. Due to the raw dataset is too large, it is not included in the repository. It can be downloaded using the script available in `scripts/02-download_data`.
- **model**: Stores the Bayesian models used in the study. Also includes an API for accessing the models.
- **paper**: Consists of files used to generate the paper, including the Quarto document, the PDF of the paper, and the reference bibliography file.
- **scripts**: Contains the R scripts used to download, clean data, and build the Bayesian models.
- **other**: Contains other supplementary files.


## Statement on LLM usage

The paper includes some content created with the assistance of ChatGPT, such as the surveys, sampling, and observational data appendix and model diagnostics. The entire interaction history with ChatGPT is available in other/llmusage.txt. Comments indicating the use of ChatGPT are included in the paper.
