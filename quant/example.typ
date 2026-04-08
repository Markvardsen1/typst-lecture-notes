#import "../base/template.typ": *

#let title = "Quantitative sustainability: A comprehensive framework for measuring and improving sustainability performance"
#let author = "Mathias Markvardsen"
#let professor = "ligma"
#let creater = "Mathias Markvardsen"
#let time = "Spring 2026"

#let abstract = "this paper is a compiled set of notes ont the course 12101 : Quantitative methods to assess sustainability."

#show: note_page.with(title, author, professor, creater, time, abstract)

= Week 1: What is sustainability?

_Brundtland Commisions_ :
Our planet is a closed system, and we are using its resources at an unsustainable rate. We need to find ways to live within the limits of our planet while still providing for the needs of current and future generations. This is the essence of sustainability.

To achieve sustainability, we need to consider three pillars: environmental, social, and economic. These pillars are interconnected and must be balanced to create a sustainable future.

See it as a Venn Diagram in the following order
$ op("Econnomies") subset op("Human Societies") subset op("Earth's Life support System") $

Can also be seen on the diagram below,
#image("images/2026-04-02_09-47-46.png", width: 60%)

== UN Sustainable Development Goals (SDGs)

rThere are 17 of them, and in general that are a set of goals that the United Nations has set for itself to achieve by 2030. They cover a wide range of issues, including poverty, hunger, health.

For about a third of them the progression is too slow, especially on the climate aspect of the goals.

== Planetary boundaries
There have been determined 9 planetary boundaries that we should not cross if we want to maintain a stable and healthy planet. These boundaries include things like climate change, biodiversity loss, and ocean acidification. We have already crossed some of these boundaries, and we need to take action to stay within them.


#image("images/planetry_boundaries.png", width: 95%)

As we can see 6 out of 9 of the boundaries have already been crossed, and we are approaching the limits of the remaining ones. This highlights the urgency of taking action to address these issues and move towards a more sustainable future.

This stems from a combination of different aspect, we have a higher demand for materials and energy, and we are also using more land for agriculture and urbanization. This is putting a lot of pressure on the planet's resources and ecosystems, and it is contributing to the crossing of these planetary boundaries.

If we continue on this trajectory, for some of the resources there will be less than 30 years left before we run out of them. This is a very alarming situation, and it highlights the need for us to take action to reduce our consumption and find more sustainable ways of living.

Key takeaways:
+ Sustainable assessment should consider three dimensions: social, economic, and environmental.
+ The environment is challenged by human activities
+ We need to reduce our envirionmental impact to stay within the planetary boundaries.

== Global commitments and obligations
The Rio Declaration on Environment and Development (1992) is a key document that outlines the principles for sustainable development. It emphasizes the need for international cooperation and the importance of integrating environmental and developmental concerns.
- Human beings are at the center of concerns for sustainable development. They are entitled to a healthy and productive life in harmony with nature.
- ... equitably meet developmental and environmental needs of present and future generations.
- ... environmental protection shall constitute an integral part of the development process and cannot be considered in isolation from it.

This lead to the now well known SDGs, but the origin stems from:
- The modern sustainbality concept emerged from interactions between economic development and environmental protection in the 1970s and 1980s.

- Consensus ||: 1992 Rio Declaration
  - Reconcile Stockholm declaration (1972) with economic development & UDHR (Humnan rights)
  - needed for global security.
  - needed to adhere to Universal Human Rights

In Europe we try to implement this through "The European Green Deal", which is a set of policies and initiatives aimed at making Europe climate neutral by 2050. It includes measures to reduce greenhouse gas emissions, promote renewable energy, and protect biodiversity.
Note some things are not set in stone yet. Nature should be restored is a goal, but it is not quite clear yet what restored means.

European Taxonomy: help incentivize sustainable investments by providing a common language and framework for identifying and classifying sustainable economic activities. It is a tool that helps investors, companies, and policymakers to identify which economic activities are environmentally sustainable and which are not. The taxonomy is based on a set of criteria that assess the environmental performance of economic activities, such as their contribution to climate change mitigation, adaptation, and other environmental objectives. By providing a clear and consistent framework for identifying sustainable economic activities, the European Taxonomy aims to promote sustainable investment and help achieve the EU's climate and energy targets.


#image("images/Eupean_green_deal.png", width: 95%)

#image("images/2026-04-02_10-24-38.png", width: 95%)

#image("images/2026-04-02_10-24-57.png", width: 95%)

= Week 2:
== Conceptual Frameworks for quantitative sustainability
The IPAT equation

#definition[
  $
    I = P A T = op("Pop") * op("GDP")/ op("Person") * I / op("GDP")
  $

  where:
  I is total environmental impact
  P is the global population size
  A is the affluence, which is often measured as GDP per capita
  T is the technology factor.
]

