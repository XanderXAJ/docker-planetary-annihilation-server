FROM golang:bookworm AS gobuild

RUN go install github.com/xanderxaj/papatcher@master

FROM ubuntu

RUN apt update && \
	apt install -y \
	ca-certificates \
	libcurl3-gnutls \
	libgl1 \
	libsdl2-2.0-0 \
	libstdc++6 \
	libuuid1

RUN mkdir /opt/pa \
	&& chmod 777 /opt/pa

COPY --from=gobuild /go/bin/papatcher /usr/bin/papatcher

COPY entrypoint.sh /

EXPOSE 20545/tcp

ENTRYPOINT [ "/entrypoint.sh" ]
