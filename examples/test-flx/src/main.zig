const std = @import("std");
const testing = std.testing;
const flx = @import("flx");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        //fail test; can't try in defer as defer is executed after we return
        if (deinit_status == .leak) {
            testing.expect(false) catch @panic("TEST FAIL");
        }
    }

    //--- Start

    const result: ?flx.Result = flx.score(allocator, "switch-to-buffer", "stb");
    std.debug.print("{d}\n", .{result.?.score});

    defer result.?.deinit(); // clean up
}
