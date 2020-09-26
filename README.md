# Phala pRuntime Docker

Used to compile and deploy Phala pRuntime

## Compile docker from Dockerfile

```sh
docker build -t <name:tag> .
```

## Or download precompiled docker image

```sh
docker pull tolak/phala-pruntime-docker
```

## Run docker container

```sh
docker run \
    -it -p 9711:9711 \
    -v <phala-blochain source code dir>:/root/phala-blockchain \
    --name pruntime tolak/phala-pruntime-docker
```

## Compile & run

 - compile pRuntime

enter docker container

```sh
docker attach <container id>
```

execute within container,  run ```SGX_MODE=SW make``` for simulation mode if you don't have the hardware

```sh
cd /root/phala-blockchain/
git submodule init
git submodule update
cd pruntime
SGX_MODE=SW make
```

Make sure put spid.txt (linkable) and key.txt into bin/.

 - run pruntime

execute target file

```sh
cd bin
./app
```
Intel SGX Driver and SDK are needed. Set environment variable SGX_MODE=SW while building to run it in computer without SGX.

The dev mode keys in spid.txt and key.txt can be obtainied from [Intel](https://software.intel.com/en-us/sgx/attestation-services).
