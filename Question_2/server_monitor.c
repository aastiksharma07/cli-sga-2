#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>

int main() {
    pid_t pid = fork();

    if (pid < 0) {
        perror("Fork failed");
        exit(1);
    } else if (pid == 0) {
        // Child Process: Simulating a web server task that hangs
        printf("Child process (PID: %d) executing...\n", getpid());
        sleep(5); // Simulates an unresponsive task
        exit(0);
    } else {
        // Parent Process: Monitoring
        printf("Parent monitoring child (PID: %d)...\n", pid);
        sleep(2); // Give child time to finish (simulated timeout)

        int status;
        // Check if child is still running using WNOHANG (non-blocking wait)
        pid_t result = waitpid(pid, &status, WNOHANG);

        if (result == 0) {
            printf("Child is unresponsive. Terminating (SIGKILL)...\n");
            kill(pid, SIGKILL);
            waitpid(pid, &status, 0); // Collect exit status to prevent zombie
            printf("Zombie prevented. Child cleaned up.\n");
        } else {
            printf("Child finished execution normally.\n");
        }
    }
    return 0;
}
