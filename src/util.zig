const std = @import("std");
const flx = @import("flx.zig");

/// Insert data.
pub fn dictInsert(allocator: std.mem.Allocator, dict: *flx.IntLInt, key: i32, val: i32) !void {
    if (!dict.contains(key)) {
        const lst = flx.LInt.init(allocator);
        try dict.put(key, lst);
    }

    try dict.getPtr(key).?.*.insert(0, val);
}

/// Return true if STR is empty or null.
pub fn nullOrEmpty(str: ?flx.String) bool {
    return str == null or str.?.len == 0;
}
