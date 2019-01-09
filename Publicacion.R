#=================    PUBLICACION EN SHINY SERVER    =======================
getwd()
rsconnect::setAccountInfo(name='cristianpachacama',
                          token='7D40FAXXXXXXXXXXXXXXXXXXXXX27FBB0',
                          secret='8aIg5XXXXXXXXXXXXXXXXXXXXGF57a+5IG')

rsconnect::deployApp("App",
                     account = "cristianpachacama",
                     appName = "TesisBorrador")
