suppressPackageStartupMessages({
    library(tidyverse)
    library(here)
    library(rio)
})


# Caricamento dati puliti
d <- rio::import(here::here("data", "processed", "cleaned_data.csv"))

# Analisi statistica
risultati_analisi <- d |>
    group_by(island) |>
    summarise(
        avg_length = mean(flipper_length_mm),
        sd = sd(flipper_length_mm)
    )

# Salvataggio risultati
rio::export(risultati_analisi, here::here("reports", "risultati_analisi.csv"))

# Visualizzazione
mass_flipper <- ggplot(
    data = d,
    aes(
        x = flipper_length_mm,
        y = body_mass_g
    )
) +
    geom_point(
        aes(
            color = species,
            shape = species
        ),
        size = 3,
        alpha = 0.8
    ) +
    scale_color_manual(values = c("darkorange", "purple", "cyan4")) +
    labs(
        title = "Penguin size, Palmer Station LTER",
        subtitle = "Flipper length and body mass for Adelie, Chinstrap and Gentoo Penguins",
        x = "Flipper length (mm)",
        y = "Body mass (g)",
        color = "Penguin species",
        shape = "Penguin species"
    )

# Save the plot as a PNG file
ggsave(
    filename = here::here("reports", "figures", "mass_flipper.png"), # Name of the file
    plot = mass_flipper, # The plot object
    device = "png", # The device type
    width = 8, # Width of the plot (in inches)
    height = 6, # Height of the plot (in inches)
    dpi = 300 # Resolution in dots per inch
)
