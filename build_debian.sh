lowfi_VERSION=$1
BUILD_VERSION=$2
declare -a arr=("bookworm" "trixie" "sid")
for i in "${arr[@]}"
do
  DEBIAN_DIST=$i
  FULL_VERSION=$lowfi_VERSION-${BUILD_VERSION}+${DEBIAN_DIST}_amd64
docker build . -t lowfi-$DEBIAN_DIST  --build-arg DEBIAN_DIST=$DEBIAN_DIST --build-arg lowfi_VERSION=$lowfi_VERSION --build-arg BUILD_VERSION=$BUILD_VERSION --build-arg FULL_VERSION=$FULL_VERSION
  id="$(docker create lowfi-$DEBIAN_DIST)"
  docker cp $id:/lowfi_$FULL_VERSION.deb - > ./lowfi_$FULL_VERSION.deb
  tar -xf ./lowfi_$FULL_VERSION.deb
done


