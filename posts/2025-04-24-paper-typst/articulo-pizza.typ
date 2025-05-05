// Some definitions presupposed by pandoc's typst output.
#let blockquote(body) = [
  #set text( size: 0.92em )
  #block(inset: (left: 1.5em, top: 0.2em, bottom: 0.2em))[#body]
]

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
    fill: luma(230),
    width: 100%,
    inset: 8pt,
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let d = (:)
  let fields = old_block.fields()
  fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  return block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subrefnumbering: "1a",
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => numbering(subrefnumbering, n-super, quartosubfloatcounter.get().first() + 1))
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => {
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          }

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let old_title = old_title_block.body.body.children.at(2)

  // TODO use custom separator if available
  let new_title = if empty(old_title) {
    [#kind #it.counter.display()]
  } else {
    [#kind #it.counter.display(): #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block, 
    block_with_new_content(
      old_title_block.body, 
      old_title_block.body.body.children.at(0) +
      old_title_block.body.body.children.at(1) +
      new_title))

  block_with_new_content(old_callout,
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color, 
        width: 100%, 
        inset: 8pt)[#text(icon_color, weight: 900)[#icon] #title]) +
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: body_background_color, width: 100%, inset: 8pt, body))
      }
    )
}

#import "@preview/fontawesome:0.3.0": *

#let color-link = rgb("#483d8b")

