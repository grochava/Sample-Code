#-----------------------------------------------------------------------
# Program name: Assignment #1
# Author: Gonzalo Rocha-Vazquez
# Date: February 3rd, 2020
# Purpose: Total Sale Calculator
#-----------------------------------------------------------------------
# GLOBAL VARIABLE DEFINITIONS (Use only until functions)
#
# Variable Type: Variable list separated by commas

#-----------------------------------------------------------------------
# CONSTANT DEFINITIONS

SALES_TAX = .08


#-----------------------------------------------------------------------
# CLASS DEFINITIONS

#-----------------------------------------------------------------------
# FUNCTION DEFINITIONS

#-----------------------------------------------------------------------
# PROGRAM'S MAIN LOGIC
#

print("=======================================")
print("     Total Sale Calculator      ")
print("=======================================")
print()


Before_Taxes = float(input("Enter the sales amount: "))
Total_Amount_Due = Before_Taxes + (Before_Taxes * SALES_TAX)

print()
print()
print("The sales amount is: $", format(Before_Taxes,',.2f'), sep='')
print("The sales tax is: $", format(Before_Taxes * SALES_TAX,',.2f'), sep='')
print("The total sale is: $", format(Total_Amount_Due,',.2f'), sep='')
print()
print("=======================================")
input("\nRun complete. Press the Enter key to exit.")

