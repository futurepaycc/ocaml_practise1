let list1 = ["10";"2";"3"];;
let list2 = ["+";"*";"EOF"];;
(* 下面这样不行，不能做元素类型转换 *)
(* List.map2 (fun item_left item_right -> [item_left]::[item_right] ) list1 list2;; *)
List.map2 (fun item_left item_right -> item_left ^ item_right ) list1 list2;;