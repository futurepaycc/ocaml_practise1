(* 命令式特性:
1. 就像其它语言一样声明一些变量，这里不同的是每个let之间用 'in' 串起来
2. 使用普通的循环而不用递归
*)
let add_vect v1 v2 = 
  let len  = min (Array.length v1) (Array.length v2) in
  let res = Array.make len 0.0 in
  for i = 0 to len - 1 do
    res.(i) <- v1.(i) +. v2.(i)
  done;
  res;;

add_vect [|1.0;2.0;|] [|3.0;4.0|];;
