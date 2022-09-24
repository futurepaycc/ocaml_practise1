open Printf

let input = "1 + 2 * 3";;

(* 方式1: 使用内部函数1个1个的转换 *)
let string2chartlist inputStr = 
  let initResult = [] in
  let initIndex = String.length inputStr -1 in

  let rec onebyone result index = match index with
    |0 -> inputStr.[0]::result
    |x -> onebyone (inputStr.[x] :: result) (index - 1)
  in
  let result = onebyone initResult initIndex in result
;;
input |> string2chartlist |> List.iter (printf "%c  ") |> print_newline ;;
print_endline "----------------";;

(* 方式2: 使用标准库List.init length, int->char转换, String.get input 返回一个int->char的偏函数 *)
let string2chartlist' = function input -> List.init (String.length input) (String.get input);;
input |> string2chartlist' |> List.iter (printf "%c  ")|> print_newline;;
print_endline "----------------";;


input |> string2chartlist
  |> List.mapi (fun index item -> match item with |'+'|'-'|'*'|'/' -> index;|x -> 0  )
  |> List.iter print_int;;
print_endline "----------------";;
