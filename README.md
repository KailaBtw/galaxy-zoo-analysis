# Galaxy Zoo Analysis (Statistics Project)

This repository contains an R-based statistics analysis using **Galaxy Zoo** (crowd‑sourced galaxy morphology classifications) and accompanying project artifacts (plots, datasets, and the final write‑up).

## Research question (final paper)

**Does axial ratio (how “round” a galaxy appears) relate to galaxy color, and does that differ between spiral and elliptical galaxies?**

- **Axial ratio**: values near 1 are rounder; low values for spirals can indicate an edge‑on view.
- **Color proxy**: \(G - R\) computed as **GMAG − RMAG**.

## Final conclusions (from the PDF in this repo)

- **Spiral galaxies**: axial ratio is associated with color.
  - **More edge‑on spirals** (lower axial ratio) tend to appear **redder**, consistent with **dust extinction** along the line of sight.
  - **More face‑on spirals** (higher axial ratio) tend to appear **bluer**, consistent with a clearer view of **younger, blue stars**.
- **Elliptical galaxies**: **no meaningful axial‑ratio / color difference** was found in this project’s split by color.

The final conclusions are summarized in `final_research_results.pdf`.

## Repository contents

- `statistical_analysis.R`: R analysis script (imports data, classifies galaxies, produces plots, and runs basic statistical tests).
- `assets/`: source datasets used for the analysis (CSV / XLSX).
- `plots/`: exported plots used in the write‑up.
- `final_research_results.pdf`: final research conclusions for the project.

## How to run

### Prerequisites

- **R** (recent version recommended)
- R packages used in `statistical_analysis.R`:
  - `ggplot2`, `tidyr`, `dplyr`, `olsrr`, `leaps`

### Run the script

1. Ensure `assets/GalaxyZoo_data.csv` exists (this repo includes it).
2. Open `statistical_analysis.R` and update the `read.csv(...)` path if needed.  
   The script currently references an **absolute local path**, so you’ll likely want to change it to something relative, for example:
   - `read.csv("assets/GalaxyZoo_data.csv", header = TRUE)`
3. Run the script in RStudio or from the command line:
   - `Rscript statistical_analysis.R`

## Data source / reference

Galaxy Zoo is a citizen science project for galaxy morphology classification. A reference used in the project materials is the paper at `https://arxiv.org/pdf/1001.1744.pdf`.
