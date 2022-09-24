let inc x = x + 1;;

let squre x = x * x;;
let result_5 = inc 5 |> squre |> inc;;
result_5 |> print_int |> print_newline;;

5 |> fun x -> x * x |> print_int |> print_newline;; (* 内联函数定义 *)


let list1 = [1;2;3;4;5;6];;
list1 |> (Fun.flip List.nth) 3 |> print_int |> print_newline;; (*flip交换参数顺序*)