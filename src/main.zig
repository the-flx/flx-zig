const std = @import("std");

const String = []const u8;
const LInt = std.ArrayList(i32);
const LLInt = std.ArrayList(LInt);
const IntLInt = std.HashMap(i32, LInt, std.hash_map.AutoContext(i32), std.hash_map.default_max_load_percentage);

fn test_array() !void {
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

    std.debug.print("{d} {d}\n", .{it.items[0], it.items[1]});
    std.debug.print("len: {d}\n", .{it.items.len});
}

fn test_hashmap() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var my_hash_map: IntLInt = std.AutoHashMap(i32, LInt).init(allocator);
    defer my_hash_map.deinit();

    var arr: LInt = LInt.init(allocator);
    defer arr.deinit();

    try my_hash_map.put(1, arr);
    try my_hash_map.put(1, arr);

    std.debug.print("{?}", .{my_hash_map.get(0)});
}

fn test_arrarr() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var inner = LInt().init(allocator);
    defer inner.deinit();
    std.debug.print("{?}", .{inner.get(0)});
}

fn test_for_times() !void {
    const len = 10;
    for (0..len) |i| {
        std.debug.print("{d}", .{i});
    }
}

fn test_for_str() !void {
    for ("abcd") |i| {
        std.debug.print("{c}", .{i});
    }
}

pub fn main() !void {
    try test_array();
    //try test_hashmap();
    //try test_arrarr();
    //try test_for_times();
    //try test_for_str();
}
