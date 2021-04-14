# R script to put subdomains and dig-results together and then we can just grep the NOERROR domains
domains <- read.csv('subs',header=F)$V1
for(d in seq_along(domains)){
	cat(paste(d,'of',length(domains),'\t',((d/length(domains))*100),'%','\r'))
	df <- NULL
	df <- data.frame(
		status=read.csv(paste0('dig-results/',domains[d]),header=F),
		url=read.csv(paste0('subdomains/',domains[d]),header=F)
	)
	write.table(
		df,
		file=paste0('knownhosts/',domains[d]),
		quote=F,
		row.names=F,
		sep='\t',
		col.names=F
	)
}
