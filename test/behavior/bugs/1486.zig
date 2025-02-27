const std = @import("std");
const expect = std.testing.expect;
const builtin = @import("builtin");

const ptr = &global;
var global: usize = 123;

test "constant pointer to global variable causes runtime load" {
    if (builtin.zig_backend == .stage2_aarch64) return error.SkipZigTest;
    global = 1234;
    try expect(&global == ptr);
    try expect(ptr.* == 1234);
}
