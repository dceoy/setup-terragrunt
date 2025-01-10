setup-terragrunt
================

GitHub Action to install the latest or a specific version of Terragrunt

Usage
-----

```yaml
steps:
  - uses: dceoy/setup-terragrunt@v1
    with:
      terragrunt-version: latest
```

##### Inputs

| Name               | Type   | Default          | Description                                         |
|:-------------------|:-------|:-----------------|:----------------------------------------------------|
| terragrunt-version | string | `latest`         | Terragrunt version (`latest` or a specific version) |
| directory-path     | string | `/usr/local/bin` | Directory path to install Terragrunt                |

##### Outputs

| Name               | Type   | Description                  |
|:-------------------|:-------|:-----------------------------|
| terragrunt-version | string | Terragrunt version installed |
| terragrunt-path    | string | Path to Terragrunt binary    |
