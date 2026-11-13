# setup-terragrunt

GitHub Action to install the latest or a specific version of Terragrunt

[![CI](https://github.com/dceoy/setup-terragrunt/actions/workflows/ci.yml/badge.svg)](https://github.com/dceoy/setup-terragrunt/actions/workflows/ci.yml)

## Usage

```yaml
steps:
  - uses: dceoy/setup-terragrunt@1cbef4029fa29d03260e3572cd1df1d45fd3f290 # v2.0.0
    with:
      terragrunt-version: latest
```

##### Inputs

| Name               | Type   | Default          | Description                                         |
| :----------------- | :----- | :--------------- | :-------------------------------------------------- |
| terragrunt-version | string | `latest`         | Terragrunt version (`latest` or a specific version) |
| directory-path     | string | `/usr/local/bin` | Directory path to install Terragrunt                |
| max-attempts       | number | `5`              | Maximum retry attempts for downloads                |

##### Outputs

| Name               | Type   | Description                  |
| :----------------- | :----- | :--------------------------- |
| terragrunt-version | string | Terragrunt version installed |
| terragrunt-path    | string | Path to Terragrunt binary    |