#let article(
  title: none,
  subtitle: none,
  header: none,
  code-repo: none,
  authors: none,
  date: none,
  abstract: none,
  keywords: none,
  custom-keywords: none,
  thanks: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  sansfont: (),
  mathfont: (),
  number-type: auto,
  number-width: auto,
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize,
           number-type: number-type,
           number-width: number-width,)
  show math.equation: set text(font: mathfont)
  set heading(numbering: sectionnumbering)

  show heading: set text(font: sansfont, weight: "semibold")

  show figure.caption: it => [
    #set text(font: sansfont, size: 0.9em)
    #if it.supplement == [Figure] {
      set align(left)
      text(weight: "semibold")[#it.supplement #it.counter.display(it.numbering): ]
      it.body
    } else {
      text(weight: "semibold")[#it.supplement #it.counter.display(it.numbering): ]
      it.body
    }
    
  ]
  
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el == none {
      it
    } else if el.func() == eq {
      link(el.location())[
        #numbering(el.numbering,
        ..counter(eq).at(el.location())
        )
      ]
      
    } else if el.func() == figure {
      el.supplement.text
      link(el.location())[
        #set text(fill: color-link)
        #numbering(el.numbering,..el.counter.at(el.location()))
      ]
    } else {
      it
    }
  }

  show link: set text(fill: color-link)
  set bibliography(title: "References")

  if date != none {
    align(left)[#block()[
      #text(weight: "semibold", font: sansfont, size: 0.8em)[
        #date
        #if header != none {
          h(3em)
          text(weight: "regular")[#header]
        }
      ]
    ]]
  }

  if code-repo != none {
    align(left)[#block()[
      #text(weight: "regular", font: sansfont, size: 0.8em)[
        #code-repo
      ]
    ]]
  }
  
  if title != none {
    align(left)[#block(spacing: 4em)[
      #text(weight: "semibold", size: 1.5em, font: sansfont)[
        #title
        #if thanks != none {
          footnote(numbering: "*", thanks)
        }\
        #if subtitle != none {
          text(weight: "regular", style: "italic", size: 0.8em)[#subtitle]
        }
      ]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(left)[
            #text(size: 1.2em, font: sansfont)[#author.name]
            #if author.orcid != [] {
                link("https://orcid.org/" + author.orcid.text)[
                  #set text(size: 0.85em, fill: rgb("a6ce39"))
                  #fa-orcid()
                ]
            } \
            #text(size: 0.85em, font: sansfont)[#author.affiliation] \
            #text(size: 0.7em, font: sansfont, fill: color-link)[
              #link("mailto:" + author.email.children.map(email => email.text).join())[#author.email]
            ]
          ]
      )
    )
  }  

  if abstract != none {
    block(inset: 2em)[
      #text(weight: "semibold", font: sansfont, size: 0.9em)[ABSTRACT] #h(0.5em)
      #text(font: sansfont)[#abstract]
      #if keywords != none {
         text(weight: "semibold", font: sansfont, size: 0.9em)[\ Keywords:]
         h(0.5em)
         text(font: sansfont)[#keywords]
      }
      #if custom-keywords != none {
        for it in custom-keywords {
          text(weight: "semibold", font: sansfont, size: 0.9em)[\ #it.name:]
          h(0.5em)
          text(font: sansfont)[#it.values]
        }
      }
    ]
  }  

  if toc {
    block(above: 0em, below: 2em)[
    #outline(
      title: auto,
      depth: none
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }

}

#let appendix(content) = {
  // Reset Numbering
  set heading(numbering: "A.1.1")
  counter(heading).update(0)
  counter(figure.where(kind: "quarto-float-fig")).update(0)
  counter(figure.where(kind: "quarto-float-tbl")).update(0)

  // Figure & Table Numbering
  set figure(numbering: it => {
    [A.#it]
  })

  // Appendix Start
  pagebreak(weak: true)
  text(size: 2em)[Appendix]
  content
}
#import "@preview/mitex:0.2.4": *

#show: doc => article(
  title: [La Mejor Masa de Pizza para Marcelo],
  subtitle: [Uso de Quarto + Typst para reportes científicos],
  header: [Por favor haga click #link("https://github.com/equihuam/prueba-git")[AQUÍ] para ir al documento en Github.],
  authors: (
    ( name: [Miguel Equihua],
      affiliation: [Inecol],
      email: [miguel.equihua\@inecol.mx],
      orcid: [0000-0001-5306-7397]
    ),
    ),
  date: [domingo, 4 de mayo de 2025],
  lang: "es",
  abstract: [Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sagittis posuere ligula sit amet lacinia. Duis dignissim pellentesque magna, rhoncus congue sapien finibus mollis. Ut eu sem laoreet, vehicula ipsum in, convallis erat. Vestibulum magna sem, blandit pulvinar augue sit amet, auctor malesuada sapien. Nullam faucibus leo eget eros hendrerit, non laoreet ipsum lacinia. Curabitur cursus diam elit, non tempus ante volutpat a. Quisque hendrerit blandit purus non fringilla. Integer sit amet elit viverra ante dapibus semper. Vestibulum viverra rutrum enim, at luctus enim posuere eu. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

],
  keywords: [Quarto, Typst, format],
  custom-keywords: (
          ( name: [JEL Codes],
        values: [J16, J22, J31]
      ),
      ),
  thanks: [This template is inspired by Kieran Healy's #link("https://github.com/kjhealy/latex-custom-kjh")[LaTeX and Rmd template] and Andrew Heiss's #link("https://github.com/andrewheiss/hikmah-academic-quarto")[Hikmah Quarto template];.

],
  font: ("Libertinus serif",),
  sansfont: ("Jost",),
  mathfont: ("Libertinus Math",),
  sectionnumbering: "1.1.1",
  cols: 1,
  doc,
)

This document shows a practical usage of the template.

I use the Palmer penguins dataset @horst2020 to demonstrate the features of the template. The code is available #link("https://github.com/kazuyanagimoto/quarto-academic-typst")[here];.

= Section as Heading Level 1
<section-as-heading-level-1>
Section numbering can be specified in the YAML `section-numbering` field as other Typst templates.

== Subsection as Heading Level 2
<subsection-as-heading-level-2>
You can use LaTeX math expressions:

$ Y_(i t) = alpha_i + lambda_t + sum_(k eq.not - 1) tau_h bb(1) { E_i + k = t } + epsilon_(i t) . $

I choose a mathematical font which supports the indicator function $bb(1) { dot.op }$. Currently, I use the Libertinus Math font.

=== Subsubsection as Heading Level 3
<subsubsection-as-heading-level-3>
I don't use and don't recommend using heading levels 3 and below but it works.

== Citation
<citation>
You can cite a reference like this @katsushika1831 or #cite(<horst2020>, form: "prose");. Typst has some built-in citation styles. Check the #link("https://typst.app/docs/reference/model/bibliography/#parameters-style")[Typst documentation] for more information.

= Figures and Tables
<figures-and-tables>
== Figures
<figures>
As #ref(<fig-facet>, supplement: [Figura]) shows, the caption is displayed below the figure. As a caption of the figure (`fig-cap`), I use bold text for the title and use a normal text for the description.

#figure([
#box(image("articulo-pizza_files/figure-typst/fig-facet-1.svg"))
], caption: figure.caption(
position: bottom, 
[
#strong[Flipper Length and Bill Length of Penguins];. The x-axis shows the flipper length, and the y-axis shows the bill length.
]), 
kind: "quarto-float-fig", 
supplement: "Figura", 
)
<fig-facet>


