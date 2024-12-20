//https://www.thingiverse.com/thing:216963
//LICENSE: GPL
// Updated by Brian Alano, 2023
/*parameters*/
// preview[view:south, tilt:top diagonal]
/* [Global] */
// Demo mode
demo=0; //[0:No,1:Yes]
// Material type
type="ABS"; //[ABS,PLA,PS,PP,OTHER]
// Width of the symbol
size=20; //[1:50]
// Thickness of the symbol
T=5; //[1:10]
/* [Hidden] */
//use <write/Write.scad>
//
//if(demo)
//color("SteelBlue")
//{
//	recycling_symbol("ABS", 30, 2, [-25,45,0]);
//	recycling_symbol("PLA", 30, 2, [25,45,0]);
//	recycling_symbol("PP", 20, 2, [-35,0,0]);
//	recycling_symbol("PS", 20, 2, [0,0,0]);
//	recycling_symbol("OTHER", 20, 2, [35,0,0]);
//}
//else
	color("SteelBlue") recycling_symbol("PET", size, T, number = 1, $fn=40);


module recycling_symbol(type="ABS", size=10, h=1, pos=[0,0,0], rot=[0,0,0],number, $fn=40)
{
     code = is_num(number) ? str(number) : (type=="ABS"?"9":type=="PS"?"6":type=="PP"?"5":"PET"?"1":"7");
    
	translate(pos) rotate(rot)
	scale([size/10,size/10,h])
	union()
	{
		for(i=[0,120,240])
			rotate(a=[0,0,i])
			__r_s_arrow(h=1);
		translate([0,0,0])
//			write(code, t=1, h=4, center=true);
            linear_extrude(1) text(code, size=4, valign="center", halign="center", font="Lucida Sans Typewriter:style=Bold");
		translate([0.5,-7,0])
//			write(type, t=1, h=4, space=1.2, center=true);
            linear_extrude(1) text(type, size=4, valign="center", halign="center", font="Lucida Sans Typewriter:style=Bold");
	}
}

module __r_s_arrow(h)
{
	width=0.8;
	y=sqrt(3)/3*6;
	arr_y=-y/2-2+width/2;
	linear_extrude(height=h)
	union()
	{
		difference()
		{
			__r_s_rounded_triangle(y,2);
			__r_s_rounded_triangle(y,2-width);
			translate([0,-5,0])
				square([6,12]);
			rotate([0,0,60])
			translate([-1.5,0,0])
				square([6,7]);
		}
		polygon(points=[[0.5,arr_y],[1.8,arr_y-1.1],[1.8,arr_y+1.1]]);
	}
}

module __r_s_rounded_triangle(y,r)
{
	hull()
	for(i=[0,120,240])
		rotate(a=[0,0,i])
		translate([0,y,0])
			circle(r=r);
}