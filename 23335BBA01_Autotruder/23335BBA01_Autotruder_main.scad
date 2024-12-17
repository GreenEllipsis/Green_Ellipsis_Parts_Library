// Brian Alano
// (C) Brian Alano, 2023, All rights reserved
// Autotruder REV 0
// Main program to get user options and generate model

include <23335BBA01_Autotruder.scad>

/* [Model Selections] */
frame_options = "F"; // [F:V-Slot 2020 Extrusion]
power_supply_options = "P"; // [P:JOYLIT S-120-24]
control_board_options = "C"; // [C:MKS Robin Nano V3.x, R:RAMPS(TODO)] 

/* [Mesh Files] */ // deprecated
filament_gripper_mesh = "../23340BBA01_Filament Gripper/23340BBA01_Filament Gripper.stl";

/* [Visibility] */
// power supply only
hide_tags ="frame 23269BBA03 23345BBA01 23329BBA01 23329BBA02 23340BBA10 23339BBA5A 23344BBA5B 23340BBA7B 23340BBA7D 23355BBA6A  23352BBA5D 23355BBA6B 23355BBA6C";
//hide_tags ="frame 23269BBA03 power_supply 23345BBA01 23329BBA02 23340BBA10 23329BBA01 23340BBA7B 23340BBA7D 23355BBA6A 23355BBA6B 23355BBA6C";
//hide_tags ="power_supply 23345BBA01 23329BBA02 23340BBA10 23329BBA01 23340BBA7B 23340BBA7D 23355BBA6A 23355BBA6B 23355BBA6C";
//hide_tags ="23269BBA03 power_supply 23345BBA01 23329BBA02 23340BBA10 23329BBA01";
//hide_tags = "frame power_supply "; 
//hide_tags = "23329BBA01 23345BBA01";
//hide_tags = "23345BBA01 23329BBA02";
//hide_tags = "";

/* [Dimensions] */
frame_length = 400;
frame_width = 130;
thick_plate_t = 5;
thin_plate_t = 1.2;
default_fillet = 2.5;

/* [Hidden] */
// options processing
v_profile= frame_options == "F" ? 20 : 0;
ps_model = power_supply_options == "P" ? "JOYLIT S-120-24" : "unsupported";

// rendering
epsilon = 0.02;
$fa = $preview ? 12 : 5;
$fs = $preview ? 4 : 0.4;

// TESTS
23335BBA01_Autotruder(hide_tags=hide_tags);

//part_23269BBA03(center=true); // show_anchors();
//control_board_assy
//
//tag("power_supply") power_supply_model(ps_model, spin=90, anchor="hole3", orient=UP);
//    attach("s_right_front") 
*color_this("Pink") tag("23329BBA02")  23329BBA02_mks_robin_nano_v3_project_box_lid(anchor="s_right_front");
//color_this("Beige") tag("23329BBA01")  23329BBA01_mks_robin_nano_v3_project_box_base(anchor="s_right_front");
//  recolor("Beige") tag("23329BBA01") left(8) 23329BBA01_mks_robin_nano_v3_project_box_base(anchor="m_right_back", spin=-90);
*color_this("Beige") tag("23329BBA01")  23329BBA01_mks_robin_nano_v3_project_box_base(anchor="s_right_front") {
  attach("s_right_front") color_this("Pink") tag("23329BBA02")  23329BBA02_mks_robin_nano_v3_project_box_lid(anchor="s_right_front");
}

