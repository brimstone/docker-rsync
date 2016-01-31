.PHONY: docker

docker: rsync.tar
	docker build -t brimstone/rsync:3.1.2 .

rsync.tar: Makefile
	docker run --rm -i \
	-e LDFLAGS="-static" \
	-w /tmp \
	alpine \
	/bin/sh -c '(apk -U add gcc make musl-dev autoconf automake curl \
	&& curl https://download.samba.org/pub/rsync/rsync-3.1.2.tar.gz \
	| tar zx \
	&& cd rsync* \
	&& ./configure --prefix=/opt/rsync \
	&& make install \
	&& rm -rf /opt/rsync/share \
	&& strip /opt/rsync/bin/rsync \
	) >&2 && tar c /opt/rsync' \
	> rsync.tar

publish:
	@docker login -e="${DOCKER_EMAIL}" -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}"
	docker push brimstone/nomad

travis: docker publish
