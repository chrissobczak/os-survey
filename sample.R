# OS-Survey Script to
# sample from the sampling
# frame
# Chris Sobczak
# April 2021
set.seed(28337)

raw <- rjson::fromJSON(file='full_frame.json')

# std margin of error
e <- 0.03
N <- length(raw)

# starting with the assumption that the
# p is 1/2;
# lohr 2019 text (2.25 and 2.26) pg 47 (60)
p <- 1/2
n <- ((qnorm(0.025,lower.tail=F)^2)*p*(1-p)) / e^2

inds <- sample.int(N, size=n, replace=FALSE)

raw_S <- raw[inds]
domains_S <- lapply(raw_S, function(x) return(x['domains']))
countries_S <- as.character(unlist(lapply(raw_S, function(x) return(x['country']))))
schools_S <- as.character(unlist(lapply(raw_S, function(x) return(x['name']))))

data <- list(domains=domains_S,country=countries_S,school=schools_S)
#save(data,file='audit/data.Rda')

# This will concatinate all the domains,
# some schools may have more than one domain
# entered, so this length will likely
# be greater than domain_S
domains <- as.character(unlist(domains_S))
#write.table(
#	domains, file="probing/domains",
#	quote=FALSE, row.names=FALSE,
#	col.names=FALSE
#)

