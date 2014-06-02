<map version="0.9.0">

<node COLOR="#000000">
<font NAME="SansSerif" SIZE="20"/>
<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Introduction to R
</p>
</body>
</html>
</richcontent>
<node COLOR="#0033ff" ID="sec-1" POSITION="right" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Workshop Materials and Introduction
</p>
</body>
</html>
</richcontent>
<node COLOR="#00b439" ID="sec-1-1" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Materials and setup
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Everyone should have R installed &#x2013;if not:
</p>

<ul class="org-ul">
<li>Open a web browser and go to <a href="http://cran.r-project.org">http://cran.r-project.org</a> and download and install it
</li>
<li>Also helpful to install RStudo (download from <a href="http://rstudio.com">http://rstudio.com</a>)
</li>
</ul>

<p>
Materials for this workshop include slides, example data sets, and example code.
</p>

<ul class="org-ul">
<li>Download materials from <a href="http://j.mp/intro-r">http://j.mp/intro-r</a>
</li>
<li>Extract the zip file containing the materials to your desktop
</li>
</ul>

<p>
Workshop notes are available in .hmtl and .pdf format. Navigate to your desktop and open either Rintro.pdf or Rintro.html.
</p>
</body>
</html>
</richcontent>
<attribute NAME="setup" VALUE=""/>
</node>

<node COLOR="#00b439" ID="sec-1-2" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>What is R?
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
R is a programming language designed for statistical computing. Notable characteristics include:
</p>

<ul class="org-ul">
<li>Vast capabilities, wide range of statistical and graphical techniques
</li>

<li>Very popular in academia, growing popularity in business: <a href="http://r4stats.com/articles/popularity/">http://r4stats.com/articles/popularity/</a>
</li>

<li>Written primarily by statisticians
</li>

<li>FREE (no cost, open source)
</li>

<li>Excellent community support: mailing list, blogs, tutorials
</li>

<li>Easy to extend by writing new functions
</li>
</ul>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-1-3" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Coming to R
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Comming from&#x2026;
</p>
<dl class="org-dl">
<dt> matlab </dt><dd><a href="http://www.math.umaine.edu/~hiebeler/comp/matlabR.pdf">http://www.math.umaine.edu/~hiebeler/comp/matlabR.pdf</a>
</dd>
<dt> SciPy </dt><dd><a href="http://mathesaurus.sourceforge.net/matlab-python-xref.pdf">http://mathesaurus.sourceforge.net/matlab-python-xref.pdf</a>
</dd>
<dt> SAS/SPSS </dt><dd><a href="http://www.et.bs.ehu.es/~etptupaf/pub/R/RforSAS&SPSSusers.pdf">http://www.et.bs.ehu.es/~etptupaf/pub/R/RforSAS&SPSSusers.pdf</a> 
</dd>
<dt> Stata </dt><dd><a href="http://www.dss.princeton.edu/training/RStata.pdf">http://www.dss.princeton.edu/training/RStata.pdf</a>
</dd>
</dl>
</body>
</html>
</richcontent>
</node>

</node>

<node COLOR="#0033ff" ID="sec-2" POSITION="left" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Graphical User Interfaces
</p>
</body>
</html>
</richcontent>
<node COLOR="#00b439" ID="sec-2-1" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>R GUI alternatives (no GUI)
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
The old-school way is to run R directly in a terminal
</p>


<div class="figure">
<p><img src="images/Rconsole.png" alt="Rconsole.png" />
</p>
</div>

<p>
But hardly anybody does it that way anymore!
</p>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-2-2" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>R GUI alternatives (Windows default)
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<div class="figure">
<p><img src="images/Rgui.png" alt="Rgui.png" />
</p>
</div>

<p>
The default windows GUI is not very good
</p>
<ul class="org-ul">
<li>No parentheses matching or syntax highlighting
</li>
<li>No work-space browser
</li>
</ul>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-2-3" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>R GUI Alternatives (Rstudio on Mac)
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<div class="figure">
<p><img src="images/Rstudio.png" alt="Rstudio.png" />
</p>
</div>

<p>
Rstudio has many useful features, including parentheses matching and auto-completion
</p>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-2-4" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>R GUI Alternatives (Emacs with ESS)
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<div class="figure">
<p><img src="images/emacs.png" alt="emacs.png" />
</p>
</div>

<p>
Emacs + ESS is a very powerful combination, but can be difficult to set up
</p>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-2-5" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Components of R GUIs
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ul class="org-ul">
<li>The R console
<ul class="org-ul">
<li>Displays command history and results
</li>
<li>Commands can be typed directly in the console
</li>
<li>R Console work disappears once session is closed
</li>
</ul>
</li>

<li>A text editor
<ul class="org-ul">
<li>A plain text editor for writing R code
</li>
<li>Good ones will have syntax highlighting, parentheses matching etc.
</li>
<li>Anything that modifies your data should be done in a text editor
</li>
</ul>
</li>

<li>Graphics windows
<ul class="org-ul">
<li>View, re-size, and save graphics
</li>
<li>A good GUI will allow you to cycle through graph history
</li>
</ul>
</li>

<li>Work-space viewer
<ul class="org-ul">
<li>Some GUIs have work-space browsers that allow you to see stored objects
</li>
<li>Very helpful if you are absentminded like me and frequently forget what names you gave your data!
</li>
</ul>
</li>
</ul>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-2-6" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Asking R for help
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ul class="org-ul">
<li>Start html help, search/browse using web browser
<ul class="org-ul">
<li>at the R console:
<div class="org-src-container">

<pre class="src src-R"><span style="color: #0000ff;">help.start</span>()
</pre>
</div>
</li>

<li>or use the help menu from you GUI
</li>
</ul>
</li>

<li>Look up the documentation for a function
<div class="org-src-container">

<pre class="src src-R"><span style="color: #0000ff;">help</span>(topicName)
</pre>
</div>

<div class="org-src-container">

<pre class="src src-R">?topicName
</pre>
</div>
</li>

<li>Look up documentation for a package
<div class="org-src-container">

<pre class="src src-R"><span style="color: #0000ff;">help</span>(package<span style="color: #008b8b;">=</span><span style="color: #8b2252;">"packageName"</span>)
</pre>
</div>
</li>

<li>Search documentation from R (not always the best way&#x2026; google often works better)
<div class="org-src-container">

<pre class="src src-R"><span style="color: #0000ff;">help.search</span>(<span style="color: #8b2252;">"topicName"</span>)
</pre>
</div>
</li>
</ul>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-2-7" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>R packages and libraries
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
There are thousands of R packages that extend R's capabilities.
</p>

<ul class="org-ul">
<li>To view available packages: 
<div class="org-src-container">

<pre class="src src-R"><span style="color: #008b8b;">library</span>()
</pre>
</div>
</li>

<li>To see what packages are loaded: 
<div class="org-src-container">

<pre class="src src-R"><span style="color: #0000ff;">search</span>()
</pre>
</div>
</li>

<li>To load a package: 
<div class="org-src-container">

<pre class="src src-R"><span style="color: #008b8b;">library</span>(<span style="color: #8b2252;">"packageName"</span>)
</pre>
</div>
</li>

<li>Install new package: 
<div class="org-src-container">

<pre class="src src-R"><span style="color: #0000ff;">install.packages</span>(<span style="color: #8b2252;">"packageName"</span>)
</pre>
</div>
</li>
</ul>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-2-8" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Things to keep in mind
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ul class="org-ul">
<li>Case sensitive, like Stata (unlike SAS)
</li>

<li>Comments can be put almost anywhere, starting with a hash mark ('<code>#</code>'); everything to the end of the line is a comment
</li>

<li>The command prompt "<code>&gt;</code>" indicates that R is ready to receive commands
</li>

<li>If a command is not complete at the end of a line, R will give a different prompt, '<code>+</code>' by default
</li>

<li>Parentheses must always match (first thing to check if you get an error)
</li>

<li>R Does not care about spaces between commands or arguments
</li>

<li>Names should start with a letter and should not contain spaces
</li>

<li>Can use "." in object names (e.g., "my.data")
</li>

<li>Use forward slash ("/") instead of backslash in path names, even on Windows
</li>
</ul>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-2-9" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Exercise 0
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ol class="org-ol">
<li>Try to get R to add 2 plus 2
</li>
<li>See if you can find the help page for the "mean" topic
</li>
<li>Using any means available, try to figure out how to run a linear regression model in R
</li>
<li>Go to <a href="http://cran.r-project.org/web/views/">http://cran.r-project.org/web/views/</a> and skim the topic closest to your field/interests
</li>
</ol>
</body>
</html>
</richcontent>
</node>

</node>



<node COLOR="#0033ff" ID="sec-3" POSITION="right" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Data and Functions
</p>
</body>
</html>
</richcontent>
<node COLOR="#00b439" ID="sec-3-1" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Assignment
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Values can be assigned names and used in subsequent operations
</p>
<ul class="org-ul">
<li>The <code>&lt;-</code> operator (less than followed by a dash) is used to save values
</li>
<li>The name on the left gets the value on the right.
</li>
</ul>

<div class="org-src-container">

<pre class="src src-R" id="firstRExample">x <span style="color: #008b8b;">&lt;-</span> <span style="color: #228b22;">11</span> <span style="color: #b22222;"># </span><span style="color: #b22222;">Assign the value 10 to a variable named x</span>
x <span style="color: #008b8b;">+</span> <span style="color: #228b22;">1</span> <span style="color: #b22222;"># </span><span style="color: #b22222;">Add 1 to x</span>
y <span style="color: #008b8b;">&lt;-</span> x <span style="color: #008b8b;">+</span> <span style="color: #228b22;">1</span> <span style="color: #b22222;"># </span><span style="color: #b22222;">Assign y the value x + 1</span>
y
</pre>
</div>

<pre class="example">
&gt; x &lt;- 11 # Assign the value 10 to a variable named x
&gt; x + 1 # Add 1 to x
[1] 12
&gt; y &lt;- x + 1 # Assign y the value x + 1
&gt; y
[1] 12
&gt;
</pre>


<p>
Saved variables can be listed, overwritten and deleted
</p>
<div class="org-src-container">

<pre class="src src-R" id="listOverwriteDelete"><span style="color: #0000ff;">ls</span>() <span style="color: #b22222;"># </span><span style="color: #b22222;">List variables in workspace</span>
x <span style="color: #b22222;"># </span><span style="color: #b22222;">Print the value of x</span>
x <span style="color: #008b8b;">&lt;-</span> <span style="color: #228b22;">100</span> <span style="color: #b22222;"># </span><span style="color: #b22222;">Overwrite x. Note that no warning is given!</span>
x
<span style="color: #0000ff;">rm</span>(x) <span style="color: #b22222;"># </span><span style="color: #b22222;">Delete x</span>
<span style="color: #0000ff;">ls</span>()
</pre>
</div>

<pre class="example">
&gt; ls() # List variables in workspace
[1] "x" "y"
&gt; x # Print the value of x
[1] 11
&gt; x &lt;- 100 # Overwrite x. Note that no warning is given!
&gt; x
[1] 100
&gt; rm(x) # Delete x
&gt; ls()
[1] "y"
&gt;
</pre>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-3-2" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Functions
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Using R is mostly about applying <b>functions</b> to <b>variables</b>. Functions
</p>
<ul class="org-ul">
<li>take <b>variable(s)</b> as input <b>argument(s)</b>
</li>
<li>perform operations
</li>
<li><b>return</b> values which can be <b>assigned</b>
</li>
<li>optionally perform side-effects such as writing a file to disk or opening a graphics window
</li>
</ul>

<p>
The general form for calling R functions is 
</p>
<div class="org-src-container">

<pre class="src src-R"><span style="color: #0000ff;">FunctionName</span>(arg.1, arg.2, ... arg.n)
</pre>
</div>

<p>
Arguments can be matched by position or name
</p>

<p>
Examples:
</p>
<div class="org-src-container">

<pre class="src src-R" id="functionExamples"><span style="color: #b22222;">#</span><span style="color: #b22222;">?sqrt</span>
a <span style="color: #008b8b;">&lt;-</span> <span style="color: #0000ff;">sqrt</span>(y) <span style="color: #b22222;"># </span><span style="color: #b22222;">Call the sqrt function with argument x=y</span>
<span style="color: #0000ff;">round</span>(a, digits <span style="color: #008b8b;">=</span> <span style="color: #228b22;">2</span>) <span style="color: #b22222;"># </span><span style="color: #b22222;">Call round() with arguments x=x and digits=2</span>
<span style="color: #b22222;"># </span><span style="color: #b22222;">Functions can be nested so an alternative is</span>
<span style="color: #0000ff;">round</span>(<span style="color: #0000ff;">sqrt</span>(y), digits <span style="color: #008b8b;">=</span> <span style="color: #228b22;">5</span>) <span style="color: #b22222;"># </span><span style="color: #b22222;">Take sqrt of a and round</span>
</pre>
</div>

<pre class="example">
&gt; #?sqrt
&gt; a &lt;- sqrt(y) # Call the sqrt function with argument x=y
&gt; round(a, digits = 2) # Call round() with arguments x=x and digits=2
[1] 3.46
&gt; # Functions can be nested so an alternative is
&gt; round(sqrt(y), digits = 5) # Take sqrt of a and round
[1] 3.4641
&gt;
</pre>
</body>
</html>
</richcontent>
</node>

</node>


<node COLOR="#0033ff" ID="sec-4" POSITION="left" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Getting data into R
</p>
</body>
</html>
</richcontent>
<node COLOR="#00b439" ID="sec-4-1" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>The gss dataset
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
The next few examples use a subset of the General Social Survey data set. The variables in this subset include
</p>
<div class="org-src-container">

<pre class="src src-R" id="GSSinfo"><span style="color: #0000ff;">head</span>(<span style="color: #0000ff;">read.csv</span>(<span style="color: #8b2252;">"dataSets/gssInfo.csv"</span>)) 
<span style="color: #b22222;">#</span><span style="color: #b22222;">see gssInfo.csv for rest of the variable descriptions</span>
</pre>
</div>

<pre class="example">
&gt; head(read.csv("dataSets/gssInfo.csv")) 
      var                      description
1 marital                   marital status
2     age                age of respondent
3    educ highest year of school completed
4     sex                  respondents sex
5     inc               respondents income
6   happy                general happiness
&gt; #see gssInfo.csv for rest of the variable descriptions
&gt;
</pre>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-4-2" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>The "working directory" and listing files
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
R knows the directory it was started in, and refers to this as the "working directory". Since our workshop examples are in the Rintro folder on the desktop, we should all take a moment to set that as our working directory:
</p>
<div class="org-src-container">

<pre class="src src-R" id="SetDesktopWorkingDirectory"><span style="color: #0000ff;">setwd</span>(<span style="color: #8b2252;">"~/Desktop/Rintro"</span>)
</pre>
</div>

<p>
We can also set the working directory using paths relative to the current working directory:
</p>

<div class="org-src-container">

<pre class="src src-R" id="getWD"><span style="color: #0000ff;">getwd</span>() <span style="color: #b22222;"># </span><span style="color: #b22222;">get the current working directory</span>
<span style="color: #0000ff;">setwd</span>(<span style="color: #8b2252;">"dataSets"</span>) <span style="color: #b22222;"># </span><span style="color: #b22222;">set wd to the dataSets folder</span>
<span style="color: #0000ff;">getwd</span>()
<span style="color: #0000ff;">setwd</span>(<span style="color: #8b2252;">".."</span>) <span style="color: #b22222;"># </span><span style="color: #b22222;">set wd to enclosing folder ("up")</span>
</pre>
</div>

<pre class="example">
&gt; getwd() # get the current working directory
[1] "/home/izahn/Documents/Work/IQSS/Classes/Workshops/R/Rintro"
&gt; setwd("dataSets") # set wd to the dataSets folder
&gt; getwd()
[1] "/home/izahn/Documents/Work/IQSS/Classes/Workshops/R/Rintro/dataSets"
&gt; setwd("..") # set wd to enclosing folder ("up")
&gt;
</pre>

<p>
It can be convenient to list files in a directory without leaving R
</p>
<div class="org-src-container">

<pre class="src src-R" id="listFilesExample"><span style="color: #0000ff;">list.files</span>(<span style="color: #8b2252;">"dataSets"</span>) <span style="color: #b22222;"># </span><span style="color: #b22222;">list files in the dataSets folder</span>
<span style="color: #b22222;"># </span><span style="color: #b22222;">list.files("dataSets", pattern = ".csv") # restrict to .csv files</span>
</pre>
</div>

<pre class="example">
&gt; list.files("dataSets") # list files in the dataSets folder
 [1] "gss.csv"            "gss.dta"            "gssInfo.csv"       
 [4] "gss.rds"            "gss.sas7bdat"       "gss.sav"           
 [7] "gss.xlsx"           "statesCodebook.txt" "states.csv"        
[10] "states.dta"         "states.xlsx"       
&gt; # list.files("dataSets", pattern = ".csv") # restrict to .csv files  
&gt;
</pre>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-4-3" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Importing data from files
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
In order to read data from a file, you have to know what kind of file it is. The table below lists the functions needed to import data from common file formats.
</p>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="left" />

<col  class="left" />

<col  class="left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="left">data type</th>
<th scope="col" class="left">function</th>
<th scope="col" class="left">package</th>
</tr>
</thead>
<tbody>
<tr>
<td class="left">comma separated (.csv)</td>
<td class="left">read.csv()</td>
<td class="left">utils (default)</td>
</tr>

<tr>
<td class="left">other delimited formats</td>
<td class="left">read.table()</td>
<td class="left">utils (default)</td>
</tr>

<tr>
<td class="left">Stata (.dta)</td>
<td class="left">read.dta()</td>
<td class="left">foreign</td>
</tr>

<tr>
<td class="left">SPSS (.sav)</td>
<td class="left">read.spss()</td>
<td class="left">foreign</td>
</tr>

<tr>
<td class="left">SAS (.sas7bdat)</td>
<td class="left">read.sas7bdat()</td>
<td class="left">sas7bdat</td>
</tr>

<tr>
<td class="left">Excel (.xls, .xlsx)</td>
<td class="left">readWorksheetFromFile()</td>
<td class="left">XLConnect</td>
</tr>
</tbody>
</table>

<p>
Examples:
</p>
<div class="org-src-container">

<pre class="src src-R" id="readRDS"><span style="color: #b22222;"># </span><span style="color: #b22222;">read gss data from the gss.rds R file</span>
datGSS <span style="color: #008b8b;">&lt;-</span> <span style="color: #0000ff;">readRDS</span>(<span style="color: #8b2252;">"dataSets/gss.rds"</span>)
<span style="color: #b22222;"># </span><span style="color: #b22222;">read gss data from the gss.csv comma separated file</span>
gss.data <span style="color: #008b8b;">&lt;-</span> <span style="color: #0000ff;">read.csv</span>(<span style="color: #8b2252;">"dataSets/gss.csv"</span>) <span style="color: #b22222;"># </span><span style="color: #b22222;">read gss data</span>
<span style="color: #b22222;"># </span><span style="color: #b22222;">read a Stata dataset from gss.dta </span>
<span style="color: #008b8b;">library</span>(foreign) <span style="color: #b22222;"># </span><span style="color: #b22222;">load foreign data functions</span>
datGSS <span style="color: #008b8b;">&lt;-</span> <span style="color: #0000ff;">read.dta</span>(file<span style="color: #008b8b;">=</span><span style="color: #8b2252;">"dataSets/gss.dta"</span>)
</pre>
</div>

<pre class="example">
&gt; # read gss data from the gss.rds R file
&gt; datGSS &lt;- readRDS("dataSets/gss.rds")
&gt; # read gss data from the gss.csv comma separated file
&gt; gss.data &lt;- read.csv("dataSets/gss.csv") # read gss data
&gt; # read a Stata dataset from gss.dta 
&gt; library(foreign) # load foreign data functions
&gt; datGSS &lt;- read.dta(file="dataSets/gss.dta")
&gt;
</pre>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-4-4" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Checking imported data
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Always a good idea  to examine the imported data set&#x2013;usually we want the results to be a <code>data.frame</code>
</p>
<div class="org-src-container">

<pre class="src src-R" id="ExamineStataData"><span style="color: #0000ff;">class</span>(datGSS) <span style="color: #b22222;"># </span><span style="color: #b22222;">check to see that test is what we expect it to be</span>
<span style="color: #0000ff;">dim</span>(datGSS) <span style="color: #b22222;"># </span><span style="color: #b22222;">how many rows and columns?</span>
<span style="color: #0000ff;">names</span>(datGSS)[<span style="color: #228b22;">1</span>:<span style="color: #228b22;">10</span>] <span style="color: #b22222;"># </span><span style="color: #b22222;">first 10 column names</span>
<span style="color: #0000ff;">str</span>(datGSS[<span style="color: #228b22;">1</span>:<span style="color: #228b22;">5</span>]) <span style="color: #b22222;"># </span><span style="color: #b22222;">more details about the first 5 columns</span>
</pre>
</div>

<pre class="example">
&gt; class(datGSS) # check to see that test is what we expect it to be
[1] "data.frame"
&gt; dim(datGSS) # how many rows and columns?
[1] 1419   35
&gt; names(datGSS)[1:10] # first 10 column names
 [1] "age"      "educ"     "emailhrs" "hrs1"     "sex"      "usecomp" 
 [7] "usemail"  "useweb"   "webhrs"   "hapmar"  
&gt; str(datGSS[1:5]) # more details about the first 5 columns
'data.frame':	1419 obs. of  5 variables:
 $ age     : num  69 27 19 21 19 87 42 19 78 70 ...
 $ educ    : num  12 10 11 9 11 8 11 11 7 9 ...
 $ emailhrs: num  -1 -1 0 -1 50 -1 3 -1 -1 -1 ...
 $ hrs1    : num  -1 60 32 20 -1 -1 -1 -1 -1 22 ...
 $ sex     : Factor w/ 2 levels "Male","Female": 1 1 1 1 1 2 1 2 2 2 ...
&gt;
</pre>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-4-5" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Saving and loading R  workspaces
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
In addition to importing individual datasets, R can save and load entire workspaces
</p>
<ul class="org-ul">
<li>Save our entire workspace
</li>
</ul>
<div class="org-src-container">

<pre class="src src-R" id="saveDelete"><span style="color: #0000ff;">ls</span>() <span style="color: #b22222;"># </span><span style="color: #b22222;">list objects in our workspace</span>
<span style="color: #0000ff;">save.image</span>(file<span style="color: #008b8b;">=</span><span style="color: #8b2252;">"myWorkspace.RData"</span>) <span style="color: #b22222;"># </span><span style="color: #b22222;">save workspace </span>
<span style="color: #0000ff;">rm</span>(list<span style="color: #008b8b;">=</span><span style="color: #0000ff;">ls</span>()) <span style="color: #b22222;"># </span><span style="color: #b22222;">remove all objects from our workspace </span>
<span style="color: #0000ff;">ls</span>() <span style="color: #b22222;"># </span><span style="color: #b22222;">list stored objects to make sure they are deleted</span>
</pre>
</div>

<pre class="example">
&gt; ls() # list objects in our workspace
[1] "a"        "datGSS"   "gss.data" "y"       
&gt; save.image(file="myWorkspace.RData") # save workspace 
&gt; rm(list=ls()) # remove all objects from our workspace 
&gt; ls() # list stored objects to make sure they are deleted
character(0)
&gt;
</pre>

<ul class="org-ul">
<li>Load the "myWorkspace.RData" file and check that it is restored
</li>
</ul>

<div class="org-src-container">

<pre class="src src-R" id="loadList"><span style="color: #0000ff;">load</span>(<span style="color: #8b2252;">"myWorkspace.RData"</span>) <span style="color: #b22222;"># </span><span style="color: #b22222;">load myWorkspace.RData</span>
<span style="color: #0000ff;">ls</span>() <span style="color: #b22222;"># </span><span style="color: #b22222;">list objects</span>
</pre>
</div>

<pre class="example">
&gt; load("myWorkspace.RData") # load myWorkspace.RData
&gt; ls() # list objects
[1] "a"        "datGSS"   "gss.data" "y"       
&gt;
</pre>

<p>
When you close R you will be asked if you want to save your workspace &#x2013; if you choose yes then your workspace will be restored next time you start R
</p>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-4-6" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Exercise 2: loading and manipulating data
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ol class="org-ol">
<li>Load the foreign package if you haven't already done so (<code>library(foreign)</code>)
</li>

<li>Look at the help page for the read.spss function
</li>

<li>Read the SPSS data set in dataSets/gss.sav and assign the result to an R data object named GSS.sav
</li>

<li>Make sure that the data loaded in step 2 is a data.frame (hint: check the arguments documented in the help page)
</li>

<li>Display the dimensions of the GSS.sav. 
</li>

<li>BONUS: figure out how to read the Excel file "gss.xlsx" into R
</li>
</ol>
</body>
</html>
</richcontent>
</node>

</node>


<node COLOR="#0033ff" ID="sec-5" POSITION="right" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Data Manipulation
</p>
</body>
</html>
</richcontent>
<node COLOR="#00b439" ID="sec-5-1" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>data.frame objects
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ul class="org-ul">
<li>Usually data read into R will be stored as a <b>data.frame</b>
</li>

<li>A data.frame is a list of vectors of equal length
<ul class="org-ul">
<li>Each vector in the list forms a column
</li>
<li>Each column can be a differnt type of vector
</li>
<li>Often the columns are variables and the rows are observations
</li>
</ul>
</li>

<li>A data.frame has two dimensions corresponding the number of rows and the number of columns (in that order)
</li>
</ul>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-5-2" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>data.frame meta-data
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
A number of functions are available for inspecting data.frame objects:
</p>

<div class="org-src-container">

<pre class="src src-R" id="getAttributes"><span style="color: #b22222;"># </span><span style="color: #b22222;">row and column names</span>
<span style="color: #0000ff;">head</span>(<span style="color: #0000ff;">names</span>(datGSS)) <span style="color: #b22222;"># </span><span style="color: #b22222;">variable names in datGSS</span>
<span style="color: #0000ff;">head</span>(<span style="color: #0000ff;">rownames</span>(datGSS)) <span style="color: #b22222;"># </span><span style="color: #b22222;">first few rownames of datGSS</span>
<span style="color: #b22222;"># </span><span style="color: #b22222;">dimensions</span>
<span style="color: #0000ff;">dim</span>(datGSS)
<span style="color: #b22222;"># </span><span style="color: #b22222;">structure</span>
<span style="color: #b22222;">#</span><span style="color: #b22222;">str(datGSS) # get structure</span>
</pre>
</div>

<pre class="example">
&gt; # row and column names
&gt; head(names(datGSS)) # variable names in datGSS
[1] "age"      "educ"     "emailhrs" "hrs1"     "sex"      "usecomp" 
&gt; head(rownames(datGSS)) # first few rownames of datGSS
[1] "1" "2" "3" "4" "5" "6"
&gt; # dimensions
&gt; dim(datGSS)
[1] 1419   35
&gt; # structure
&gt; #str(datGSS) # get structure
&gt;
</pre>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-5-3" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Logical operators
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
It is often useful to select just those rows of your data where some condition holds&#x2013;for example select only rows where sex is 1 (male). The following operators allow you to do this:
</p>

<dl class="org-dl">
<dt> == </dt><dd>equal to 
</dd>
<dt> != </dt><dd>not equal to
</dd>
<dt> &gt; </dt><dd>greater than
</dd>
<dt> &lt; </dt><dd>less than
</dd>
<dt> &gt;= </dt><dd>greater than or equal to
</dd>
<dt> &lt;= </dt><dd>less than or equal to
</dd>
<dt> &amp; </dt><dd>and
</dd>
<dt> | </dt><dd>or
</dd>
</dl>

<p>
Note the double equals signs for testing equality. The following example show how to use some of these operators to extract and replace elements matching specific conditions.
</p>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-5-4" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Extracting subsets of data.frames
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
You can flexibly extract subsets of data.frames using single brackets
</p>
<ul class="org-ul">
<li>The first index corresponds to rows, the second to columns
</li>
<li>Empty index means "all"
</li>
</ul>

<div class="org-src-container">

<pre class="src src-R" id="indexingDataFrame"><span style="color: #b22222;"># </span><span style="color: #b22222;">extracting subsets</span>
<span style="color: #b22222;"># </span><span style="color: #b22222;">datGSS[c(1,2), ] # rows 1 and 2, all columns</span>
<span style="color: #b22222;"># </span><span style="color: #b22222;">datGSS[ , c(1,2)] # all rows, columns 1 and 2</span>
<span style="color: #b22222;"># </span><span style="color: #b22222;">datGSS[ , c("age", "educ")] # same as above</span>

datGSS[<span style="color: #228b22;">1</span>:<span style="color: #228b22;">5</span>, <span style="color: #228b22;">1</span>] <span style="color: #b22222;"># </span><span style="color: #b22222;">rows 1 through 5, column 1</span>
datGSS[<span style="color: #228b22;">1</span>:<span style="color: #228b22;">5</span>, <span style="color: #8b2252;">"educ"</span>] <span style="color: #b22222;"># </span><span style="color: #b22222;">rows 1-5, column "educ"</span>
datGSS[datGSS[, <span style="color: #8b2252;">"age"</span>] <span style="color: #008b8b;">&gt;</span> <span style="color: #228b22;">90</span>, <span style="color: #0000ff;">c</span>(<span style="color: #8b2252;">"sex"</span>, <span style="color: #8b2252;">"age"</span>)] <span style="color: #b22222;"># </span><span style="color: #b22222;">rows where age &gt; 90</span>
</pre>
</div>

<pre class="example">
&gt; # extracting subsets
&gt; # datGSS[c(1,2), ] # rows 1 and 2, all columns
&gt; # datGSS[ , c(1,2)] # all rows, columns 1 and 2
&gt; # datGSS[ , c("age", "educ")] # same as above
&gt; 
&gt; datGSS[1:5, 1] # rows 1 through 5, column 1
[1] 69 27 19 21 19
&gt; datGSS[1:5, "educ"] # rows 1-5, column "educ"
[1] 12 10 11  9 11
&gt; datGSS[datGSS[, "age"] &gt; 90, c("sex", "age")] # rows where age &gt; 90
       sex age
315 Female  99
665   Male  99
&gt;
</pre>

<p>
Note the use of the <code>c()</code> function to combine arguments
</p>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-5-5" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Replacing subsets of data.frames
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
You can flexibly create and replace subsets of data.frames using bracket notation
</p>

<div class="org-src-container">

<pre class="src src-R" id="replaceDataFrame"><span style="color: #b22222;"># </span><span style="color: #b22222;">creating new variable mean centered age</span>
datGSS[ , <span style="color: #8b2252;">"ageC"</span>] <span style="color: #008b8b;">&lt;-</span> datGSS[, <span style="color: #8b2252;">"age"</span>] <span style="color: #008b8b;">-</span> <span style="color: #0000ff;">mean</span>(datGSS[, <span style="color: #8b2252;">"age"</span>])

 <span style="color: #b22222;">#</span><span style="color: #b22222;">education difference between wifes and husbands</span>
datGSS[ , <span style="color: #8b2252;">"educ.diff"</span>] <span style="color: #008b8b;">&lt;-</span> datGSS[ , <span style="color: #8b2252;">"wifeduc"</span>] <span style="color: #008b8b;">-</span> datGSS[, <span style="color: #8b2252;">"husbeduc"</span>]

<span style="color: #b22222;"># </span><span style="color: #b22222;">replacing subsets to create young/old variable</span>
datGSS[ , <span style="color: #8b2252;">"young"</span>] <span style="color: #008b8b;">&lt;-</span> <span style="color: #8b2252;">"no"</span> <span style="color: #b22222;"># </span><span style="color: #b22222;">all values of young = "no"</span>
datGSS[datGSS[ , <span style="color: #8b2252;">"age"</span>] <span style="color: #008b8b;">&lt;</span> <span style="color: #228b22;">30</span>, <span style="color: #8b2252;">"young"</span>] <span style="color: #008b8b;">&lt;-</span> <span style="color: #8b2252;">"yes"</span> <span style="color: #b22222;"># </span><span style="color: #b22222;">change to "yes" if age &lt; 30</span>

datGSS[<span style="color: #228b22;">1</span>:<span style="color: #228b22;">4</span>, <span style="color: #0000ff;">c</span>(<span style="color: #8b2252;">"age"</span>, <span style="color: #8b2252;">"ageC"</span>, <span style="color: #8b2252;">"young"</span>, <span style="color: #8b2252;">"wifeduc"</span>, <span style="color: #8b2252;">"husbeduc"</span>, <span style="color: #8b2252;">"educ.diff"</span>)]
</pre>
</div>

<pre class="example">
&gt; # creating new variable mean centered age
&gt; datGSS[ , "ageC"] &lt;- datGSS[, "age"] - mean(datGSS[, "age"])
&gt; 
&gt;  #education difference between wifes and husbands
&gt; datGSS[ , "educ.diff"] &lt;- datGSS[ , "wifeduc"] - datGSS[, "husbeduc"]
&gt; 
&gt; # replacing subsets to create young/old variable
&gt; datGSS[ , "young"] &lt;- "no" # all values of young = "no"
&gt; datGSS[datGSS[ , "age"] &lt; 30, "young"] &lt;- "yes" # change to "yes" if age &lt; 30
&gt; 
&gt; datGSS[1:4, c("age", "ageC", "young", "wifeduc", "husbeduc", "educ.diff")]
  age      ageC young wifeduc husbeduc educ.diff
1  69  22.36364    no      NA       NA        NA
2  27 -19.63636   yes      13       10         3
3  19 -27.63636   yes      NA       NA        NA
4  21 -25.63636   yes      NA       NA        NA
&gt;
</pre>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-5-6" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Exporting Data
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Now that we have made some changes to our GSS data set, we might want to save those changes to a file. Everything we have done so far has only modified the data in R; the files have remained unchanged. 
</p>

<div class="org-src-container">

<pre class="src src-R" id="dataExportExamples"><span style="color: #b22222;"># </span><span style="color: #b22222;">write data to a .csv file</span>
<span style="color: #0000ff;">write.csv</span>(datGSS, file <span style="color: #008b8b;">=</span> <span style="color: #8b2252;">"gss.csv"</span>)
<span style="color: #b22222;"># </span><span style="color: #b22222;">write data to a Stata file</span>
<span style="color: #0000ff;">write.dta</span>(datGSS, file <span style="color: #008b8b;">=</span> <span style="color: #8b2252;">"gss.dta"</span>)
<span style="color: #b22222;"># </span><span style="color: #b22222;">write data to an R file</span>
<span style="color: #0000ff;">saveRDS</span>(datGSS, file <span style="color: #008b8b;">=</span> <span style="color: #8b2252;">"gss.rds"</span>)
</pre>
</div>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-5-7" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Exercise 3: Data manipulation
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Use the gss.rds data set
</p>

<ol class="org-ol">
<li>Generate the following variables:
<ul class="org-ul">
<li>"rich" equal to 0 if rincdol is less than 100000, and 1 otherwise
</li>
<li>"sinc" equal to incomdol - rincdol
</li>
</ul>
</li>
<li>Create a subset of the data containing only rows where "usecomp" = "Yes"
</li>
<li>Examine the data.frame created in step 2, and answer the following questions:
<ul class="org-ul">
<li>How many rows does it have?
</li>
<li>How many columns does it have?
</li>
<li>What is the class of the "satjob" variable?
</li>
</ul>
</li>
<li>BONUS (hard): Generate a variable named "dual.earn" equal to 1 if both wkftwife = 1 and wkfthusb = 1, and zero otherwise
</li>
</ol>
</body>
</html>
</richcontent>
</node>

</node>


<node COLOR="#0033ff" ID="sec-6" POSITION="left" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Basic Statistics and Graphs
</p>
</body>
</html>
</richcontent>
<node COLOR="#00b439" ID="sec-6-1" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Basic statistics
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Descriptive statistics of single variables are straightforward:
</p>
<div class="org-src-container">

<pre class="src src-R" id="descriptiveStats1"><span style="color: #0000ff;">mean</span>(datGSS[ , <span style="color: #8b2252;">"educ"</span>]) <span style="color: #b22222;"># </span><span style="color: #b22222;">calculate mean of x</span>
<span style="color: #0000ff;">sd</span>(datGSS[, <span style="color: #8b2252;">"educ"</span>]) <span style="color: #b22222;"># </span><span style="color: #b22222;">calculate standard deviation of x</span>
<span style="color: #0000ff;">summary</span>(datGSS[ , <span style="color: #8b2252;">"educ"</span>]) <span style="color: #b22222;"># </span><span style="color: #b22222;">calculate min, max, quantiles, mean</span>
</pre>
</div>

<pre class="example">
&gt; mean(datGSS[ , "educ"]) # calculate mean of x
[1] 13.47498
&gt; sd(datGSS[, "educ"]) # calculate standard deviation of x
[1] 5.389476
&gt; summary(datGSS[ , "educ"]) # calculate min, max, quantiles, mean
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00   12.00   13.00   13.47   16.00   99.00 
&gt;
</pre>

<p>
If you get tired of typing the data.frame name over and over, use <code>with()</code> instead
</p>
<div class="org-src-container">

<pre class="src src-R" id="descriptiveStats2"><span style="color: #0000ff;">with</span>(datGSS,
     <span style="color: #0000ff;">c</span>(Lowest <span style="color: #008b8b;">=</span> <span style="color: #0000ff;">min</span>(educ),
       Average <span style="color: #008b8b;">=</span> <span style="color: #0000ff;">mean</span>(educ),
       Highest <span style="color: #008b8b;">=</span> <span style="color: #0000ff;">max</span>(educ))
     )
</pre>
</div>

<pre class="example">
&gt; with(datGSS,
+      c(Lowest = min(educ),
+        Average = mean(educ),
+        Highest = max(educ))
+      )
  Lowest  Average  Highest 
 0.00000 13.47498 99.00000 
&gt;
</pre>

<p>
Some of these functions (e.g., summary) will also work with data.frames and other types of objects
</p>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-6-2" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Counts and proportions
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Start by using the <code>table()</code> function to tabulate counts, then perform additional computations if needed
</p>
<div class="org-src-container">

<pre class="src src-R" id="tableExample">sex.counts <span style="color: #008b8b;">&lt;-</span> <span style="color: #0000ff;">table</span>(datGSS[, <span style="color: #8b2252;">"sex"</span>]) <span style="color: #b22222;"># </span><span style="color: #b22222;">tabulate sex categories</span>
sex.counts
<span style="color: #0000ff;">prop.table</span>(sex.counts) <span style="color: #b22222;"># </span><span style="color: #b22222;">convert to proportions</span>
</pre>
</div>

<pre class="example">
&gt; sex.counts &lt;- table(datGSS[, "sex"]) # tabulate sex categories
&gt; sex.counts

  Male Female 
   622    797 
&gt; prop.table(sex.counts) # convert to proportions

     Male    Female 
0.4383369 0.5616631 
&gt;
</pre>

<p>
Add variables for crosstabs
</p>

<div class="org-src-container">

<pre class="src src-R" id="crosstabExample"><span style="color: #0000ff;">table</span>(datGSS[, <span style="color: #0000ff;">c</span>(<span style="color: #8b2252;">"sex"</span>, <span style="color: #8b2252;">"happy"</span>)]) <span style="color: #b22222;"># </span><span style="color: #b22222;">crosstab marital X happy</span>
</pre>
</div>

<pre class="example">
&gt; table(datGSS[, c("sex", "happy")]) # crosstab marital X happy
        happy
sex      NAP VERY HAPPY PRETTY HAPPY NOT TOO HAPPY  DK  NA
  Male     0        189          350            73   0  10
  Female   0        246          447            84   1  19
&gt;
</pre>
</body>
</html>
</richcontent>
</node>



<node COLOR="#00b439" ID="sec-6-3" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Statistics by classification factors
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
The <code>by()</code> function can be used to perform a calculation separately for each level of a classifying variable
</p>
<div class="org-src-container">

<pre class="src src-R" id="byExample"><span style="color: #0000ff;">by</span>(datGSS[, <span style="color: #0000ff;">c</span>(<span style="color: #8b2252;">"income"</span>, <span style="color: #8b2252;">"educ"</span>)],
   INDICES<span style="color: #008b8b;">=</span>datGSS[<span style="color: #8b2252;">"sex"</span>],
   FUN<span style="color: #008b8b;">=</span>summary)
</pre>
</div>

<pre class="example">
&gt; by(datGSS[, c("income", "educ")],
+    INDICES=datGSS["sex"],
+    FUN=summary)
sex: Male
             income         educ      
 $40000 TO 49999: 59   Min.   : 4.00  
 $50000 TO 59999: 56   1st Qu.:12.00  
 $60000 TO 74999: 49   Median :13.00  
 $35000 TO 39999: 48   Mean   :13.68  
 REFUSED        : 48   3rd Qu.:16.00  
 $110000 OR OVER: 43   Max.   :99.00  
 (Other)        :319                  
---------------------------------------------------- 
sex: Female
             income         educ      
 REFUSED        : 76   Min.   : 0.00  
 $60000 TO 74999: 62   1st Qu.:12.00  
 $40000 TO 49999: 60   Median :12.00  
 $50000 TO 59999: 52   Mean   :13.32  
 $30000 TO 34999: 49   3rd Qu.:15.00  
 $25000 TO 29999: 42   Max.   :99.00  
 (Other)        :456                  
&gt;
</pre>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-6-4" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Correlations
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Let's look at correlations among between age, income, and education
</p>
<div class="org-src-container">

<pre class="src src-R" id="corEx"><span style="color: #0000ff;">cor</span>(datGSS[ , <span style="color: #0000ff;">c</span>(<span style="color: #8b2252;">"age"</span>, <span style="color: #8b2252;">"incomdol"</span>, <span style="color: #8b2252;">"educ"</span>)])
</pre>
</div>

<pre class="example">
&gt; cor(datGSS[ , c("age", "incomdol", "educ")])
                 age   incomdol        educ
age       1.00000000 -0.1186564 -0.07362454
incomdol -0.11865641  1.0000000  0.21013267
educ     -0.07362454  0.2101327  1.00000000
&gt;
</pre>


<p>
For significance tests, use cor.test()
</p>
<div class="org-src-container">

<pre class="src src-R" id="corTest"><span style="color: #0000ff;">with</span>(datGSS,
     <span style="color: #0000ff;">cor.test</span>(age, educ))
</pre>
</div>

<pre class="example">
&gt; with(datGSS,
+      cor.test(age, educ))

	Pearson's product-moment correlation

data:  age and educ
t = -2.779, df = 1417, p-value = 0.005525
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 -0.12518333 -0.02166916
sample estimates:
        cor 
-0.07362454 

&gt;
</pre>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-6-5" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Multiple regression
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Modeling functions generally use the <i>formula</i> interface whith DV on left followed by "~" followed by predictors&#x2013;for details see
</p>
<div class="org-src-container">

<pre class="src src-R"><span style="color: #0000ff;">help</span>(<span style="color: #8b2252;">"formula"</span>)
</pre>
</div>

<ul class="org-ul">
<li>Predict the number of hours individuals spend on email (emailhrs)
</li>
</ul>
<div class="org-src-container">

<pre class="src src-R" id="regression">m1 <span style="color: #008b8b;">&lt;-</span> <span style="color: #0000ff;">lm</span>(educ ~ sex <span style="color: #008b8b;">+</span> age, data <span style="color: #008b8b;">=</span> datGSS)
<span style="color: #0000ff;">summary</span>(m1)
</pre>
</div>

<pre class="example">
&gt; m1 &lt;- lm(educ ~ sex + age, data = datGSS)
&gt; summary(m1)

Call:
lm(formula = educ ~ sex + age, data = datGSS)

Residuals:
    Min      1Q  Median      3Q     Max 
-13.434  -1.785  -0.688   1.955  86.049 

Coefficients:
             Estimate Std. Error t value Pr(&gt;|t|)
(Intercept) 14.652702   0.425691  34.421  &lt; 2e-16
sexFemale   -0.275235   0.289290  -0.951  0.34156
age         -0.021938   0.008238  -2.663  0.00783

Residual standard error: 5.377 on 1416 degrees of freedom
Multiple R-squared:  0.006056,	Adjusted R-squared:  0.004652 
F-statistic: 4.314 on 2 and 1416 DF,  p-value: 0.01356

&gt;
</pre>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-6-6" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Save R output to a file
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Earlier we learned how to write a data set to a file. But what if we want to write something that isn't in a nice rectangular format, like the results of our regression model? For that we can use the <code>sink()</code> function:
</p>

<div class="org-src-container">

<pre class="src src-R" id="sinkExample"><span style="color: #0000ff;">sink</span>(file<span style="color: #008b8b;">=</span><span style="color: #8b2252;">"output.txt"</span>, split<span style="color: #008b8b;">=</span><span style="color: #228b22;">TRUE</span>) <span style="color: #b22222;"># </span><span style="color: #b22222;">start logging</span>
<span style="color: #0000ff;">print</span>(<span style="color: #8b2252;">"This is the result from model 1\n"</span>)
<span style="color: #0000ff;">print</span>(<span style="color: #0000ff;">summary</span>(m1))
<span style="color: #0000ff;">sink</span>() <span style="color: #b22222;">## </span><span style="color: #b22222;">sink with no arguments turns logging off</span>
</pre>
</div>

<pre class="example">
&gt; sink(file="output.txt", split=TRUE) # start logging
&gt; print("This is the result from model 1\n")
[1] "This is the result from model 1\n"
&gt; print(summary(m1))

Call:
lm(formula = educ ~ sex + age, data = datGSS)

Residuals:
    Min      1Q  Median      3Q     Max 
-13.434  -1.785  -0.688   1.955  86.049 

Coefficients:
             Estimate Std. Error t value Pr(&gt;|t|)
(Intercept) 14.652702   0.425691  34.421  &lt; 2e-16
sexFemale   -0.275235   0.289290  -0.951  0.34156
age         -0.021938   0.008238  -2.663  0.00783

Residual standard error: 5.377 on 1416 degrees of freedom
Multiple R-squared:  0.006056,	Adjusted R-squared:  0.004652 
F-statistic: 4.314 on 2 and 1416 DF,  p-value: 0.01356

&gt; sink() ## sink with no arguments turns logging off
&gt;
</pre>
</body>
</html>
</richcontent>
</node>


<node COLOR="#00b439" ID="sec-6-7" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Basic graphics: Frequency bars
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Thanks to classes and methods, you can <code>plot()</code> many  kinds of objects:
</p>

<div class="org-src-container">

<pre class="src src-R" id="plotExample"><span style="color: #0000ff;">plot</span>(datGSS[ , <span style="color: #8b2252;">"marital"</span>]) <span style="color: #b22222;"># </span><span style="color: #b22222;">Plot a factor</span>
</pre>
</div>

<div class="figure">
<p><img src="images/examplePlot1.png" alt="examplePlot1.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-6-8" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Basic graphics: Boxplots by group
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Thanks to classes and methods, you can <code>plot()</code> many kinds of objects:
</p>
<div class="org-src-container">

<pre class="src src-R" id="plotExample2"><span style="color: #0000ff;">with</span>(datGSS,
     <span style="color: #0000ff;">plot</span>(marital, educ)) <span style="color: #b22222;"># </span><span style="color: #b22222;">Plot ordinal by numeric</span>
</pre>
</div>

<div class="figure">
<p><img src="images/examplePlot2.png" alt="examplePlot2.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-6-9" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Basic graphics: Mosaic chart
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Thanks to classes and methods, you can <code>plot()</code> many kinds of objects:
</p>
<div class="org-src-container">

<pre class="src src-R" id="plotExample3"><span style="color: #0000ff;">with</span>(datGSS, <span style="color: #b22222;"># </span><span style="color: #b22222;">Plot factor X factor</span>
     <span style="color: #0000ff;">plot</span>(marital, happy))
</pre>
</div>

<div class="figure">
<p><img src="images/examplePlot3.png" alt="examplePlot3.png" />
</p>
</div>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-6-10" POSITION="left" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Exercise 3
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<p>
Using the datGSS data.frame
</p>

<ol class="org-ol">
<li>Cross-tabulate sex and emailhrs
</li>
<li>Calculate the mean and standard deviation of incomdol by sex
</li>
<li>Save the results of the previous two calculations to a file
</li>
<li>Create a scatter plot with educ on the x-axis and incomdol on the y-axis
</li>
</ol>
</body>
</html>
</richcontent>
</node>

</node>

<node COLOR="#0033ff" ID="sec-7" POSITION="right" FOLDED="true">
<font NAME="SansSerif" SIZE="18"/>
<edge STYLE="sharp_bezier" WIDTH="8"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Wrap-up
</p>
</body>
</html>
</richcontent>
<node COLOR="#00b439" ID="sec-7-1" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Help us make this workshop better!
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ul class="org-ul">
<li>Please take a moment to fill out a very short feedback form
</li>

<li>These workshops exist for you – tell us what you need!
</li>

<li><a href="http://tinyurl.com/R-intro-feedback">http://tinyurl.com/R-intro-feedback</a>
</li>
</ul>
</body>
</html>
</richcontent>
</node>

<node COLOR="#00b439" ID="sec-7-2" POSITION="right" FOLDED="false">
<font NAME="SansSerif" SIZE="16"/>
<edge STYLE="bezier" WIDTH="thin"/>

<richcontent TYPE="NODE">
<html>
<head>
</head>
<body>
<p>Additional resources
</p>
</body>
</html>
</richcontent>
<richcontent TYPE="NOTE">
<html>
<head>
</head>
<body>
<ul class="org-ul">
<li>IQSS workshops: <a href="http://projects.iq.harvard.edu/rtc/filter_by/workshops">http://projects.iq.harvard.edu/rtc/filter_by/workshops</a>
</li>

<li>IQSS statistical consulting: <a href="http://rtc.iq.harvard.edu">http://rtc.iq.harvard.edu</a>
</li>

<li>Software (all free!):
<ul class="org-ul">
<li>R and R package download: <a href="http://cran.r-project.org">http://cran.r-project.org</a>
</li>
<li>Rstudio download: <a href="http://rstudio.org">http://rstudio.org</a>
</li>
<li>ESS (emacs R package): <a href="http://ess.r-project.org/">http://ess.r-project.org/</a>
</li>
</ul>
</li>

<li>Online tutorials
<ul class="org-ul">
<li><a href="http://www.codeschool.com/courses/try-r">http://www.codeschool.com/courses/try-r</a>
</li>
<li><a href="http://www.datamind.org">http://www.datamind.org</a>
</li>
</ul>
</li>

<li>Getting help:
<ul class="org-ul">
<li>Documentation and tutorials: <a href="http://cran.r-project.org/other-docs.html">http://cran.r-project.org/other-docs.html</a>
</li>
<li>Recommended R packages by topic: <a href="http://cran.r-project.org/web/views/">http://cran.r-project.org/web/views/</a>
</li>
<li>Mailing list: <a href="https://stat.ethz.ch/mailman/listinfo/r-help">https://stat.ethz.ch/mailman/listinfo/r-help</a>
</li>
<li>StackOverflow: <a href="http://stackoverflow.com/questions/tagged/r">http://stackoverflow.com/questions/tagged/r</a>
</li>
</ul>
</li>
</ul>
</body>
</html>
</richcontent>
</node>

</node>

</node>
</map>
