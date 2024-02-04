template:
	@helm template -n dev base-helm

docs:
	@helm-docs -c ${CI_PROJECT_DIR}/helm-charts/common -o ../../README.md --template-files=../../README.md.gotmpl

docs-lint:
	@helm-docs -x -c ${CI_PROJECT_DIR}/helm-charts/common

test:
	@helm dependency build ${CI_PROJECT_DIR}/example/single-chart-example
	helm unittest -n "dev" ${CI_PROJECT_DIR}/example/single-chart-example