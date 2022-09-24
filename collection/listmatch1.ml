(* TODO: 完成char list -> token list 函数*)

let list1 = ['1'; '0'; ' '; '+'; ' '; '2'; '*'; '3'];;

list1 |> List.iter print_char |> print_newline;;
print_endline "--------------";;


let list2 = ['1','0','+','2','*','3'];;


(* 参考: https://dev.realworldocaml.org/lists-and-patterns.html *)
let rec drop_add list =
  match list with
  | [] -> []
  | '+' :: tl -> drop_add tl
  | hd :: tl -> hd :: drop_add tl
;;

list1 |> drop_add |> List.iter print_char |> print_newline;;
print_endline "--------------";;

(* 这种方法怎么尝试都不行: TODO: 使用map + fold尝试
let rec listPattern1 list = function
| [] -> []
| '+'::tail -> listPattern1 ['+']
| '-'::tail -> listPattern1 ['-']
| '*'::tail -> listPattern1 ['*']
| head::tail -> head :: listPattern1 tail;;

(* listPattern1 list2;; *) *)