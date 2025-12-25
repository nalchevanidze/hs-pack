# hs-pack

Build and package Haskell binaries for release artifacts

A GitHub Action that simplifies building, packaging, and uploading Haskell binaries to GitHub releases. Supports multiple platforms (Linux, macOS, Windows) and generates checksums automatically.

## Features

- 🚀 Build Haskell binaries using Cabal
- 📦 Package binaries with platform-specific naming
- 🔐 Generate SHA256 checksums automatically
- ☁️ Upload to GitHub releases or workflow artifacts
- 💾 Cache Cabal dependencies for faster builds
- 🌍 Cross-platform support (Linux, macOS, Windows)

## Usage

### Basic Usage - Build Only

Build a binary and upload as workflow artifact:

```yaml
name: Build

on:
  push:
    branches: [main]
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: nalchevanidze/hs-pack@v1
        with:
          binary-name: my-app
```

### Upload to Release

Build and upload binaries to GitHub release on new tags:

```yaml
name: Release

on:
  release:
    types: [published]

jobs:
  build:
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest, windows-latest]
    runs-on: ${{ matrix.os }}
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4
      - uses: nalchevanidze/hs-pack@v1
        with:
          binary-name: my-app
          upload-release: 'true'
```

### Advanced Configuration

Customize GHC version, build arguments, and more:

```yaml
- uses: nalchevanidze/hs-pack@v1
  with:
    binary-name: my-app
    package-name: myapp
    ghc-version: '9.6.3'
    cabal-version: '3.10'
    build-dir: '.'
    extra-build-args: '--enable-optimization=2'
    generate-checksums: 'true'
    upload-release: 'true'
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `binary-name` | Name of the binary to build (executable name from cabal file) | Yes | - |
| `package-name` | Name for output binary filename | No | Same as `binary-name` |
| `ghc-version` | GHC version to use | No | `9.4.8` |
| `cabal-version` | Cabal version to use | No | `3.10` |
| `build-dir` | Directory where the cabal project is located | No | `.` |
| `upload-release` | Upload binaries to GitHub release | No | `false` |
| `release-tag` | Release tag to upload to | No | `github.event.release.tag_name` |
| `extra-build-args` | Extra arguments to pass to cabal build | No | `''` |
| `generate-checksums` | Generate SHA256 checksums for binaries | No | `true` |

## Outputs

| Output | Description |
|--------|-------------|
| `binary-path` | Path to the built binary |
| `checksum-path` | Path to the checksum file (if generated) |

## Binary Naming

Binaries are automatically named with platform and architecture information:

- Linux: `<package-name>-linux-<arch>`
- macOS: `<package-name>-darwin-<arch>`
- Windows: `<package-name>-windows-<arch>.exe`

Examples:
- `my-app-linux-x86_64`
- `my-app-darwin-arm64`
- `my-app-windows-x86_64.exe`

## Multi-Platform Release Example

Complete example for building and releasing binaries for all platforms:

```yaml
name: Release

on:
  release:
    types: [published]

jobs:
  build-release:
    name: Build ${{ matrix.os }}
    strategy:
      fail-fast: false
      matrix:
        include:
          - os: ubuntu-latest
            platform: linux
          - os: macos-latest
            platform: macos
          - os: windows-latest
            platform: windows
    runs-on: ${{ matrix.os }}
    permissions:
      contents: write
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Build and upload binary
        uses: nalchevanidze/hs-pack@v1
        with:
          binary-name: my-app
          ghc-version: '9.4.8'
          upload-release: 'true'
```

## Caching

The action automatically caches Cabal dependencies to speed up subsequent builds:
- `~/.cabal/packages`
- `~/.cabal/store`
- `dist-newstyle`

Cache keys are based on OS, GHC version, and cabal/project file hashes.

## Permissions

When uploading to releases, ensure your workflow has the necessary permissions:

```yaml
permissions:
  contents: write
```

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
