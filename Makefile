CI_PROJECT_DIR ?= .

template:
	@helm template -n dev base-helm

template-basic-example:
	helm dependency build ${CI_PROJECT_DIR}/example/basic-example
	helm template -n "dev" --debug ${CI_PROJECT_DIR}/example/basic-example -f ${CI_PROJECT_DIR}/example/basic-example/values.dev.yaml

docs:
	@helm-docs -c ${CI_PROJECT_DIR}/helm-charts/common -o ../../README.md --template-files=../../README.md.gotmpl

docs-lint:
	@helm-docs -x -c ${CI_PROJECT_DIR}/helm-charts/common

test:
	@helm dependency build ${CI_PROJECT_DIR}/example/single-chart-example
	helm unittest -n "dev" ${CI_PROJECT_DIR}/example/single-chart-example