let divide_zero x y = 
  try
    x/y
  with Division_by_zero -> 
    print_endline "divid by zero"; 
    0
;;

(* let printInt x = print_int x |> print_newline;; *)
let res = divide_zero 5 0;;
(* printInt res;; *)
Printf.printf "%d\n" res;;