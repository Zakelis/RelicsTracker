# RelicsTracker

## Usage
Follow prompt to indicate [PLThreshold].

### Mandatory args :

- **[PLThreshold]** filters all items which WA price is below given value. Must be a strictly positive round number or a 1-decimal floating number with '.' as separator (42.0 and not 42,0).

### Optional args :

- **[UpdateCache]** updates local cache (might take some time). Must be "true" or "false" (default). Not supported yet.

## Roadmap

- ~Legacy code.~
- ~1.0 : Entire rewriting of legacy code, basic flow and output.~
- 1.1 : Implement cache. Reduce runtime as no requests have to be made if we use the cache.
- 1.2 : Sorting options for both modes.
