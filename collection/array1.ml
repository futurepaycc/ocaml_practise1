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

(* 数组map变换与迭代1 *)
let s1 = Array.map string_of_int a1;;
Array.iter print_endline s1;;
print_endline "-------------";;

(* 数组map变换与迭代2 *)
a1 |> Array.map string_of_int |> Array.iter print_endline ;;
print_endline "-------------";;

(* 数组连接 *)
let a2 = [|4;5;|];;
let a3 = Array.append a1 a2;;
a3 |> Array.map string_of_int |> Array.iter print_endline ;;
print_endline "-------------";;

(* 数组转换成List *)
let l1 = Array.to_list a1;;
l1 |> List.map string_of_int |> List.iter print_endline ;;
print_endline "-------------";;

(* 没有数组删除|过滤, 转成List或子数组 *)
(* 子数组 *)
let a4 = Array.sub a3 1 4;; (* NOTE 这里传入2 4报参数错误, 而普通初始化组组没有关系 *)
a4 |> Array.map string_of_int |> Array.iter print_endline ;;
print_endline "-------------";;