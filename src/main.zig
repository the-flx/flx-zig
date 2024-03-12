const std = @import("std");
const flx = @import("root.zig");

const String = []const u8;
const LInt = std.ArrayList(i32);
const LLInt = std.ArrayList(LInt);
const IntLInt = std.HashMap(i32, LInt, std.hash_map.AutoContext(i32), std.hash_map.default_max_load_percentage);

fn testArray() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    // TODO: ..
    var it: LInt = std.ArrayList(i32).init(allocator);
    std.debug.print("{}\n", .{@TypeOf(it)});
    defer it.deinit();

    try it.append(1);
    try it.append(2);

    it.items[1] = 99;

    for (it.items) |item| {
        std.debug.print("{d}\n", .{item});
    }

    std.debug.print("{d} {d}\n", .{ it.items[0], it.items[1] });
    std.debug.print("len: {d}\n", .{it.items.len});
}

fn testHashmap() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var my_hash_map = IntLInt.init(allocator);
    defer my_hash_map.deinit();

    var arr: LInt = LInt.init(allocator);
    defer arr.deinit();

    try my_hash_map.put(1, arr);
    try my_hash_map.put(1, arr);

    std.debug.print("{?}", .{my_hash_map.get(0)});
}

fn testArrArr() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var inner: LInt = std.ArrayList(i32).init(allocator);
    defer inner.deinit();
    try inner.append(1);
    std.debug.print("{?}", .{inner.items[0]});
}

fn testForTimes() !void {
    const len = 10;
    for (0..len) |i| {
        std.debug.print("{d}", .{i});
    }
}

fn testForStr() !void {
    for ("abcd") |i| {
        std.debug.print("{c}", .{i});
    }
}

fn testScore() !void {
    const result: ?flx.Result = flx.score("switch-to-buffer", "stb");
    if (result != null) {
        std.debug.print("{d}\n", .{result.?.score});
    }
}

pub fn main() !void {
    //try testArray();
    //try testHashmap();
    //try testArrArr();
    //try testForTimes();
    //try testForStr();
    try testScore();
}
