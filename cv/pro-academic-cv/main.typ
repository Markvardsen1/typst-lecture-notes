#import "@preview/pro-academic-cv:0.1.0": *

#show: resume.with(
  author-info: (
    name: "Mathias Markvardsen",
    primary-info: [
      +45 53 61 02 11 | #link("mailto:Mathias@Markvardsen.net")[Mathias\@Markvardsen.net]
    ],
    secondary-info: [
      Github: #link("https://github.com/Markvardsen1")[Markvardsen1] | LinkedIn: #link("https://www.linkedin.com/in/mathias-markvardsen-50a310190")[Mathias Markvardsen]
    ],
    tertiary-info: "Lyngby, Denmark",
  ),
  author-position: center,
)

== Objective
Seeking to leverage my background in Applied Math and Computer Science to drive innovation in complex technical problems. A solution is never done alone and I dream of being part of a great team that can push the boundaries of what is possible. I know my limitations and hope to learn from experts in the field, while taking the initiative to contribute from day 1.

== Experience
#r2c2-entry-list(
  (
    entry-header-args: (
      top-left: [VetAlign],
      top-right: [Sep 2025 - Present],
      bottom-left: [Partner / Co-founder],
      bottom-right: [Denmark],
    ),
    list-items: (
      [Partner in a start-up within the Veterinary sector.],
      [Fully functional Saas product built on C\# and NextJS],
    ),
  ),
  (
    entry-header-args: (
      top-left: [NORDIC MARINE PARTNER],
      top-right: [Jan 2024 - Jul 2025],
      bottom-left: [Associate, Technical Department],
      bottom-right: [Denmark],
    ),
    list-items: (
      [Responsible for Fleet Performance and developing management tracking tools.],
      [Built an automated system for retrieving monthly fleet reports and analyzing Lube Oil Performance],
      [Developed performance analysis tools using Python, Excel, and Power BI.],
      [Provided in-depth reports on optimal anti-fouling based on company strategy.],
    ),
  ),
  (
    entry-header-args: (
      top-left: [TRAINING SHIP DANMARK, M/Y CHRISTINA O],
      top-right: [Jan 2020 - Sep 2022],
      bottom-left: [Quartermaster (AB)],
      bottom-right: [Global],
    ),
    list-items: (
      [Responsible for educating the next generation of deckhands in the Danish Fleet.],
      [Maintained high standards onboard a traditional full-rigger for educative purposes.],
      [Managed deckhand operations and receptions during international voyages.],
    ),
  ),
  (
    entry-header-args: (
      top-left: [WIDEX],
      top-right: [Aug 2019 - Dec 2019],
      bottom-left: [Project Manager Assistant in R&D],
      bottom-right: [Denmark],
    ),
    list-items: (
      [Helped present a new platform project valued at 70M Euros.],
      [Managed legal papers and salary discussions for international staff work permits, FDA Audits.],
    ),
  ),
)

== Education
#r2c2-entry-list(
  (
    entry-header-args: (
      top-left: [Danish Technical University (DTU)],
      top-right: [Sep 2022 - Jun 2027],
      bottom-left: [Msc Mathematical Modelling and Computation],
      bottom-right: [Lyngby, Denmark],
    ),
    list-items: (
      [Current educational progress: 1st year Masters student.],
      [Exchange at top university in Switzerland, EPFL, Fall 2024],
      [Completed Bsc General Engineering – Cyber Systems, Average grade: 9.13 out of 12.],
    ),
  ),
  (
    entry-header-args: (
      top-left: [Frederiksborg Gymnasium og HF],
      top-right: [2016 - 2019],
      bottom-left: [Higher Education],
      bottom-right: [Hillerød, Denmark],
    ),
    list-items: (
      [Average grade: 11.6 out of 12.],
      [Focused on Mathematics, Physics, Chemistry, and Biotechnology.],
    ),
  ),
)

== Academic Achievements
#publication-entry-list(
  (
    (
      category: "P",
      value: [Mathias Markvardsen. (2025). #link("https://dl.acm.org/doi/10.1145/3714394.3754422")[*Toward a Testbed for the Internet of Underwater Things: Challenges and Considerations*].],
    ),
  ),
)

== Skills
#multi-line-list(
  single-line-entry(
    "Programming & Tools:",
    [Python, Typescript, F\#, Java, C\#, Power BI, Excel, SQL, ESP32, Forecasting, Time Series Analysis & ML, Docker],
    [],
  ),
  single-line-entry("Languages:", [English (Fluent), Spanish (Fluent), Danish (Native) ], []),
  single-line-entry("Certifications:", [Ordinary Seaman (OS) STCW Certified, EXPLORE (start-up programme)], []),
  single-line-entry(
    "Leadership:",
    [Leadership in stressful situations, Helicopter view, Growth Mindset ],
    [],
  ),
  single-line-entry(
    "Tinkering:",
    [ I appreciate playing around with terminal, tmux, neovim, homeserver etc.],
    [],
  ),
  single-line-entry(
    "Hobbies",
    [Sports addict, reading books, spend time with family.],
    [],
  ),
)
