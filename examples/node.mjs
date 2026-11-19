// Shopify Store Products Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Every in-stock variant of one collection
const run = await client.actor('Turboextract/shopify-store-products').call({
    "stores": [
        "https://www.allbirds.com/collections/mens"
    ],
    "rowPerVariant": true,
    "onlyAvailable": true
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.title, item.price, item.onSale, item.url);
}
