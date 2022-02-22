FROM ruby:3.0-alpine

ENV WORKING_DIRECTORY /usr/src/app

RUN \
  gem install webrick

WORKDIR $WORKING_DIRECTORY

COPY index.html $WORKING_DIRECTORY/

CMD ["ruby", "-run", "-e", "httpd", ".", "-p", "8000"]
