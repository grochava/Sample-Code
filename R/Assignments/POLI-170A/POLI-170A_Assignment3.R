# 1. Set working directory
setwd("/Users/gonzalorocha-vazquez/Desktop/POLI 170A/Data")

# 2. Load appropriate libraries
library(readxl) #loads excel files
library(readr) #loads csv files
library(tidyverse) #need to use dplyr
library(dplyr) #need for data wrangling

# 3. Load in both datasets
rural <- read_xlsx("RuralPopData_POLI170A.xlsx") #load the “RuralPopData_POLI170A.xlsx”
coffee <- read.csv("coffee_production.csv") #load in the “coffee_production.csv”

# 4. Change the variable type of “Rural population (% of total population)” from character to numeric
rural$`Rural population (% of total population)` <- as.numeric(rural$`Rural population (% of total population)`) #Change our variable of interest to numeric

# 5. Select only the iso and coffee_production_2017 variables from the coffee dataset
coffee <- coffee %>% select(iso, coffee_production_2017) #filtering out our dataset so it only includes our variables of interest

# 6. Rename the variables in the Rural Population data to be: (a) country; (b) iso; (c) rural_pop_percent
rural <- rename(rural, country = `Country Name`, #rewrite original object
                iso = `Country Code`, #format: new_name = old_name
                rural_pop_percent = `Rural population (% of total population)`)

# 7. Merge the coffee data into the rural population data
new_dataset <- dplyr::left_join(rural, coffee, by = c("iso" = "iso"))
# dplyr::left_join(first_data, second_data, by = c("first_variable" = "second_variable")) 
# We merged coffee into rural and hosted it in a new datset, so information in coffee but not in rural got dropped

# 8. Create a new variable called log_coffee where you log transform coffee_production_2017
new_dataset$log_coffee <- log(new_dataset$coffee_production_2017)

# 9. Run a simple linear regression using rural_pop_percent to predict log_coffee. That is, log_coffee is your outcome variable (Y) and rural_pop_percent is your explanatory variable (X)
regression = lm(log_coffee ~ rural_pop_percent, data = new_dataset)
summary(regression)

# 10. Report and interpret the adjusted R2 of this regression
# Adjusted R-squared:  0.1218 
# The adjusted R^2 is a "goodness-of-fit" measurement that tells us how accurately our model "explains" the data; it is preferred over a regular R^2 because it corrects for additional X variables added by penalizing us. The adjusted R^2 given, "0.1218", means that our model explains 12.18% of the variance in our data: the percentage of rural population in the country accounts for 12.18% of the variance in the (log) coffee production in 2017. 