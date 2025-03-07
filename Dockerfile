ARG DEBIAN_DIST=bookworm
FROM buildpack-deps:$DEBIAN_DIST

ARG DEBIAN_DIST
ARG lowfi_VERSION
ARG BUILD_VERSION
ARG FULL_VERSION

RUN apt update && apt install -y wget pkg-config libc-bin libssl-dev libasound2-dev git

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.85.0

RUN set -eux; \
    wget "https://static.rust-lang.org/rustup/archive/1.28.1/x86_64-unknown-linux-gnu/rustup-init"; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain 1.85.0 --default-host x86_64-unknown-linux-gnu;

    
RUN mkdir -p /output/usr/bin
RUN mkdir -p /output/usr/share/doc/lowfi
RUN git clone https://github.com/talwat/lowfi
RUN cd lowfi && cargo build --release --all-features && cp ./target/release/lowfi /output/usr/bin/
RUN mkdir -p /output/DEBIAN

COPY output/DEBIAN/control /output/DEBIAN/
COPY output/copyright /output/usr/share/doc/lowfi/
COPY output/changelog.Debian /output/usr/share/doc/lowfi/
COPY output/README.md /output/usr/share/doc/lowfi/

RUN sed -i "s/DIST/$DEBIAN_DIST/" /output/usr/share/doc/lowfi/changelog.Debian
RUN sed -i "s/FULL_VERSION/$FULL_VERSION/" /output/usr/share/doc/lowfi/changelog.Debian
RUN sed -i "s/DIST/$DEBIAN_DIST/" /output/DEBIAN/control
RUN sed -i "s/lowfi_VERSION/$lowfi_VERSION/" /output/DEBIAN/control
RUN sed -i "s/BUILD_VERSION/$BUILD_VERSION/" /output/DEBIAN/control

RUN dpkg-deb --build /output /lowfi_${FULL_VERSION}.deb
