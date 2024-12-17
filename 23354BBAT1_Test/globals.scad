str1="global string";
echo("globals",str1=str1, str2=str2);

module inc_module() {
  echo("globals->inc_module()",str1=str1,str2=str2);
}