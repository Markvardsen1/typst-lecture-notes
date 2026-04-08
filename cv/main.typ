#import "@preview/pro-academic-cv:0.1.0": *

#show cv: doc => doc

#cv(
  name: "Mathias Markvardsen",
  address: "Lyngby, Denmark",
  phone: "+45 53 61 02 11",
  email: "Mathias@Markvardsen.net",
  // You can add your LinkedIn or GitHub here if desired
  links: (
    (label: "Email", href: "mailto:Mathias@Markvardsen.net"),
  ),
)

#cv-section("Personal Profile")
1st year masters student at DTU in Mathematical Modelling and Computation[cite: 7]. Experienced in IoT, audio signal processing, and vessel performance analytics[cite: 9, 10]. Proven leadership skills from maritime roles as a Quartermaster and project management in R&D[cite: 11, 39, 44].

#cv-section("Education")

#cv-entry(
  title: "Msc Mathematical Modelling and Computation",
  society: "Danish Technical University (DTU)",
  date: "Sep 2022 - Jun 2027",
  location: "Lyngby, DK",
  description: [
    - Currently a 1st year masters student[cite: 7].
    - Previously completed Bsc General Engineering – Cyber Systems[cite: 14].
  ],
)

#cv-entry(
  title: "Higher Education (Gymnasium)",
  society: "Frederiksborg Gymnasium og HF",
  date: "2016 - 2019",
  location: "Hillerød, DK",
  description: [
    - Specialized in English, Spanish, Mathematics, and Biotechnology[cite: 27].
    - Graduated with an average grade of 11.6/12[cite: 28].
  ],
)

#cv-section("Professional Experience")

#cv-entry(
  title: "Partner / Co-founder",
  society: "VetAlign",
  date: "Sep 2025 - Present",
  description: [
    - Building a new SaaS platform for medical records in the veterinary sector[cite: 17].
  ],
)

#cv-entry(
  title: "Associate, Technical Department / Student Assistant",
  society: "Nordic Marine Partner",
  date: "Jan 2024 - Jul 2025",
  description: [
    - Solely responsible for the technical department, providing in-depth vessel performance reports[cite: 31].
    - Built an automated system in Python, Excel, and Power BI to analyze fleet Lube Oil Performance[cite: 22, 32].
  ],
)

#cv-entry(
  title: "Quartermaster (AB)",
  society: "Training Ship DANMARK",
  date: "Jul 2022 - Sep 2022",
  description: [
    - Responsible for educating the next generation of deckhands in the Danish Fleet[cite: 36].
    - Managed operations on a traditional full-rigger during global voyages[cite: 37].
  ],
)

#cv-entry(
  title: "Project Manager Assistant (R&D)",
  society: "Widex",
  date: "Aug 2019 - Dec 2019",
  description: [
    - Assisted in presenting a project worth 70M Euros[cite: 41].
    - Handled Danish Work Permit logistics and salary negotiations for international staff[cite: 41, 42].
    - Managed documentation for Federal Drug Agency (FDA) audits[cite: 43].
  ],
)

#cv-section("Publications")
#cv-entry(
  title: "Toward a Testbed for the Internet of Underwater Things: Challenges and Considerations",
  society: "Bachelor Thesis released as a Paper",
  date: "2022",
  description: [Focuses on IoT and Audio Signal Processing for underwater communication[cite: 8, 9].],
)

#cv-section("Skills")
- *Technical:* Python, Power BI, Excel, Audio Signal Processing, IoT[cite: 9, 22].
- *Languages:* Danish (Native), English (Fluent), Spanish (Fluent)[cite: 3, 5].
- *Soft Skills:* Leadership, "Helicopter view" in stressful situations, and a Growth Mindset[cite: 48, 50].

#cv-section("Referees")
- *Ulrich Skovbo:* Master on Training Ship Danmark (+31 6 36307573)[cite: 53, 54].
- *Kyle Meidlinger:* Ex-Captain Christina O Master 3000 GT (+44 7741 740326)[cite: 55, 56].
