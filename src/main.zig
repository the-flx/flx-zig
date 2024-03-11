const std = @import("std");

const LInt = std.ArrayList(i32);
const IntLInt = std.HashMap(i32, LInt, std.hash_map.AutoContext(i32), std.hash_map.default_max_load_percentage);

fn test_hashmap() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var my_hash_map: IntLInt = std.AutoHashMap(i32, LInt).init(allocator);
    defer my_hash_map.deinit();

    var arr: LInt = LInt.init(allocator);
    defer arr.deinit();

    try my_hash_map.put(0, arr);
    try my_hash_map.put(0, arr);

    std.debug.print("{?}", .{my_hash_map.get(0)});
}

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

    for (it.items) |item| {
        std.debug.print("{d}\n", .{item});
    }

    std.debug.print("{d}\n", .{it.items[0]});
    std.debug.print("len: {d}\n", .{it.items.len});
}

pub fn main() !void {
    //try test_array();
    try test_hashmap();
}

test "test" {
    // TODO: ..
}
