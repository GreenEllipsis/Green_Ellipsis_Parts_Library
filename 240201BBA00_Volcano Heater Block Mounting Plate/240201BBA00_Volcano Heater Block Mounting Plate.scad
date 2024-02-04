// a BOSL2 module
include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/attachments_extras.scad>
include <../libs/BOSL2/mounting_plate.scad>

function _240201BBA00_holes(width, vslot_profile, t) = 
  assert(is_def(width),"frame 'width' not defined")
  assert(is_def(vslot_profile),"'vslot_profile' not defined")
  assert(is_def(t),"backet thickness 't' not defined")
  TODO add center hole for block mounting screw
  let (
    hole_d = 4.3,
    vslot_distance = width - vslot_profile
  )
  [
    [[0, -vslot_distance/2], TOP, [hole_d, t]], //DEBUG
    [[0, vslot_distance/2], TOP, [hole_d, t]],
  ];
  
function 240201BBA00_volcano_heater_block_mounting_plate_geom(width, vslot_profile, t) = 
  assert(is_def(width),"frame 'width' not defined")
  assert(is_def(vslot_profile),"'vslot_profile' not defined")
  assert(is_def(t),"backet thickness 't' not defined")
  let (
    size=[vslot_profile, width, t],
    holes = _240201BBA00_holes(width, vslot_profile, t)
  )
  attachable_geom(geom=mounting_plate_geom(size=size, holes=holes));
 
module 240201BBA00_volcano_heater_block_mounting_plate(width, vslot_profile, t, anchor, spin, orient) {
  assert(is_def(width),"frame 'width' not defined");
  assert(is_def(vslot_profile),"'vslot_profile' not defined");
  assert(is_def(t),"backet thickness 't' not defined");
  geom = 240201BBA00_volcano_heater_block_mounting_plate_geom(width, vslot_profile, t);
  size = _attach_geom_size(geom);
  holes = _240201BBA00_holes(width, vslot_profile, t);
  attachable(anchor,spin,orient, geom=geom) {
    mounting_plate(size=size, holes=holes);
    children();
  }
}
