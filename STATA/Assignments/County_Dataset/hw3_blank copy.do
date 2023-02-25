* Do file for homework 3

*=============================
* Setup
*==============================

// Start-up commands
capture log close
clear all
log using Gonzalo_HW3.txt, text replace

* Change the working directory 
cd "/Users/gonzalorocha-vazquez/Desktop/Homework 3"

* load the data 
use county_characteristics.dta, replace 
describe

*===============================
* Questions (make sure to refer to the instructions for more detail)
*===============================

* 1. what is the average, max, and min rent of a two bedroom apartment in 2015 across counties
sum rent_twobed2015
* average = 684.8963; min = 172.1595; max = 2085.227

* 2. the fips_county for san diego is 06073
* what is the average two bedroom rent in san diego county
sum rent_twobed2015 if fips_county == "06073"
* average = 1441.758

* 3A. what is the population density of San Diego county
summarize popdensity2010 if fips_county == "06073"
* population density of SD = 735.8169

* 3B. construct a histogram for population density
twoway histogram popdensity2010, frac color (gs12) ///
	title("Distribution of County Population Density Across the Country") ///
	xtitle("Population Density (per square mile) (2010)") ///
	ytitle("Fraction") ///
	graphregion(color(white) fcolor(white))

* 4. generate a scatterplot with popdensity2010 on the x-axis
* and rent_twobed2015 on the y-axis
twoway scatter rent_twobed2015 popdensity2010, msymbol(circle_hollow) msize(large) ///
	title("Average Two-Bedroom Rent vs. Population Density") ///
	xtitle("Population Density (per square mile) (2010)") ///
	ytitle("Average Rent for Two-Bedroom Apartment (2015)") ///
	graphregion(color(white) fcolor(white))

* 5A. next create a variable called log_popdensity2010 that is equal
* to the log of popdensity2010
gen log_popdensity2010 = ln(popdensity2010)

* 5B. generate a scatterplot with log_popdensity2010 on the x-axis
* and rent_twobed2015 on the y-axis
twoway scatter rent_twobed2015 log_popdensity2010, msymbol(circle_hollow) msize(large) ///
	title("Average Two-Bedroom Rent vs. Log Population Density") ///
	xtitle("Log Population Density (per square mile) (2010)") ///
	ytitle("Average Rent for Two-Bedroom Apartment (2015)") ///
	graphregion(color(white) fcolor(white))

* 6A. estimate the regression
reg rent_twobed2015 popdensity2010

* 6B-6C (answer using regression output)

* 6D. compute the predicted average rent for a two bedroom apartment if the popdensity2010 is equal to 1000
display  _b[_cons] + _b[popdensity2010]*1000

* 6D. compute the predicted average rent for a two bedroom apartment if the popdensity2010 is equal to 2000
display  _b[_cons] + _b[popdensity2010]*2000
 
* 7A. Regression with log_popdensity2010 as the explanatory variable 
reg rent_twobed2015 log_popdensity2010

* 7C. compute the predicted average rent of a two bedroom apartment that has a popdensity2010 equal to 2000 
display  _b[_cons] + _b[log_popdensity2010]*ln(1000)

* 7D. compute the predicted average rent of a two bedroom apartment that has a popdensity2010 equal to 2000
display  _b[_cons] + _b[log_popdensity2010]*ln(2000)

* 8 Make a scatterplot with log_popdensity2010 on the x-axis
* rent_twobed2015 on the y-axis and a fitted line. You 
* can construct the line using the steps in the lecture slides
* or the lfit command
twoway scatter rent_twobed2015 log_popdensity2010, msymbol(circle_hollow) ///
	|| lfit rent_twobed2015 log_popdensity2010, ///
	title("Average Two-Bedroom Rent vs. Log Population Density") ///
	xtitle("Log Population Density (per square mile) (2010)") ///
	ytitle("Average Rent for Two-Bedroom Apartment (2015)") ///
	graphregion(color(white) fcolor(white))

	
* 9. Pick another variable in the dataset and explore the relationship
* between this variable and rent_twobed2015
reg rent_twobed2015 gsmn_math_~2013

* close log
log close
	
	
	
