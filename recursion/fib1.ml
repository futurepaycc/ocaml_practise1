let rec fib1 n = if n < 2 then 1 else fib1 (n - 1) + fib1 (n - 2);;

print_int (fib1 5);;

(* 最外层的括号反而必须有 *)

print_newline ()

let rec fib2 = function
  | 0 -> 1
  | 1 -> 1
  | _ as x -> fib2 (x - 1) + fib2 (x - 2)
;;

5 |> fib2 |> print_int |> print_newline

let rec fib3 = function
  | 0 | 1 -> 1
  | _ as x -> fib3 (x - 1) + fib3 (x - 2)
;;

5 |> fib3 |> print_int |> print_newline
