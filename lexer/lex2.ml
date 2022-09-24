open Printf;;
open Str;;

(* 
这里使用正则完成lexer
TODO: 学习calc3|str使用递归写出一个累积函数
chartlist2tocken
["1"; "0"; " "; "+"; " "; "2"; "*"; "3"]
->
["10","+","2","*","3"]
*)

let input = "21-20+100*20/15";;
let list1 = ["10";"2";"3"];;
let list2 = ["+";"*";"EOF"];;

let print_stringlist str_list = List.iter (printf "%s\n") str_list;;
let print_charlist charlist = List.iter (printf "%c\n") charlist;;

(* 分割子串,找出数字, 这里的'-'号写在最前面就没事，FUCK *)
input |> split (regexp "[-|+|*|/]") |> print_stringlist;;
print_endline "-------------";;

(* 分割子串，找出操作符号 *)
input |> split (regexp "[0-9]+") |> print_stringlist;;
print_endline "-------------";;

for i=0 to (List.length list1) - 1 do
  List.nth list1 i |> print_endline
done;;
print_endline "-------------";;

let rec printList = function
| [] -> print_newline ()
| head::tail -> print_endline head;printList tail;;
list1 |> printList;;
print_endline "-------------";;

(* ocaml4.11才支持List.filteri *)
list1 
  |> List.mapi (fun i x -> [List.nth list1 i] @ [List.nth list2 i]) 
  |> List.flatten 
  |> List.iter print_endline;;
print_endline "----------------";;


let result = list1 
  |> List.mapi (fun i x -> [List.nth list1 i] @ [List.nth list2 i]) 
  |> List.flatten ;;

result |> List.filteri (fun index item-> index != (List.length result) - 1 ) |> List.iter print_endline;;
print_endline "----------------";;