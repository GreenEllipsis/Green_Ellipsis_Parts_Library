//TESTS
include <23356BBA02_Heater Block Mount.scad>

*23356BBA02_heater_block_mount() show_anchors();
*23356BBA02_heater_block_mount() attach("heater_front_hole") recolor("red") cube(10);
projection() rotate([0,90,0]) 23356BBA02_heater_block_mount();

