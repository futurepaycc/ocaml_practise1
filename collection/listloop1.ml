open Printf;;

(* let input = "1 + 2 * 3";;
let list2 = ["+";"*"];; *)

let list1 = ["1";"2";"3"];;

list1 |> List.iter (printf "%s\n");;
print_endline "-------------";;

(* for do done里面是表达式，多条语句单分 *)
for i=0 to (List.length list1) - 1 do 
  print_string (List.nth list1 i); (* 这里只能单分 *)
  print_newline () (* 这里的括号不能省 *)
done;;
print_endline "-------------";;

for i=0 to (List.length list1) - 1 do
  List.nth list1 i |> print_endline
done;;
print_endline "-------------";;