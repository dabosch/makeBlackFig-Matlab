# MakeBlackFig
a script for creating good-looking figures in matlab with a black background

**v1.0 (2021-04-18)**

call with makeBlackFig(<figureHandle>,<backgroundColor>,<foregroundColor>);
all 3 parameters are optional. So you can also just call

`> makeBlackFig;`

For lines in plots makeBlackFig will automatically determine new line
colors based on the current and the new background color.
There also is a makeWhiteFig script, which basically just calls

`> makeBlackFig(fig,'w','k');`.

Copyright (c) 2021 Dario Bosch <kontakt(at)dariobosch(dot)de>

This project on Matlab file exchange: [![View makeBlackFig on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://de.mathworks.com/matlabcentral/fileexchange/90777-makeblackfig)
