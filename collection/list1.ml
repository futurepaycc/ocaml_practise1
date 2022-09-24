let list1 = [1;2;3;3;2;1] ;;

(* list长度 *)
print_int (List.length list1);;
print_newline();;

(* list指定位置元素 *)
print_int (List.nth list1 0);; (* 按下标访问list *)
print_newline();;

(* list递归求和 -- 函数表达式match写法 *)
let rec sum list =
  match list with
  | [] -> 0
  | head :: tail -> head + sum tail
;;

list1 |> sum |> print_int |> print_newline;;

(* list递归求和 -- 单参函数match写法 *)
let rec sum2 = function (*NOTE2: 使用function关键字，不能带参数*)
| [] -> 0
| head :: tail -> head + sum2 tail
;;
list1 |> sum2 |> print_int |> print_newline;;

(* 两个list的合并 *)
let list2 = [4;5;];;
list1 @ list2 |> sum2 |> print_int |> print_newline ;;