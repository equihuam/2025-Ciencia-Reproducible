pacman::p_load(RPostgres)

dsn_database <-  "dvdrental"   # Specify the name of your Database
# Specify host name e.g.:"aws-us-east-1-portal.4.dblayer.com"

tryCatch({
  drv <- Postgres()
  print("Connecting to Database…")
  connec <- dbConnect(drv, 
                      dbname =   dsn_database,
                      host =     Sys.getenv("psql_eq_ip"), 
                      port =     Sys.getenv("psql_eq_port"),
                      user =     keyring::key_list("psql-eq")[1,2],
                      password = keyring::key_get(service = "psql-eq", 
                                                  username = dsn_uid))
  print("Database Connected!")
},
error=function(cond) {
  print(cond)
  print("Unable to connect to Database.")
})

df <- dbGetQuery(connec, "SELECT first_name, last_name FROM actor")

dbDisconnect(connec)