When I want to show multiple figures side by side, I use the `patchwork` package. The reason why I don't use the `layout-col` option is that the caption is also split into two parts.

#figure([
#box(image("articulo-pizza_files/figure-typst/fig-patchwork-1.svg"))
], caption: figure.caption(
position: bottom, 
[
#strong[Characteristics of Penguins];. The left panel shows the relationship between flipper length and body mass. The right panel shows the density of flipper length.
]), 
kind: "quarto-float-fig", 
supplement: "Figura", 
)
<fig-patchwork>


== Tables
<tables>
You can use #link("https://vincentarelbundock.github.io/tinytable/")[tinytable] for general tables and #link("https://vincentarelbundock.github.io/modelsummary/")[modelsummary] for regression tables. As #ref(<tbl-sum-penguins>, supplement: [Tabla]) shows, the caption is displayed above the table. The notes of the table can be added using the `notes` argument of the `tinytable::tt()` function.

#figure([
#show figure: set block(breakable: true)

#let nhead = 2;
#let nrow = 3;
#let ncol = 9;

  #let style-array = ( 
    // tinytable cell style after
(pairs: ((0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (7, 0), (7, 1), (7, 2), (7, 3), (7, 4), (8, 0), (8, 1), (8, 2), (8, 3), (8, 4),), ),
  )

  // tinytable align-default-array before
  #let align-default-array = ( left, left, left, left, left, left, left, left, left, ) // tinytable align-default-array here
  #show table.cell: it => {
    if style-array.len() == 0 {
      it 
    } else {
      let tmp = it
      for style in style-array {
        let m = style.pairs.find(k => k.at(0) == it.x and k.at(1) == it.y)
        if m != none {
          if ("fontsize" in style) { tmp = text(size: style.fontsize, tmp) }
          if ("color" in style) { tmp = text(fill: style.color, tmp) }
          if ("indent" in style) { tmp = pad(left: style.indent, tmp) }
          if ("underline" in style) { tmp = underline(tmp) }
          if ("italic" in style) { tmp = emph(tmp) }
          if ("bold" in style) { tmp = strong(tmp) }
          if ("mono" in style) { tmp = math.mono(tmp) }
          if ("strikeout" in style) { tmp = strike(tmp) }
        }
      }
      tmp
    }
  }

  #align(center, [

  #table( // tinytable table start
    column-gutter: 5pt,
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
    stroke: none,
    align: (x, y) => {
      let sarray = style-array.filter(a => "align" in a)
      let sarray = sarray.filter(a => a.pairs.find(p => p.at(0) == x and p.at(1) == y) != none)
      if sarray.len() > 0 {
        sarray.last().align
      } else {
        left
      }
    },
    fill: (x, y) => {
      let sarray = style-array.filter(a => "background" in a)
      let sarray = sarray.filter(a => a.pairs.find(p => p.at(0) == x and p.at(1) == y) != none)
      if sarray.len() > 0 {
        sarray.last().background
      }
    },
 table.hline(y: 2, start: 0, end: 9, stroke: 0.05em + black),
 table.hline(y: 5, start: 0, end: 9, stroke: 0.1em + black),
 table.hline(y: 0, start: 0, end: 9, stroke: 0.1em + black),
    // tinytable lines before

    table.header(
      repeat: true,
[ ],table.cell(stroke: (bottom: .05em + black), colspan: 4, align: center)[Male],table.cell(stroke: (bottom: .05em + black), colspan: 4, align: center)[Female],
[], [Bill Length (mm)], [Bill Depth (mm)], [Flipper Length (mm)], [Body Mass (g)], [Bill Length (mm)], [Bill Depth (mm)], [Flipper Length (mm)], [Body Mass (g)],
    ),

    // tinytable cell content after
[Adelie], [40.39], [19.07], [192.4], [4043], [37.26], [17.62], [187.8], [3369],
[Gentoo], [49.47], [15.72], [221.5], [5485], [45.56], [14.24], [212.7], [4680],
[Chinstrap], [51.09], [19.25], [199.9], [3939], [46.57], [17.59], [191.7], [3527],

    // tinytable footer after

    table.footer(
      repeat: false,
      // tinytable notes after
    table.cell(align: left, colspan: 9, text([_Notes_: Data from Palmer penguins dataset.])),
    ),
    

  ) // end table

  ]) // end align
], caption: figure.caption(
position: top, 
[
Summary Statistics of Penguins
]), 
kind: "quarto-float-tbl", 
supplement: "Tabla", 
)
<tbl-sum-penguins>


