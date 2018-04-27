FROM python:3.6-slim

# Debug tools
RUN pip3 install ipdb bpython flake8

# Supporting libraries for python modules
RUN apt-get update && apt-get install --yes \
    libpq-dev libjpeg-dev zlib1g-dev libpng12-dev libmagickwand-dev \
    python3-dev python3-swiftclient python3-psycopg2 \
    build-essential libjpeg-progs optipng

# Default config for where we expect to find requirements
ENV REQUIREMENTS_PATH="requirements.txt"
ENV REQUIREMENTS_HASH="/usr/local/lib/python3.6/site-packages/requirements.md5"

# Ensure all users can create dependencies
RUN chmod -R 777 /usr/local/

# Create a shared home directory - helps anonymous users have a home
ENV HOME=/home/shared
RUN mkdir -p $HOME $HOME/.cache/pip
RUN chmod -R 777 $HOME

# Add binaries to image
ENTRYPOINT ["/entrypoint"]
ADD entrypoint /entrypoint
ADD wait-for-postgres   /wait-for-postgres
