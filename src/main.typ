#import "@preview/charged-ieee:0.1.3": ieee

#set text(font: "Linux Biolinum O", size: 11pt)

#show: ieee.with(
  title: [Catching Bugs Before They Bite], authors: (
    (
      name: "Tygo van den Hurk", department: [Computer Science and Engineering], organization: [Technical University Eindhoven], location: box(
        inset: 0pt, outset: 0pt,
      )[
        #link(
          "https://orcid.org/0009-0003-4182-5076", block(inset: 0pt, outset: 0pt)[
            #box(image("images/orcid.svg"))
            0009-0003-4182-5076
          ],
        )
      ], email: link(
        "mailto:t.j.f.h.v.d.hurk@student.tue.nl", "t.j.f.h.v.d.hurk@student.tue.nl",
      ),
    ),
  ),
)

#text(
  weight: "bold",
)[Everyone makes mistakes. It is --- however painful --- a part of human
  experience. We make between 3-6 errors per hour, 16 hours a day, 7 days a week.
  We are taught that we have to tolerate mistakes, but what if we didn't have to?
  What if we could find mistakes before they ever took effect? What if we could
  prevent them all together? What if, we could catch bugs before they bite...]

= The Project

Let's take a step back. Right now I am working on my Software End Project, or
SEP as I will call it from here on out. For SEP we have to learn how to work in
large groups (\~10 people) and write software together for a real world client.
Our group is making a medical app that diagnoses possible complications in the
elderly. Since this is people's health we are talking about, mistakes are not
something that we can afford to make.

= The Problem

Having such a large group is nice. It means that we can split the work up.
However, the chance that one of us makes a mistake is definitely there. That is
not something we actually want, we want to prevent this. That is what I will be
teaching you about today. How we prevent mistakes before they even take effect.

In software development it really easy to break things. Which is why there are
so many problems with software today. Writing good software is hard, expensive,
and time consuming. Those are not good for profit. Which is why many companies
just don't bother. If it works enough to convince you to buy it, that is good
enough for their bottom line.

= Real life example
Imagine you're building a calculator app. At first, you support basic operations
like addition and subtraction --- and it works fine. But one day, users ask for
division.

To add this new feature, you need to support decimal numbers, fractions, and
very small values. Suddenly, it’s not so simple. You also need to make sure
these changes don’t break anything that already works.

This kind of issue is common in software: adding new features can cause
unexpected bugs. The goal is to catch these problems before users ever see them.

= The Solution

If humans make mistakes all the time by accident, why don't we automate some
sort of checking? This is where what I made for our group comes in. One of the
contributions I made for my group is a CI/CD pipeline. What is that? Good
question! A CI/CD pipeline is something that constantly checks what you build
for breaking changes. Every time you make a change this program will run over
what you made and tell you if something that used to work is now broken.

The way we use it is that there is one copy of our program called the golden
egg. We don't touch that one. It is special, and that egg works. Next, each one
of us gets a copy of that egg, and makes modifications to it. Then, as soon as
we would like to improve our golden egg we present our modifications to the
pipeline and then the pipeline checks if the egg still works exactly as we
thought it was supposed to.

#figure(block(breakable: false, width: 100%)[
  #block(above: 0pt, below: 0pt)[#image("images/passed.svg")]
  #block(above: 0pt, below: 0pt)[#image("images/failed.svg")]
  #block(above: 0pt, below: 0pt)[#image("images/partial.svg")]
], caption: [Examples of possible results. from the pipeline]) <test-results>

If something breaks, nothing bad happens, we just keep making modifications to
our personal egg until it's ready for presenting again. If it is all good we
replace our golden egg with our one and we again take a copy for ourselves.
Repeating the cycle.

= Why This Matters

This way of working means we always have one working egg, the golden egg. This
is the egg we let users download. The one we show to our client. All the rotten
eggs never see the light of day. This is how we catch the bugs before they bite.

// amount of mistakes a day: https://teacherscollegesj.org/how-often-do-professionals-make-mistakes/