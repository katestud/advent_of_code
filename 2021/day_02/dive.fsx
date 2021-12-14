open System

let readLines = IO.File.ReadAllText("input.txt");;
let instructions = [| for x in readLines.Split [|'\n'|] -> x.Split(' ') |]

let mutable horiz = 0
let mutable depth = 0

Console.WriteLine "Executing Step 1"

[|
  for x in instructions ->
   match x[0] with
    | "forward" -> horiz <- horiz + (x[1] |> int)
    | "down" -> depth <- depth + (x[1] |> int)
    | "up" -> depth <- depth - (x[1] |> int)
    | _ -> ()
|]

let result1 = horiz * depth
printfn "Result is %d" result1

Console.WriteLine "Executing Step 2"

horiz <- 0
depth <- 0
let mutable aim = 0

[|
  for x in instructions ->
   match x[0] with
    | "forward" ->
        horiz <- horiz + (x[1] |> int)
        depth <- (aim * (x[1] |> int)) + depth
    | "down" -> aim <- aim + (x[1] |> int)
    | "up" -> aim <- aim - (x[1] |> int)
    | _ -> ()
|]

let result2 = horiz * depth
printfn "Result is %d" result2
