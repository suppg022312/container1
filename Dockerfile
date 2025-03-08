FROM python:3.9-slim-buster

WORKDIR /app

RUN apt-get update && \
    apt-get install -y curl && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install 20 && nvm use 20

RUN apt-get update && \
    curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get install -y python3 python3-pip net-tools iputils-ping && \
    pip3 install uv flask streamlit

COPY app.py /app/app.py
CMD ["flask", "run", "--host=0.0.0.0", "--port=8888"]
