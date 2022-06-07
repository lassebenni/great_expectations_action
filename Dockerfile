FROM python:3.9-buster

RUN apt-get update && apt-get install curl -y
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs
RUN curl -L https://npmjs.org/install.sh | bash
RUN npm install -g netlify-cli
ENV NODE_PATH="/usr/lib/node_modules"

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY run_checkpoints.sh /run_checkpoints.sh
COPY build_gh_action_site.py /build_gh_action_site.py
RUN chmod u+x /run_checkpoints.sh

ENTRYPOINT ["/bin/bash", "/run_checkpoints.sh"]
