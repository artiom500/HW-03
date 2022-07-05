FROM python:3.7-alpine

ENV PATH /usr/local/bin:$PATH
ENV LANG C.UTF-8
ENV USER=prodUser UID=12345 GID=23456

RUN mkdir -p /usr/src/app

COPY requirements.txt /usr/src/app/

RUN buildDeps='gcc python3-dev musl-dev postgresql-dev' \
    && apk update \
        && apk add --no-cache libpq \
            && apk add --virtual temp1 --no-cache $buildDeps \
                && pip install --no-cache-dir -r /usr/src/app/requirements.txt \
                    && apk del temp1

COPY . /srv/app/
WORKDIR /srv/app/


CMD [ "python3", "web.py"]