// Brian Alano
// (C) Brian Alano, 2023, All rights reserved
// Autotruder REV 0

include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/extrusion_vslot.scad>
include <../libs/BOSL2/power_supply.scad>
include <../libs/BOSL2/attachments_extras.scad>
// if we "use" these, we can't recolor() or hide them:
include <../23344BBA5B_Autotruder Rightward Spool and Gear Holder/23344BBA5B Autotruder Rightward Spool and Gear Holder.scad>
include <../23352BBA5D_Small Gear/23352BBA5D_Small Gear.scad>
include <../23339BBA5A_Autotruder Rightward Spool Holder/23339BBA5A_Autotruder Rightward Spool Holder.scad>
include <../23340BBA5C_DoubleGear48t/23340BBA5C_DoubleGear48t.scad>
include <../23353BBA01_Gantry Wheel 2020/23353BBA01_Gantry Wheel 2020.scad>
include <../23329BBA02_MKS Robin Nano V3 Project Box Lid/23329BBA02_MKS Robin Nano V3 Project Box Lid.scad> 
include <../23329BBA01_MKS Robin Nano V3 Project Box Base/23329BBA01_MKS Robin Nano V3 Project Box Base.scad>
include <../23345BBA01_MKS Robin Nano V3.1_001 3D/23345BBA01_MKS Robin Nano V3.1_001 3D.scad>
include <../23320BBA7A_Spool Rod/23320BBA7A_Spool Rod.scad>
include <../23340BBA7B_Spool Rod Nut/23340BBA7B_Spool Rod Nut.scad>
include <../23340BBA10_Handle/23340BBA10_Handle.scad>
include <../23355BBA6A_Spool Gear Rightward/23355BBA6A_Spool Gear Rightward.scad>
include <../23355BBA6B_Spool Core/23355BBA6B_Spool Core.scad>
include <../23355BBA6C_Spool End Cap Removable/23355BBA6C_Spool End Cap Removable.scad>
include <../23340BBA7D_Spool Rod Spacer/23340BBA7D_Spool Rod Spacer.scad>



/* [Hole Sizes] */
M4_through_hole_d = 4.2;
M3_through_hole_d = 3.2;
M4_tap_hole_d = 3.7;
M4_head_d = 5.5; // FIXME

function 23335BBA01_Autotruder_geom(
  size=[400,130],
  thick_plate=5,
  thin_plate=1.2,
  fillet=2.5,
  v_profile=20,
  power_supply="JOYLIT S-120-24",
  control_board="MKS ROBIN NANO V3"
) = _23335BBA01_frame_geom(size, v_profile);

function _23335BBA01_frame_geom(size, v_profile) =
  let (
    p1 = [size.x/2, (size.y-v_profile)/2, v_profile/2],
    size = [size.x, size.y, v_profile],
    anchors = [
        named_anchor("front_left_top",  [-p1.x, -p1.y, p1.z],, TOP, 0),
        named_anchor("front_left_bottom", [-p1.x, -p1.y, -p1.z], BOTTOM, 0),
        named_anchor("front_right_top", [p1.x, -p1.y, p1.z], TOP, 0),
        named_anchor("front_right_bottom", [p1.x, -p1.y, -p1.z], BOTTOM, 0),
        named_anchor("back_left_top", [-p1.x, p1.y, p1.z], TOP, 0),
        named_anchor("back_left_bottom", [-p1.x, p1.y, -p1.z], BOTTOM, 0),
        named_anchor("back_right_top", [p1.x, p1.y, p1.z], TOP, 0),
        named_anchor("back_right_bottom", [p1.x, p1.y, -p1.z], BOTTOM, 0)
    ]
  )
  attachable_geom(size=size, anchors=anchors);

    
// frame
module frame(size, v_profile, anchor, spin, orient) {

  module shape() {
    // frame calculations
    cross_brace_length = size.y - v_profile*2;
    rotate([0, 90]) {
      fwd((cross_brace_length+v_profile)/2) extrusion_vslot(profile=v_profile, height=frame_length, anchor=CENTER) ; 
      back((cross_brace_length+v_profile)/2) extrusion_vslot(profile=v_profile, height=frame_length, anchor=CENTER) ; 
    }
    rotate([90, 0]) {
      left((frame_length-v_profile)/2) extrusion_vslot(profile=v_profile, height=cross_brace_length, anchor=CENTER) ; 
      right((frame_length-v_profile)/2) extrusion_vslot(profile=v_profile, height=cross_brace_length, anchor=CENTER) ; 
    }
  }
  
  geom = _23335BBA01_frame_geom(size, v_profile);
  attachable(anchor,spin,orient, geom=geom) { // TEST
      tag("frame") shape();
      children();
  }
}

