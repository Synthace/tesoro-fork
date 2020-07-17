all: clean package

.PHONY: test
test:
	@echo ----- Running python tests -----
	python3 -m unittest discover

.PHONE: test_docker
test_docker:
	@echo ----- Testing build of docker image -----
	docker build . --no-cache -t tesoro
	@echo ----- Testing run of docker image -----
	docker run -ti --rm tesoro --help

.PHONY: test_coverage
test_coverage:
	@echo ----- Testing code coverage -----
	coverage run --source=tesoro -m unittest discover
	coverage report --fail-under=15 -m

.PHONY: test_formatting
test_formatting:
	@echo ----- Testing code formatting -----
	black -l 110 -t py37 --check .
	@echo

.PHONY: format_codestyle
format_codestyle:
	which black || echo "Install black with pip3 install --user black"
	# ignores line length and reclass
	black -l 110 -t py37 .
	@echo
