### 说明
不是很好用, 断点工作不是很正常

### 安装
opam upgrade
opam install earlybird
vscode install earlybird-debugger

### 使用
ocamlc -g -o hello1.nc hello1.ml  #编译成byte执行,必须加-g才能debug (ocamlopt编译成native)
F5 debug