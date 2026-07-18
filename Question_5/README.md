### Question 5: vi Editor Recovery Evaluation

**Evaluation of Mechanisms:**
* **Registers & Undo History:** These are stored in volatile RAM. During a system crash, power is lost, and RAM is cleared. These are useless for crash recovery unless persistent undo (`set undofile`) is configured.
* **Backup Files (`~` files):** Backup files only store the version of the file as it was *during the last successful save*. They do not capture unsaved edits made just before the crash.
* **Swap Files (`.swp`):** This is vi/Vim's primary crash-protection mechanism. As you edit, `vi` periodically writes unsaved buffer changes to a hidden `.swp` file on the disk.
* **Auto-Recovery:** When opening a file that crashed, `vi` detects an orphaned `.swp` file and prompts the user to press `(R)ecover`, applying the swap data.

**Proposed Strategy & Justification:**
The most reliable recovery strategy is **relying on Swap File Recovery (`vi -r filename`) combined with proactive configuration.** 
I propose configuring `vi` (via the `~/.vimrc` file) with `set updatetime=200` to force the swap file to save to disk every 200 milliseconds of inactivity. Because a crash clears RAM but leaves the hard drive intact, the `.swp` file is the only mechanism that reliably captures mid-edit keystrokes, ensuring almost zero data loss when the system reboots.
