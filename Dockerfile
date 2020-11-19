FROM python:3-alpine
RUN apk add --no-cache git && pip install gitdb2==3.0.0 trufflehog; exit 0
RUN adduser -S truffleHog; exit 0
USER truffleHog
WORKDIR /proj; exit 0
ENTRYPOINT [ "trufflehog" ]
CMD [ "-h " ] ; exit 0
