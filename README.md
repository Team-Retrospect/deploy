# Retrospect Infrastructure Deployment

This repository contains files that deploy Retrospect's infrastructure. 

## Retrospect's Infrastructure

  + Cassandra

    - Storage for events and traces

  + Scheduled Tasks
    
    - Contains cron jobs that add metadata to certain type of database spans and a cleaner that removes expired data (older than a set number of days).

  + Api

    - Receives data from the Retrospect client and server agents and stores data in Cassandra. 

    - Serves requested data to Retrospect's UI. 

  + UI (client & server)

    - Filters and displays requested events and traces. 

## How to Deploy Retrospect's Infrastructure

  + Clone this repository to your local machine using `git clone`
  + `cd` into the folder and run `docker-compose up` to deploy the infrastructure in a docker network
