# Script to identify the items in subdomains/
# that are supposed to be together for the same psu

domains <- read.csv('domains',header=F)[,1]
load('../data.Rda')

ThisSchool <- function(school, domain){
	return(any(domain %in% school))
}

#multi <- unlist(lapply(raw, ThisSchool, domain=domains))
