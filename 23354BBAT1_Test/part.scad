include <globals.scad>
str1="part";

module part_of_parts() {
  echo("part-->part_of_parts()", str1=str1, str2=str2);
}

module part() {
  module part_in_parts() {
    echo("part-->part_in_parts()", str1=str1, str2=str2);
  }
  str1 = "part_string";
  str2 = "part() only string";
  echo("part-->part()", str1=str1, str2=str2);
  inc_module();
  part_of_parts();
  part_in_parts();
}
echo("part", str1=str1, str2=str2);

part();