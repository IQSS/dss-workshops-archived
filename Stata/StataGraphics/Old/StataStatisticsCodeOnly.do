// Step 1: tell Stata where to find data:
cd /Users/dataclass/Desktop/StataGraphics/dataSets
// Step 2: call up our dataset:
use TimePollPubSchools.dta

hist F1, bin(10) percent title(TITLE) ///
  subtitle(SUBTITLE) caption(CAPTION) note(NOTES)

hist F1, bin(10) percent title(TITLE) subtitle(SUBTITLE) ///
    caption(CAPTION) note(NOTES) ///
    xtitle(Here's your x-axis title) ///
ytitle(here's your y-axis title)

hist F4, title(Racial breakdown of Time Poll Sample) xtitle(Race) ///
ytitle(Percent) xlabel(1 "White" 2 "Black" 3 "Asian" 4 "Hispanic" ///
 5 "Other") discrete percent addlabels

use NatNeighCrimeStudy.dta
tw scatter T_PERCAP T_VIOLNT
tw dropline T_PERCAP T_VIOLNT
tw  lfitci T_PERCAP T_VIOLNT

twoway scatter T_PERCAP T_VIOLNT, by(DIVISION)

twoway scatter T_PERCAP T_VIOLNT, ///
    title(Comparison of Per Capita Income ///
          and Violent Crime Rate at Tract level) ///
xtitle(Violent Crime Rate) ytitle(Per Capita Income) ///
    note(Source: National Neighborhood Crime Study 2000)

twoway scatter T_PERCAP T_VIOLNT, ///
    title("Comparison of Per Capita Income" ///
"and Violent Crime Rate at Tract level") ///
xtitle(Violent Crime Rate) ytitle(Per Capita Income) ///
note(Source: National Neighborhood Crime Study 2000)
