# Homework 5 Blank
 
rm(list=ls())

# you will need to load these packages 
library("rio")
library("tidyverse")
library("dplyr")
library("ggplot2")

# replace with your working directory
setwd("/Volumes/GoogleDrive/Poli 5D - Data Analytics for the Social Sciences/Assignments/Homework 5")

# import the data 
df <- import("hw5_data.dta")

# drop missing values
mean(df$urate)
df <- df %>% drop_na(urate)
mean(df$urate)

# make histogram of urate 
u <- ggplot(df, aes(x=urate)) + 
  geom_histogram(fill="#69b3a2") +
  ylab("Number of Counties") +
  xlab("Unemployment Rate (%)") + 
  ggtitle("Distribution of Unemployment Rates Across Counties in the U.S.") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  ) +
  theme(axis.line = element_line(color = 'black'))
u

# make histogram of prescrip_rate
p <- ggplot(df, aes(x=prescrip_rate)) + 
  geom_histogram(fill="#404080") +
  ylab("Number of Counties") +
  xlab("Prescriptions per 100 persons") + 
  ggtitle("Distribution of Opioid Prescription Rates Across Counties in the U.S.") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  ) +
  theme(axis.line = element_line(color = 'black'))
p

# Now let's estimate a regression of with prescrip_rate as the Y-variable
# and unemployment rate as the X variablea
lmfit <- lm(prescrip_rate ~ urate, data = df)
summary(lmfit)

# Make a scatterplot with prescrip_rate on the y-axis
# and unemployment rate on the x-axis. use geom_smooth() to add a best fit line
dfplot <- ggplot(df, aes(x=urate, y=prescrip_rate)) +
  geom_point(size = 1) +
  xlab("Unemployment Rate (%)") +
  ylab("Opioid Prescriptions per 100 persons") +
  ggtitle("Relationship between Unemployment & Opioid Usage") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  ) +
  theme(axis.line = element_line(color = 'black'))

dfplot <- dfplot + geom_smooth(method=lm, color="red")
dfplot

# now we are worried that education is contributing to both
# opioid rates and unemployment. To check if this is a possibility, let's see if 
# education predicts opioid rates by estimating a linear regression using 
# the variable frac_coll_plus2000 as the X-variable
lmfit <- lm(prescrip_rate ~ frac_coll_plus2000, data = df)
summary(lmfit)

# This code will remove all commas from the variable labor force and 
# coerce it into a numeric variable
df <- df %>% mutate(labor_force=as.numeric(str_remove_all(labor_force,",")))

# use filter to create two new dataframes. One of counties with labor force > 100000
# and one with counties with labor force < 100000
df1 <- df %>% filter(labor_force > 100000)
df2 <- df %>% filter(labor_force <= 100000)

# Now let's estimate a regression of with prescrip_rate as the Y-variable
# and unemployment rate as the X variable for each of the subset of data (i.e. for each
# dataframe we created above)
lmfit1 <- lm(prescrip_rate ~ urate, data = df1)
summary(lmfit1)

lmfit2 <- lm(prescrip_rate ~ urate, data = df2)
summary(lmfit2)







