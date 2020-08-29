CC := gcc
CFLAGS := -Wall -Wpedantic
TARGET := mec


all:
	$(CC) main.c -o $(TARGET) $(CFLAGS)
debug:
	$(CC) main.c -o $(TARGET) $(CFLAGS) -DDEBUG
clean:
	rm -f $(TARGET)
