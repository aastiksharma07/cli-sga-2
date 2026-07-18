### Question 2 Explanations

* `fork()`: I used `fork()` to create a new child process to handle the web server request independently from the parent monitor.
* `waitpid(pid, &status, WNOHANG)`: I used `waitpid` with the `WNOHANG` flag so the parent can check if the child has finished without blocking/pausing its own execution.
* `kill(pid, SIGKILL)` and `waitpid(...)`: I used `kill` to forcefully terminate the child if it exceeded the time limit, followed immediately by a blocking `waitpid` to reap the process and prevent it from becoming a zombie.
