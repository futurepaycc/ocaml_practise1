(* 柯里化是一种函数的转换，它是指将一个函数从可调用的 f(a, b, c) 转换为可调用的 f(a)(b)(c)。 *)
(* Fun.flip 反转二元函数参数顺序 *)
(* 理解参考: https://www.cs.cornell.edu/courses/cs3110/2014sp/lectures/3/lec03.html *)

let add x y = x + y;; (* curry函数定义的形式，是下面的语法糖 *)
let add' = function (x) -> function (y) -> x + y;; (* 类型提示理解: int -> (int -> int) , 而 -> 是右结合的，括号可以省略 *)

let add3 = add 3;; (* 这里返回的是一个接收单一参数的函数 *)
add3 5 |> print_int |> print_newline;;


let add'' (x,y) = x + y;; (* 非柯里化定义形式，是下面元组matching的语法糖, 元组的类形提示为 item1*item2.... *)
(* let plus = fun (z : int * int) -> match z with (x, y) -> x + y;; *)

add'' (3,5) |> print_int |> print_newline;;
