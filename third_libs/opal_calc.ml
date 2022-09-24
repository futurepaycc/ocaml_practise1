(* opal库: 解析器组合子，基于monad, chainl1是其中实现的函数,haskell中的parsec似乎也有 *)
(* 说明: 原理需要参考haskell的Text.parsec.combinator *)

(* .merlin加入： PKG opal *)
#require "opal"
open Opal

(* 
构建: 
ocamlfind ocamlopt -c opal1.ml -package opal
ocamlfind ocamlopt -o opal1  opal1.ml -linkpkg -package opal
echo "1+2*3" | ./opal1 

参考:
https://github.com/pyrocat101/opal (opal使用)
https://ocaml.org/learn/tutorials/compiling_ocaml_projects.html#Using-the-ocamlfind-front-end (ocamlfind命令)
*)

let parens = between (exactly '(') (exactly ')')
let integer = many1 digit => implode % int_of_string
let add = exactly '+' >> return ( + )
let sub = exactly '-' >> return ( - )
let mul = exactly '*' >> return ( * )
let div = exactly '/' >> return ( / )

let rec expr input = chainl1 term (add <|> sub) input
and term input = chainl1 factor (mul <|> div) input
and factor input = (parens expr <|> integer) input

(* 有LazyStream.of_string 函数*)
let () =
  (* let input = LazyStream.of_channel stdin in *)
  let input = LazyStream.of_string "(1+2)*3" in
  match parse expr input with
  | Some ans -> Printf.printf "%d\n" ans
  | None -> print_endline "ERROR!"