# Welcome to Python!  This line is a comment, and it is not read by Python, it's
# just a way for us to describe what's happening in the code.  Any line that
# starts with the # character will be a comment.

# Python is an interpreted language - each line is evaluated on the fly.  Copy
# this line to the "Python Shell" or just type it in and see what happens.
print("hello world")

# Python is a language, as well as a program that evaluates Python code.  Unlike
# Matlab, Stata, SPSS and similar programs, there is no "integrated development
# environment" that is synonymous with Python.  I recommend Wing IDE for
# starting out, but you can use whatever you like!

# Evaluate the next lines:

mystring = "Hello World"
myinteger = 4
myfloat = 4.0

# Python assigns the thing on the right to the variable name on the left.
# Python can figure out whether the variable is text, integer, or decimal.

type(mystring)
type(myinteger)
type(myfloat)

# Python is object oriented.  mystring is an object of type <str>, or string.
# Objects have methods, which are functions that work just on that type of object.
# You can call methods using a given instance of an object followed by a period
# and the method name.

name = 'Alex'
name.upper()

# Notice, this does not change the initial string!

pledge = "I pledge allegiance to the flag, of the United States of America, and to the republic, for which it stands, one nation, indivisible, with liberty and justice for all."

# We can use the in operator to ask some questions about a string.

'nation' in pledge

# This returns True, indicating that the word 'nation' is in the pledge of allegiance.

# We can use things that evaluate to True/False in logical branching statements.

# Python has a special syntax for this involving a colon and indentation!
# It's very picky about it!

wordcheck = 'nation'
if wordcheck in pledge:
    print "I found the word:", wordcheck
else:
    print "I didn't find the word:", wordcheck
    
# You can also use the 'in' operator to see if a letter is in a word

lettercheck = 'a'
if lettercheck in wordcheck:
    print "The word", wordcheck, "has the letter", lettercheck
else:
    print "The word", wordcheck, "does not have the letter", lettercheck

# We can think of a string as a collection of letters
    
myword = 'pledges'

# The first letter
print myword[0]

# The second letter
print myword[1]

# The last letter
print myword[-1]

# If we want to print out each letter one at a time, we can do this:

print myword[0]
print myword[1]
print myword[2]
print myword[3]
print myword[4]
print myword[5]
print myword[6]

# Obviously, this is not the best.  We'd rather say something like:
#
# print myword[i], where i starts at 0 and then goes until you get to 6

# The way to do this is with a "for" loop and the "range" function

for i in range(0,7):
    print myword[i]
    
# Here, we had to use our psychic powers to know the word had 7 letters.
# Here's a better way:

for i in range(0,len(myword)):
    print myword[i]
    
# Python is actually very flexible about for loops.
#
# for [variable] in [values]:
#     [code where variable is interpreted as each value]

# You can treat the word as the values, like this:

for letter in myword:
    print letter
    
# This concise way of writing this is very "pythonic".  It is easy to read and
# the "right" way to do this in python.  Python tries to have a "right" way, but
# as you're learning, the right way is the one that works!

################
## EXERCISES
################

# Print "All Work And No Play Makes Jack A Dull Boy" 10 times
# Print "I have written this sentence i times", where i goes from 1 to 10
# Use an if statement to print whether there is a 'z' in the pledge of allegiance