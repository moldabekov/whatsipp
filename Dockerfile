FROM scratch
COPY main /
COPY index.html /
# Print logs to stdout
ENV DOCKER TRUE
EXPOSE 8080/tcp
CMD ["/main"]

