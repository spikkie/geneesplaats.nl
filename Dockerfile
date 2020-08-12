FROM scratch
EXPOSE 8080
ENTRYPOINT ["/geneesplaats-nl"]
COPY ./bin/ /