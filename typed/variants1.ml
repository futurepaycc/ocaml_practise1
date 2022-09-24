(* 变体variants可以类比c语言的union *)
type day =
  | Sunday
  | Monday
  | Tuesday
  | Wenesday
  | Thursday
  | Friday
  | Saturday

let is_weekend_day = function
  | Sunday   -> true
  | Saturday -> true
  | _        -> false
;;

let print_bool = function
  | true  -> print_endline "true"
  | false -> print_endline "false"
;;

(*lsp这里就是单纯的找不到print_bool么? -- 是batteries内的函数*)
Sunday |> is_weekend_day |> print_bool