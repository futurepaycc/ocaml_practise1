(* 
开发运行：
.merlin: PKG sexplib

utop下运行1:
#load "sexplib.cma";;
#use "sexp1.ml";;

运行方式2:
utop -require sexplib sexp1.ml

来源: 
https://github.com/janestreet/sexplib
参考: 
https://dev.realworldocaml.org/data-serialization.html
https://rosettacode.org/wiki/S-expressions
大学课程:
https://cs.wellesley.edu/~cs301/f03/sexpr.pdf
https://cs.wellesley.edu/~cs251/s11/lectures/expression-trees-slides-handouts.pdf

NOTE: require 和 load 区别啊
*)
open Sexplib

let () =
  (* Build an Sexp from: (This (is an) (s expression)) *)
  let exp1 = Sexp.(List [
    Atom "This";
    List [Atom "is"; Atom "an"];
    List [Atom "s"; Atom "expression"]
  ]) in
  (* Serialize an Sexp object into a string *)
  print_endline (Sexp.to_string exp1);
  (* Parse a string and produce a Sexp object  *)
  let exp2 = Sexp.of_string "(This (is an) (s expression))" in
  (* Ensure we parsed what we expected. *)
  assert (Sexp.compare exp1 exp2 = 0)