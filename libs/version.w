World [
	Title:	"Version Library"
	Author:	"John Niclasen"
]

is-32-bit?: make function! [[
	"True if 32-bit."
][
	system/version/variation/1 = 2
]]
is-32bit?: make function! reduce [pick :is-32-bit? 1 pick :is-32-bit? 2]

is-64-bit?: make function! [[
	"True if 64-bit."
][
	system/version/variation/1 = 1
]]
is-64bit?: make function! reduce [pick :is-64-bit? 1 pick :is-64-bit? 2]

Linux?: make function! [[
	"True if running under Linux."
][
	system/version/platform = 'Linux
]]

Linux32?: make function! [[
	"True if running 32-bit under Linux."
][
	system/version/platform = 'Linux and (system/version/variation/1 = 2)
]]

Linux64?: make function! [[
	"True if running 64-bit under Linux."
][
	system/version/platform = 'Linux and (system/version/variation/1 = 1)
]]

Mac-OS-X?: make function! [[
	"True if running under Mac OS X."
][
	system/version/platform = 'MacOSX
]]
MacOSX?: make function! reduce [pick :Mac-OS-X? 1 pick :Mac-OS-X? 2]

MacOSX64?: make function! [[
	"True if running 64-bit under Mac OS X."
][
	system/version/platform = 'MacOSX and (system/version/variation/1 = 1)
]]

Win32?: make function! [[
	"True if running 32-bit under Windows."
][
	system/version/platform = 'Windows and (system/version/variation/1 = 2)
]]

comment {
Win64?: make function! [[
	"True if running 64-bit under Windows."
][
	system/version/platform = 'Windows and (system/version/variation/1 = 1)
]]
}

Windows?: make function! [[
	"True if running under Windows."
][
	system/version/platform = 'Windows
]]

