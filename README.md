rsync
=====

This is a simple container running just an rsync daemon

Usage
=====
```bash
docker run --rm -i --name rsync -v $PWD:/srv:ro -P brimstone/rsync:3.1.2
```

Then just lookup the port with `docker ps` and connect with `rsync rsync://$YOUR_IP:PORT/srv/`
