FROM ubuntu:16.04
WORKDIR /home/cloudbci_agent1/
RUN apt-get update && apt-get install -y git curl maven && apt-get clean && rm -rf /var/lib/apt/lists/*



