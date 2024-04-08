module Main where
import Data.List 

--returns a list of tuples (N1,N2,N3,N4,N5) that may be solutions to the teaser
--where N1,3,5 are 3 digit numbers, and N2,4 are 2 digit numbers
generator2 :: [(String, String, String, String, String)]
generator2 =
    [ (n1, n2, n3, n4, n5) |
        n1 <- filter (\num -> num == nub num && '0' `notElem` num) (map show [123..987]), -- finish removing repeated and 0's
        n2 <-  map delTail(permutations n1),
        head n1 /= head n2,
        n3 <- permutations n1,
        n4 <- map delTail(permutations n1),
        n5 <-  permutations n1 
    ]

-- Deletes the tailing element from a list of strings, with each string containing an integer. Returns string - final element
delTail :: String -> String
delTail [] = []
delTail (a) 
    = show ((read a) `div` 10) 


--test function for generator2
x_generator2 :: Int
x_generator2 =
    length [ t | t <- ts , t `elem` g ]
    where
    g = generator2
    ts =
        [ ( "123" ,"21" ,"123" ,"12" ,"123" )
        , ( "162" ,"26" ,"261" ,"12" ,"621" )
        , ( "219" ,"19" ,"912" ,"21" ,"291" )
        , ( "329" ,"92" ,"932" ,"32" ,"239" )
        , ( "439" ,"94" ,"394" ,"43" ,"394" )
        , ( "549" ,"95" ,"945" ,"95" ,"945" )
        , ( "568" ,"68" ,"586" ,"56" ,"586" )
        , ( "769" ,"67" ,"679" ,"97" ,"796" )
        , ( "879" ,"79" ,"897" ,"98" ,"789" )
        , ( "987" ,"79" ,"789" ,"79" ,"789" )
        ]

tester2 :: (String, String, String, String, String) -> Bool
tester2 (n1, n2, n3, n4, n5) =
    read n1 - read n2 == read n3 &&  read n3 - read n4 == read n5 && read n1 + read n3 + read n5 < 2000

--test function for tester2
x_tester2 :: Int
x_tester2 =
    length [ t | t <- ts , tester2 t ]
    where
    ts =
        [ ( " 138 " ," 01 " ," 137 " ," 50 " ," 87 " )
        , ( " 143 " ," 01 " ," 142 " ," 52 " ," 90 " )
        , ( " 171 " ," 02 " ," 169 " ," 79 " ," 90 " )
        , ( " 152 " ," 03 " ," 149 " ," 54 " ," 95 " )
        , ( " 159 " ," 04 " ," 155 " ," 61 " ," 94 " )
        , ( " 161 " ," 05 " ," 156 " ," 63 " ," 93 " )
        , ( " 182 " ," 06 " ," 176 " ," 80 " ," 96 " )
        , ( " 151 " ," 07 " ," 144 " ," 57 " ," 87 " )
        , ( " 165 " ," 08 " ," 157 " ," 64 " ," 93 " )
        , ( " 174 " ," 09 " ," 165 " ," 71 " ," 94 " )
        ]

main = do
    print(filter tester2 generator2)