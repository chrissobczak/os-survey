library(stringr)
domains <- paste0('results/',read.csv('domains',header=F)$V1)
n <- length(domains)

APACHE='(Apache|Jetty|Prometheus)'
BSD='(lighttpd|nginx|CherryPy|thttpd)'
GPL='(Payara|Icecast|GlassFish|Cherokee|squid|gSOAP)'
MIT='Twisted'
GENFOSS='(Open Source|Ethernut)'
PROP='(Microsoft|Helix|Cloudflare|MS-Server|LiteSpeed|Perservica)'

cats <- c(APACHE,BSD,GPL,MIT,GENFOSS,PROP)

OS_OPEN='(Debian|Ubuntu|SUSE)'
OS_PROP='(Win|Win64|Enterprise|HP|CANON)'


props <- data.frame(
	domain=gsub('probing/servers/','',domains),
	Mi=NA,
	apache=NA,
	bsd=NA,
	gpl=NA,
	mit=NA,
	prop=NA,
	genfoss=NA,
	missing=NA
)
for(d in seq_along(domains)){
	cat(paste0('\t',d,'\tof\t',n,'\t(',floor((d/n)*100),'%)\t\t\r'))
	servers <- read.csv(domains[d],header=F)$V1
	servers <- servers[!is.na(servers)]
	Mi <- length(servers)
	servers <- gsub('/(\\d*|\\.)*','',servers)
	servers <- gsub('(PHP|mod_ssl|OpenSSL|\\d|Serial|\\.).*$','',servers)
	props[d,'Mi'] <- Mi

	props[d,'apache'] <- length(grep(APACHE,servers,ignore.case=T))/Mi
	props[d,'bsd'] <- length(grep(BSD,servers,ignore.case=T))/Mi
	props[d,'gpl'] <- length(grep(GPL,servers,ignore.case=T))/Mi
	props[d,'mit'] <- length(grep(MIT,servers,ignore.case=T))/Mi
	props[d,'genfoss'] <- length(grep(GENFOSS,servers,ignore.case=T))/Mi
	props[d,'prop'] <- length(grep(PROP,servers,ignore.case=T))/Mi
	props[d,'missing'] <- 1-sum(props[d,3:7])
}
props$FOSS <- apply(props[3:6],1,sum)
write.table(props,
	file='proportions.csv',
	sep=',',
	row.names=F,
	quote=F
)
