################
## EXERCISE SOLUTIONS
################

# Print "All Work And No Play Makes Jack A Dull Boy" 10 times

for i in range(0,10):
    print "All Work And No Play Makes Jack A Dull Boy"

# Print "I have written this sentence i times", where i goes from 1 to 10

for i in range(1,11):
    print "I have written this sentence", i, "times"

# Use an if statement to print whether there is a 'z' in the pledge of allegiance

pledge = "I pledge allegiance to the flag, of the United States of America, and to the republic, for which it stands, one nation, indivisible, with liberty and justice for all."

if 'z' in pledge:
    print "I found z!"
else:
    print "I found no z."
    
#-------------------------------------------------------------------------------

# Square brackets are used to create a list.

mylist = ['a','b','c']

# Lists can be indexed, have a length, and can be iterated over.

print mylist[-1]    # last item in the list
print len(mylist)   # list length
for item in mylist:
    print item

# We can use the 'split' function to split a string into words

pledgewords = pledge.split()
print "The pledge has", len(pledgewords), "words."

#################
## EXERCISE
#################

foo = ["dogs","cats","fish","zebras"]

# ==> Go here: http://docs.python.org/2/library/stdtypes.html#string-methods
# for the list of methods that string objects have.  Feel free to google for solutions!

# Write a for loop to print out each element of the list 'foo'
# How many characters total are in the list 'foo'?
# Write a for loop that prints out all of the words in the pledge containing the letter 'e'
# Do the above, but print the words out in ALL CAPS
# Print out the longest word in the pledge
# Repeat the above, but remove all punctuation