#-----------------------------------------------------------------------
# Program name: Assignment #3
# Author: Gonzalo Rocha-Vazquez
# Date: February 25, 2020
# Purpose: 
#-----------------------------------------------------------------------
# GLOBAL VARIABLE DEFINITIONS (Use only until functions)
#
# Variable Type: Variable list separated by commas

#-----------------------------------------------------------------------
# CONSTANT DEFINITIONS

#-----------------------------------------------------------------------
# CLASS DEFINITIONS

#-----------------------------------------------------------------------
# FUNCTION DEFINITIONS

#-----------------------------------------------------------------------
# PROGRAM'S MAIN LOGIC
#

print("VOTER ELIGIBILITY AND POLLING STATION PROGRAM")
print()
print()
#You must be atleast 18 years of age to be eligible to vote
age = int(input("Enter your age (Type '0' to exit program): "))
#"While" loop continues until "0" is inputted
while age != 0:
     if age < 18:
          print()
          print("YOU ARE INELIGIBLE TO VOTE")
          print()
          print()
#Age input has to be included within the loop to continue asking for age
          age = int(input("Enter your age (Type '0' to exit program): "))
#Has to be equal to or greater than 18 to include the 18
     elif age >= 18:
          print()
          zip_code = input("Enter your residence's zip code: ")
          if zip_code == '93305':
               print("Your polling station is 123 Panorama Drive.")
          elif zip_code == '93306':
               print("Your polling station is 6143 Fairfax Drive.")
          elif zip_code == '93307':
               print("Your polling station is 21121 B Street.")
          elif zip_code == '93308':
               print("Your polling station is 863 Desmond Ct.")
          elif zip_code == '93309':
               print("Your polling station is 7332 Del Canto Ct.")
          else:
               print("Error-unknown zip code")
          print()
          print()
#Age input has to be included within the loop to continue asking for age
          age = int(input("Enter your age (Type '0' to exit program): "))
#Need to have your "escape route" OUTSIDE of the loop
input("\nRun complete. Press the Enter key to exit.")
