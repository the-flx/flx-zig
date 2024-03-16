const std = @import("std");
const flx = @import("flx.zig");
const testing = std.testing;

pub const String = flx.String;

/// Result container.
pub const Result = flx.Result;

/// Return best score matching QUERY against STR.
pub fn score(allocator: std.mem.Allocator, str: String, query: String) ?Result {
    return flx.score(allocator, str, query);
}
