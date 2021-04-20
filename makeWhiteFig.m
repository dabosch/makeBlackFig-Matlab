function makeWhiteFig(fig)
    if ~exist('fig','var') || isempty(fig)
        fig = gcf;
    end
    makeBlackFig(fig,'w','k');
end