#Recommended to use with x11 forwarding.
#Use PuTTY in windows in order to connect with x11 forwarding.
FROM alpine:latest
WORKDIR /
RUN apk update && apk upgrade
RUN apk add git
RUN git clone https://github.com/username29800/endure
RUN cp -a endure/* .
RUN ./pkg-alpine-cqgw.sh
RUN adduser -D user
RUN ./sysind.sh
RUN cp -r endure /home/user/
RUN echo sb0 > /home/user/endure/prefix
RUN echo /home/user >> /home/user/endure/sprefix
RUN chown -R user:user /home/user/endure
RUN mkdir /home/user/.ssh
RUN ssh-keygen -t rsa -N "" -f /home/user/.ssh/id_rsa
USER user
WORKDIR /home/user/endure
RUN ./sabre.sh ../.ssh/id_rsa
RUN echo . > pprefix
RUN utils/sacpreset default
RUN utils/sacpreset sb0
EXPOSE 8830
WORKDIR /home/user
CMD ["zsh", "-l"]
