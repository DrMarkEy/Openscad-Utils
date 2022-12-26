function toVector(val) = ((val[0]==undef) ? [val, val, val]: val);

module translateGap(gap=_gap)
{
    gapVec = toVector(gap);
    gapX = gapVec[0];
    gapY = gapVec[1];
    gapZ = gapVec[2];
    
    translate([-gapX, -gapY, -gapZ])
        children();
}


module gCube(size, gap = _gap, center = false)
{
    gapVec = toVector(gap);
    gapX = gapVec[0];
    gapY = gapVec[1];
    gapZ = gapVec[2];
    
    module sizedCube()
    {
        cube([size[0] + 2*gapX, size[1] + 2*gapY, size[2] + 2*gapZ], center = center);
    }
    
    if(center == false) // Only translate gap if not centered!
    {
        translateGap(gap)
        sizedCube();
    }
    else
    {
        sizedCube();
    }
}

module gCylinder(height, radius1, radius2, gap = _gap, center = false)
{
    gapVec = toVector(gap);
    gapH = gapVec[0];
    gapR1 = gapVec[1];    
    gapR2 = gapVec[2]==undef?gapVec[1]:gapVec[2];    
    
    module sizedCylinder()
    {
        cylinder(height + 2*gapH, radius1 + gapR1, radius2 + gapR2, center = center);
    }
    
    if(center)
    {
        sizedCylinder();
    }
    else
    {
        translate([0, 0, -gapH])
        sizedCylinder();
    }
}