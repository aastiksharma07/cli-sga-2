### Question 3 Explanations

* `open("employees.dat", O_CREAT | O_RDWR, 0600)`: I used the `open()` system call to create the file with strict read/write permissions (`0600`) restricted only to the owner for security.
* `lseek(fd, 0, SEEK_SET)`: I used `lseek()` to move the file descriptor's cursor directly to the exact byte offset of the specific record, avoiding the need to load the entire file into memory.
* `write()` and `read()`: I used `write()` to overwrite exactly the bytes at the updated location, and `read()` to pull the raw binary data directly into the C struct variable.
* `close(fd)`: I used `close()` to properly release the file descriptor and free system resources after all operations were complete.
