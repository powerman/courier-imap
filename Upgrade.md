# Upgrading packages

Update versions in `Dockerfile`, then:

```
docker build -t courier-imap:build .

rm -rf deb
id=$(docker create courier-imap:build)
docker cp $id:/build/deb .
docker rm $id

for f in deb/*; do reprepro --basedir apt/noble includedeb noble $f; done
```
