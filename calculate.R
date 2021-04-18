# Script to calculate the population
# estimates using the data in
# proportions.csv
df <- read.csv('proportions.csv')

open <- df[,3:6]
prop <- df[,'prop']
n <- nrow(df)
N <- 9693

ybari <- apply(open,1,sum,na.rm=T)
Mi <- df[,'Mi']

ybarhatr <- sum(Mi*ybari,na.rm=T)/sum(Mi,na.rm=T)

SEybarhatr <- sqrt(
	(1 - (n/N)) *
	(1/(n*(mean(Mi,na.rm=T)^2))) *
	(
		sum((Mi^2)*((ybari - ybarhatr)^2),na.rm=T)
		/
		(n-1)
	)
)

cat(paste0('ybarhar:\t',ybarhatr,'\n'))
cat(paste0('SEybarhar:\t',SEybarhatr,'\n'))

load('audit/weights.RData')
collected <- read.csv('domains',header=F)$V1
country_inds <- c()
for(j in 1:length(collected)){
	country_inds[j] <- grep(collected[j], domains_S)
}
c_s <- countries_S[country_inds]

c <- unique(countries_S)[order(unique(countries_S))]
phi_c <- weights[-5,c(1,6)]
w <- N/n
wtildei <- c()
for(j in 1:length(c_s)){
	wtildei[j] <- ifelse(c_s[j] %in% phi_c[,1], w*phi_c[grep(c_s[j],phi_c[,1]),2],w)
}

thatwc <- sum(wtildei*ybari)
ybarhatwc <- thatwc/sum(wtildei)


cat(paste0('ybarhatwc:\t',ybarhatwc,'\n'))
