// a BOSL2 module
include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/attachments_extras.scad>
// See 23356BBA01_Volcano Heater Block examples.scad for examples

function 23356BBA01_volcano_heater_block_geom() = 
  let(
    size =[24, 20, 11.5],
    anchors=[
      named_anchor("heater_front_hole",[-size.x/2+2.5, -size.y/2+15, size.z/2], TOP, 0),
      named_anchor("heater_back_hole",[-size.x/2+2.5, -size.y/2+5.5, size.z/2], TOP, 0),
      named_anchor("heater",[-size.x/2+8, size.y/2, size.z/2-4.4], BACK, 0),
      named_anchor("nozzle",[-size.x/2+15.5, -size.y/2, size.z/2-4.5], FRONT, 0),
      named_anchor("thermistor",[-size.x/2+21.2, size.y/2-4, 0], BACK, 0),
    ]
  )
  attachable_geom(size=size, anchors=anchors);

module 23356BBA01_volcano_heater_block(anchor=CENTER, spin=0, orient=UP) {
  file="../23356BBA01_Volcano Heater Block/23356BBA01_Volcano Heater Block.stl";
  geom = 23356BBA01_volcano_heater_block_geom();
  size = _attach_geom_size(geom);
  echo(geom[8]);
  attachable(anchor,spin,orient, size=size, anchors=geom[8]) {
    import(file);
    children();
  }
}
