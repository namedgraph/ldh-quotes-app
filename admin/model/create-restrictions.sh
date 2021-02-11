#!/usr/bin/env bash

[ -z "$SCRIPT_ROOT" ] && echo "Need to set SCRIPT_ROOT" && exit 1;

if [ "$#" -ne 3 ]; then
  echo "Usage:   $0 $base $cert_pem_file $cert_password" >&2
  echo "Example: $0" 'https://localhost:4443/demo/skos/ ../../../../../certs/martynas.stage.localhost.pem Password' >&2
  echo "Note: special characters such as $ need to be escaped in passwords!" >&2
  exit 1
fi

base="$1"
cert_pem_file=$(realpath -s "$2")
cert_password="$3"

pushd . && cd "$SCRIPT_ROOT"/admin/model

./create-restriction.sh \
-b "${base}admin/" \
-f "$cert_pem_file" \
-p "$cert_password" \
--uri "${base}ns/domain#TopicOfQuoteItem" \
--label "Topic of quote item" \
--slug topic-of-quote-item \
--on-property "http://xmlns.com/foaf/0.1/isPrimaryTopicOf" \
--all-values-from "${base}ns/domain#QuoteItem"

./create-restriction.sh \
-b "${base}admin/" \
-f "$cert_pem_file" \
-p "$cert_password" \
--uri "${base}ns/domain#ItemOfQuoteContainer" \
--label "Item of quote container" \
--slug item-of-quote-container \
--on-property "http://rdfs.org/sioc/ns#has_container" \
--has-value "${base}quotes/"

popd