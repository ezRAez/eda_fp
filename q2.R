source("read_data.R")

# |||||||||||||||||||||||||||||||||||||||||||
# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting
# system to make a plot answering this question.
# |||||||||||||||||||||||||||||||||||||||||||

png("q2_plot.png")

# filter for Baltimore (fips 24510)
# group by year
# calculate total emissions for each group
yearly_em <- summ_scc %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarize(em = sum(Emissions))

with(yearly_em, plot(year, em, xlab = "Year",
                           ylab="Total PM2.5 Emission (t)",
                           main="Yearly PM2.5 Emmissions for Baltimore, MD",
                           col="pink", type="l"))

with(yearly_em, points(year, em, col="orange", pch=7))

dev.off()
