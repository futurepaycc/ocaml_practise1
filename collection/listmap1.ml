let list1 = ["1";"2";"3"];;
let list2 = ["+";"*";""];;

print_endline "----------------";;
list1 |> List.map (fun x -> x ^ "1") |> List.iter print_endline;;

print_endline "----------------";;
list1 |> List.mapi (fun i x-> List.nth list1 i) |> List.iter print_endline;;

print_endline "----------------";;
list1 |> List.mapi (fun i x -> [List.nth list1 i] @ [List.nth list2 i]) |> List.flatten |> List.iter print_endline;;
