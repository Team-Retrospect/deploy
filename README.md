# Retrospect Infrastructure Deployment

## What is Retrospect

Retrospect is a full-stack tracing tool designed for debugging small applications.

Retrospect is comprised of 6 different pieces: a client agent, a server agent, an api server, a server running scheduled data maintenance tasks, an instance of a cassandra database, and the user interface.

For more information on Retrospect, visit our [website](https://retrospecthq.com/).

## Prerequisites

- Install [retrospect-client-agent](https://github.com/Team-Retrospect/client-agent)

- Install [retrospect-server-agent](https://github.com/Team-Retrospect/server-agent)

## Retrospect's Infrastructure

- [Cassandra](https://github.com/Team-Retrospect/api-server)

  - Cassandra is used for storing for events and traces

- [Scheduled Tasks](https://github.com/Team-Retrospect/maintenance-scripts)

  - This server contains cron jobs that add metadata to certain type of database spans and a cleaner that removes expired data (older than a set number of days).

- [Api](https://github.com/Team-Retrospect/api-server)

  - This server receives data from the Retrospect client agent and server agents and stores data in Cassandra. It also serves requested data to Retrospect's UI.

- [UI](https://github.com/Team-Retrospect/retrospect-ui)

  - Filters and displays requested events and traces.

## How to Deploy Retrospect's Infrastructure with Docker (recommended)

- Install `docker` and `docker-compose` up where ever you want to deploy Retrospect.

  - `docker` version should be 20.10.6
  - `docker-compose` version should be 1.29.1
  - Use this installation guide for assistance: https://docs.docker.com/compose/install/

- Clone this repository to your local machine using `git clone`

- `cd` into the folder and run `docker-compose up` to deploy the infrastructure in a docker network

- Update the `endpoint` property in the "retrospect-server-agent" and "retrospect-client-agent" configuration files to point to the location of this network.

  - For example, if this network is deployed locally (where your instrumented service lives) then the `endpoint` should have a value of `"http://localhost"`. If the network lives on a virtual machine like a Digital Ocean droplet, then the `endpoint` should have a value containing the `"http://134.209.66.75"`.

  - If you deploy Retrospect on a virtual machine like Digital Ocean, make sure to use one with at least 4GB of RAM.

The Retrospect UI should start automatically in the browser. If not, it will be running on port 3200. If you are running the application locally, navigate to localhost:3200.

## How to Deploy Retrospect's Infrastructure Manually

- Set up api server and cassandra

  - See instructions [here](https://github.com/Team-Retrospect/api-server)

  <br>

- Set up scheduled tasks server

  - See instructions [here](https://github.com/Team-Retrospect/maintenance-scripts)

  <br>

- Set up Retrospect's UI
  - See instructions [here](https://github.com/Team-Retrospect/retrospect-ui)
