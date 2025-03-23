https://www.cynthiahqy.com/posts/layout-folder-images/

```{r}
#| output: asis

img_lst <- fs::dir_ls("img/", glob = "*.png")

cat("::: {layout-ncol=3}\n",
    glue::glue("![]({img_lst})\n\n\n"),
    ":::",
    sep = ""
)


```