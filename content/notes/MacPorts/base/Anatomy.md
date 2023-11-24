## Database

```c
/* ports table */
"CREATE TABLE registry.ports ("
        "id INTEGER PRIMARY KEY" // row ID
    ", name TEXT COLLATE NOCASE" // name of the port
    ", portfile TEXT" // path of Portfile copy
    ", location TEXT" // image (binary archive) location
    ", epoch INTEGER" // part of version comparison
    ", version TEXT COLLATE VERSION" // part of version comparison
    ", revision INTEGER" // part of version comparison
    ", variants TEXT" // actual variants used to build port
    ", requested_variants TEXT" // variants explicitly requested by user
    ", state TEXT" // installed (activated) or imaged (has image)
    ", date DATETIME" // install date
    ", installtype TEXT" // unused, always "image"
    ", archs TEXT" // list of architectures of this port
    ", requested INTEGER" // is port requested (boolean)
    ", os_platform TEXT" // operating system (e.g. darwin)
    ", os_major INTEGER" // OS version
    ", cxx_stdlib TEXT" // stdlib used for C++ ("libstdc++" or "libc++")
    ", cxx_stdlib_overridden INTEGER" // flag to track broken C++ ports
    ", UNIQUE (name, epoch, version, revision, variants)"
    ")",
"CREATE INDEX registry.port_name ON ports"
    "(name, epoch, version, revision, variants)",
"CREATE INDEX registry.port_state ON ports(state)",

/* file map */
"CREATE TABLE registry.files ("
        "id INTEGER" // row ID
    ", path TEXT" // file path
    ", actual_path TEXT" // actual path installed (FS case-sensitivity)
    ", active INTEGER" // is file installed
    ", binary BOOL" // is file a binary (rev-upgrade check)
    ", FOREIGN KEY(id) REFERENCES ports(id))",
"CREATE INDEX registry.file_port ON files(id)",
"CREATE INDEX registry.file_path ON files(path)",
"CREATE INDEX registry.file_actual ON files(actual_path)",
"CREATE INDEX registry.file_actual_nocase ON files(actual_path COLLATE NOCASE)",

/* dependency map */
"CREATE TABLE registry.dependencies ("
        "id INTEGER" // row ID
    ", name TEXT" // name of the port
    ", variants TEXT" // variants of the port
    ", FOREIGN KEY(id) REFERENCES ports(id))", // the dependency
"CREATE INDEX registry.dep_id ON dependencies(id)",
"CREATE INDEX registry.dep_name ON dependencies(name)",
```

## Versioning

```
epoch > version > revision
```

## Prefixes

MacPorts defaults to `/opt/local`, but allows alternatives prefixes.

## Phases

- fetch

Fetch the `${distfiles}` (e.g. source code).

- checksum

Compare `${checksums}` specified in a `Portfile` to the checksums of the fetched `${distfiles}`.

- extract

Extract the `${distfiles}` into working directory for build.

- patch

Apply optional patch files.

- configure

Execute `${configure.cmd}` in `${worksrcpath}`.

- build

Execute `${build.cmd}` in `${worksrcpath}`.

- destroot

Execute command to "stages" an installation into an intermediate location `${destroot}`.

- install

Archive (a.k.a. Image) a port's destrooted files into `${prefix}/var/macports/software`.

- activate

Extract the port's files from the archive in `${prefix}/var/macports/software` to their final installed locations, usually in `${prefix}`.

## PortGroup

Rolling release (synced with ports tree) of utility functions to help make Portfiles more concice and declarative.

## Variants

Maximum flexibility, but brings a lot of headache. Prefer non-conflicting subports if possible.

## Subports

A directive used in Portfile to generate multiple port definitions from a single Portfile.

## C++ stdlib

The default C++ runtime on OS X 10.9 and later is [libc++](https://libcxx.llvm.org/) from LLVM which supports C++11.

For older OS X versions, MacPorts will install a functional libc++ toolchain by default to replace the ancient version of [libstdc++](https://gcc.gnu.org/onlinedocs/libstdc++/) OS X shipped.

On Linux libstdc++ (The GNU C++ Library) is more ubiquitous.