const std = @import("std");
const builtin = @import("builtin");
const tests = @import("tests.zig");

pub fn addCases(cases: *tests.StandaloneContext) void {
    cases.add("test/standalone/hello_world/hello.zig");
    cases.addC("test/standalone/hello_world/hello_libc.zig");
    cases.add("test/standalone/cat/main.zig");
    cases.add("test/standalone/issue_9693/main.zig");
    cases.add("test/standalone/guess_number/main.zig");
    cases.add("test/standalone/main_return_error/error_u8.zig");
    cases.add("test/standalone/main_return_error/error_u8_non_zero.zig");
    cases.addBuildFile("test/standalone/main_pkg_path/build.zig", .{});
    cases.addBuildFile("test/standalone/shared_library/build.zig", .{});
    cases.addBuildFile("test/standalone/mix_o_files/build.zig", .{});
    if (builtin.os.tag == .macos) {
        // Zig's macOS linker does not yet support LTO for LLVM IR files:
        // https://github.com/ziglang/zig/issues/8680
        cases.addBuildFile("test/standalone/mix_c_files/build.zig", .{
            .build_modes = false,
            .cross_targets = true,
        });
    } else {
        cases.addBuildFile("test/standalone/mix_c_files/build.zig", .{
            .build_modes = true,
            .cross_targets = true,
        });
    }
    cases.addBuildFile("test/standalone/global_linkage/build.zig", .{});
    cases.addBuildFile("test/standalone/static_c_lib/build.zig", .{});
    cases.addBuildFile("test/standalone/link_interdependent_static_c_libs/build.zig", .{});
    cases.addBuildFile("test/standalone/link_static_lib_as_system_lib/build.zig", .{});
    cases.addBuildFile("test/standalone/link_common_symbols/build.zig", .{});
    cases.addBuildFile("test/standalone/link_frameworks/build.zig", .{
        .requires_macos_sdk = true,
    });
    cases.addBuildFile("test/standalone/link_common_symbols_alignment/build.zig", .{});
    if (builtin.os.tag == .macos) {
        cases.addBuildFile("test/standalone/link_import_tls_dylib/build.zig", .{});
    }
    cases.addBuildFile("test/standalone/issue_339/build.zig", .{});
    cases.addBuildFile("test/standalone/issue_8550/build.zig", .{});
    cases.addBuildFile("test/standalone/issue_794/build.zig", .{});
    cases.addBuildFile("test/standalone/issue_5825/build.zig", .{});
    cases.addBuildFile("test/standalone/pkg_import/build.zig", .{});
    cases.addBuildFile("test/standalone/use_alias/build.zig", .{});
    cases.addBuildFile("test/standalone/brace_expansion/build.zig", .{});
    cases.addBuildFile("test/standalone/empty_env/build.zig", .{});
    cases.addBuildFile("test/standalone/issue_7030/build.zig", .{});
    cases.addBuildFile("test/standalone/install_raw_hex/build.zig", .{});
    cases.addBuildFile("test/standalone/issue_9812/build.zig", .{});
    cases.addBuildFile("test/standalone/fail_full_report/build.zig", .{});
    if (builtin.os.tag != .wasi) {
        cases.addBuildFile("test/standalone/load_dynamic_library/build.zig", .{});
    }
    // C ABI compatibility issue: https://github.com/ziglang/zig/issues/1481
    if (builtin.cpu.arch == .x86_64) {
        cases.addBuildFile("test/stage1/c_abi/build.zig", .{});
    }
    cases.addBuildFile("test/standalone/c_compiler/build.zig", .{
        .build_modes = true,
        .cross_targets = true,
    });

    if (builtin.os.tag == .windows) {
        cases.addC("test/standalone/issue_9402/main.zig");
    }
    // Try to build and run a PIE executable.
    if (builtin.os.tag == .linux) {
        cases.addBuildFile("test/standalone/pie/build.zig", .{});
    }
    // Try to build and run an Objective-C executable.
    cases.addBuildFile("test/standalone/objc/build.zig", .{
        .build_modes = true,
        .requires_macos_sdk = true,
    });
    // Try to build and run an Objective-C++ executable.
    cases.addBuildFile("test/standalone/objcpp/build.zig", .{
        .build_modes = true,
        .requires_macos_sdk = true,
    });

    // Ensure the development tools are buildable.
    cases.add("tools/gen_spirv_spec.zig");
    cases.add("tools/gen_stubs.zig");
    cases.add("tools/update_clang_options.zig");
    cases.add("tools/update_cpu_features.zig");
    cases.add("tools/update_glibc.zig");
    cases.add("tools/update_spirv_features.zig");
}
