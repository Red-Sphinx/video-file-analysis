# Video File Analysis Scripts

A small collection of Bash scripts written while learning shell scripting and `ffprobe`.

The project demonstrates the gradual development of a practical command-line utility for inspecting video files.

Each version introduces one new concept.

## Versions

### Version 001

Basic use of `ffprobe` to display video metadata.

Topics:

- ffprobe
- command options
- formatted output
---

### Version 002

Improved metadata formatting and output.

Topics:

- command substitution $(...)
- variables
- printf
- integer arithmetic
- awk
---

### Version 003

Accepts a filename supplied on the command line.

Example:

```bash
./v_file_analysis_version_003.sh movie.mp4
```

Topics:

- `$1`
- quoting variables
- user input
---

### Version 004

Processes multiple files.

Example:

```bash
./v_file_analysis_version_004.sh movie1.mp4 movie2.mp4 movie3.mp4
```

Topics:

- `$@`
- `for` loops
- iteration
---

### Version 005

Added bitrate reporting and improved stream selection by querying video, audio and subtitle streams where appropriate.

Example:

```bash
./v_file_analysis_version_005.sh movie1.mp4 movie2.mp4 movie3.mp4
```

Topics:

- -select_streams
- multiple media streams
- video codec
- audio codec
- subtitle codec
- bitrate
- awk
- stream metadata
---

### Version 006

Added basic defensive programming to improve user input validation.

Example:

```bash
./v_file_analysis_version_006.sh movie1.mp4 movie2.mp4 movie3.mp4
```

Topics:

- if statements
- test expressions
- argument count ($#)
- file testing (-f)
- logical NOT (!)
- continue
- exit
- input validation
- defensive programming
---
