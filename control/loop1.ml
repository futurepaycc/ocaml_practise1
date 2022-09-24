(* for 循环 *)
for i = 1 to 3 do
  print_endline (string_of_int i)
done;;
print_endline "--------------";;

(* while 循环 *)
(* 注意: ref型变量声明，取值与修改 *)
let idx = ref 0;;
while !idx < 3 do 
  print_int !idx;
  print_newline ();
  incr idx
done;;
print_endline "--------------";;