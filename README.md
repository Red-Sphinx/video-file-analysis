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
