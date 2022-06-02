#!/usr/bin/env sh
set -euo pipefail

# This tool focuses on extracting the last NUMCERTS certificates out of a bundle 
# for an OBJECT of a specific KIND, utilising the JSONPATH to reach the bundle
# It takes care of donwloading the bundle, decoding it, splitting it into separate
# certificates and then returning a concatenation of the last NUMCERTS
# This is useful in certificate rotation patterns where you want to keep 2
# certificates in a valid state so that the swap does not disrupt anything


PATTERN='-----BEGIN CERTIFICATE-----'
function main {

    NUMCERTS=1
    while [ $# -gt 1 ] ; do
        case $1 in
            --kind)     KIND=$2; shift;;
            --object)   OBJECT=$2; shift;;
            --jsonpath) JSONPATH=$2; shift;;
            --numcerts) NUMCERTS=$2; shift;;
            *)          EXTRAS="${EXTRAS:-} $1";;
        esac
        shift
    done
    [ -n "${EXTRAS:-}" ] && echo "Unrecognized parameters: ${EXTRAS:-}" >&2

    current_ca_bundle=$(kubectl get ${KIND} ${OBJECT} -o=jsonpath="{${JSONPATH}}")
    decoded_ca=$(echo "$current_ca_bundle" | base64 -d)

    if [ -z "$decoded_ca" ]; then
        echo "No bundle found" >&2
        exit 0
    fi

    num_certs=$(($(echo "$decoded_ca" | grep "^$PATTERN" | wc -l)))
    echo "${num_certs} certs found in file" >&2
    if [ "${num_certs}" -eq 1 ]; then
        echo "$decoded_ca"
        exit 0
    fi

    TMPDIR=$(mktemp -d )
    echo "${decoded_ca}" | csplit -f "${TMPDIR}/cert_" - '/^'"${PATTERN}"'$/' '{'$((num_certs-1))'}' >&2
    last_cert=$(ls ${TMPDIR}/cert_* | tail -${NUMCERTS})
    cat $last_cert
}

main "$@"
