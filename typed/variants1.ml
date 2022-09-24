(*这句放在了pkg文件中，直接运行脚本或者repl中需要*)
#require "batteries";; 
open Batteries;; (*依赖库*)

type day =
  | Sunday
  | Monday
  | Tuesday
  | Wenesday
  | Thursday
  | Friday
  | Saturday

let is_weeken_day d =
  match d with
  | Sunday -> true
  | Saturday -> true
  | _ -> false
;;

(*lsp这里就是单纯的找不到print_bool么? -- 是batteries内的函数*)
Sunday |> is_weeken_day |> print_bool |> print_newline