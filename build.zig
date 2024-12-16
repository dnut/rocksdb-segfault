const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const dep_opts = .{ .target = target, .optimize = optimize };

    const rocksdb_dep = b.dependency("rocksdb", dep_opts);
    const rocksdb_c = rocksdb_dep.module("rocksdb");

    const exe = b.addExecutable(.{
        .name = "rocksdb_segfault",
        .root_source_file = b.path("c-repro.zig"),
        .target = target,
        .optimize = optimize,
    });

    exe.root_module.addImport("rocksdb", rocksdb_c);
    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
