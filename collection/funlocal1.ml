(* 问题: 
* 两个test句子不能放在一起; 
* 打印换行结果也与预期不一致 
*)

let test1_iter (l:int list) = 
  l |> List.map (fun x -> x+1) |> List.iter print_int;;
  print_endline "";;
  
let test2_length (l:int list) = 
  (* print_newline ();; *) (* 这个句子都不能加, List.length有问题啊 *)
  let len = List.length l 
            in print_int len;;
  print_endline "";;
    
test1_iter [1;2;3];;
test2_length [1;2;3];;