TEST_DIR = tests

DIFF_DIR = diff
SH_OUTPUT_DIR = sh_out
HSH_OUTPUT_DIR = hsh_out

HSH_PATH = ./hsh
SH_PATH = /usr/bin/sh
DIFF_PATH = /usr/bin/diff

IN_FILES = $(wildcard $(TEST_DIR)/*)
SH_OUTPUT = $(patsubst $(TEST_DIR)/%.in,$(SH_OUTPUT_DIR)/%.out,$(IN_FILES))
HSH_OUTPUT = $(patsubst $(TEST_DIR)/%.in,$(HSH_OUTPUT_DIR)/%.out,$(IN_FILES))

DIFF_FILES = $(patsubst $(TEST_DIR)/%.in,$(DIFF_DIR)/%.diff,$(IN_FILES))

create_dirs: 
	@mkdir -p $(DIFF_DIR)
	@mkdir -p $(SH_OUTPUT_DIR)
	@mkdir -p $(HSH_OUTPUT_DIR)

valgrind: create_dirs $(IN_FILES)

	@echo "\n-------------- Valgrind Testing --------------\n"

	@for input in $(IN_FILES); do \
		valgrind -q --leak-check=full cat $$input | $(HSH_PATH) > /dev/null 2>&1; \
		if [ $$? -eq 0 ]; then \
			echo "$$input Valgrind: \033[92mOK\033[0m"; \
		else \
			echo "$$input Valgrind: \033[91mKO\033[0m"; \
		fi; \
	done

	@echo "\n"

test: $(DIFF_FILES)

$(SH_OUTPUT): $(IN_FILES) $(SH_OUTPUT_DIR)
	@for input in $(IN_FILES); do \
		$(SH_PATH) < $$input > $(SH_OUTPUT_DIR)/$$(basename $$input).out 2>&1; \
		echo "\nExit code: $$?" >> $(SH_OUTPUT_DIR)/$$(basename $$input).out; \
	done

$(HSH_OUTPUT): $(IN_FILES) $(HSH_OUTPUT_DIR)
	@for input in $(IN_FILES); do \
		$(HSH_PATH) < $$input > $(HSH_OUTPUT_DIR)/$$(basename $$input).out 2>&1; \
		echo "\nExit code: $$?" >> $(HSH_OUTPUT_DIR)/$$(basename $$input).out; \
	done

testing: create_dirs $(SH_OUTPUT) $(HSH_OUTPUT)

	@echo "\n-------------- Checks Testing --------------\n"

	@for input in $(IN_FILES); do \
		$(DIFF_PATH) -B $(SH_OUTPUT_DIR)/$$(basename $$input).out $(HSH_OUTPUT_DIR)/$$(basename $$input).out > $(DIFF_DIR)/$$(basename $$input).diff 2>&1; \
		if [ $$? -eq 0 ]; then \
			echo "$$input is: \033[92mOK\033[0m"; \
		else \
			echo "$$input is: \033[91mKO\033[0m"; \
		fi; \
	done

	@echo "\n"

clean:
	@echo "Cleaning files..."
	@rm -rf $(SH_OUTPUT_DIR)/*
	@rm -rf $(HSH_OUTPUT_DIR)/*
	@rm -rf $(DIFF_DIR)/*