include <BOSL2/std.scad>
recolor("lavender") cuboid() {
  position(RIGHT) recolor("pink") cyl($fn=30,anchor=LEFT,orient=LEFT);
  attach(LEFT) cuboid([0.5,0.8,2]);
}