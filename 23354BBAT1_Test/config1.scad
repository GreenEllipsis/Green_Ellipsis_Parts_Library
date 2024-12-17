include <library.scad>
param1="config1";
echo("config1",param1=param1, param2=param2);

module param1() {
  echo("config1-->param1",param1=param1, param2=param2);
}

*library();
