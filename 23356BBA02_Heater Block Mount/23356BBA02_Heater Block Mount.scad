// creates a heater block mount for the Autotrude with an E3D Volcano Heater Block
// TODO extend extrusion over the top of the block like a heat shield
include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/extrusion_vslot.scad>
include <../23356BBA01_Volcano Heater Block/23356BBA01_Volcano Heater Block.scad>


module 23355BBA02_heater_block_mount(anchor, spin, orient) {
  size = [20, 20, 40];
  hb_size = [24, 20, 11.5]; // heater_block_size

  module shape() {
    diff() {
      recolor("Green") extrusion_vslot(profile=size.x, height=size.z, anchor=CENTER) {
        #tag("remove") position(TOP) cuboid([hb_size.x+4, hb_size.y+1, hb_size.z+.02], anchor=TOP+LEFT, spin=[180,90,0]);
        #tag("remove") down(6) left(2) position(TOP) cuboid([hb_size.x-2, hb_size.y+1, hb_size.z+2], anchor=TOP+LEFT, spin=[180,90,0]);
        
        tag("keep") position(TOP) recolor("DarkSalmon") 23356BBA01_volcano_heater_block(anchor=TOP+LEFT, spin=[180,90,0]) {
          tag("remove") attach("heater_front_hole") cylinder(d=3.2,h=hb_size.x*2);
          tag("remove") attach("heater_back_hole") cylinder(d=3.2,h=hb_size.x*2);
        }
      }
    }
  }

  anchors = [
//        named_anchor("front_left_top",  [-p1.x, -p1.y, p1.z],, TOP, 0),
//        named_anchor("front_left_bottom", [-p1.x, -p1.y, -p1.z], BOTTOM, 0),
//        named_anchor("front_right_top", [p1.x, -p1.y, p1.z], TOP, 0),
//        named_anchor("front_right_bottom", [p1.x, -p1.y, -p1.z], BOTTOM, 0),
//        named_anchor("back_left_top", [-p1.x, p1.y, p1.z], TOP, 0),
//        named_anchor("back_left_bottom", [-p1.x, p1.y, -p1.z], BOTTOM, 0),
//        named_anchor("back_right_top", [p1.x, p1.y, p1.z], TOP, 0),
//        named_anchor("back_right_bottom", [p1.x, p1.y, -p1.z], BOTTOM, 0)
  ];
  
    
  
  attachable(anchor,spin,orient, size=size, anchors=anchors) {
    shape();
    children();
  }
}

//TESTS

*23355BBA02_heater_block_mount() show_anchors();
23355BBA02_heater_block_mount();

