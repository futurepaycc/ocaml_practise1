let list1 = [1;2;3;4];;

(* fold相当于reduce, 
  参数1: 操作函数
  参数2: 初始值
  参数3: 待操作的list对象
*)
List.fold_left (+) 0 list1 |> print_int |> print_newline;;
print_endline "---------------";;

let list2 = ["1";"2";"3";"4"];;
List.fold_left (fun x y -> x ^ y) "" list2 |> print_string |> print_newline;;
print_endline "---------------";;