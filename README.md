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

### Version 007

Extended media analysis by reporting additional video and audio properties useful for playback compatibility.

Example:

```bash
./v_file_analysis_version_007.sh movie1.mp4 movie2.mp4 movie3.mp4
```

Topics:

- container formats
- codec profiles
- pixel formats
- scan type
- audio channels
- audio sample rate
- display aspect ratio
- playback compatibility
---

### Version 008 - Refactoring experiments

Version 008 explores several Bash techniques for reducing repeated code without changing the output produced by Version 007.

Experiments include:

- `mapfile` for reading command output into Bash arrays
- Bash arrays and indexed access
- functions
- positional parameters inside functions
- `"$@"` for forwarding arguments
- `printf` formatting through a reusable `print_field()` function
- command substitution
- process substitution `< <(...)`
- using `awk` together with Bash variables
- separating data collection from output formatting

The experiments showed that refactoring does not necessarily make a script easier to understand.

Version 007 remains the clearest implementation for learning how `ffprobe` fields are selected and formatted.

Version 008 is therefore kept as a collection of refactoring experiments rather than as a replacement for Version 007.
 
---
