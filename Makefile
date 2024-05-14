# 定义编译器和编译器前缀
CC := aarch64-openwrt-linux-gnu-gcc

# 编译目标
TARGET := ts_calibrate

# 源文件和对象文件
SOURCES := ts_calibrate.c tests/fbutils-linux.c tests/testutils.c src/ts_fd.c src/ts_read_raw.c src/ts_version.c src/ts_setup.c \
	tests/ts_calibrate_common.c src/ts_close.c tests/font_8x8.c src/ts_read.c src/ts_open.c src/ts_config.c src/ts_error.c \
	src/ts_load_module.c src/ts_attach.c
OBJECTS := $(SOURCES:.c=.o)

# 编译选项，指定了头文件的搜索路径
CFLAGS := -Wall -O2 -I. -Isrc/ -Itests/ -DTS_POINTERCAL=\"/etc/pointercal\" -DTS_CONF=\"/etc/ts.conf\" -DPLUGIN_DIR=\"/usr/lib/ts\" \
	-DHAVE_LIBDL=1


# 链接选项，如果有额外的库需要链接，请在这里添加
LDFLAGS := -ldl

# 默认目标：构建可执行文件
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

# .c到.o的规则
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
CLEAN_OBJS_SRC := $(addprefix src/,$(notdir $(SOURCES:.c=.o)))
CLEAN_TESTS_OBJS := $(addprefix tests/,$(notdir $(SOURCES:.c=.o)))
# 清理目标
clean:
	rm -f $(CLEAN_TESTS_OBJS) $(CLEAN_OBJS_SRC) $(TARGET)

# 安装目标（如果需要的话）
install:
	# 这里可以添加将可执行文件安装到特定位置的命令
