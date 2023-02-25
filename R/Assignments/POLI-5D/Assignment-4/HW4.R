setwd("/Volumes/GoogleDrive/Poli 5D - Data Analytics for the Social Sciences/Assignments/Homework 4")

library(dplyr)
library(ggplot2)
library(hrbrthemes)
library(wesanderson)
library(foreign)
library(haven)

df <- read.csv("brexit_df1.csv")

mean(df$leave_share)

summary(df$leave_share)

df$leave_yes <- ifelse(df$leave_share >= 50, 1, 0)
#df <- df %>% mutate(leave_yes = as.numeric(leave_share >= 50))

prop.table(table(df$leave_yes))

m1 <- mean(df$unemployment[df$leave_yes == 1])
# m1 <- df %>% filter(df$leave_yes == 1)
# m1 <- mean(m1$unemployment)
m1

m2 <- mean(df$unemployment[df$leave_yes == 0])
# m2 <- df %>% filter(df$leave_yes == 0)
# m2 <- mean(m2$unemployment)
m2

vec <- c(m1,m2)
barplot(vec, main="Average Unemployment Rate for Regions in the EU",
        xlab="Decision on Brexit", 
        ylab="Average Unemployment Rate", 
        names.arg = c("Leave","Stay"),
        col = c("red","green"))

med_is <- median(df$immigrant_share)
med_is

df_above <- df %>% filter(df$immigrant_share >= med_is)
# df_above <- df[which(df$immigrant_share >= med_is)]
df_below <- df %>% filter(df$immigrant_share < med_is)
# df_below <- df[which(df$immigrant_share < med_is)]

mean(df_above$leave_share)
mean(df_below$leave_share)

df2 <- read.csv("brexit_df2.csv")

df3 <- df %>% inner_join(df2, by = "council_id")

#quantile(df3$share_above_60)
#p75 <- quantile(df3$share_above_60, probs =.75)
#p25 <- quantile(df3$share_above_60, probs =.25)
p75 <- quantile(df3$share_above_60, .75)
p75
p25 <- quantile(df3$share_above_60, .25)
p25

m3 <- prop.table(table(df3$leave_yes[which(df3$share_above_60 >= p75)]))
m3 <- m3[2]
m3

m4 <- prop.table(table(df3$leave_yes[which(df3$share_above_60 <= p25)]))
m4 <- m4[2]
m4

vec2 <- c(m3,m4)
vec3 <- c("Greater than equal to the 75th percentile", 
          "Less than equal to the 25th percentile")
df_bar <- as.data.frame(cbind(vec3, vec2))

barplot <- df_bar %>% ggplot(aes(x=vec3,y=as.numeric(vec2),fill=vec3)) +
  geom_bar(stat="Identity") + 
  geom_text(aes(label=vec2), position=position_dodge(width=0.9), vjust=-0.25) +
  ylab("Fraction That Voted to Leave EU") +
  xlab("Quantile Group") + 
  ggtitle("Share of People over 60 in Favor of Brexit") +
  scale_y_continuous(limits=c(0,1)) +
  #ylim(0,1) +  ##This one works too, the problem was our y needed to be numeric
  scale_fill_discrete(name = "Quantile Groups") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  ) +
  theme(axis.line = element_line(color = 'black'))

barplot







