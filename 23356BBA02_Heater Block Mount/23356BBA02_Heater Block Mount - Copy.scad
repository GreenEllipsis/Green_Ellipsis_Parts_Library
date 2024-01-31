// creates a heater block mount for the Autotrude with an E3D Volcano Heater Block
// TODO set height of nozzle to 21.6+51/2
// TODO add anchors for mounting heater block mounting holes
include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/extrusion_vslot.scad>
include <../23356BBA01_Volcano Heater Block/23356BBA01_Volcano Heater Block.scad>


module 23355BBA02_heater_block_mount(anchor, spin, orient) {
  /* [Rendering] */
  preview_fa = 12;
  preview_fs = 5;
  render_fa = 10;
  render_fs = 0.4;
  $fa = $preview ? preview_fa : render_fa;
  $fs = $preview ? preview_fs : render_fs;

  size = [20, 20, 50];
  hb_size = 23356BBA01_volcano_heater_block_dims()[0]; // heater_block_size
  z_offset = 6;

  module shape() {
    render(convexity = 1) diff() {
      recolor("Green") extrusion_vslot(profile=size.x, height=size.z, anchor=CENTER) {
        tag("remove") down(-2 + z_offset) position(TOP+LEFT) cuboid([hb_size.x+4, hb_size.y+1, hb_size.z+.02], anchor=TOP+LEFT, spin=[180,90,0]);
        tag("remove") down(-2 + z_offset) position(TOP+LEFT) cuboid([hb_size.x-4, hb_size.y+2, hb_size.z+1], anchor=TOP+LEFT, spin=[180,90,0]);
        tag("remove") down(z_offset) position(TOP+LEFT) recolor("DarkSalmon") 23356BBA01_volcano_heater_block(anchor=BOTTOM+RIGHT, spin=[180,-90,0]) {
          tag("remove") attach("heater_front_hole", CENTER) cylinder(d=3.2,h=hb_size.x*2);
          tag("remove") attach("heater_back_hole", CENTER) cylinder(d=3.2,h=hb_size.x*2);
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
23355BBA02_heater_block_mount() attach("heater_front_hole") recolor("red") cube(10);

