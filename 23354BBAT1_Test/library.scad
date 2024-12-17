param1 = "library";
module library() {
  linear_extrude(4)text(param1);
  translate([0,0,-20]) linear_extrude(4) text(param2);
}