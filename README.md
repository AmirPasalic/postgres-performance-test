# Postgres Performance Test Project

## About the Project
The scope of this project is to setup a simple test database and run some queries to measure their performance.
The goal is to test simple PostgreSQL sql relational table based schema in comparison to JSONB based Document 
based schema. How same queries(queries which aim to retrieve same data regardless of table structure) 
will perform based on the table structures? What is the impact of relational vs Document based schema?
These are some of the questions we will try to answer with this project.

## Motivation
The motivation was to test in PostgreSQL db how standard sql schema compares to JSONB based schema. By saying standard schema I mean a standard relational table design with separate column for each filed. On the other hand by saying the JSONB based schema I mean a regular Document db based table design where only the unique identifier of the table is a separate column. Everything else is one JSONB column called data or content which is serving as some kind of payload
(as json object).

**Why?**

Seeing multiple project going away from standard relational database table design to a Document based design(like in other
Databases like MongoDb or Elastic Search) or even an Hybrid SQL/Document based design(a one where you use a combination of standard SQL columns and JSONB columns containing sub/entities or satellite entities) .For multiple reasons I wanted to test the impact on some standard or often used queries(search scenarios) on the PostgreSQL database.

*As always my standard motivation behind this and any other project is as always to learn something 
and try things out.* 

## Where to start?
The documentation(Docs) related to this project have all the details and examples in order to 
understand the Model and examples, setup the test db and run some test runs or 'Labs'
to see the results. Below is a list of all Docs related to this projects. Reading and following
those will give you a good overview how to setup, run the performance test and analyze results.
\
Documentation:
- [Introduction](Docs/Introduction.md)
- [Setup](Docs/Setup.md)
- [CLI](Docs/CLI.md)
- [Disclaimer](DISCLAIMER.md)
- Labs
    - [Lab1](Lab1.md)
    - [Lab2](Lab2.md)

\
In order to continue and run the project please read the Docs section above starting from [Introduction](Docs/Introduction.md) and the section for [Setup](Docs/Setup.md) and [CLI](Docs/CLI.md). After you have read these you 
can have a look at the Labs. The Labs serve as a example test run for this project.
