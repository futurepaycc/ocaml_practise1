(* utop str.cma lex1.ml  *)

open Printf;;
open Str;;

let print_charlist charlist = List.iter (printf "%c") charlist;;
let print_stringlist str_list = List.iter (printf "%s\n") str_list;;
let input = " 10 + 2 * 3 ";;

let result1 = input |> String.trim |> String.split_on_char ' ';;

List.iter (printf "%s\n") result1;;

List.length result1 |> print_int |> print_newline;;

let result2 = Str.split (Str.regexp "[ \n\r\x0c\t]+") input;;
List.iter (printf "%s\n") result2;;

let string2charlist s =
  let rec loop acc = function
    | 0 -> s.[0] :: acc
    | x -> loop (s.[x] :: acc) (x - 1)
  in
  loop [] (String.length s - 1);;

input |> string2charlist |> print_charlist;;

let char1 = 'c';;
(* 字符转为字符串: https://stackoverflow.com/questions/20441263/convert-char-to-string-in-ocaml *)
let str1 = String.make 1 char1;;