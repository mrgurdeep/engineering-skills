---
title: System landscape
type: landscape
project: all
related: [README.md]
last_verified: <date>
---
# System landscape

How all team projects fit together. Each arrow links to an interdependency page.

```mermaid
flowchart LR
  %% one node per project; arrows = "calls / depends on"; label = protocol
  %% webapp["Shop Web<br/>React"] -->|REST /orders| api["Shop API<br/>Node"]
```

## Dependency matrix
| From \ To | <!-- project ids --> |
|---|---|

## Shared components & infrastructure
<!-- libraries, design system, auth, queues, databases shared by several projects -->

## Related
- [Knowledge base index](README.md)
