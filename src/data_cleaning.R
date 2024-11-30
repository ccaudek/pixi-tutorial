suppressPackageStartupMessages({
  library(rio)
  library(tidyverse)
  library(here)
})

# Caricamento dati
raw_data <- rio::import(
  here::here("data", "raw", "penguins.csv")
)

# Pulizia dati
cleaned_data <- raw_data |>
  dplyr::filter(!is.na(flipper_length_mm)) |>
  mutate(island = factor(island))

# Salvataggio dati puliti
rio::export(
  cleaned_data,
  here::here("data", "processed", "cleaned_data.csv")
)
