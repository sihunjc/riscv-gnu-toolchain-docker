FROM debian:bookworm

ENV RISCV=/opt/riscv
ENV PATH=$PATH:$RISCV/bin

RUN apt-get update                                                             \
	&& DEBIAN_FRONTEND=noninteractive                                          \
	&& apt-get install -y autoconf automake autotools-dev curl python3         \
	python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison   \
	flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev           \
	ninja-build git cmake libglib2.0-dev libslirp-dev                          \
	&& apt-get clean                                                           \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1                                                        \
	https://github.com/riscv-collab/riscv-gnu-toolchain.git                    \
	/tmp/riscv-gnu-toolchain                                                   \
	&& cd /tmp/riscv-gnu-toolchain                                             \
	&& ./configure --prefix=$RISCV --with-arch=rv64gc --with-abi=lp64d         \
	&& make linux                                                              \
	&& rm -rf /tmp/riscv-gnu-toolchain
