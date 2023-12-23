param1 = "library2";
module library() {
  color("green") translate([20,0,20]) {
    linear_extrude(4) text(param1);
    translate([0,0,-20]) linear_extrude(4) text(param2);
  }
}