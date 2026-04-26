is_directory_encrypted <- function(path) {
  # Get all HTML files in the directory
  html_files <- list.files(path, pattern = "\\.html$", full.names = TRUE, recursive = TRUE)
  
  if (length(html_files) == 0) return(FALSE)
  
  # Read the first few lines of the first file to check for the signature
  # We look for "staticrypt" which is part of the form ID or class
  first_file_content <- readLines(html_files[1], n = 100, warn = FALSE)
  is_encrypted <- any(grepl("staticrypt", first_file_content))
  
  return(is_encrypted)
}


if (!is_directory_encrypted("_site/posts/privado/"))
{
  staticryptR::staticryptr(files = "_site/posts/privado/",
                           directory = "_site/posts/",
                           password = "prueba-123", 
                           short = TRUE,
                           recursive = TRUE
                           )
}
