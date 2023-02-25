#-----------------------------------------------------------------------
# Program name: Assignment #5
# Author: Gonzalo Rocha-Vazquez
# Date: March 31, 2020
# Purpose: Look up Zipcodes
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


def main():

    print("ZIPCODE LOOKUP PROGRAM")

    dataList, abort = loadLists()

    if not abort:
        promptAndFindLoop(dataList)

    input("\nRun complete. Press the Enter key to exit.")

def loadLists():

    dataList = []

    try:
        zipFile = open("zipcodes.txt","r")
    except IOError:
        print("Error - zipcodes.txt does not exist")
        abort = True
    else:

        for line in zipFile:
            parsedString = line.split(",")
            dataList.append(parsedString)

        zipFile.close()
        abort = False

    return dataList, abort

def getZip():
    return input("Enter a zip code to find (Press Enter key alone to stop): ")

def promptAndFindLoop(dataList):

    userInput = getZip()
    while userInput != "":
        searchList(userInput, dataList)
        userInput = getZip()

def searchList(userInput, dataList):

    foundIt = False
    for item in dataList:
        if userInput == item[0]:
            print("\n\tThe city is " + item[1] + " and the state is " + item[2].rstrip() + ".\n")
            foundIt = True
            break

    if not foundIt:
        print("\n\tThe zip code does not exist.\n")




#-----------------------------------------------------------------------
# PROGRAM'S MAIN LOGIC
#

main()


