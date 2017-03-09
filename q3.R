library(ggplot2)
source("read_data.R")

# |||||||||||||||||||||||||||||||||||||||||||
# Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint,
# onroad, nonroad) variable, which of these four sources have seen
# decreases in emissions from 1999–2008 for Baltimore City? Which have
# seen increases in emissions from 1999–2008? Use the ggplot2 plotting
# system to make a plot answer this question.
# |||||||||||||||||||||||||||||||||||||||||||

# filter for balitmore
# mutate on four types
# group by type & year
yearly_em <- summ_scc %>%
    filter(fips == "24510") %>%
    mutate(type=as.factor(type)) %>%
    group_by(type, year) %>%
    summarize(em = sum(Emissions))

png("q3_plot.png")

plot <- qplot(year, em, color=type, data=yearly_em, geom="point",
              xlab="Year", ylab="Total PM2.5 Emissions (t)",
              main="Yearly PM2.5 Emissions for Baltimore, MD")

# draw regression lines
# do not display confidence interval around smooth
plot <- plot + geom_smooth(method="lm", se = FALSE)

print(plot)

dev.off()
