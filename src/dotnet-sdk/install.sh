#!/bin/bash

set -e

# download install script
tmpdir="$(mktemp -d)"
curl -fsSL "https://dot.net/v1/dotnet-install.sh" -o "$tmpdir/dotnet-install.sh"
chmod +x "$tmpdir/dotnet-install.sh"

# install dotnet sdk
IFS=',' read -r -a versions <<< "$VERSIONS"
for version in "${versions[@]}"; do
    version="${version#"${version%%[![:space:]]*}"}"
    version="${version%"${version##*[![:space:]]}"}"

    $tmpdir/dotnet-install.sh --channel $version --install-dir /usr/local/dotnet --no-path --verbose
done

# install workloads
IFS=',' read -r -a workloads <<< "$WORKLOADS"
for workload in "${workloads[@]}"; do
    workload="${workload#"${workload%%[![:space:]]*}"}"
    workload="${workload%"${workload##*[![:space:]]}"}"

    dotnet workload install $workload
done
