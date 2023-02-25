#-----------------------------------------------------------------------
# Program name: Assignment #2
# Author: Gonzalo Rocha-Vazquez
# Date: February 18, 2020
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

print("CONVERSION PROGRAM")
print()

print("T = Convert Fahrenheit to Celsius")
print("D = Convert Miles to Kilometers")
print("W = Convert Pounds to Kilograms")
print()

conversion = input("Select conversion to perform('T'emperature, 'D'istance, 'W'eight)? ")
if conversion == 'T' or conversion == 't':
    tempF = float(input("Please enter the temperature in FAHRENHEIT: "))
    tempC = format(((tempF - 32)/1.8), ',.3f')
    print(format(tempF, ','), "fahrenheit is", tempC, "celsius.")
elif conversion == 'D' or conversion == 'd':
    mi = float(input("Please enter the distance in MILES: "))
    km = format((mi/0.621371192237), ',.3f')
    print(format(mi, ','), "miles is", km, "kilometers.")
elif conversion == 'W' or conversion == 'w':
    lbs = float(input("Please enter the weight in POUNDS: "))
    kg = format((lbs/2.2), ',.3f')
    print(format(lbs, ','), "pounds is", kg, "kilograms.")
else:
    print()
    print("Error - Invalid option selected. You may only enter T, D, or W.")

input("\nRun complete. Press the Enter key to exit.")

