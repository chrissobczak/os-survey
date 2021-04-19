library(dplyr)
load('audit/weights.RData')

missing_props <- data.frame(country=weights[-5,1],missingprop=(weights[-5,2]-weights[-5,3])/weights[-5,2])
orig_missing_countries=missing_props$country
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

load('audit/calcs.RData')
df <- read.csv('proportions.csv')

c_props <- data.frame(country=c_s,prop=df[,'FOSS'])
c_props <- c_props %>%
	group_by(country) %>%
	summarise(mean=mean(prop,na.rm=T))
c_props <- c_props[which(c_props$country %in% orig_missing_countries),]
c_props <- c_props[order(c_props[,2],decreasing=T),]
o_props <- left_join(missing_props,c_props,by='country')

c_props$country <- gsub(',\\sRepublic.*$','',c_props$country)
c_props$country <- gsub('Syrian.*$','Syria',c_props$country)
c_props$country <- gsub(',\\sBoliva.*','',c_props$country)
c_props$country <- gsub('n\\sFed.*','',c_props$country)

pdf('report/graphics/country_props.pdf')
par(mar=c(7.1,4.1,4.1,2.1))
barplot(
	c_props$mean,
	names.arg=c_props$country,
	las=2,
	border=F,
	ylab='Proportion of FOSS Licenses',
	main='Proportions of FOSS per Country With Nonresponses',
	cex.names=0.7
)
dev.off()
