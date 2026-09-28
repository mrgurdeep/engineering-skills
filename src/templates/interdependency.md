---
title: <a> → <b>
type: interdependency
from: <a>
to: <b>
related: [../system-landscape.md, ../projects/<a>/integrations.md, ../projects/<b>/apis.md]
sources: []
last_verified: <date>
---
# <a> → <b>

**What:** <a> uses <b> for … · **How:** REST / GraphQL / events / shared DB / shared package · **Criticality:** high|med|low

```mermaid
sequenceDiagram
  participant A as <a>
  participant B as <b>
  A->>B: <call>
  B-->>A: <response>
```

## Contract
| Endpoint / topic | Caller file | Provider file | Auth | Notes |
|---|---|---|---|---|

## Failure modes & ownership
## Related
- [System landscape](../system-landscape.md)
