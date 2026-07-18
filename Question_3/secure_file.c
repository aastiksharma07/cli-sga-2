#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

typedef struct {
    int id;
    char name[20];
    float salary;
} Employee;

int main() {
    // 1. open(): Create or open file securely
    int fd = open("employees.dat", O_CREAT | O_RDWR, 0600);
    if (fd == -1) {
        perror("Failed to open file");
        return 1;
    }

    // 2. write(): Add a record
    Employee emp1 = {1, "Alice", 75000.0};
    write(fd, &emp1, sizeof(Employee));

    // 3. lseek() & write(): Update a record without rewriting file
    Employee emp_update = {1, "Alice", 80000.0};
    lseek(fd, 0, SEEK_SET); // Move cursor back to the start (Record 0)
    write(fd, &emp_update, sizeof(Employee));

    // 4. lseek() & read(): Retrieve record efficiently
    Employee read_emp;
    lseek(fd, 0, SEEK_SET); 
    read(fd, &read_emp, sizeof(Employee));
    printf("Read Record: ID=%d, Name=%s, Salary=%.2f\n", read_emp.id, read_emp.name, read_emp.salary);

    // 5. close()
    close(fd);
    return 0;
}
