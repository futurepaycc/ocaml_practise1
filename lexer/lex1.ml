(* 不使用正则的方式:
let string2charlist s = List.init (String.length s) (String.get s);;
map1: String.make 1 char
map2: +-x/ -> 空格
fold_left 合并
split_on_char 得到数字list
filter: +-x/ -> 得到操作符list
*)

let list3 = ["1";"2";"3";"4";" ";"4";"5"];;
List.fold_left (fun x y -> x ^ y) "" list3 |> print_string |> print_newline;;
print_endline "---------------";;


(* String.split_on_char  *)
(* String. *)

let result1 = List.fold_left (fun x y -> x ^ y) "" list3 ;;
let strList = String.split_on_char  ' ' result1;;

strList |> List.iter print_endline;;