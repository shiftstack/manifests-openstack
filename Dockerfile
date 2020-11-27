FROM ubi8/ubi-minimal

RUN microdnf install -y python3 jq
RUN python3 -m pip install yq

COPY ./src /src

USER 1001

ENV XDG_CONFIG_HOME=/.config

ENTRYPOINT ["/src/run.sh"]