What is clear from the "IPAT" equations is that the total environmental impact can only be reduced through technological advancements, reducing population growth, or reducing affluence. However, reducing population growth and affluence can be difficult to achieve, and therefore technological advancements are often seen as the most viable solution for reducing environmental impact.

If the technological factor remains constant, then the total environmental impact will continue to increase as the population and affluence grow. This highlights the importance of investing in sustainable technologies and finding ways to reduce our environmental impact while still meeting the needs of a growing population and increasing affluence.
Size of reduction in T has been discussed in the academia and is ine order of 4 to 20 times reductions to see a proper impact on the environment.

Key takeaways:
- The global envionmental impact is a function of population, affluence, and technology. It is driven by human consumption and demand
- We can achieve some reductions in environmental impact by technology development, which should be a factor 4-20 more efficient.
- But we also need to address the human consumption it self.

== The Assessment Framework
goals: illustrate the generic life cycle of products and systems, explain the fundementals of LCA, identify indicators for life cycle sustainability assessment, formulate a simplified assessment approach.


- Technosphere: This word describes all the components made in the "human-world". In relation to environmental impact, it includes all the products, services, and infrastructure that we create and use. The technosphere is a key driver of environmental impact, as it is responsible for the extraction of resources, the production of goods, and the generation of waste.
- Ecosphere: The ecoshpere is where we see the consequences from the decisions done in the technosphere. It includes all the natural systems and processes that are affected by human activities, such as climate change, biodiversity loss, and pollution. The ecosphere is where we see the impacts of our actions on the environment, and it is important to consider both the technosphere and the ecosphere when assessing sustainability.

#definition[
  The life cycle of a product or system includes all the stages from raw material extraction, production, use, and disposal. It is important to consider the entire life cycle when assessing sustainability, as each stage can have different environmental impacts. For example, the production stage may have a high impact due to energy use and emissions, while the use stage may have a lower impact. By considering the entire life cycle, we can identify opportunities for reducing environmental impact and improving sustainability.

  - Such environmental impact can be assesed by doing a life cycle analysis (LCA), which is a comparative approach to comment on the environmental impact of the product or system throughout its life cycle. LCA considers all the stages of the life cycle and quantifies the environmental impact in terms of various indicators, such as greenhouse gas emissions, water use, and land use. By conducting an LCA, we can identify the stages of the life cycle that have the highest environmental impact and develop strategies to reduce that impact.
  - To include societal and economic impact, we can do a life cycle sustainability assessment (LCSA).
  - In this course we do not apply LCSA but aim to cover all aspects in a lufe cycle perspective through a simplified approach.

]

== Defining the object of assessment
- dewcribe the central properties of a product or system
- Define the object of assesment - The functional unit

+ The user context sets the background for defining our product or system, you should be able to ask questions such as:
- what shoiuld the product be used for?
- What does the product do?
- ... For whom is the product intended?
- how long and how often should the product be used?
- where in the world will the product be used?

Which value contribution does the product deliver to the user?

+ List the obligatory and positioning properties of the product or system you are assessing.

- Obligatory properties:
  - Decisive for the customers percieving the products as a product
  - Potential legal requirements
  - Helps define the product

- Positioning properties:
  - Not decisive for the customers percieving the products as a product
  - Not legal requirements
  - Helps position the product in the market

+ The Functional Unit
This is an essential aspect of doing quantitative sustainability assessment, as it defines the unit of measurement for the product or system being assessed. The functional unit should be defined in a way that allows for meaningful comparisons between different products or systems. For example, if we are assessing the environmental impact of different types of transportation, we might define the functional unit as "per passenger-kilometer traveled". This allows us to compare the environmental impact of different modes of transportation, such as cars, buses, and trains, on a common basis. This is essential in order to ensure equivalence between the compared services or products.

Example of a functional unit of outdoor paint:
"Complete coverage of $1 m^2$ primed outdoor wall for 10 years in Germany in a uniform color at $99.9%$ opacity"
In this example the functional unit includes: the what (Complete Coverage), the how much ($1 m^2$), the where (Germany), the how long (10 years), the how well (uniform color at $99.9%$ opacity).

= Week 3 : Case studies
*We have chosen satellites, later check if needed to find go through slides and videos here*

= Week 4 : Carbon Footprint and environmental indicators.
Introduction to environmental indicators.

learning objectives:
- apply a causal framework to relate human activity to climate change indicators
- calculate carbon footprint to determine how determine subtances can be aggregates based on impact
- position the carbon footprint vs other indicators.

*The DPSIR Model*

#image("images/DPSIR_model.png", width: 95%)

In this model and example we see how transportation impacts climate, we have some drivers, they emit gases, this add to the increase in temperature, the impact is then i.e. loss in biodiversity, and the response is to reduce emissions i.e. through adding taxes to vehicles driving on classic fuel. This model is a way to understand the causal relationships between human activities and environmental impacts, and it can help us identify opportunities for intervention and improvement.

= Week 5 Sustainability tools for Soociety ||:

