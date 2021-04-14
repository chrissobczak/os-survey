# Script to identify the items in subdomains/
# that are supposed to be together for the same psu
source('sample.R')
multi <- read.csv('multi.csv',header=F)[,1]
multi_inds <- which(multi>1)
multi_domains <- do.call(
	"[[",
	list(
		domains_S,
		multi_inds
	)
)
