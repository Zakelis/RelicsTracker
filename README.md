# RelicsTracker

A practical tool that indicates all relics worthy to refine.
Dynamically making use of last 48 hours weighted  from warframe.market !

Warning : Setting this entry at a low value (<= 35) can take more than a minute. This is because WFM's API only allows 3 requests per second.

## Usage
Follow prompt to indicate [MinPlatValue]. All drop locations for all eligible items worth at least that much platinium will be shown.

### Mandatory args :

- **[MinPlatValue]** filters all items which WA price is below given value. Must be a strictly positive round number or a 1-decimal floating number with '.' as separator (42.0 and not 42,0).

### Optional args :

- **[UpdateCache]** updates local cache (might take some time). Must be "true" or "false" (default). Not supported yet.

## Roadmap

- ~Legacy code.~
- ~1.0 : Entire rewriting of legacy code, basic flow and output.~
- 1.1 : Implement results cache. Reduce runtime by bypassing requests.
- 1.2 : Relic selector cache to filter possesses relics.
