/*==============================================


Homework 2 Solutions


================================================*/

// Start-up commands
capture log close
clear all
log using Gonzalo_HW2.txt, text replace

***************************************

* Part 1: Setup and Exploring

***************************************

*0. change your working directory and load the data.
cd "/Users/gonzalorocha-vazquez/Desktop/Homework 2"

* load the data
use anes_2016.dta, clear

* 1.	Generate a table of frequencies of V161158x (Party ID). 
* This is a categorical variable that takes on seven values, 
* from “Strong Democrat” to “Strong Republican.” Notice that 
*  missing values are coded -9 and -8.
tab V161158x

* 2.	Next, you will create a new variable called partyid. 
		*In doing this, you should go through the steps listed below:

	** 2a.	Generate a new variable, partyid, and set it to be equal to V161158x
	gen partyid = V161158x
	
	** 2b. Recode partyid so that Democrats are coded 1,
	* 	Independents are coded 2 and Republicans are coded 3, and missing values are coded accordingly. 
	* 	The recode command is not one we covered in class so type "help recode"
	*   One of the examples in the help file will be particularly helpful
	recode partyid (1/3 = 1) (4 = 2) (5/7 = 3) (8 9 = .)
	
	** 2c.	Label partyid as “Party Identification.”
	label var partyid "Party Identification"

* 3. 
	** 3a. rename V161087 (Feeling Thermometer: Republican Presidential candidate) to "trumpft"
	rename V161087 trumpft

	** 3b.	Replace values to missing if values are equal to -99 or -88
	replace trumpft = . if trumpft == -99 | trumpft == -88

	** 3c. average of trumpft
	mean(trumpft)

* 4
	** 4a. average if Democrat
	mean(trumpft) if partyid == 1

	** 4a. average if Independent
	mean(trumpft) if partyid == 2

	** 4c. average if republican
	mean(trumpft) if partyid == 3
	
	** 4c. retrieve percentiles
	summarize trumpft, detail

* 5 .
	** a.	Rename V161267 to age.
	rename V161267 age

	** b. replace age to missing if less than zero
	
	** c. median value of age




********** DESCRIPTIVE STATISTICS **********

* 6. Generate histograms with the fractions of sample  for: 
** a.	trumpft,
graph twoway histogram trumpft, frac width() ///
	xlabel(0(10)100) ///
	title("Distribution of people in favor of Trump") ///
	xtitle("Feelings Thermometer Score") ///
	ytitle("Percentage")

*7 scatter plot of age and trumpft
twoway scatter trumpft age, msymbol(smcircle_hollow) ///
	title("Relationship between Age and Feelings about Trump") ///
	xtitle("Age") ///
	ytitle("Feelings Thermometer Score") ///
	graphregion(color(white) fcolor(white))



* 8 reshape the data
	** a.
	rename V161086 demft0 
	rename V162078 demft1

	** b.
	keep respondent_id demft0 demft1
	
	** c.
	reshape long demft, i(respondent_id) j(ba_election)
	
* close log
log close




