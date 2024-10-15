const std = @import("std");
const mem = std.mem;
const testing = std.testing;
const TupleStepString = struct { step: Step, string: []u8 };
const re = @cImport(@cInclude("regex.h"));

export fn add(a: i32, b: i32) i32 {
    return a + b;
}
const ParseError = error{ TooShort, InvalidStep };

const Step = enum(u8) { C = 1, D = 2, E = 3, F = 4, G = 5, A = 6, B = 7 };
fn ParseStep(text: []u8) ParseError!TupleStepString {
    if (text.len == 0) {
        return ParseError.TooShort;
    }
    const head = text[0];
    const tail = text[1..];
    switch (head) {
        'A' => {
            return TupleStepString{ .step = Step.A, .string = tail };
        },
        'B' => {
            return TupleStepString{ .step = Step.B, .string = tail };
        },
        'C' => {
            return TupleStepString{ .step = Step.C, .string = tail };
        },
        'D' => {
            return TupleStepString{ .step = Step.D, .string = tail };
        },
        'E' => {
            return TupleStepString{ .step = Step.E, .string = tail };
        },
        'F' => {
            return TupleStepString{ .step = Step.F, .string = tail };
        },
        'G' => {
            return TupleStepString{ .step = Step.G, .string = tail };
        },
        else => {
            return ParseError.InvalidStep;
        },
    }
}
const Alteration = enum(i8) {
    DoubleFlat = -2,
    Flat = -1,
    Natural = 0,
    Sharp = 1,
    DoubleSharp = 2,
};
fn ParseAlteration(text: []u8) ParseError!Alteration {
    if (text.len == 0) {
        return ParseError.TooShort;
    }
    switch (text) {
        "bb" => {
            return Alteration.DoubleFlat;
        },
        "b" => {
            return Alteration.Flat;
        },
        "" => {
            return Alteration.Natural;
        },
        "#" => {
            return Alteration.Sharp;
        },
        "##" => {
            return Alteration.DoubleSharp;
        },
        else => {
            return ParseError.InvalidAlteration;
        },
    }
}
fn AlterationFromInt(value: i8) Alteration {
    switch (value) {
        -2 => {
            return Alteration.DoubleFlat;
        },
        -1 => {
            return Alteration.Flat;
        },
        1 => {
            return Alteration.Sharp;
        },
        2 => {
            return Alteration.DoubleSharp;
        },
        else => {
            return Alteration.Natural;
        },
    }
}

const PitchClass = struct {
    step: Step,
    alteration: Alteration,
    fn GetStep(self: *Step) Step {
        return self.step;
    }
    fn GetAlteration(self: *Alteration) Alteration {
        return self.alteration;
    }
};

fn ParsePitchClass(text: []u8) ParseError!PitchClass {
    const step = try ParseStep(text);
    return PitchClass{
        .step = step.step,
        .alteration = .DoubleSharp,
    };
}

test "parse pitch class using simple name" {
    const alloc = std.heap.page_allocator;
    const alterationTexts = [_][]const u8{ "bb", "b", "", "#", "##" };
    const stepTexts = [_][]const u8{ "C", "D", "E", "F", "G", "A", "B" };

    for (alterationTexts, 0..) |alt, ialt| {
        for (stepTexts, 0..) |step, istep| {
            const text = try alloc.alloc(u8, step.len + alt.len);
            mem.copyForwards(u8, text[0..], step);
            mem.copyForwards(u8, text[step.len..], alt);
            std.debug.print("INPUT = '{s}'\n", .{text});

            const parsed = try ParsePitchClass(text);
            std.debug.print("  parsed.step = {}\n", .{parsed.step});
            std.debug.print("  parsed.alteration = {}\n", .{parsed.alteration});

            const expectedStep: Step = @enumFromInt(istep + 1);
            const expectedAlteration: Alteration = @enumFromInt(@as(i8, @intCast(ialt)) - 2);
            try testing.expectEqual(expectedStep, parsed.step);
            try testing.expectEqual(expectedAlteration, parsed.alteration);
        }
    }
}
