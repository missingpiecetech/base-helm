![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square)

# base-helm

missingpiecetech common chart to spin up GKE cluster with all needed resources

## Installing

TODO for when we figure out how to do this with github

## Usage

Information on more complex usage scenarios. For filling out values, see README below.

### Templating

To template and test the output of the app, try build one of the example apps. For now, we have `make template-basic-example`.

### What is `.Chart.Name`?

We use the name of the chart as a default value in many instances to keep things simple. If you see `.Chart.Name`
as a default in the values that just means we're grabbing the chart name using [helm's chart object](https://helm.sh/docs/chart_template_guide/builtin_objects/).

### Setting the Image Tag

TODO for when we have more information on how tag will be passed in

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling.enabled | bool | `false` |  |
| autoscaling.hpaName | string | `""` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.replicaCount | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| backend.enabled | bool | `true` | Turn this on to create a backend deployment resource. Most likely you want this ON |
| backend.image.name | string | `{{ .Chart.Name }}-backend` | Can overwrite image name. Defaults to chart name + "-backend" |
| backend.image.repository | string | `.Values.imageRepository` | Can overwrite backend image repository. Defaults to .Values.imageRepository |
| backend.image.tag | string | `"latest"` | The tag of the image. This will most likely need to be overridden at runtime. |
| backend.name | string | `{{ .Chart.Name }}-backend` | Can overwrite backend deployment name. Defaults to chart name+ "-backend" |
| backend.port | int | `80` | Backend image port |
| backend.resources.cpu | string | `"200m"` | CPU for pods |
| backend.resources.limitCPU | string | `"300m"` | limitCPU for pods |
| backend.resources.limitMemory | string | `"700Mi"` | limitMemory for pods |
| backend.resources.memory | string | `"512Mi"` | Memory for pods |
| backend.targetPort | int | `3001` | Backend external port |
| certManager.enabled | bool | `true` | Turn this on to create needed Issuer resources. Most likely you want this ON |
| database.database_name | string | `{{ .Chart.Name }}-db` | Name of the database to be created |
| database.enabled | bool | `true` | Turn this on to create a database resource. Right now this will only be postgres |
| database.memory | string | `"1Gi"` | Database memory |
| database.name | string | `{{ .Chart.Name }}-db` | Can overwrite serviceAccount name. Defaults to chart name + "-db" |
| database.password | string | `"postgres"` | Password used to access the database |
| database.port | int | `5432` | Port to expose. By default postgres uses 5432 |
| database.replicas | int | `1` | Number of pod replicas |
| database.storage | string | `"20Gi"` | Database storage |
| database.user | string | `"postgres"` | Username used to access the database |
| environment.secret | string | `""` | Set this to pull in a Secret to the deployment |
| environment.variables | list | `[]` | List of variables you want to use throughout the app. This will create a configmap that is pulled in to all deployments |
| frontend.enabled | bool | `true` | Turn this on to create a frontend deployment resource |
| frontend.image.name | string | `{{ .Chart.Name }}-frontend` | Can overwrite image name. Defaults to chart name + "-frontend" |
| frontend.image.repository | string | `.Values.imageRepository` | Can overwrite frontend image repository. Defaults to .Values.imageRepository |
| frontend.image.tag | string | `"latest"` | The tag of the image. This will most likely need to be overridden at runtime. |
| frontend.name | string | `{{ .Chart.Name }}-frontend` | Can overwrite backend deployment name. Defaults to chart name + "-frontend" |
| frontend.port | int | `80` | Frontend image port |
| frontend.resources.cpu | string | `"100m"` | CPU for pods |
| frontend.resources.limitCPU | string | `"200m"` | limitCPU for pods |
| frontend.resources.limitMemory | string | `"256Mi"` | limitMemory for pods |
| frontend.resources.memory | string | `"128Mi"` | Memory for pods |
| frontend.targetPort | int | `3000` | Frontend external port |
| host | string | `""` | External host to use for app |
| imageRepository | string | `""` | GCR image repo to pull from for all deployments in this chart. Frontend and backend deployments can be overridden under their settings |
| ingress.enabled | bool | `true` | Turn this on to create a ingress resource. Most likely you want this ON |
| ingress.name | string | `{{ .Chart.Name }}` | Can overwrite serviceAccount name. Defaults to chart name |
| ingress.port | string | `"80"` | Port to expose |
| ingress.service | string | `{{ .frontend.name }}` | What service should this ingress point to? Defaults to the frontend service |
| serviceAccount.enabled | bool | `true` | Turn this on to create a serviceAccount resource. Most likely you want this ON |
| serviceAccount.imagePullSecrets | string | `"gcr-json-key"` | GCR secret used to authenticate and pull images from Google |
| serviceAccount.name | string | `{{ .Chart.Name }}` | Can overwrite serviceAccount name. Defaults to chart name |
| test.enabled | bool | `false` |  |
| test.name | string | `""` |  |

## Development

### Installing Dependencies

To run the charts, make documentation changes, and run testing locally, please install via hombrew and helm:

```sh
~ brew install helm
~ helm plugin install https://github.com/helm-unittest/helm-unittest.git
~ brew install norwoodj/tap/helm-docs
```

See [the helm docs](https://helm.sh/docs/intro/install/), [the helm-docs docs](https://github.com/norwoodj/helm-docs), and
[helm-unittest docs](https://github.com/helm-unittest/helm-unittest) for more information or to install in other environments.

### Editing the README

Because we're using an automatic doc generator, you need to **update `README.md.gotmpl` not `README.md` directly!!**. This
will then be picked up by `helm-docs` to make changes.

To generate changes manually please run `make docs`

### Setting up pre-hook

To start developing, first [download pre-commit](https://pre-commit.com/) to get the docs pre-commit hook working, if this
goes as expect pre-commit will automatically fix the docs for you before commit.

### Testing

We use [helm unittest] to test the common chart. Right now there is just one test charts that lives in the `example` dir:
`basic-example`. All tests are found under `tests` within this chart.

For documentation on testing see the [unittest documentation here](https://github.com/helm-unittest/helm-unittest/blob/main/DOCUMENT.md).

To run the tests, use `make tests`.

#### Gotchas

The biggest testing gotcha is that we use one large `app.yaml` to generate our manifests, which makes it slightly difficult.
To make sure you reference the right manifest, use `documentIndex` and the number of the resulting yaml that appears in `app.yaml`.

For instance:

```yaml
  - it: should do basic template properly
    documentIndex: 0 # find the vs manifest, in this case its the 1st generated
    asserts:
      - isKind:
          of: VirtualService
      - equal:
          path: metadata.name
          value: your_app-svc
```

grabs the first generated manifest from `app.yaml`. In this case its the VirtualService yaml.