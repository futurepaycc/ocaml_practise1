(* 
调用方法: ocaml echo.ml hello world
说明: ocaml看来不需要明确的main函数
*)
let echo() = 
  let len = Array.length Sys.argv in
  if len > 1 then
    begin
      print_string Sys.argv.(1);
      for i=2 to len - 1 do
        print_char ' ';
        print_string Sys.argv.(i);
      done;
    end;;
echo();;