Since the default backend of `modelsummary` is `tinytable`, you can use the customization options of `tinytable` for `modelsummary`. In #ref(<tbl-regression>, supplement: [Tabla]), I use `tinytable::group_tt()` function to group the regression results by the dependent variables

#figure([
#show figure: set block(breakable: true)

#let nhead = 2;
#let nrow = 9;
#let ncol = 7;

  #let style-array = ( 
    // tinytable cell style after
(pairs: ((0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (0, 6), (0, 7), (0, 8), (0, 9), (0, 10),), align: left,),
(pairs: ((1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10), (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (2, 10), (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (3, 8), (3, 9), (3, 10), (4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (4, 10), (5, 0), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9), (5, 10), (6, 0), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (6, 8), (6, 9), (6, 10),), align: center,),
  )

  // tinytable align-default-array before
  #let align-default-array = ( left, left, left, left, left, left, left, ) // tinytable align-default-array here
  #show table.cell: it => {
    if style-array.len() == 0 {
      it 
    } else {
      let tmp = it
      for style in style-array {
        let m = style.pairs.find(k => k.at(0) == it.x and k.at(1) == it.y)
        if m != none {
          if ("fontsize" in style) { tmp = text(size: style.fontsize, tmp) }
          if ("color" in style) { tmp = text(fill: style.color, tmp) }
          if ("indent" in style) { tmp = pad(left: style.indent, tmp) }
          if ("underline" in style) { tmp = underline(tmp) }
          if ("italic" in style) { tmp = emph(tmp) }
          if ("bold" in style) { tmp = strong(tmp) }
          if ("mono" in style) { tmp = math.mono(tmp) }
          if ("strikeout" in style) { tmp = strike(tmp) }
        }
      }
      tmp
    }
  }

  #align(center, [

  #table( // tinytable table start
    column-gutter: 5pt,
    columns: (auto, auto, auto, auto, auto, auto, auto),
    stroke: none,
    align: (x, y) => {
      let sarray = style-array.filter(a => "align" in a)
      let sarray = sarray.filter(a => a.pairs.find(p => p.at(0) == x and p.at(1) == y) != none)
      if sarray.len() > 0 {
        sarray.last().align
      } else {
        left
      }
    },
    fill: (x, y) => {
      let sarray = style-array.filter(a => "background" in a)
      let sarray = sarray.filter(a => a.pairs.find(p => p.at(0) == x and p.at(1) == y) != none)
      if sarray.len() > 0 {
        sarray.last().background
      }
    },
 table.hline(y: 2, start: 0, end: 7, stroke: 0.05em + black),
 table.hline(y: 10, start: 0, end: 7, stroke: 0.05em + black),
 table.hline(y: 11, start: 0, end: 7, stroke: 0.1em + black),
 table.hline(y: 0, start: 0, end: 7, stroke: 0.1em + black),
    // tinytable lines before

    table.header(
      repeat: true,
[ ],table.cell(stroke: (bottom: .05em + black), colspan: 3, align: center)[Bill Length (mm)],table.cell(stroke: (bottom: .05em + black), colspan: 3, align: center)[Body Mass (g)],
[ ], [(1)], [(2)], [(3)], [(4)], [(5)], [(6)],
    ),

    // tinytable cell content after
[Chinstrap], [10.042\*\*], [10.010\*\*], [10.037\*\*], [32.426], [26.924], [27.229],
[], [(0.432)], [(0.341)], [(0.340)], [(67.512)], [(46.483)], [(46.587)],
[Gentoo], [8.713\*\*], [8.698\*\*], [8.693\*\*], [1375.354\*\*], [1377.858\*\*], [1377.813\*\*],
[], [(0.360)], [(0.287)], [(0.286)], [(56.148)], [(39.104)], [(39.163)],
[Male], [], [3.694\*\*], [3.694\*\*], [], [667.555\*\*], [667.560\*\*],
[], [], [(0.255)], [(0.254)], [], [(34.704)], [(34.755)],
[Year], [], [], [0.324\*], [], [], [3.629],
[], [], [], [(0.156)], [], [], [(21.428)],
[Observations], [342], [333], [333], [342], [333], [333],

    // tinytable footer after

    table.footer(
      repeat: false,
      // tinytable notes after
    table.cell(align: left, colspan: 7, text([\+ p \< 0.1, \* p \< 0.05, \*\* p \< 0.01])),
    table.cell(align: left, colspan: 7, text([\_Notes\_: Data from Palmer penguins dataset.])),
    ),
    

  ) // end table

  ]) // end align
], caption: figure.caption(
position: top, 
[
Regression Results of Penguins
]), 
kind: "quarto-float-tbl", 
supplement: "Tabla", 
)
<tbl-regression>


