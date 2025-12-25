# Contributing to hs-pack

Thank you for your interest in contributing to hs-pack! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Issues

If you find a bug or have a feature request:

1. Check the [existing issues](https://github.com/nalchevanidze/hs-pack/issues) to avoid duplicates
2. Create a new issue with a clear title and description
3. Include steps to reproduce (for bugs)
4. Include your environment details (OS, GHC version, etc.)

### Submitting Changes

1. Fork the repository
2. Create a new branch for your changes (`git checkout -b feature/your-feature-name`)
3. Make your changes
4. Test your changes thoroughly
5. Update documentation if needed
6. Commit your changes with clear commit messages
7. Push to your fork
8. Submit a pull request

### Pull Request Guidelines

- Keep changes focused and atomic
- Update README.md if you're adding new features
- Add entries to CHANGELOG.md under [Unreleased]
- Ensure examples in documentation are tested
- Follow existing code style

### Testing

When testing your changes:

1. Test on multiple platforms (Linux, macOS, Windows) if possible
2. Test with different GHC versions
3. Test both upload to release and artifact scenarios
4. Verify checksums are generated correctly

### Development Setup

To test your changes locally:

1. Create a test repository with a simple Haskell project
2. Reference your local changes in the workflow using a relative path or commit hash
3. Trigger the workflow and verify the behavior

Example test workflow:
```yaml
- uses: your-username/hs-pack@your-branch
  with:
    binary-name: test-app
```

## Code of Conduct

Be respectful and constructive in all interactions. We're all here to make this project better.

## Questions?

Feel free to open an issue for questions or discussions about the project.
