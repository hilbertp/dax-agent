## Dax v0.1 Installation

install.sh downloads the Dax runtime files listed in dax/runtime/RUNTIME_LOCKFILE.json into a hidden `.dax/` folder in your target repository, sets executable bits on the shipped scripts, and refuses to run inside the dax-agent source tree. It is POSIX sh, non-interactive, and defaults to the `main` reference unless `DAX_REF` is provided.

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
