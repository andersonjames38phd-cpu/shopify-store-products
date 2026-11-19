"""Shopify Store Products Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Products on sale at a store
run = client.actor("Turboextract/shopify-store-products").call(run_input={
    "stores": [
        "allbirds.com"
    ],
    "onlyOnSale": True,
    "maxProductsPerStore": 500
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("title"), item.get("price"), item.get("onSale"), item.get("url"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
