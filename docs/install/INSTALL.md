## Dax v0.1 Installation

install.sh downloads the Dax runtime files listed in dax/runtime/RUNTIME_LOCKFILE.json into a hidden `.dax/` folder in your target repository, sets executable bits on the shipped scripts, and refuses to run inside the dax-agent source tree. It is POSIX sh, non-interactive, and defaults to the `main` reference unless `DAX_REF` is provided.

**Before you begin**: Create `PRD.md` and `EPICS.md` in your repo root. The Development Start Gateway will warn if they are missing or underspecified. See [docs/gateways/DEVELOPMENT_START_GATEWAY.md](../gateways/DEVELOPMENT_START_GATEWAY.md) and [docs/examples/](../examples/) for templates and examples.

### Quick install (curl | sh)
```bash
curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh | sh
```

### Pinned install (recommended)
```bash
DAX_REF=<commit-or-tag> curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh | sh
```

### Local run
```bash
curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh -o install.sh
chmod +x install.sh
./install.sh /path/to/target
```

### Verify
```bash
.dax/agent/bootstrap.sh
```

The Development Start Gateway is **warn-only**: if PRD.md or EPICS.md are missing, you will see a warning but installation will not fail. However, implementation agents (like ii-agent) operating without a complete PRD and epic list may hallucinate scope and miss constraints.
