PRODUCT="my-product"

RETRIES=100
while true; do
    if [ $RETRIES -eq 0 ]; then
        echo "No retries left, timed out waiting for release to succeed"
        exit 1
    fi
    echo retries left: $RETRIES

    RELEASE_STATUS=$(cf product-release list ${PRODUCT} | jq -r '.[0].status')
    echo ${RELEASE_STATUS}
    if [ "${RELEASE_STATUS}" = "SUCCEEDED" ]; then
        echo "Release SUCCEEDED"
        exit 0
    fi

    RETRIES=$((RETRIES-1))
    sleep 5
done
