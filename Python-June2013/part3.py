################
## EXERCISE SOLUTIONS
################

foo = ["dogs","cats","fish","zebras"]
pledge = "I pledge allegiance to the flag, of the United States of America, and to the republic, for which it stands, one nation, indivisible, with liberty and justice for all."

# ==> Go here: http://docs.python.org/2/library/stdtypes.html#string-methods
# for the list of methods that string objects have.  Feel free to google for solutions!

# Write a for loop to print out each element of the list 'foo'

for elem in foo:
    print elem

# How many characters total are in the list 'foo'?

totallength = 0
for elem in foo:
    totallength = len(elem)+totallength

# Write a for loop that prints out all of the words in the pledge containing the letter 'e'

for word in pledge.split():
    if 'e' in word:
        print word

# Do the above, but print the words out in ALL CAPS
for word in pledge.split():
    if 'e' in word:
        print word.upper()

# Print out the longest word in the pledge
longest = ''
for word in pledge.split():
    if len(word)>len(longest):
        longest = word
print longest.upper(), "is the longest word in the pledge."

# Print out the longest word in the pledge without punctuation
longest = ''
for word in pledge.replace(',','').replace('.','').split():
    if len(word)>len(longest):
        longest = word
print longest.upper(), "is the longest word in the pledge."


#-------------------------------------------------------------------------------

# Python has a number of external libraries that you can use, 
# and there are more that you can install.

# To use them, use the 'import' statement:

import re

# The re module is for regular expressions, which are a very powerful way to
# search through text.

re.findall('.+?e\W',pledge)

# next: urllib2, ElementTree:
# http://docs.python.org/2/library/xml.etree.elementtree.html

