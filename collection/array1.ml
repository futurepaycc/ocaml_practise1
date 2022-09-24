let a1 = [| 1; 2; 3 |];;
a1 |> Array.length |> print_int |> print_newline;;

(* 数组的下标访问 *)
a1.(1) |> print_int |> print_newline;;

(* 数组的下标赋值 *)
a1.(2) <- 100;;
a1.(2) |> print_int;;