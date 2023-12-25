// a BOSL2 module
include <../libs/BOSL2/std.scad>

module 23356BBA01_volcano_heater_block(anchor=CENTER, spin=0, orient=UP) {
  file="../23356BBA01_Volcano Heater Block/23356BBA01_Volcano Heater Block.stl";
  size = [24, 20, 11.5]; 
anchors=[
    named_anchor("heater_front_hole",[-size.x/2+2.5, -size.y/2+15, size.z/2], TOP, 0),
    named_anchor("heater_back_hole",[-size.x/2+2.5, -size.y/2+5.5, size.z/2], TOP, 0),
    named_anchor("heater",[-size.x/2+8, size.y/2, size.z/2-4.4], BACK, 0),
    named_anchor("nozzle",[-size.x/2+15.5, -size.y/2, size.z/2-4.5], FRONT, 0),
    named_anchor("thermistor",[-size.x/2+21.2, size.y/2-4, 0], BACK, 0),
  ];
  attachable(anchor,spin,orient, size=size, anchors=anchors) {
    import(file);
    children();
  }
}

//TESTS
*23356BBA01_volcano_heater_block() show_anchors();
*23356BBA01_volcano_heater_block() ;
* difference() {
23356BBA01_volcano_heater_block() show_anchors();
  translate([0,0,-100]) cube(200);
}