While `tinytable` generates compatible tables between LaTeX and Typst, it does not support LaTeX math expressions for Typst tables. I think the compatibility between LaTeX and Typst is crucial for academic writing because it guarantees that the document can be easily converted to LaTeX for submission to journals.

A workaround is to use #link("https://typst.app/universe/package/mitex/")[MiTeX];, a Typst package that allows you to use LaTeX math expressions in Typst. I write a custom theme for `tinytable` to convert LaTeX math expressions to MiTeX expressions. The following table includes LaTeX math expressions but will be converted to MiTeX expressions in the Typst output.

#figure([
#show figure: set block(breakable: true)

#let nhead = 1;
#let nrow = 3;
#let ncol = 1;

  #let style-array = ( 
    // tinytable cell style after
(pairs: ((0, 0), (0, 1), (0, 2), (0, 3),), ),
  )

  // tinytable align-default-array before
  #let align-default-array = ( left, ) // tinytable align-default-array here
  #show table.cell: it => {
    if style-array.len() == 0 {
      it 
    } else {
      let tmp = it
      for style in style-array {
        let m = style.pairs.find(k => k.at(0) == it.x and k.at(1) == it.y)
        if m != none {
          if ("fontsize" in style) { tmp = text(size: style.fontsize, tmp) }
          if ("color" in style) { tmp = text(fill: style.color, tmp) }
          if ("indent" in style) { tmp = pad(left: style.indent, tmp) }
          if ("underline" in style) { tmp = underline(tmp) }
          if ("italic" in style) { tmp = emph(tmp) }
          if ("bold" in style) { tmp = strong(tmp) }
          if ("mono" in style) { tmp = math.mono(tmp) }
          if ("strikeout" in style) { tmp = strike(tmp) }
        }
      }
      tmp
    }
  }

  #align(center, [

  #table( // tinytable table start
    columns: (auto),
    stroke: none,
    align: (x, y) => {
      let sarray = style-array.filter(a => "align" in a)
      let sarray = sarray.filter(a => a.pairs.find(p => p.at(0) == x and p.at(1) == y) != none)
      if sarray.len() > 0 {
        sarray.last().align
      } else {
        left
      }
    },
    fill: (x, y) => {
      let sarray = style-array.filter(a => "background" in a)
      let sarray = sarray.filter(a => a.pairs.find(p => p.at(0) == x and p.at(1) == y) != none)
      if sarray.len() > 0 {
        sarray.last().background
      }
    },
 table.hline(y: 1, start: 0, end: 1, stroke: 0.05em + black),
 table.hline(y: 4, start: 0, end: 1, stroke: 0.1em + black),
 table.hline(y: 0, start: 0, end: 1, stroke: 0.1em + black),
    // tinytable lines before

    table.header(
      repeat: true,
[Math],
    ),

    // tinytable cell content after
[#mitex(`\alpha`)],
[#mitex(`a_{it}`)],
[#mitex(`e^{i\pi} + 1 = 0`)],

    // tinytable footer after

  ) // end table

  ]) // end align
], caption: figure.caption(
position: top, 
[
Math Symbols
]), 
kind: "quarto-float-tbl", 
supplement: "Tabla", 
)
<tbl-math>


= Last words
<last-words>
I made this template for my working papers, so it may not be suitable for other fields than economics. I am happy to receive feedback and suggestions for improvement.

#show: appendix
= Supplemental Figures
<supplemental-figures>
The section numbering will be changed to "A.1.1" in the appendix. The second section in the appendix will be "B". On the other hand, the figure numbering will be reset to "A.1", "A.2" so that it is clear that these figures are part of the appendix. The "A" stands for the "Appendix", not the section numbering.

#figure([
#box(image("img/hokusai_kanagawa.jpg"))
], caption: figure.caption(
position: bottom, 
[
#strong[The Great Wave off Kanagawa];. A woodblock print by #cite(<katsushika1831>, form: "prose");.
]), 
kind: "quarto-float-fig", 
supplement: "Figura", 
)
<fig-img>


#pagebreak()


 

#set bibliography(style: "american-psychological-association")


#bibliography("paper-refs.bib")

