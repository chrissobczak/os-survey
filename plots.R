library(ggplot2)
df <- read.csv('proportions.csv')

ggplot(df, aes(FOSS, fill=Mi)) +
	geom_histogram(bins=50)

