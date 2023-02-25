#-----------------------------------------------------------------------
# Program name: Assignment #8 (Employee Class)
# Author: Gonzalo Rocha-Vazquez
# Date: May 12, 2020
# Purpose: 
#-----------------------------------------------------------------------
# GLOBAL VARIABLE DEFINITIONS (Use only until functions)
#
# Variable Type: Variable list separated by commas

#-----------------------------------------------------------------------
# CONSTANT DEFINITIONS

#-----------------------------------------------------------------------
# CLASS DEFINITIONS

class Employee:
    def __init__(self, name, number):
        self.name = name
        self.number = number

    def setName(self, name):
        self.name = name

    def setNumber(self, number):
        self.number = number

    def getName(self, name):
        return self.name

    def getNumber(self, number):
        return self.number

    def __str__(self):
        return self.name + self.number
    
class ProductionWorker(Employee):
    def __init__(self, name, number, shift, pay):
        Employee.__init__(self, name, number)
        self.shift = shift
        self.pay = pay

    def setShift(self, shift):
        self.shift = shift

    def setPay(self, pay):
        self.pay = pay

    def getName(self, shift):
        return self.shift

    def getNumber(self, pay):
        return self.pay

    def __str__(self):
        return 'Name: ' + self.name + '\nID Number: ' + self.number +\
               '\nShift: ' + str(self.shift) + '\nHourly Pay Rate: $' +\
               str(self.pay)
        
#-----------------------------------------------------------------------
# FUNCTION DEFINITIONS

def main():
    employeeName = input("Enter the Name: ")
    employeeID_Number = input("Enter the ID Number: ")
    employeeShiftNumber = int(input("Enter the shift number: "))
    #Employee pay needs to be formatted to tenths place
    employeePay = format(float(input("Enter the hourly pay rate: ")),'.2f')

    print()
    print("Production worker information")
    print("-----------------------------")
    print()

    worker = ProductionWorker(employeeName, employeeID_Number, 
                              employeeShiftNumber, employeePay)

    print(worker)

#-----------------------------------------------------------------------
# PROGRAM'S MAIN LOGIC
#

main()

input("\nRun complete. Press the Enter key to exit.")

