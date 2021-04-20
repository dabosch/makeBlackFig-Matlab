%% makeBlackFig - a script for creating good-looking figures in matlab with a black background
% v1.0 (2021-04-18)
%
% call with makeBlackFig(<figureHandle>,<backgroundColor>,<foregroundColor>);
% all 3 parameters are optional. So you can also just call
% > makeBlackFig;
%
% For lines in plots makeBlackFig will automatically determine new line
% colors based on the current and the new background color.
% There also is a makeWhiteFig script, which basically just calls
% makeBlackFig(fig,'w','k').
%
% Copyright (c) 2021 Dario Bosch <kontakt(at)dariobosch(dot)de>

% Permission is hereby granted, free of charge, to any person
% obtaining a copy of this software and associated documentation files
%(the "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
%
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
function makeBlackFig(fig,bg,fg)
    if ~exist('fig','var') || isempty(fig)
        fig = gcf;
    end
    oldBG = get(fig,'color');
    if nargin<2
        bg = 'k';
    end
    if ischar(bg); bg = str2rgb(bg);  end
    if nargin < 3
        fg = 1 - bg;
    end
    if ischar(fg); fg = str2rgb(fg);  end
    
    ax = [findall(fig,'type','Axes');findall(fig,'type','ColorBar');];
    for i=1:size(ax,1)
        a = ax(i);
        set(a,'Color',bg);
        %set(a,'Box','off');
        %set(a,
        try
            set(a,'XColor',fg);
            set(a,'YColor',fg);
            set(a,'ZColor',fg);
        end
    end
    set(fig,'Color',bg);
    ax = [findall(fig,'type','Text')];
    for i=1:size(ax,1)
        a = ax(i);
        set(a,'Color',fg);
    end
    try
        set(fig.Title,'Color',fg);
    end
    ch = fig.Children;
    for i=1:size(ch,1)
        try
            set(ch(i).Title,'Color',fg);
        end
    end
    %try
    %    set(fig.Children.Title,'Color',fg);
    %end
    
    
    % fix legends
    ax = findall(fig,'type','Legend');
    for i=1:size(ax,1)
        a = ax(i);
        set(a,'Color',bg);
        set(a,'TextColor',fg);
        set(a,'EdgeColor',fg);
    end
    
    % fix plot colors
    ax = findall(fig,'type','Axes');
    for i=1:size(ax,1)
        ln = findall(ax(i),'type','line');
        nLines = size(ln,1);
        for n=1:nLines
            v = get(ln(n),'color');
            d = bg-oldBG;
            c = abs(v - abs(d));
            set(ln(n),'Color',c);
        end
        br = findall(ax(i),'type','bar');
        for n=1:size(br,1)
            d = bg-oldBG;
            v = get(br(n),'FaceColor');
            c = abs(v - abs(d));
            set(br(n),'FaceColor',c);
            v = get(br(n),'EdgeColor');
            c = abs(v - abs(d));
            set(br(n),'EdgeColor',c);
        end
    end
    
    
    drawnow;pause(0.01);
end

function rgb = str2rgb(x)
    if ischar(x)
        l = line('color',x);
        rgb = get(l,'color');
        delete(l);
    else
        rgb = x;
    end
end
