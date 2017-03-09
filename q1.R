source("read_data.R")

# |||||||||||||||||||||||||||||||||||||||||||
# Have total emissions from PM2.5 decreased in the United States from
# 1999 to 2008? Using the base plotting system, make a plot showing the
# total PM2.5 emission from all sources for each of the years 1999,
# 2002, 2005, and 2008.
# |||||||||||||||||||||||||||||||||||||||||||

png("q1_plot.png")

# group summ_scc by year
# calculate total PM2.5
yearly_em <- summ_scc %>% group_by(year) %>%
                          summarize(em = sum(Emissions)) %>%
                          mutate(em = em / 10^6)


with(yearly_em, plot(year, em, xlab = "Year",
                     ylab="Total PM2.5 Emission (Mt)",
                     main="Yearly PM2.5 Emmission", type="l", col="pink"))

with(yearly_em, points(year, em, col="orange", pch=7))

dev.off()
