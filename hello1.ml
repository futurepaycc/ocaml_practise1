let average a b = (a +. b) /. 2.0

let result =
  (* 参数不能加括号，没有参数才加括号 *)
  average 5.5 6.5
;;

print_endline (string_of_float result);;

print_endline "hello world"

let list1 = [ "a", "b", "c", "d", "e" ]

(* 这是一个自执行函数? *)
let () = print_endline "hello ()"
