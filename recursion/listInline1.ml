(* 这咱是不写rec且定义递归的方式 *)
let printFunc theList = 
  Printf.printf "%d\n" theList in
  List.iter printFunc [1;2;3;];;