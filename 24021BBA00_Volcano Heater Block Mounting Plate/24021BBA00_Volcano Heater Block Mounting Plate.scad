  // a BOSL2 module
include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/attachments_extras.scad>
include <../libs/BOSL2/screws.scad>
include <../libs/BOSL2/mounting_plate.scad>

// There's a bug where the hole's attachment point isn't getting 
// put in the right
// place, even though the hole is.
// It's related to the width parameter, probably having different 
// values at different times.

function _24021BBA00_holes(width, vslot_profile, t) = 
  assert(is_def(width),"frame 'width' not defined")
  assert(is_def(vslot_profile),"'vslot_profile' not defined")
  assert(is_def(t),"backet thickness 't' not defined")
  //TODO add center hole for block mounting screw
  let (
    w= width,
    length = 130, // standard Autotruder distance
    hole_d = 4.5,
    hole2_d = 5.5,
    hole_s = w/2-hole_d*1.5,
    vslot_distance = length - vslot_profile,
    d1=15,
    d2=20,
    h=sqrt(d1*d1-d2*d2/4)
  )
  [
    [[hole_s, -vslot_distance/2], TOP, [hole_d, t]], //vslot mount
    [[-hole_s, -vslot_distance/2], TOP, [hole_d, t]], //vslot mount
    [[hole_s, vslot_distance/2], TOP, [hole_d, t]], // vslot mount
    [[-hole_s, vslot_distance/2], TOP, [hole_d, t]], // vslot mount
    [[d2/2, 0], TOP, [hole2_d, t]], // bracket mount
    [[-d2/2, 0], TOP, [hole2_d, t]], // bracket mount
    [[0, h], TOP, [hole2_d, t]] // bracket mount
  ];
  
function 24021BBA00_volcano_heater_block_mounting_plate_geom(width, vslot_profile, t) = 
  assert(is_def(width),"frame 'width' not defined")
  assert(is_def(vslot_profile),"'vslot_profile' not defined")
  assert(is_def(t),"bracket thickness 't' not defined")
  let (
    length = 130,
    size=[width, length, t],
    holes = _24021BBA00_holes(length, vslot_profile, t)
  )
  attachable_geom(geom=mounting_plate_geom(size=size, holes=holes));
 
module 24021BBA00_volcano_heater_block_mounting_plate(vslot_profile=20, t=5, anchor, spin, orient) {
//  assert(is_def(width),"frame 'width' not defined");
  assert(is_def(vslot_profile),"'vslot_profile' not defined");
  assert(is_def(t),"backet thickness 't' not defined");
  width=38;
  geom = 24021BBA00_volcano_heater_block_mounting_plate_geom(width, vslot_profile, t);
  size = _attach_geom_size(geom);
  holes = _24021BBA00_holes(width, vslot_profile, t);
  echo(holes=holes);
  
  module shape() {
//    diff() {
      mounting_plate(size=size, holes=holes);
//      attach(BOTTOM) tag("remove")
//      screw_hole("M5x1",length=t+0.02, tolerance="loose", anchor=TOP);
//    }
  }
  
  attachable(anchor,spin,orient, geom=geom) {
    shape();
    children();
  }
}

