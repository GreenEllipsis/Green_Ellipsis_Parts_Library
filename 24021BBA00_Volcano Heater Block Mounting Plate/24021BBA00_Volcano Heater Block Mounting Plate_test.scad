include <24021BBA00_Volcano Heater Block Mounting Plate.scad>

$fs = $preview ? 2 : 0.4;
$fa = $preview ? 12 : 5;

// Standard part
24021BBA00_volcano_heater_block_mounting_plate();

// TESTS
*down(5.1) 24021BBA00_volcano_heater_block_mounting_plate(vslot_profile=20, t=6) show_anchors()
  attach("hole_4", TOP) cube([10,10,30]);
*echo(_attach_geom_size(240201BBA00_volcano_heater_block_mounting_plate_geom()));
*echo(24021BBA00_volcano_heater_block_mounting_plate_geom());
*echo(attachable_geom(geom=mounting_plate_geom(size=[90,20,6], holes=_24021BBA00_holes())));
*echo(_attach_geom_size(23335BBA01_Autotruder_geom()).x);
*echo(_attach_geom_size(extrusion_vslot_geom()).x);
//echo("holes",holes=_240201BBA00_holes(20,30,6));
//holes=_240201BBA00_holes(20,30,6);
////mounting_plate(size=[20,130,6],holes=holes);
//
////holes=[
////[[-45, -45], TOP, [5,2]],
////[[45, -45], TOP, [3,6]],
////[[-45, 45], BOTTOM, [5,2]],
////];
//
//echo("geom",mounting_plate_geom(size=[20,30,6],holes=holes));
//mounting_plate(size=[20,30,6],holes=holes) show_anchors();
