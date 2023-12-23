include <part1.scad>
include <part2.scad>
param2 = "main";
echo("main",param1=param1, param2=param2);
part1();
translate([20,0,-20]) part2();
param1();
param2();