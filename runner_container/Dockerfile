FROM docker:latest

LABEL org.opencontainers.image.source=https://github.com/jordanblakey/docker-in-depth

WORKDIR /app

COPY . .

# this runs on build
RUN echo "Installing dependencies..."
RUN apk add make
RUN apk add nodejs


# check everything is in place
CMD ["./tests.sh"]