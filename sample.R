source('read.R')

N <- length(raw)
n <- 1000

inds <- sample(x=1:N, size=n, replace=FALSE)

S <- lapply(domains, function(x) return(x
