library(rjson)
raw <- fromJSON(file = 'all.json')
domains <- lapply(raw, function(x) return(x['domains']))
countries <- unlist(lapply(raw, function(x) return(x['country'])))
school <- unlist(lapply(raw, function(x) return(x['name'])))

df <- data.frame(school=school,country=countries)