thinking about sustainsbility in a context outside environment only i.e. economic and social aspects to it.

To consider different ways of impact assessment we can use other frameworks such as:
- Life Cycle Costing (LCC): This framework focuses on the economic aspects of sustainability, and it considers the total cost of ownership of a product or system over its entire life cycle. This includes not only the initial purchase price, but also the costs associated with maintenance, operation, and disposal. By conducting an LCC analysis, we can identify opportunities for reducing costs and improving economic sustainability.

- Social Life Cycle Assessment (S-LCA): This framework focuses on the social aspects of sustainability, and it considers the impacts of a product or system on husman well-being and social equity. This includes factors such as labor conditions, human rights, and community impacts. By conducting an S-LCA analysis, we can identify opportunities for improving social sustainability and promoting social justice.

  - Data and Databases: The social Hostspot Database (SHDB) and the Product Social Impact Life Cycle Assessment (PSILCA) database are two examples of databases that can be used to conduct social life cycle assessments. These databases provide information on the social impacts of different products and systems, and they can help us identify areas for improvement and promote social sustainability.
  - Both databases assume pathways exist across value chains and are commonly used to provide country and sector specific data on social impacts. They are based on a set of indicators that assess the social performance of products and systems, such as labor conditions, human rights, and community impacts as specfied by UNEP/SETAC.

The main purpose with the impact pathway in S-LCA is to assess / model relations between the cause (social activities / stressors) that arises from a company and their effect.

#image("images/scla_example_human_ocean.png", width: 95%)
Let us consider the example above in the figure to describe how CO2 emissions can damage society, environment, and economy through a S-LCA perspective. The case we consider is the CO2 emissions impact on Oceans and Human Health. Oceans acidification (midpoint level) is a consequence of an increase in CO2 emissions (environmental inventory), this leads to a decrease in the biodiversity (Damage Level), this then impacts a decrease in fishing capacities (economic), Decrease in well-being in coastal communities (societal), Loss of Ecosystem Quality (environment).

= Week 6 : Economic dimensions
Further explanation on LCC. Important from this week is to know how to assess using the Multi-Criteria Decision Assessment (MCDA) framework. So how to compare different products or systems based on multiple criteria, such as environmental impact, economic cost, and social impact. The MCDA framework allows us to weigh these different criteria and make informed decisions about which product or system is more sustainable overall. The example used in class consider 3 different bikes, with different prices, environmental impact (CO2) and social impact (child labor). See slides from week 6 to check how to weigh and normalize the different criteria.

= Week 7 : Ressource Management
See Elinor Ostrom's speech at her nobel prize lecture regarding polycentric governance of common pool resources. She argues that we need to move away from the idea of a single, centralized authority managing resources, and instead embrace a more decentralized approach that allows for multiple actors to be involved in the management of resources. This approach is more effective in promoting sustainability and ensuring that resources are used in a way that benefits everyone.

In the slides he goes through an example of how to sustainably manage a fishery company. Important concepts are:
- Maximum Sustainable Yield (MSY): This is the maximum amount of a resource that can be harvested without depleting the resource over time. It is important to determine the MSY for a resource in order to ensure that it is being used sustainably.
- Maximum Economic Yield (MEY): This is the level of harvesting that maximizes economic profit while still ensuring the sustainability of the resource. It is important to consider both the economic and environmental aspects of resource management in order to achieve sustainability.
- Bioeconomic Equilibrium: This is the point at which the economic benefits of harvesting a resource are balanced with the environmental costs
. It is important to find this equilibrium in order to ensure that resources are being used in a way that is both economically and environmentally sustainable.


#image("images/ressource_management_key_takeaways.png", width: 95%)

= Week 8 : Planetary Boundaries and absolute sustainability
The idea behind absolute sustainibility is to tackle the problem with a top-down approach, where we set limits for the different planetary boundaries and then work to stay within those limits. This is in contrast to a relative sustainability approach, which focuses on making incremental improvements without necessarily considering the overall limits of the planet.

For this we need to consider things such as:
- eco/efficiency: This is the idea of using resources more efficiently in order to reduce our environmental impact. It involves finding ways to produce more with less, and it is an important aspect of achieving absolute sustainability. It is the inverse of the technological factor in the IPAT equation, and it is essential for reducing our environmental impact while still meeting the needs of a growing population and increasing affluence.
To reach sustainability we need to increase our eco-efficiency by a factor of 4-20, which means that we need to find ways to produce more with less and reduce our environmental impact significantly.
Our current focus on eco-efficiency must be informed by an absolut sustainability perspective to ensure that solutions are also eco-efficitive.

Focus of the planetary boundaries is to constrain dramatic climate variations as was seen in the past. 


#image("images/2026-04-04_14-51-38.png", width: u85%)
This figure absolute sustainability in social dimensions. It is the Donut Model and we should as a humnaity aim to be in the green ring. 
