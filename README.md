# classic-ash

**classic-ash** is a modern, standalone port of the original Almquist Shell from **4.4BSD-Lite2** (1995) to Linux and other POSIX-like systems.

While modern derivatives like `dash` have evolved significantly, this project preserves the original Berkeley implementation while ensuring it remains buildable and safe on modern 64-bit systems.

## Features
- **Authentic 4.4BSD Source**: The core logic remains faithful to the original 1995 Berkeley release.
- **Linux Portability**: Built-in compatibility layer ([compat.h](compat.h)) for non-BSD systems.
- **Clean Build**: 100% warning-free compilation on modern `gcc`.
- **64-bit Ready**: All internal arithmetic and pointer handling updated for 64-bit safety.
- **Memory Stable**: Zero memory leaks under heavy stress testing (verified with Valgrind).
- **Line Editing**: Integrated with modern `libedit` for history and command-line editing.
- **3-Clause BSD License**: Modernized licensing for easy re-use.

## Building

### Dependencies
- `gcc` or `clang`
- `make` (GNU or BSD)
- `bison` (or `yacc`)
- `flex` (or `lex`)
- `libedit-dev`
- `libbsd-dev`

### Compilation
Simply run make using the portable Makefile:
```bash
make -f Makefile.portable
```

This will:
1. Compile the native bootstrap tools (`mkinit`, `mknodes`, `mksyntax`).
2. Generate the shell's internal tables and headers.
3. Build the `sh` binary.

## Usage
Run the shell interactively:
```bash
./sh
```

Or execute shell scripts:
```bash
./sh my_script.sh
```

## Special Features
- **Job Control**: Full support for background jobs and `%` notation.
- **Directory Stack**: Specialized `pushd`, `popd`, and `dirs` shell functions are available in the `funcs/` directory.

## License
This project is licensed under the **3-clause BSD License**. See [LICENSE](LICENSE) for details.

---
*Derived from software contributed to Berkeley by Kenneth Almquist.*
