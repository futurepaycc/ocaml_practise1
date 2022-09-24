(* 如何配置这面这句都会报错: https://github.com/ocaml-batteries-team/batteries-included/wiki/Getting-started *)
#require "batteries"
open Batteries;; (*依赖库*) 
open Printf;;

let nums = List.of_enum (1--10);;  (*生成range的方式*)

nums |> List.iter (printf "%d\n");;