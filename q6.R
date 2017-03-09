library(ggplot2)
source("read_data.R")

# |||||||||||||||||||||||||||||||||||||||||||
# Compare emissions from motor vehicle sources in Baltimore City with
# emissions from motor vehicle sources in Los Angeles County,
# California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes
# over time in motor vehicle emissions?
# |||||||||||||||||||||||||||||||||||||||||||


# EI.Sector tells us if its from motor vehicle
# use to subset source desc dataset
vehicles <- with(scc, grep("[Vv]ehicles", EI.Sector))
v_sub <- scc[vehicles, ]

summ_v <- inner_join(summ_scc, v_sub, by="SCC")

# fiter for balitmore or la
# group by year
# calculate total emission for each group
yearly_em <- summ_v %>%
    filter(fips == "24510" | fips == "06037") %>%
    group_by(fips, year) %>%
    summarize(em = sum(Emissions)) %>%
    mutate(county = ifelse(fips == "06037", "Los Angeles", "Baltimore"))


png("q6_plot.png")

plot <- qplot(year, em, color=county, geom="point", data=yearly_em,
              xlab="Year", ylab="Total PM2.5 Emission (t)",
              main="Yearly Vehicle PM2.5 Emission")

plot<- plot + geom_line() + geom_smooth(linetype="dashed", method="lm", se=FALSE)

print(plot)

dev.off()
