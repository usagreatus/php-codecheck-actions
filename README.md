# GitHub Action: Run php check codes

This action runs phpcs, and phpmd

## Inputs

### `directory`

Optional. The subdirectory where your php code resides.

### `phpcs_args`

Optional. Arguments to pass to phpcs.

### `phpmd_args`

Optional. Arguments to pass to phpmd.

## Example usage

### Minimum Usage Example

```yml
name: php-check-code
on: [pull_request]
jobs:
  php-check-code:
    name: runner / php-check-code
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the workspace
        uses: actions/checkout@v4
      - name: Check Code
        uses: eeyon/php-codecheck-actions@v3
        with:
          phpmd_args: '--exclude */test/*,*Test.php,*/autoload_classmap.php,*.js'
```
