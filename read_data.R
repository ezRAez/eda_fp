#||||||||||||||||||||||||||||||||||||||||||||
# Setup - Make .rds into R object
# Assumes repo as cwd
#||||||||||||||||||||||||||||||||||||||||||||

#clear workspace
rm(list = ls())

scc <- readRDS("./emissions_data/Source_Classification_Code.rds")
summ_scc <- readRDS("./emissions_data/summarySCC_PM25.rds")
