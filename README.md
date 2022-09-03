# RelicsTracker

## Usage
Follow prompt to indicate [PLThreshold].

### Mandatory args :

- **[PLThreshold]** filters all items which WA price is below given value. Must be a strictly positive integer or float.

### Optional args :

- **[UpdateCache]** updates local cache (might take some time). Must be "true" or "false" (default). Not supported yet.

## Roadmap

- ~Legacy code.~
- 1.0 : Rework of legacy code, basic flow and output.
- 1.1 : Sorting options.
- 1.2 : Implement cache. Reduce runtime as no requests have to be made if we use the cache.
