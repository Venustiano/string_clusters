# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

install.packages(c(
  "data.table",
  "stringr",
  "ggplot2",
  "text",
  "textdata",
  "cluster",
  "Rtsne",
  "wordcloud2",
  "tm",
  "SnowballC",
  "wordcloud",
  "tidytext",
  "tidyr"),
                 dependencies = TRUE)
