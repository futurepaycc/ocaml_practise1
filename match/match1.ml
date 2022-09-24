(* 函数表达式match写法 *)
let is_zero x =
  match x with
  | 0 -> true
  | _ -> false
let is_zero_1 = is_zero 1;;
Printf.printf "1 is_zero? %B\n" is_zero_1;;

Printf.printf "0 is_zero? %B\n" (is_zero 0)

(* 单参function的match写法，看来简单些 *)
let is_one = function
  | 1 -> true
  | _ -> false
;;

Printf.printf "1 is_one? %B \n" (is_one 1);;
Printf.printf "2 is_one? %B \n" (is_one 2)

type animal =
  | Dog of string
  | Cat of string

let say_hello = function
  | Dog x -> x ^ " Say woof"
  | Cat x -> x ^ " say meow"

let hello_str = say_hello (Cat "Fluffy");;
print_endline hello_str
