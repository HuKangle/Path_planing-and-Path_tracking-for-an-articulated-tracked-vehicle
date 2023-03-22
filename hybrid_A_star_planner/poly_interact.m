% Define and fill a rectangular area in the plane
    xlimit = [3 13];
    ylimit = [2  8];
    xbox = xlimit([1 1 2 2 1]);
    ybox = ylimit([1 2 2 1 1]);
    mapshow(xbox,ybox,'DisplayType','polygon','LineStyle','none')
 
    % Define and display a two-part polyline
    x = [0 6  4  8 8 10 14 10 14 NaN 4 4 6 9 15];
    y = [4 6 10 11 7  6 10 10  6 NaN 0 3 4 3  6];
    mapshow(x,y,'Marker','+')
 
    % Intersect the polyline with the rectangle
    [xi, yi] = polyxpoly(x, y, xbox, ybox);
    mapshow(xi,yi,'DisplayType','point','Marker','o')
 
    % Display the intersection points; note that the point (12, 8) appears
    % twice because of a self-intersection near the end of the first part
    % of the polyline.
    [xi yi]
 
    % You could suppress this duplicate by using the 'unique' option.
    [xi, yi] = polyxpoly(x, y, xbox, ybox, 'unique');
    [xi yi]