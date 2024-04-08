module Main where
import Data.List -- Allows use of nub
import Data.Char -- allows use of digitToInt
import Data.Tuple

-- Generates tuples of possible solutions in the form (HR, MN, DY, MT)
generator1 :: [(Int, Int, Int, Int)]
generator1 =
  [(a,b,c,d)
    --Check these ranges are correct
    | a <- [0..23]
    , b <- [0..59]
    , c <- [1..31]
    , d <- [1..12]
    , isValidDate c d
  ]

-- Checks if a date is valid given day d, and month m as an integer. Returns True if a date is valid, and False otherwise
isValidDate :: Int -> Int -> Bool
isValidDate d m =
    case m of
        1 -> d `elem`  [1..31]
        2 -> d `elem`  [1..28] -- Model assumes a non-leap year
        3 -> d `elem`  [1..31]
        4 -> d `elem`  [1..30]
        5 -> d `elem`  [1..31]
        6 -> d `elem`  [1..30]
        7 -> d `elem`  [1..31]
        8 -> d `elem`  [1..31]
        9 -> d `elem`  [1..30]
        10 -> d `elem` [1..31]
        11 -> d `elem` [1..30]
        12 -> d `elem` [1..31]
        _  -> False

-- returns a list of tuples (HR, MN, DY, MT) that may be solutions to the teaser
-- Returns True if a number is factorisable & False otherwise
factorisable :: Int -> Int -> Bool
factorisable f n
  | f * f <= n = n `mod` f == 0 || factorisable (f+1) n
  | otherwise = False

-- Returns True if a number is prime & False otherwise
prime :: Int -> Bool
prime
    = not . factorisable 2

-- Counts the number of segments in a digit, takes i, integer and nd, number of digits to count
-- if nd > i.length then trailing 0's are used
countSegments :: Int -> Int -> Int
countSegments i 0 = 0
countSegments i nd -- currently counts '12' 24' etc as a single segment, not 2 of them
    | nd > 0 = countSegments (i `div` 10) (nd - 1) + countSingleDigit
    | otherwise = 0

    where
        countSingleDigit =
            case i `mod` 10 of
                1 -> 2
                2 -> 5
                3 -> 5
                4 -> 4
                5 -> 5
                6 -> 6
                7 -> 3
                8 -> 7
                9 -> 6
                _ -> 6 -- case 0 is default

-- takes in a tuple of (HR, MN, DY, MO) and their values, counts the total number of segments and returns the integer value
clockNumSegments :: (Int, Int, Int, Int) -> Int
clockNumSegments (hr, mn, dy, mo)
    = countSegments hr 2 + countSegments mn 2 + countSegments dy 2 + countSegments mo 2

-- Checks if a given set of digits is valid, if not it makes them valid. returns a valid 4 tuple
makeClockValid :: (Int, Int, Int, Int) -> (Int, Int, Int, Int)
makeClockValid (hr, mn, dy, mo)
    = (hr + (mn `div` 60), mn `mod` 60, dy, mo)

-- takes a 4-tuple argument and returns a list
tupleToList :: (a, a, a, a) -> [a]
tupleToList (a, b, c, d) = [a, b, c, d]

-- tester function to find possible solutions to the problem
tester1 :: (Int, Int, Int, Int) -> Bool
tester1 (hr,mn,dy,mo)
  = prime (clockNumSegments (hr, mn, dy, mo))
    && nub [hr `mod` 10, mn `mod` 10, dy `mod` 10, mo `mod` 10, hr `div` 10, mn `div` 10, dy `div` 10, mo `div` 10] == [hr `mod` 10, mn `mod` 10, dy `mod` 10, mo `mod` 10, hr `div` 10, mn `div` 10, dy `div` 10, mo `div` 10]
    && nub [hr, mn, dy, mo] == [hr, mn, dy, mo]
    && prime (clockNumSegments (hr, mn, dy+1, mo))
    && nub (tupleToList (hr, mn, dy+1, mo)) == tupleToList (hr, mn, dy+1, mo)
    && clockNumSegments (makeClockValid (hr, mn+1, dy+1, mo)) == ((clockNumSegments (hr, mn, dy+1, mo) + clockNumSegments (hr, mn, dy, mo)) `div` 2)

-- mn+1 makes the minutes 60, but then the digits would be different as the hour would increase and mn = 00


-- Question 1.1 Tester
x_generator1 :: Int
x_generator1 =
    length [ t | t <- ts , t `elem` g ]
    where
    g = generator1
    ts =
        [ ( 2 ,15 ,14 ,11)
        , ( 4 ,31 ,27 , 9)
        , ( 6 ,47 ,10 , 8)
        , ( 9 , 3 ,23 , 6)
        , (11 ,19 , 6 , 5)
        , (13 ,35 ,19 , 3)
        , (15 ,51 , 2 , 2)
        , (18 , 6 ,16 ,12)
        , (20 ,22 ,29 ,10)
        , (22 ,38 ,11 , 9)
        ]

-- Question 1.2 Tester
x_tester1 :: Int
x_tester1 =
    length [ t | t <- ts , tester1 t ]
    where
    ts =
        [ ( 6 ,59 ,17 ,24)
        , ( 6 ,59 ,17 ,34)
        , ( 6 ,59 ,27 ,14)
        , ( 6 ,59 ,27 ,41)
        , ( 8 ,59 ,12 ,46)
        , (16 ,59 , 7 ,24)
        , (16 ,59 , 7 ,42)
        , (16 ,59 , 7 ,43)
        , (16 ,59 ,27 ,40)
        , (18 ,59 , 2 ,46)
        ]

main = do
    print (filter tester1 generator1)
