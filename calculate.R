# Script to calculate the population
# estimates using the data in
# proportions.csv
df <- read.csv('proportions.csv')

open <- df[,3:6]
prop <- df[,'prop']
n <- nrow(df)
N <- 9693

ybari <- apply(open,1,sum)
Mi <- df[,'Mi']

ybarhatr <- sum(Mi*ybari)/sum(Mi)

SEybarhatr <- sqrt(
	(1 - (n/N)) *
	(1/(n*(mean(Mi)^2)) *
	(
		sum((Mi^2)*((ybari - ybarhatr)^2))
		/
		(n-1)
	)
)

cat(paste0('ybarhar:\t',ybarhatr,'\n'))
cat(paste0('SEybarhar:\t',SEybarhatr,'\n'))
