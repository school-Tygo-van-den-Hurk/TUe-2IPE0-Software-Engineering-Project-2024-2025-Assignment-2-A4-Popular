// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

#import "@preview/charged-ieee:0.1.3": ieee

#set document(
  title: "Title", // TODO: TBD
  author: "Tygo van den Hurk",
)

#show: ieee.with(
  title: [Title], // TODO: TBD
  authors: (
    (
      name: "Tygo van den Hurk", department: [Bachelor Computer Science], organization: [Technical University Eindhoven], email: "t.j.f.h.v.d.hurk@student.tue.nl",
    ),
  ),
  // abstract: [ ABSTRACT ],
  index-terms: ("Scientific writing", "Typesetting", "Document creation", "Syntax"), figure-supplement: [Fig.],
)

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Styling ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

#set text(font: "Linux Biolinum O", size: 11pt)
// #set text(font: "Roboto", size: 11pt)

#show heading.where(level: 1): set text(size: 18pt, weight: "bold")
#show heading.where(level: 2): set text(size: 16pt, weight: "bold")
#show heading.where(level: 3): set text(size: 14pt, weight: "regular")

#show link: it => [
  #text(blue, underline(stroke: blue + 0.1pt, offset: 1.75pt)[#it])
]

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Content ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

#lorem(663)

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
