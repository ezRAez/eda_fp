library(ggplot2)
source("read_data.R")

# |||||||||||||||||||||||||||||||||||||||||||
# How have emissions from motor vehicle sources changed from 1999–2008
# in Baltimore City?
# |||||||||||||||||||||||||||||||||||||||||||

# EI.Sector tells us if its from motor vehicle
# use to subset source desc dataset
vehicles <- with(scc, grep("[Vv]ehicles", EI.Sector))
v_sub <- scc[vehicles, ]

summ_v <- inner_join(summ_scc, v_sub, by="SCC")

yearly_em <- summ_v %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarize(em = sum(Emissions))

png("q5_plot.png")

plot <- qplot(year, em, geom="point", data=yearly_em,
              xlab="Year", ylab="Total PM2.5 Emission (t)",
              main="Yearly Baltimore PM2.5 Emission from Motor Vehicle Sources") + geom_line()

print(plot)

dev.off()
