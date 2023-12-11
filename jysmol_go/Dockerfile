FROM ubuntu:latest
RUN apt-get update && apt install -y make git curl && \
    apt install -y golang-go
COPY ./jysmol_go .
RUN go build -o input main.go
RUN chmod +x /input
CMD ["go", "test", "-v"]
