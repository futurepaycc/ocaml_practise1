open Printf
let list1 = [ "1"; "2"; "3" ]

(* head是元素，tail是列表 *)
let rec printList = function
  | [] -> print_newline ()
  | head :: tail ->
    print_endline head;
    printList tail
;;

list1 |> printList
