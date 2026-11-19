#!/usr/bin/env bash
# Shopify Store Products Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~shopify-store-products"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Products on sale at a store (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "stores": [
      "allbirds.com"
    ],
    "onlyOnSale": true,
    "maxProductsPerStore": 500
  }'

# 2. Every in-stock variant of one collection (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "stores": [
      "https://www.allbirds.com/collections/mens"
    ],
    "rowPerVariant": true,
    "onlyAvailable": true
  }'

# 3. Hoodies across two stores (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "stores": [
      "https://www.gymshark.com",
      "allbirds.com"
    ],
    "keywords": [
      "hoodie"
    ],
    "includeDescription": true
  }'
