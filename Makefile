CONTAINER_NAME=unipd/texlive-ir
DOCKER=docker run --rm -it -w "/doc" -v "${PWD}":/doc $(CONTAINER_NAME)

TEX_FILE=report
BUILD_DIR=build/

#####################################################
# Main
#####################################################
build: clean
	@$(DOCKER) make .build
watch: clean
	@$(DOCKER) make .build LATEX_FLAGS="-pvc"
clean:
	@$(DOCKER) rm -rf $(BUILD_DIR)

.build:
	@latexmk -xelatex -output-directory=$(BUILD_DIR) $(LATEX_FLAGS) $(TEX_FILE) \
		&& latexmk -c -output-directory=$(BUILD_DIR) \
		&& rm -f $(BUILD_DIR)*.bbl

.PHONY: build watch clean .build

#####################################################
# Docker
#####################################################
docker:
	@docker build -t $(CONTAINER_NAME):latest .

.PHONY: docker
