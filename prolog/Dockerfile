FROM swipl:8.3.13
WORKDIR /app
RUN useradd -ms /bin/sh prolog
USER prolog
COPY . .
EXPOSE 5000
CMD ["swipl", "http_server.pl", "--no-fork", "--port=5000"]
