const std = @import("std");

fn declareModule(b: *std.Build) void {
    _ = b.addModule("flx", .{
        .root_source_file = .{ .path = "src/root.zig" },
    });

fn rest(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "flx-zig",
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(lib);

    const exe = b.addExecutable(.{
        .name = "flx-zig",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const lib_unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const exe_unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
    test_step.dependOn(&run_exe_unit_tests.step);

    //-- Doc
    const docs_step = b.step("docs", "Emit docs");
    const docs_install = b.addInstallDirectory(.{
        .source_dir = lib.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "docs", // location
    });
    docs_step.dependOn(&docs_install.step);
}

pub fn build(b: *std.Build) void {
    rest(b);
    declareModule(b);
}
