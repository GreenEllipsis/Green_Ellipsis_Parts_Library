// thimble
// print with fuzzy skin in slicer for texture
width=15.5; // width at top of base
depth=11.5; // depth at top of base
thickness=2;
height=20;
tip_percent=50; //[0:100]
taper_percent=10; //[0:100]
/* [Hidden] */
$fa=$preview ? 10 : 4;
$fs=$preview ? 5 : 0.4;

tip_pct=tip_percent/100;

base_height=height*(1-tip_pct);
tip_height=height-base_height;


//base
cylinder(d1=width*(100+taper_percent)/100, d2=width, h=base_height);
//tip
if (cone_percent > 0) translate([0,0,base_height]) resize([width,width,tip_height*2]) sphere(d=width);


