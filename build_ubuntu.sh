lowfi_VERSION=$1
BUILD_VERSION=$2

LOWFI_BINARY="lowfi-linux-x86_64"

wget "https://github.com/talwat/lowfi/releases/download/${lowfi_VERSION}/${LOWFI_BINARY}"
chmod +x "${LOWFI_BINARY}"

declare -a arr=("jammy" "noble" "questing")
for i in "${arr[@]}"
do
  UBUNTU_DIST=$i
  FULL_VERSION=$lowfi_VERSION-${BUILD_VERSION}+${UBUNTU_DIST}_amd64_ubu
  docker build . -f Dockerfile.ubu -t lowfi-ubuntu-$UBUNTU_DIST \
    --build-arg UBUNTU_DIST=$UBUNTU_DIST \
    --build-arg lowfi_VERSION=$lowfi_VERSION \
    --build-arg BUILD_VERSION=$BUILD_VERSION \
    --build-arg FULL_VERSION=$FULL_VERSION \
    --build-arg LOWFI_BINARY=$LOWFI_BINARY
  id="$(docker create lowfi-ubuntu-$UBUNTU_DIST)"
  docker cp $id:/lowfi_$FULL_VERSION.deb - > ./lowfi_$FULL_VERSION.deb
  tar -xf ./lowfi_$FULL_VERSION.deb
done

rm -f "${LOWFI_BINARY}"
