# Get the data and images from GitHub since the eval project builds them
library(tidyverse)

base_url <- paste0(
  "https://raw.githubusercontent.com/andrewheiss/", 
  "evalsp26.classes.andrewheiss.com/refs/heads/main/", 
  "files/data/generated_data/"
)

dir.create("data", showWarnings = FALSE)
walk(c("barrels_observational.csv", "barrels_rct.csv"), \(f) {
  if (!file.exists(paste0("data/", f))) {
    download.file(paste0(base_url, f), paste0("data/", f))
  }
})

dir.create("images", showWarnings = FALSE)
walk(c("barrel-dag-observational.png", "barrel-dag-rct.png"), \(f) {
  if (!file.exists(paste0("images/", f))) {
    download.file(paste0(base_url, f), paste0("images/", f))
  }
})

# Build answer key so that the plots to recreate exist in images/
quarto::quarto_render(
  "answers.qmd",
  output_format = c("html", "typst")
)
