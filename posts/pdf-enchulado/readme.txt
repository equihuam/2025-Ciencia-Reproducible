En tu documento necesitarás:

Frontmatter con definición de metadatos de autores y afiliaciones:

author:
  - name: "Miguel Equihua"
    email: "miguel@ejemplo.com"
    orcid: "0000-0001-5306-7397"
    affiliations:
      - ref: inecol
    attributes:
      corresponding: true

affiliations:
  - id: inecol
    name: "Instituto de Ecología, Xalapa, Veracruz, México"

format:
  html:
    toc: true
    toc-depth: 3
    number-sections: true
    embed-resources: true
    title-block-style: manuscript  # <- aquí enchufas tu “paquete” de encabezado

  pdf:
    documentclass: article
    keep-tex: true
    template-partials:
      - title.tex      # <- aquí enchufas tu “paquete” de portada
    include-in-header:
      text: |
        \usepackage[noblocks]{authblk}
        \usepackage{graphicx}
        \usepackage{fontawesome5}   % para \faIcon{envelope}
        \usepackage[colorlinks=true]{hyperref}
        \renewcommand*{\Authsep}{, }
        \renewcommand*{\Authand}{, }
        \renewcommand*{\Authands}{, }
        \renewcommand\Affilfont{\small}