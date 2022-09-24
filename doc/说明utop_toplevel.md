### 1. toplevel需要配置 ~/.ocamlinit

#use "topfind"
#camlp4o
#thread
#require "core.top"
#require "core.syntax"

### core库需要安装
opam install core base utop

### 使用库
#require "str";; //加载库及依赖
#load "str.cma";; //也是加载库，更细粒度
open Str;;


#require "batteries";;
open Batteries;;
### 使用文件
#use 'yourfile.ml'

### 使用-unsafe-string
ocaml -unsafe-string
utop -unsafe (fuck，这样的行为也和上面不一样)

### ref
https://stackoverflow.com/questions/17645634/ocaml-and-opam-unbound-module-core (基本配置)
https://stackoverflow.com/questions/20643862/ocaml-how-to-load-file-ml/20647506 (使用文件)
https://stackoverflow.com/questions/42631912/whats-the-difference-between-include-require-and-open-in-ocaml (include require load说明)