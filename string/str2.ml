open Printf;;
open Str;;

let input = "21-20+100*20/15";;
let print_stringlist str_list = List.iter (printf "%s\n") str_list
let print_charlist charlist = List.iter (printf "%c\n") charlist

(*
   这个是最简单的方式，其他需要递归
   https://stackoverflow.com/questions/10068713/string-to-list-of-char/10069969
*)
(* 字符串转为chart list *)
let string2charlist s = List.init (String.length s) (String.get s);;

(* char list合并成字符串 *)
let rec charlist2string = function
  | [] -> ""
  | x :: xs -> String.make 1 x ^ charlist2string xs;; (* ^:字符串连接符 *)

(* 消除空白 *)
" 1 + 2 * 3" |> global_replace (regexp " +") "" |> print_endline;;

(* 分割子串,找出数字, 这里的'-'号写在最前面就没事，FUCK *)
input |> split (regexp "[-|+|*|/]") |> print_stringlist;;

(* 分割子串，找出操作符号 *)
input |> split (regexp "[0-9]+") |> print_stringlist;;

