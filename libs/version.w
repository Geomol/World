World [
	Title:	"Version Library"
	Author:	"John Niclasen"
]

is-32-bit?: is-32bit?: make function! [[
	"True if 32-bit."
][
	system/version/variation/1 = 2
]]

is-64-bit?: is-64bit?: make function! [[
	"True if 64-bit."
][
	system/version/variation/1 = 1
]]

Linux?: make function! [[
	"True if running under Linux."
][
	system/version/platform = 'linux
]]

Linux32?: make function! [[
	"True if running 32-bit under Linux."
][
	system/version/platform = 'linux and (system/version/variation/1 = 2)
]]

comment {
Linux64?: make function! [[
	"True if running 64-bit under Linux."
][
	system/version/platform = 'linux and (system/version/variation/1 = 1)
]]
}

Mac-OS-X?: MacOSX?: make function! [[
	"True if running under Mac OS X."
][
	system/version/platform = 'macosx
]]

MacOSX64?: make function! [[
	"True if running 64-bit under Mac OS X."
][
	system/version/platform = 'macosx and (system/version/variation/1 = 1)
]]

Win32?: make function! [[
	"True if running 32-bit under Windows."
][
	system/version/platform = 'win32 and (system/version/variation/1 = 2)
]]

comment {
Win64?: make function! [[
	"True if running 64-bit under Windows."
][
	system/version/platform = 'win32 and (system/version/variation/1 = 1)
]]
}

Windows?: make function! [[
	"True if running under Windows."
][
	system/version/platform = 'win32
]]

