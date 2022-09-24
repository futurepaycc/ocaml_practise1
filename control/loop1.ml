for i = 1 to 3 do
  print_endline (string_of_int i)
done
;;

print_endline "--------------";;

(* let list1 = [1;2;3;4;5];; *)
let iterFunc theList = 
  Printf.printf "%d\n" theList in
  List.iter iterFunc [1;2;3;4;5];;