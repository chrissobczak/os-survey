library(dplyr)
load('audit/weights.RData')

missing_props <- data.frame(country=weights[-5,1],missingprop=(weights[-5,2]-weights[-5,3])/weights[-5,2])
missing_props$country <- gsub(',\\sRepublic.*$','',missing_props$country)
missing_props$country <- gsub('Syrian.*$','Syria',missing_props$country)
missing_props$country <- gsub(',\\sBoliva.*','',missing_props$country)
missing_props$country <- gsub('n\\sFed.*','',missing_props$country)

#missing_props$country <- gsub('United States','US',missing_props$country)
#missing_props$country <- gsub('United Kingdom','UK',missing_props$country)

missing_props <- missing_props[order(missing_props[,2],decreasing=T),]
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

df <- read.csv('proportions.csv')
load('audit/calcs.RData')

c_props <- data.frame(country=c_s,prop=df[,'FOSS'])
bycountry <- summarise(c_props, group_by=country, mean=mean(FOSS))
c_props <- c_props[order(c_props[,2],decreasing=T),]
pdf('report/graphics/country_props.pdf')
par(mar=c(7.1,4.1,4.1,2.1))
barplot(
	c_props$FOSS,
	names.arg=c_props$country,
	las=2,
	border=F,
	ylab='Proportion of FOSS Licenses',
	main='Proportions of FOSS per Country With Nonresponses',
	cex.names=0.7
)
dev.off()
