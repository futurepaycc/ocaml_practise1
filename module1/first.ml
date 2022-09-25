(* 说明:
1. 文件本身就是模块
2. 模块首字母大写, 本文件顶级模块为First
https://ocaml.org/docs/modules
*)

(* 一、基础内嵌模块 *)
module M1 = struct
  let addone x = x + 1;;
  type int_tuple = int * int;;
end;; (* 结束必有分号 *)

print_endline "-------------------------------------";;
let printInt x = print_int x |> print_newline ;;
M1.addone 3 |> printInt ;;

print_endline "-------------------------------------";;
let m1_t1:M1.int_tuple = (1,2);; (* typehint方式类似python语法 *)
match m1_t1 with (a,b) -> Printf.printf "(%d,%d)\n" a b;; (* 自定义元组类型也可以使用标准元组类型解构 *)


(* 二、模块签名 *)
module M2 : sig
  val hello : unit -> unit
end
= 
struct
let message = "Hello"
let hello () = print_endline message
end
;;

print_endline "-------------------------------------";;
(* print_endline M2.message 经过签名包装, M2.message无法访问了 *)
M2.hello () (* 无参函数调用者必须用 () *)