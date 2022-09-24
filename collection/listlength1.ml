let l1 = [1;2;3];;

let rec length = function
|[] -> 0
|_::tail -> 1+ length tail;;

(* 这里必须有括号，函数左结合，优先级最高 *)
print_int (l1 |> length);;
print_newline ();;