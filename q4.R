library(ggplot2)
source("read_data.R")

# |||||||||||||||||||||||||||||||||||||||||||
# Across the United States, how have emissions from coal
# combustion-related sources changed from 1999–2008?
# |||||||||||||||||||||||||||||||||||||||||||

# combine where data indicates coal
coal_ei <- with(scc, grep("Comb.*Coal", EI.Sector))
coal_short <- with(scc, grep("Comb.*Coal", Short.Name))
coal_sub <- scc[union(coal_ei, coal_short), ]

# join subset with summarized data
summ_coal <- inner_join(summ_scc, coal_sub, by="SCC")

# group by year
# calculate total emission for each eyear
yearly_em <- summ_coal %>%
    group_by(year) %>%
    summarize(em = sum(Emissions)) %>%
    mutate(em = em / 10^6)

png("q4_plot.png")

coal_plot <- qplot(year, em, geom="point", data=yearly_em,
              xlab="Year", ylab="Total PM2.5 Emission (Mt)",
              main="Yearly PM2.5 Emission from Coal") + geom_line()

print(coal_plot)

#close the png graphic device
dev.off()
