
# Lecture 1 and 2: Causal Inference with DAGs

## Lecture 1: motivation

- Causal inference frameworks
  - What are they for?
  - Why learn more than one?

- Lecture 1 & 2 topics
  - what are DAGs
  - causal inference with DAGs
    - what is an intervention
    - DAG-structures: confounding, mediation, colliders
    - d-separation
    - back-door criterion

- Motivating examples (same data, different dags)
  - Example task: are hospital deliveries good for babies?
  - New question: hernia

- Causal Directed Acyclic Graphs
  - diagram that represents our assumptions on causal relations
  - Causal DAGs to the rescue

- Back to example 1 and 2: we got the right answer

## What are DAGs?

- DAG definitions and properties
  - DAGs convey two types of assumptions: causal direction and conditional independence
  - DAGs are 'non-parametric': They relay what variable 'listens' to what, but not in what way

- DAG rules: chain, fork, collider

## From DAGs to causal inference

- The DAG definition of an intervention
  - DAGs imply a causal factorization of the joint distribution
  - Intervention as graph surgery - changed distribution
- The gist of observational causal inference is to take data we have to make inferences about data from a different distribution (i.e. the intervened-on distribution)

- When life gets complicated / real: many variable
  - d-separation (directional-separation)
  - The back-door criterion and adjustment
  - Did we see this equation before?

- How about positivity

# Lecture 3 structural causal models (SCMs)

- recap on DAGs
- Structural Causal Models: definitions
  - Think of the world as a computer program
  - Structural Causal Model 1
  - Recursive Structural Causal Models imply a Directed Acyclic Graph
  - Submodel and Effect of Action as a mutilated DAG
  - Specifying a distribution for exogenous variables U
  - A Probabilistic Causal Model is a SCM with a distribution over U
  - Calculating a treatment effect in a fully specified probabilistic causal model

- Identification
  - Recap of SCM - definitions
  - In the real world we don't know most of the SCM
  - Idenfitication in pictures
  - Not identified vs estimand
  - Seeing is not doing

- Defining counterfactuals and the causal Hierarchy (of questions)
  - Counterfactuals
  - Adam versus Zoe
  - Computing counterfactuals with SCMs
  - Pearl's Causal Hierarchy (of questions)
  - Where do we get this knowledge from?
  - Not covered but also possible:
    - DAGs: soft interventions, missing data assumptions
    - SCMs: causal sufficiency / necessity

# Lecture 4: How to find adjustment sets?

- Valid adjustment sets
- How to do adjustment
  - What not to do (univariable pre-screening)
  - Adjustment formula
  - Target queries: ATE / CATE, prediction under intervention
  - The simplest case: linear regression

- General estimators for the ATE and the CATE (meta-learners)
  - Intuitive way-pointers: Where does the variance come from?

- Limitations of DAGs and SCMs
  - Making DAGs
  - A003024: The death of DAGs?
  - Do we need to consider all DAGs?

- SCM vs potential outcomes
  - PO: averages of individual potential outcomes
  - SCM: submodel or mutilated DAG
- both require positivity
- d-separation implies conditional independence (exchangeability)
