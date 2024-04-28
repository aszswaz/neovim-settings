BUILD_DIR=build
CFLAGS=-g3 -ggdb -Werror -Wextra
CC=@gcc $(CFLAGS)

all: $(BUILD_DIR)

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

.PHONY: clean
clean:
	@rm -rf $(BUILD_DIR)
