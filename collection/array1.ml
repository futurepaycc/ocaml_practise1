(* 数组创建 *)
let a1 = [| 1; 2; 3 |];;

(* 数组的下标访问 *)
a1.(0) |> print_int |> print_newline;;
print_endline "-------------";;

(* 数组长度 *)
a1 |> Array.length |> print_int |> print_newline;;
print_endline "-------------";;

(* 数组的下标赋值 *)
a1.(2) <- 100;;
a1.(2) |> print_int |> print_newline;;
print_endline "-------------";;

(* 数组变换与迭代1 *)
let s1 = Array.map string_of_int a1;;
Array.iter print_endline s1;;
print_endline "-------------";;

(* 数组变换与迭代2 *)
a1 |> Array.map string_of_int |> Array.iter print_endline ;;