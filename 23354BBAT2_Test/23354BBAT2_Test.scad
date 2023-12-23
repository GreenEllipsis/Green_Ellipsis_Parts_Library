// a BOSL2 Test module
standalone = is_undef(BOSL_VERSION);
if (standalone) include <BOSL2/std.scad>
include <../23354BBAT1_Test/23354BBAT1_Test.scad>
echo(standalone=standalone);
//if (standalone) {
//  *23354BBAT1_Test() show_anchors();
//  recolor("pink") 23354BBAT1_Test() {
//    attach(BOTTOM) recolor("orange") 23353BBA01_gantry_wheel_2020(anchor=BOTTOM);
//  }
//}