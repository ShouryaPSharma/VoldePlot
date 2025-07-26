# VoldePlot
"There is no good and evil, there is only power, and those too weak to seek it."- Lord Voldemort... well if the issue is 'seeking' volcano plots with gene expression data, look no further than VoldePlot.
VoldePlot is a lightweight Shiny web application for dynamic visualization of gene expression data. It allows users to explore volcano plots, find relevant genetic expression and filter genes of interest - all within an interactive and user-friendly interface.

 Try it out here:[VoldePlot Web App](https://voldeplot.shinyapps.io/VoldePlot/)


## Repository Contents

- `voldeplot.R` — Main Shiny app file
- `https://voldeplot.shinyapps.io/VoldePlot/` — Weblink for VoldePlot
- `vdata.csv` — Sample input data for testing
- `README.md` — Project overview and usage instructions


---
##  Required Pre-processed Input Data

The app expects a **CSV file** with the following **pre-processed columns**:

| Column Name     | Description                                      |
|------------------|--------------------------------------------------|
| `gene name/symbol`           | Gene identifiers (e.g., symbols or IDs)          |
| `logFoldChange`          | Log2 fold-change values                          |
| `pvalue`         | Raw p-values                                     |


>  Ensure there are no missing values in the dataset before uploading.
> Dont worry if the column names differ in given input file, the app can autodetect column names and run smoothly :)
A sample CSV file `v_data.csv` has been provided in the repository.
 ---

 ## How to Use the App

1. **Launch the app**
   
   - Open URL : https://voldeplot.shinyapps.io/VoldePlot/
   - Open `VoldePlot.R` in RStudio
   - Click the "Run App" button in the top-right corner, or run:
     ```r
     shiny::runApp("VoldePlot.R")
     ```

3. **Upload your data**
   - Click **"Browse"** in the **"Update CSV File"** box 
   - Use a CSV file that contains columns: `Gene ID/symbol`, `logFoldChange`, and `P-value` (actual column names can vary)

4. **Customize the plot**
   - Use the sliders to set thresholds for log fold-change and p-value
   - Highlight specific gene expression data by selecting paricular gene from dropdown box

5. **View results**
   - Interactive volcano plot is displayed in the main panel
   - A table below shows entire gene data
  
  Thanks for reading!!