// M3 slotted mounting bracket
module part_23269BBA03(center, anchor="hole_front_bottom", spin=0, orient) {
  tag("23269BBA03") 
  basic_mounting_plate(
    slot_length=hole_center_s, //+M3_through_hole_d, 
    slot_d =M3_through_hole_d,
    text="P/N 23269BBA03", 
    center=center, 
    anchor=anchor, 
    spin=spin,
    orient=orient
  )
  children();
}

module 23335BBA01_Autotruder(
  size=[400,130],
  thick_plate=5,
  thin_plate=1.2,
  fillet=2.5,
  v_profile=20,
  power_supply="JOYLIT S-120-24",
  control_board="MKS ROBIN NANO V3",
  hide_tags=""
)
{
  /* [Dimensions] */
  slot_width = size.y - 20;

  // power supply parameters
  ps = power_supply_model_params(ps_model);
  hole_center_s = ps[4][1][1][0] - ps[4][0][1][0];
  ps_hole_back_s = ps[1].y - ps[4][3][1][1];

  // control_board TODO(?)
  
  // spool holder parameters
  sh_hole_y_offset = 4.4;
  shg_hole_y_offset = 3.2;
  shg_thickness = 6;

  hide(hide_tags) color_this("DimGray") frame(size, v_profile)
  {
  //  show_anchors();
    // handle
    position(LEFT+FRONT) color_this("Beige") tag("23340BBA10") 23340BBA10_handle(anchor=LEFT+BOTTOM,orient=FRONT);
    // first power supply mounting bracket attached to frame
    attach("front_right_bottom")  right(ps_hole_back_s) color_this("DarkSeaGreen") tag("23269BBA03") part_23269BBA03() {
        // power supply attached to first bracket
        attach("slot_front_top") color_this("Gainsboro") 
          tag("power_supply") power_supply_model(ps_model, spin=90 , anchor="hole3", orient=UP) {
            // second power supply mounting bracket attached to power supply
            attach("hole0") color_this("DarkSeaGreen") part_23269BBA03(anchor="slot_front_top", orient=DOWN, spin=90);
        }
    }
    // project box base attached to frame
    attach("front_left_bottom") color_this("Beige") tag("23329BBA01") left(8) 23329BBA01_mks_robin_nano_v3_project_box_base(anchor="m_right_back", spin=-90) {
      // lid attached to base
      attach("s_right_front") color_this("Beige") tag("23329BBA02")  23329BBA02_mks_robin_nano_v3_project_box_lid(anchor="s_right_front");
      // pcb attached to base
      attach("p_right_front") color_this("DimGray") tag("23345BBA01") 23345BBA01_mks_robin_nano_v3_1_001_3d(anchor="left_front", spin=90);
    }
    // spool holder attached to frame
    position("front_right_top") color_this("Beige")23339BBA5A_autotruder_rightward_spool_holder(orient=FRONT, anchor="right_holes");
    // spool and gear holder attached to frame
    position("back_right_top") color_this("Beige") 23344BBA5B_autotruder_rightward_spool_and_gear_holder(orient=FRONT, anchor="right_holes") {
       // small gear on gear holder TODO mount motor
      attach("motor") color_this("CadetBlue") zrot(24) 
        23352BBA5D_small_gear(anchor=BOTTOM);
      // bearing on gear holder
      attach("gear") color_this("DarkGray") 
        23353BBA01_gantry_wheel_2020(anchor=BOTTOM) {
        // TODO double gear on bearing
        attach(TOP) color_this("CadetBlue") 
          23340BBA5C_doublegear48t(anchor=BOTTOM);
      } // gantry_wheel_2020
      // spool rod spacer on gear holder
      attach("spool", TOP) color_this("Beige") tag("23340BBA7D")
        up(8) 23340BBA7D_spool_rod_spacer() {
        // spool gear on spool spacer
        attach(BOTTOM, BOTTOM) color_this("CadetBlue") tag("23355BBA6A") 
          23355BBA6A_spool_gear_rightward() {
          // spool core on spool gear
          attach("face", BOTTOM) color_this("Beige") tag("23355BBA6B") 
            23355BBA6B_spool_core() {
              // spool cap on spool core
            attach(TOP, "face") color_this("CadetBlue") tag("23355BBA6C") 
              23355BBA6C_spool_end_cap_removable();
          } // spool_core
        } // spool_gear
      } // rod_spacer
      // spool rod on spool&gear holder
      attach("spool") color_this("DarkSalmon") up((slot_width+shg_thickness)/2) 
        23320BBA7A_spool_rod() {
        // nuts on spool rod
        attach(BOTTOM, "ceiling") color_this("CadetBlue") tag("23340BBA7B")
          23340BBA7B_spool_rod_nut();
          attach(TOP, "ceiling") color_this("CadetBlue") tag("23340BBA7B") 23340BBA7B_spool_rod_nut();
      } // spool rod
    } // spool and gear holder
  }
}