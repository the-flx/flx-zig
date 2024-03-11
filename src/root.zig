const std = @import("std");
const testing = std.testing;

const String = []const u8;
const LInt = std.ArrayList(i32);
const IntLInt = std.HashMap(i32, LInt, std.hash_map.AutoContext(i32), std.hash_map.default_max_load_percentage);

const word_separators = [_]u8{
    ' ',
    '-',
    '_',
    ':',
    '.',
    '/',
    '\\',
};

const default_score: i32 = -35;

/// Check if CHAR is a word character.
fn word(ch: u8) bool {
    return !std.mem.containsAtLeast(u8, &word_separators, 1, &[_]u8{ch});
}

/// Check if CHAR is an uppercase character.
fn capital(ch: u8) bool {
    return word(ch) and std.ascii.isUpper(ch);
}

/// Check if LAST-CHAR is the end of a word and CHAR the start of the next.
///
/// This function is camel-case aware.
fn boundary(last_ch: u8, ch: u8) bool {
    if (ch == null) return false;
    if (!capital(last_ch) and capital(ch)) return true;
    if (!word(last_ch) and word(ch)) return true;
    return false;
}

/// Increment each element in VEC between BEG and END by INC.
fn inc_vec(vec: LInt, inc: ?i32, beg: ?i32, end: ?i32) void {
    const _inc: i32 = inc orelse 1;
    var _beg: i32 = beg orelse 0;
    const _end: i32 = end orelse @intCast(vec.items.len);

    while (_beg < _end) {
        vec.items[@intCast(_beg)] += _inc;
        _beg += 1;
    }
}

/// Return hash-table for string where keys are characters.
/// Value is a sorted list of indexes for character occurrences.
fn get_hash_for_string(result: IntLInt, str: String) void {
    result.clearAndFree();
    const str_len: usize = str.len;
    var index: i32 = str_len - 1;
    var ch: u8 = undefined;
    var down_ch: u8 = undefined;

    while (0 <= index) {
        ch = str[index];

        if (capital(ch)) {
            result.put(ch, index);

            down_ch = std.ascii.toLower(ch);
        } else {
            down_ch = ch;
        }

        result.put(down_ch, index);

        index -= 1;
    }
}

//--- Testing

test "word" {
    try testing.expect(word('a'));
}

test "capital" {
    try testing.expect(capital('A'));
}

test "inc_vec" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var it: LInt = std.ArrayList(i32).init(allocator);
    defer it.deinit();
    try it.append(1);
    try it.append(2);
    try it.append(3);
    try it.append(4);
    try it.append(5);

    inc_vec(it, 2, 2, null);

    try testing.expect(it.items[2] == 5);
}

test "get_hash_for_string" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var result: IntLInt = std.AutoHashMap(i32, LInt).init(allocator);
    defer result.deinit();

    var arr = LInt.init(allocator);
    defer arr.deinit();

    try result.put(0, arr);

    try testing.expect(true);
}
