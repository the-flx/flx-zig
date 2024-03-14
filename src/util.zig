const std = @import("std");
const flx = @import("root.zig");

/// Insert data.
pub fn dictInsert(allocator: std.mem.Allocator, dict: *flx.IntLInt, key: i32, val: i32) !void {
    if (!dict.contains(key)) {
        const lst = flx.LInt.init(allocator);
        std.debug.print("created!! {} @ {*}\n", .{key, &lst});
        try dict.put(key, lst);
    }

    try dict.getPtr(key).?.*.insert(0, val);

    std.debug.print("key&len: {} {}\n", .{key, dict.getPtr(key).?.*.items.len});
     var index: i32 = 0;
     for (dict.get(key).?.items) |item| {
         std.debug.print("  [{}]: ", .{index});
         std.debug.print("{}", .{ item });
         index += 1;
     }
     std.debug.print("\n", .{});
}

/// Return true if STR is empty or null.
pub fn nullOrEmpty(str: ?flx.String) bool {
    return str == null or str.?.len == 0;
}
