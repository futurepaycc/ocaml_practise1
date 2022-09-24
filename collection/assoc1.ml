(* 这里require报错据说是因为没有使用dune构建配置包 *)

(* 关联列表测试 *)

#require "base";;
open Base;;

let digit_alist = [0,"zero";  1,"one";   2,"two"];;
let res = List.Assoc.find ~equal:Int.equal digit_alist 2;;

(* 没有getvalue方法，只有模式匹配取值 *)
(* https://stackoverflow.com/questions/12288628/ocaml-option-get *)
match res with
|None -> Stdlib.print_endline ""
|Some v -> Stdlib.print_endline v;;