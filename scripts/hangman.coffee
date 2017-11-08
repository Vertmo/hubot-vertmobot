playing = false
remainingChances = 8

module.exports = (robot) ->
    robot.respond /hangman start (.*)/i, (res) ->
        if playing
            res.send("The game as already started")
            return
        playing = true
        remainingChances = 8
        res.send("Okay, let's go !")
        
    robot.respond /hangman has (.)/i, (res) ->
        if !playing
            res.send("The game has not yet started !")
            return
        res.send(draw remainingChances)

draw = (rc) ->
    switch rc
        when 8 then return "8 chances restantes\n
  +----+\n
   |       |\n
           |\n
           |\n
           |\n
           |\n
======"
