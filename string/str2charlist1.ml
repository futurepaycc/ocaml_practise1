open Printf

let input = "1 + 2 * 3";;

let string2chartlist inputStr = 
  let initResult = [] in
  let initIndex = String.length inputStr -1 in
  let rec onebyone result index = match index with
    |0 -> inputStr.[0]::result
    |x -> onebyone (inputStr.[x] :: result) (index - 1)
  in
  let result = onebyone initResult initIndex in
    result
;;

input |> string2chartlist |> List.iter (printf "%c  ") |> print_newline ;;

let string2chartlist' = function input -> List.init (String.length input) (String.get input);;
input |> string2chartlist' |> List.iter (printf "%c  ")|> print_newline;;


input |> string2chartlist
  |> List.mapi (fun index item -> match item with |'+'|'-'|'*'|'/' -> index;|x -> 0  )
  |> List.iter print_int

