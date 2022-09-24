type point = int * int;; (* 也是一个元组 *)

let p1:point = (3,3);;

let get_2_1 (a,_) = a;;

print_int (get_2_1 p1);;
print_char '\n';;  (* 为何print_newline;;不行？ *)
print_endline "";; (* print_endline是需要带参数的 *)

(* function默认自带单参模式匹配语义 *)
let print_tuple = function
|(a,b) -> print_int a; print_char ' '; print_int b; print_char '\n';;
;;

print_tuple p1;;

(* 这个和上面有所不同，是在元组基础上构造，可以转化tuple *)
(* https://ocaml.org/docs/data-types *)
type t2 = T2 of (int * int);;
let pair = (1,2);;
T2 pair;;
