# buildinternet/homebrew-tap

Homebrew tap for Build Internet CLIs.

## Install

```bash
brew install buildinternet/tap/releases
```

Or in two steps:

```bash
brew tap buildinternet/tap
brew install releases
```

## Formulas

- `Formula/releases.rb` — Changelog indexer and registry for AI agents and developers.

## Maintenance

Formulas in this tap are generated automatically by the upstream release pipeline on every published version. **Do not hand-edit `Formula/*.rb`** — your changes will be overwritten on the next publish.

If you need to change the formula (e.g., add a `depends_on` or a `livecheck` block), update the template in the upstream release workflow instead.
