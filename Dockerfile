ARG DEBIAN_DIST=bookworm
FROM debian:$DEBIAN_DIST

ARG DEBIAN_DIST
ARG lowfi_VERSION
ARG BUILD_VERSION
ARG FULL_VERSION
ARG LOWFI_BINARY

RUN mkdir -p /output/usr/bin
RUN mkdir -p /output/usr/share/doc/lowfi
RUN mkdir -p /output/DEBIAN

COPY ${LOWFI_BINARY} /output/usr/bin/lowfi
RUN chmod +x /output/usr/bin/lowfi

COPY output/DEBIAN/control /output/DEBIAN/
COPY output/DEBIAN/postinst /output/DEBIAN/postinst
RUN chmod 755 /output/DEBIAN/postinst
COPY output/copyright /output/usr/share/doc/lowfi/
COPY output/changelog.Debian /output/usr/share/doc/lowfi/
COPY output/README.md /output/usr/share/doc/lowfi/

RUN sed -i "s/DIST/$DEBIAN_DIST/" /output/usr/share/doc/lowfi/changelog.Debian
RUN sed -i "s/FULL_VERSION/$FULL_VERSION/" /output/usr/share/doc/lowfi/changelog.Debian
RUN sed -i "s/DIST/$DEBIAN_DIST/" /output/DEBIAN/control
RUN sed -i "s/lowfi_VERSION/$lowfi_VERSION/" /output/DEBIAN/control
RUN sed -i "s/BUILD_VERSION/$BUILD_VERSION/" /output/DEBIAN/control

RUN dpkg-deb --build /output /lowfi_${FULL_VERSION}.deb
