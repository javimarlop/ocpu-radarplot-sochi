This is an [OpenCPU](http://opencpu.org) application, originally based on the [sochi repo](https://github.com/ramnathv/sochi) by @ramnathv, that uses the Highcharts binding in [rCharts](http://rcharts.io) to visualize some example data, together with Leaflet maps, also including other demos from the OpenCPU repo that I am testing.

### Quick Start

The easiest way to run this webapp locally is to install the `ocpuRadarplot` package from `github`

```r
install.packages('XML', type = 'source')
devtools::install_github('javimarlop/ocpu-radarplot-sochi')
library(opencpu)
opencpu$browse('/library/ocpuRadarplot/www')
```

