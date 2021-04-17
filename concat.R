# Pull out the repeated domains
domains <- read.csv('domains',header=F)$V1
multi <- read.csv('audit/multi.csv',header=F)[,5:6]
multi <- c(multi[,1],multi[,2])
multi <- multi[!is.na(multi)]
write.table(domains[!(domains %in% multi)],
	file='domains',
	quote=F,
	row.names=F,
	sep=','
)
