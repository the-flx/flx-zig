const std = @import("std");
const testing = std.testing;

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
    if (ch == null) {
        return false;
    }

    if (!capital(last_ch) and capital(ch)) {
        return true;
    }

    if (!word(last_ch) and word(ch)) {
        return true;
    }

    return false;
}

//--- Testing

test "test word" {
    try testing.expect(word('a'));
}

test "test capital" {
    try testing.expect(capital('A'));
}
