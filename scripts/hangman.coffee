playing = false
toGuess = ""
remainingChances = 7
found = []

module.exports = (robot) ->
    robot.respond /hangman start (.*)/i, (res) ->
        if playing
            res.send("The game as already started")
            return
        playing = true
        toGuess = res.match[1]
        found = ("-" for i in [0..toGuess.length-1])
        remainingChances = 7
        res.send("Okay, let's go ! ")
        
    robot.respond /hangman has (.)/i, (res) ->
        letter = res.match[1]
        if !playing
            res.send("The game has not yet started !")
            return
        if letter in toGuess
            for i in [0..toGuess.length]
                if toGuess[i] == letter
                    found[i] = letter
            res.send("Yes ! " + letter + " is in the word")
        else
            remainingChances -= 1
            res.send("No ! " + letter + " is not in the word")

        s = draw remainingChances
        s += "\n" + arrayToString found
        res.send(s)

    robot.respond /hangman is (.*)/i, (res) ->
        if !playing
            res.send("The game has not yet started !")
            return
        if res.match[1] == toGuess
            res.send("Yay ! You won !")
            playing = false
            return
        remainingChances -= 1
        s = "No !\n" + draw remainingChances
        s += "\n" + arrayToString found
        res.send(s)

arrayToString = (arr) ->
    return arr.reduce (x,y) -> x + " " + y

draw = (rc) ->
    switch rc
        when 6 then return "6 chances remaining\n
  +----+\n
   |       |\n
           |\n
           |\n
           |\n
           |\n
======"
        when 5 then return "5 chances remaining\n
  +----+\n
   |       |\n
   0      |\n
           |\n
           |\n
           |\n
======"
        when 4 then return "4 chances remaining\n
  +----+\n
   |       |\n
   0      |\n
   |       |\n
           |\n
           |\n
======"
        when 3 then return "3 chances remaining\n
  +----+\n
   |       |\n
   0      |\n
   |\\      |\n
           |\n
           |\n
======"
        when 2 then return "2 chances remaining\n
  +----+\n
   |       |\n
   0      |\n
  /|\\     |\n
           |\n
           |\n
======"
        when 1 then return "1 chances remaining\n
  +----+\n
   |       |\n
   0      |\n
  /|\\     |\n
    \\      |\n
           |\n
======"
        when 0 then return "0 chances remaining. You lose !\n
  +----+\n
   |       |\n
   0      |\n
  /|\\     |\n
  / \\     |\n
           |\n
======"

