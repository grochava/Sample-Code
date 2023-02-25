#-----------------------------------------------------------------------
# Program name: File Encryption
# Author: Gonzalo Rocha-Vazquez
# Date: April 14, 2020
# Purpose: 
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# FUNCTION DEFINITIONS

def main():
    #Function Variable Definitions
    menuOption = displayMenuAndGetOption()

    if menuOption != 'Q':
        if menuOption == 'E':
            theirFile, ourFile, abort = getFiles(menuOption)
            if abort == False:
                convert(theirFile, ourFile)
        elif menuOption == 'D':
            theirFile, ourFile, abort = getFiles(menuOption)
            if abort == False:
                convert(theirFile, ourFile)
        else:
            print("Error - Invalid Option.")
    
    input("\nRun complete. Press the Enter key to exit.")

def displayMenuAndGetOption():
    #Function Variable Definitions
    print()
    print("File Encryption Program")
    print()
    print("E = Encrypt a file")
    print("D = Decrypt a file")
    print("Q = Quit the program")
    print()
    menuSelection = input("Enter menu selection (E, D, or Q): ").upper()
    print()
    return menuSelection

def getFiles(option):
    if option == 'E':
        fileName = input("Enter the file to ENCRYPT. Press Enter alone to abort: ")
    elif option == 'D':
        fileName = input("Enter the file to DECRYPT. Press Enter alone to abort: ")

    while fileName != '':
        try:
            fileName = open(fileName, 'r')
        except IOError:
            print("Error - ", fileName, "does not exist")
            if option == 'E':
                print()
                fileName = input("Enter the file to ENCRYPT. Press Enter alone to abort: ")
            else:
                fileName = input("Enter the file to DECRYPT. Press Enter alone to abort: ")
        else:
            fileData = fileName.read()
            outputNameOfFile = input("Enter the output file name: ")
            abort = False
            return fileData, outputNameOfFile, abort

    if fileName == '':
        abort = True
        inputNameOfFile = "place Holder"
        outputNameOfFile = "place holder"
        return inputNameOfFile, outputNameOfFile, abort

def convert(inputFile, outputFile):

    #Function Variable Definitions
    outputName = open(outputFile, 'w')

    # Encryption and decryption are inverse of one another
    CODE = {'A':')','a':'0','B':'(','b':'9','C':'*','c':'8',\
            'D':'&','d':'7','E':'^','e':'6','F':'%','f':'5',\
            'G':'$','g':'4','H':'#','h':'3','I':'@','i':'2',\
            'J':'!','j':'1','K':'Z','k':'z','L':'Y','l':'y',\
            'M':'X','m':'x','N':'W','n':'w','O':'V','o':'v',\
            'P':'U','p':'u','Q':'T','q':'t','R':'S','r':'s',\
            'S':'R','s':'r','T':'Q','t':'q','U':'P','u':'p',\
            'V':'O','v':'o','W':'N','w':'n','X':'M','x':'m',\
            'Y':'L','y':'l','Z':'K','z':'k','!':'J','1':'j',\
            '@':'I','2':'i','#':'H','3':'h','$':'G','4':'g',\
            '%':'F','5':'f','^':'E','6':'e','&':'D','7':'d',\
            '*':'C','8':'c','(':'B','9':'b',')':'A','0':'a',\
            ':':',',',':':','?':'.','.':'?','<':'>','>':'<',\
            "'":'"','"':"'",'+':'-','-':'+','=':';',';':'=',\
            '{':'[','[':'{','}':']',']':'}'}
    for character in inputFile:
        outputName.write(CODE.get(character,character))
    outputName.close()

#-----------------------------------------------------------------------
# PROGRAM'S MAIN LOGIC
#

main()

