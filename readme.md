# VEriK Helm Charts
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/verik-charts)](https://artifacthub.io/packages/search?repo=verik-charts)
[![Release Charts](https://github.com/veriks/charts/actions/workflows/release.yml/badge.svg)](https://github.com/veriks/charts/actions/workflows/release.yml)
[![Labeler](https://github.com/veriks/charts/actions/workflows/labeler.yml/badge.svg)](https://github.com/veriks/charts/actions/workflows/labeler.yml)
[![Lint and Test Charts](https://github.com/veriks/charts/actions/workflows/lint-test.yml/badge.svg)](https://github.com/veriks/charts/actions/workflows/lint-test.yml)
[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add <alias> https://charts.veriksystems.com/charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
<alias>` to see the charts.

To install the <chart-name> chart:

    helm install my-<chart-name> <alias>/<chart-name>

To uninstall the chart:

    helm delete my-<chart-name>
