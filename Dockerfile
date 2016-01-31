FROM scratch

EXPOSE 873

VOLUME /srv

COPY passwd /etc/passwd

COPY group /etc/group

ADD rsync.tar /

COPY rsyncd.conf /rsyncd.conf

ENTRYPOINT ["/opt/rsync/bin/rsync", "--no-detach", "--daemon", "--config", "/rsyncd.conf" ]
