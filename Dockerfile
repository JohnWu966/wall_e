FROM python:3.5.5-alpine

WORKDIR /usr/src/app

COPY requirements.txt .

RUN apk add --update alpine-sdk libffi-dev

RUN apk add freetype-dev && apk add postgresql-dev && pip install --no-cache-dir -r requirements.txt &&  apk --update add postgresql-client 

COPY main.py .

COPY commands_to_load commands_to_load

COPY helper_files helper_files

COPY wait-for-postgres.sh .

CMD ["./wait-for-postgres.sh", "db",  "python", "./main.py" ]
