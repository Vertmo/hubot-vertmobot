playing = false
nombre = 0
tentatives = 0

module.exports = (robot) ->
    
    robot.respond /plusmoins entre (.*) et (.*)/i, (res) ->
        min = parseInt(res.match[1])
        max = parseInt(res.match[2])
        if isNaN(min) or isNaN(max)
            res.reply "Entrez des nombres s'il vous plait"
            return
        if !playing
            playing = true
            tentatives = 0
            nombre = Math.floor(Math.random()*(max-min)+min)
            res.reply "OK on joue !"
            return
        res.reply "On est déjà en train de jouer !"

    robot.respond /(.*) \?/i, (res) ->
        if !playing
            res.reply "La partie n'a pas commencée"
            return
        entree = parseInt(res.match[1])

        if isNaN(entree)
            res.reply "Entrez des nombres s'il vous plait"
            return

        tentatives += 1

        if entree==nombre
            res.reply "Gagné ! En " + tentatives + " tentatives"
            playing = false
            return

        if entree > nombre
            res.reply "C'est moins !"
            return
        res.reply "C'est plus !"
