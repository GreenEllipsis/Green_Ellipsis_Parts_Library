include <library2.scad>
param1="config2";
echo("config2",param1=param2, param2=param2);

module param() {
  echo("config2-->param",param1=param1, param2=param2);
}

