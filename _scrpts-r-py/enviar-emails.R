pacman::p_load(emayili, keyring, gmailr)

email <- envelope() %>%
  render(
    "### Prueba
    
    Check out [`{emayili}`](https://cran.r-project.org/package=emayili).
    
    ") %>% 
  from("equihuam@gmail.com") %>%
  to("equihuam@gmail.com") %>%
  subject("This is a MD text message!")

print(email, details = TRUE)

smtp <- server(
  host = "smtp.gmail.com",
  port = 465,
  username = "equihuam@gmail.com",
  password = key_get("smtp-gmail", "miguel")
)

smtp(email, verbose = TRUE)
 

# Leer gmail
path_to_json <- "C:/Users/equih/0 Versiones/ciencia-reproducible/2025/_creds/miguel.json"
gm_auth_configure(path = path_to_json)  
gm_oauth_client()  
gm_auth()
gm_profile()

my_threads <- gm_threads(num_results = 30, 
                         search = "subject:(MD text message)")

# Recupera las hebras de interés empezando por la primer ID
# véase: https://support.google.com/mail/answer/7190?hl=en
convers <- length(my_threads[[1]][["threads"]])

for (i in (1:convers))
{
  conv_i <- gm_thread(gm_id(my_threads)[[i]])
  msg_i <- conv_i$messages[[1]]
  cat(i, ":  ", gm_subject(msg_i), ", ", gm_date(msg_i), "\n" )
  
}

