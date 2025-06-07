FROM alpine:latest

WORKDIR /app

COPY . .

# this runs on build
RUN echo "Installing dependencies..."

# this runs on run
CMD ["./main.sh"]