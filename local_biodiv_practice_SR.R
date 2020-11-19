# R code for local biodiversity project - an example
## Load the necessary packages
if (!require("ggplot2")) {
  install.packages("ggplot2")
  require("ggplot2")
}
if (!require("vegan")) {
  install.packages("vegan")
  require("vegan")
}
if (!require("gridExtra")) {
  install.packages("gridExtra")
  require("gridExtra")
}
library(vegan)
library(ggplot2)
library(gridExtra)
## Set your working directory setwd to source File Location
## Read in your data
dat <- read.csv("Data/Test_data_local_biodiv.csv", head = T, 
                row.names = 1)
### View table
dat
### Look at row and column sums
summary(rowSums(dat))
summary(colSums(dat))
### Most analyses will want data transposed (rows as 'sites'
### and columns as 'species')
datt <- t(dat)
#### Species-individual curve (optional)
dat.specaccum <- specaccum(datt, method = "rarefaction")
plot(dat.specaccum)
#### Measures of alpha diversity
dat.specnumber <- specnumber(datt)  ## Number of species
dat.rowsums <- rowSums(datt != 0)  ## Number of non-zero elements in each row. 
## Note that this is the same as above.
dat.shannon <- diversity(datt)  ## default is Shannon diversity
dat.ens <- exp(dat.shannon)  ## Effective number of species
### Combine into one table for easy graphing
dat.alpha <- cbind.data.frame(Quadrat = c(1:6), dat.specnumber, 
                              dat.shannon, dat.ens)
### This is an example of just plotting in basic R
plot(dat.alpha$Quadrat, dat.alpha$dat.specnumber)
### Make graphs in ggplot2
plot1 <- ggplot(data = dat.alpha, aes(x = Quadrat, y = dat.specnumber)) + 
  geom_point()
plot2 <- ggplot(data = dat.alpha, aes(x = Quadrat, y = dat.shannon)) + 
  geom_point()
plot3 <- ggplot(data = dat.alpha, aes(x = Quadrat, y = dat.ens)) + 
  geom_point()
### plot the 3 graphs next to each other
grid.arrange(plot1, plot2, plot3, ncol = 3)
## why do we see that a quadrant with the 2nd lowest species
## number has the second highest effective number of species?
### Do not answer the question, as the solutions have been
### provided in the documentation see folder entitled
### 'Documentation.html'.

