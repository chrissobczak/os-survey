library(ggplot2)
#df <- read.csv('proportions.csv')
load('audit/weights.RData')
#load('audit/calcs.RData')

missing_props <- data.frame(country=weights[-5,1],missingprop=(weights[-5,2]-weights[-5,3])/weights[-5,2])
missing_props <- missing_props[order(missing_props[,2],decreasing=T),]
missing_props$country <- gsub(',\\sRepublic.*$','',missing_props$country)
missing_props$country <- gsub('Syrian.*$','Syria',missing_props$country)
missing_props$country <- gsub(',\\sBoliva.*','',missing_props$country)
missing_props$country <- gsub('n\\sFed.*','',missing_props$country)

#missing_props$country <- gsub('United States','US',missing_props$country)
#missing_props$country <- gsub('United Kingdom','UK',missing_props$country)

pdf('report/graphics/missingprops.pdf')
par(mar=c(7.1,4.1,4.1,2.1))
barplot(
	missing_props$missingprop,
	names.arg=missing_props$country,
	las=2,
	border=F,
	ylab='Proportion of Nonresponses',
	main='Proportions of Nonresponses per Sample Size per Country',
	cex.names=0.7
)
dev.off()
