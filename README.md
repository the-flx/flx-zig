[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Release](https://img.shields.io/github/tag/the-flx/flx-zig.svg?label=release&logo=github)](https://github.com/the-flx/flx-zig/releases/latest)

# flx-zig
> Rewrite emacs-flx in Zig

[![Docs](https://github.com/the-flx/flx-zig/actions/workflows/docs.yml/badge.svg)](https://github.com/the-flx/flx-zig/actions/workflows/docs.yml)
[![CI](https://github.com/the-flx/flx-zig/actions/workflows/test.yml/badge.svg)](https://github.com/the-flx/flx-zig/actions/workflows/test.yml)

## 🔧 Usage

```zig
const result: ?flx.Result = flx.score(allocator, "switch-to-buffer", "stb");
std.debug.print("{d}\n", .{result.?.score});

defer result.?.deinit(); // clean up
```

## 💾 Installation

1. Add the dependency to the `build.zig.zon` of your project.

```zig
.dependencies = .{
    .flx = .{
        .url = "https://github.com/jcs090218/flx-zig/archive/82eb49e8e26ceb53c58e2f4fe5bc2ab3f6ec91d4.tar.gz",
        .hash = "12202ffde84f17914ba10f6bc1799738b5db997e6ff8f9092384c7f8f9f63bfa4c42",
    },
},
```

2. Add the dependency and module to your `build.zig`.

```zig
const flx_dep = b.dependency("flx", .{});
const flx_mod = flx_dep.module("flx");
exe.addModule("flx", flx_mod);
```

3. Import it inside your project.

```zig
const flx = @import("flx");
```

*📝 P.S. See [examples](https://github.com/jcs090218/flx-zig/tree/master/examples) for full example!*

## ⚜️ License

`flx-zig` is distributed under the terms of the MIT license.

See [LICENSE](./LICENSE) for details.


<!-- Links -->

[flx]: https://github.com/lewang/flx
