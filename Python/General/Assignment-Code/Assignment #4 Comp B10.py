#-----------------------------------------------------------------------
# Program name: Assignment #4
# Author: Gonzalo Rocha-Vazquez
# Date: March 10, 2020
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

def main():
     conversion = getMenuSelection()
     while conversion != 'Q':
          if conversion == 'T':
               numberForConversion = getValueToConvert(conversion)
               convertedNumber = calculateCelsius(numberForConversion)
               printResult(conversion, numberForConversion, convertedNumber)
          elif conversion == 'D':
               numberForConversion = getValueToConvert(conversion)
               convertedNumber = calculateKilometers(numberForConversion)
               printResult(conversion, numberForConversion, convertedNumber)
          elif conversion == 'W':
               numberForConversion = getValueToConvert(conversion)
               convertedNumber = calculateKilograms(numberForConversion)
               printResult(conversion, numberForConversion, convertedNumber)
          else:
               calculateError()
          conversion = getMenuSelection()

#You have to offer the menu options first
def getMenuSelection():
     print("\n")
     print("------------------")
     print("CONVERSION PROGRAM")
     print("------------------")
     print()
     print("T = Convert Fahrenheit to Celsius")
     print("D = Convert Miles to Kilometers")
     print("W = Convert Pounds to Kilograms")
     conversionSelected = input("\nSelect conversion to perform ('T'emperature, 'D'istance, 'W'eight, or 'Q'uit)? ").upper()
     return conversionSelected

#You have to ask the user for the value to convert
def getValueToConvert(value):
     if value == 'T':
          tempF = float(input("\nPlease enter the temperature in fahrenheit: "))
          return tempF
     elif value == 'D':
          mi = float(input("\nPlease enter the distance in miles: "))
          return mi
     elif value == 'W':
          lbs = float(input("\nPlease enter the weight in pounds: "))
          return lbs
     

#You need to have a function for each response now
def calculateCelsius(number):
     tempC = format(((number - 32)/1.8), ',.3f')
     return tempC

def calculateKilometers(number):
     km = format(((number)/0.621371192237), ',.3f')
     return km

def calculateKilograms(number):
     kg = format(((number)/2.2), ',.3f')
     return kg

def calculateError():
     error = print("\nError - Invalid option selected. You may only enter T, D, or W")
     return error

def printResult(answer, numberFor ,converted):
     if answer == 'T':
          print(format(numberFor, ','), "fahrenheit is", converted, "celsius.")
     elif answer == 'D':
          print(format(numberFor, ','), "miles is", converted, "kilometers.")
     elif answer == 'W':
          print(format(numberFor, ','), "pounds is", converted, "kilograms.")

main()

input("\nRun complete. Press the Enter key to exit.")
