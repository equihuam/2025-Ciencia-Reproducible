pacman::p_load(emayili, keyring)

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
 