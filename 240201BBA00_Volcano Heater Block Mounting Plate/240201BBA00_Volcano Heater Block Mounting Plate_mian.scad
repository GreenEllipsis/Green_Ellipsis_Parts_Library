include <240201BBA00_Volcano Heater Block Mounting Plate.scad>

// TESTS
240201BBA00_volcano_heater_block_mounting_plate(width=130, vslot_profile=20, 6);
*echo(_attach_geom_size(240201BBA00_volcano_heater_block_mounting_plate_geom()));
*echo(240201BBA00_volcano_heater_block_mounting_plate_geom());
*echo(attachable_geom(geom=mounting_plate_geom(size=[90,20,6], holes=_240201BBA00_holes())));
*echo(_attach_geom_size(23335BBA01_Autotruder_geom()).x);
*echo(_attach_geom_size(extrusion_vslot_geom()).x);
