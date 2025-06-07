FROM docker:latest

WORKDIR /app

COPY . .

# this runs on build
RUN echo "Installing dependencies..."
RUN apk add make
RUN apk add nodejs


# check everything is in place
CMD ["./tests.sh"]